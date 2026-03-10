import asyncio
import uuid
import bcrypt
from datetime import datetime, timedelta, timezone
from db.appwrite_client import databases, DATABASE_ID
from appwrite.id import ID
from utils.logger import logger

USERS_COLLECTION = "users"
PATIENTS_COLLECTION = "patients"
VITALS_COLLECTION = "vitals"
ALERTS_COLLECTION = "alerts"

async def seed_database():
    logger.info("Starting database seeding...")

    # 1. Create a mock user (manual auth with bcrypt)
    test_email = "test.patient@example.com"
    test_password = "SecurePassword123!"

    user_id = None
    try:
        logger.info(f"Creating test user: {test_email}")
        hashed_password = bcrypt.hashpw(test_password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")
        result = databases.create_document(
            database_id=DATABASE_ID,
            collection_id=USERS_COLLECTION,
            document_id=ID.unique(),
            data={
                "email": test_email,
                "password": hashed_password,
                "created_at": datetime.now(timezone.utc).isoformat()
            }
        )
        user_id = result["$id"]
        logger.info(f"Created user with ID: {user_id}")
    except Exception as e:
        logger.warning(f"User creation failed (may already exist). Error: {e}")
        # Fallback to random UUID
        user_id = str(uuid.uuid4())
        logger.info(f"Using mock UUID for user: {user_id}")

    doctor_id = str(uuid.uuid4())
    patient_id = str(uuid.uuid4())

    # 2. Seed Patients
    logger.info("Seeding patients collection...")
    patient_data = {
        "name": "Jacob Jones",
        "age": 45,
        "doctor_id": doctor_id,
        "family_user_id": user_id,
        "created_at": datetime.now(timezone.utc).isoformat()
    }

    try:
        databases.create_document(
            database_id=DATABASE_ID,
            collection_id=PATIENTS_COLLECTION,
            document_id=patient_id,
            data=patient_data
        )
        logger.info(f"Inserted patient: {patient_data['name']}")
    except Exception as e:
        logger.error(f"Failed to insert patient: {e}")

    # 3. Seed Vitals (past few hours)
    logger.info("Seeding vitals collection...")
    base_time = datetime.now(timezone.utc) - timedelta(hours=4)

    pulses = [72, 75, 78, 85, 92, 95, 88, 76, 70, 68]
    for i, pulse in enumerate(pulses):
        status = "normal"
        if pulse > 90:
            status = "warning"

        vital_data = {
            "patient_id": patient_id,
            "pulse_rate": pulse,
            "status": status,
            "recorded_at": (base_time + timedelta(minutes=30 * i)).isoformat()
        }

        try:
            databases.create_document(
                database_id=DATABASE_ID,
                collection_id=VITALS_COLLECTION,
                document_id=ID.unique(),
                data=vital_data
            )
        except Exception as e:
            logger.error(f"Failed to insert vital record: {e}")

    logger.info(f"Inserted {len(pulses)} vital records")

    # 4. Seed Alerts
    logger.info("Seeding alerts collection...")
    alerts_data = [
        {
            "patient_id": patient_id,
            "message": "Elevated heart rate detected (95 bpm)",
            "severity": "warning",
            "is_read": False,
            "created_at": (base_time + timedelta(minutes=30 * 5)).isoformat()
        },
        {
            "patient_id": patient_id,
            "message": "Heart rate returning to normal",
            "severity": "info",
            "is_read": True,
            "created_at": (base_time + timedelta(minutes=30 * 7)).isoformat()
        }
    ]

    for alert in alerts_data:
        try:
            databases.create_document(
                database_id=DATABASE_ID,
                collection_id=ALERTS_COLLECTION,
                document_id=ID.unique(),
                data=alert
            )
        except Exception as e:
            logger.error(f"Failed to insert alert: {e}")

    logger.info(f"Inserted {len(alerts_data)} alert records")
    logger.info("Seeding complete!")

if __name__ == "__main__":
    asyncio.run(seed_database())
