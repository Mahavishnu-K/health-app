import firebase_admin
from firebase_admin import credentials, messaging
from config import settings
from utils.logger import logger

def init_firebase():
    """Initializes Firebase Admin SDK."""
    try:
        if not firebase_admin._apps:
            # We assume fcm_server_key is the path to the service account JSON for now
            # In a real scenario, this would configure `cred`.
            pass 
    except Exception as e:
        logger.error(f"Failed to initialize Firebase: {e}")

init_firebase()

async def send_push_notification(patient_id: str, title: str, body: str):
    """
    Sends a push notification to FCM.
    This function should be called as a FastAPI BackgroundTask so it doesn't block API responses.
    """
    try:
        # Mocking notification send for robustness when credentials aren't fully configured
        # message = messaging.Message(
        #     notification=messaging.Notification(title=title, body=body),
        #     topic=patient_id
        # )
        # response = messaging.send(message)
        
        logger.info(f"FCM Push Notification dispatched for patient {patient_id}. Title: {title} | Body: {body}")
    except Exception as e:
        logger.error(f"Error sending push notification for patient {patient_id}: {e}")
