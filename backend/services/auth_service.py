import bcrypt
import jwt
from datetime import datetime, timedelta, timezone
from db.appwrite_client import databases, DATABASE_ID
from appwrite.id import ID
from appwrite.query import Query
from models.auth_model import UserSignup, UserLogin
from config import settings
from utils.logger import logger
from fastapi import HTTPException

USERS_COLLECTION = "users"

def signup_user(user: UserSignup):
    try:
        # Check if user already exists
        existing = databases.list_documents(
            database_id=DATABASE_ID,
            collection_id=USERS_COLLECTION,
            queries=[Query.equal("email", user.email)]
        )
        if existing["total"] > 0:
            raise HTTPException(status_code=400, detail="User with this email already exists")

        # Hash the password
        hashed_password = bcrypt.hashpw(user.password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")

        # Store user document
        result = databases.create_document(
            database_id=DATABASE_ID,
            collection_id=USERS_COLLECTION,
            document_id=ID.unique(),
            data={
                "email": user.email,
                "password": hashed_password,
                "created_at": datetime.now(timezone.utc).isoformat()
            }
        )
        logger.info(f"User registered: {user.email}")
        return {"message": "User registered successfully", "user_id": result["$id"]}
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error during signup: {e}")
        raise HTTPException(status_code=400, detail=str(e))

def login_user(user: UserLogin):
    try:
        # Find user by email
        result = databases.list_documents(
            database_id=DATABASE_ID,
            collection_id=USERS_COLLECTION,
            queries=[Query.equal("email", user.email)]
        )

        if result["total"] == 0:
            raise HTTPException(status_code=401, detail="Invalid email or password")

        user_doc = result["documents"][0]

        # Verify password
        if not bcrypt.checkpw(user.password.encode("utf-8"), user_doc["password"].encode("utf-8")):
            raise HTTPException(status_code=401, detail="Invalid email or password")

        # Generate JWT token
        payload = {
            "user_id": user_doc["$id"],
            "email": user_doc["email"],
            "exp": datetime.now(timezone.utc) + timedelta(hours=24)
        }
        token = jwt.encode(payload, settings.jwt_secret, algorithm="HS256")

        logger.info(f"User logged in: {user.email}")
        return {"access_token": token, "token_type": "bearer", "user_id": user_doc["$id"]}
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error during login: {e}")
        raise HTTPException(status_code=401, detail=str(e))
