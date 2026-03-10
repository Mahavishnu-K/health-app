from fastapi import APIRouter, HTTPException
from db.appwrite_client import databases, DATABASE_ID
from appwrite.id import ID
from appwrite.query import Query
from models.device_model import DeviceTokenRegister
from utils.logger import logger

DEVICES_COLLECTION = "devices"

router = APIRouter(prefix="/api/v1/devices", tags=["Devices"])

@router.post("/register")
def register_device(device: DeviceTokenRegister):
    """
    Register or update an FCM device token for push notifications.
    Called by the Flutter app on startup or when the FCM token refreshes.
    """
    try:
        # Check if this token already exists
        existing = databases.list_documents(
            database_id=DATABASE_ID,
            collection_id=DEVICES_COLLECTION,
            queries=[Query.equal("fcmToken", device.fcm_token)]
        )

        if existing["total"] > 0:
            # Token exists — update the userId and reactivate
            doc = existing["documents"][0]
            databases.update_document(
                database_id=DATABASE_ID,
                collection_id=DEVICES_COLLECTION,
                document_id=doc["$id"],
                data={
                    "userId": device.user_id,
                    "isActive": True,
                    "deviceType": device.device_type
                }
            )
            logger.info(f"Updated device token for user {device.user_id}")
            return {"message": "Device token updated", "device_id": doc["$id"]}

        # New token — create a new device document
        result = databases.create_document(
            database_id=DATABASE_ID,
            collection_id=DEVICES_COLLECTION,
            document_id=ID.unique(),
            data={
                "userId": device.user_id,
                "fcmToken": device.fcm_token,
                "deviceType": device.device_type,
                "isActive": True
            }
        )
        logger.info(f"Registered new device for user {device.user_id}")
        return {"message": "Device token registered", "device_id": result["$id"]}

    except Exception as e:
        logger.error(f"Failed to register device token: {e}")
        raise HTTPException(status_code=500, detail="Failed to register device token")

@router.delete("/unregister/{token}")
def unregister_device(token: str):
    """
    Unregister a device token (e.g., on user logout).
    """
    try:
        result = databases.list_documents(
            database_id=DATABASE_ID,
            collection_id=DEVICES_COLLECTION,
            queries=[Query.equal("fcmToken", token)]
        )
        for doc in result["documents"]:
            databases.update_document(
                database_id=DATABASE_ID,
                collection_id=DEVICES_COLLECTION,
                document_id=doc["$id"],
                data={"isActive": False}
            )
        logger.info(f"Unregistered device token ...{token[-8:]}")
        return {"message": "Device token unregistered"}
    except Exception as e:
        logger.error(f"Failed to unregister device: {e}")
        raise HTTPException(status_code=500, detail="Failed to unregister device")
