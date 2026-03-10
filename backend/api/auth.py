from fastapi import APIRouter
from models.auth_model import UserSignup, UserLogin
from services.auth_service import signup_user, login_user

router = APIRouter(prefix="/auth", tags=["Authentication"])

@router.post("/signup")
def signup(user: UserSignup):
    """
    Register a new user with email and password.
    Password is hashed with bcrypt and stored in the database.
    """
    response = signup_user(user)
    return response

@router.post("/login")
def login(user: UserLogin):
    """
    Login an existing user and get a JWT session token.
    """
    response = login_user(user)
    return response
