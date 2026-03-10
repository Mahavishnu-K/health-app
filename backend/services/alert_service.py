from db.appwrite_client import databases, DATABASE_ID
from appwrite.id import ID
from appwrite.query import Query
from models.alert_model import AlertCreate
from utils.logger import logger

ALERTS_COLLECTION = "alerts"

def create_alert(alert: AlertCreate):
    try:
        result = databases.create_document(
            database_id=DATABASE_ID,
            collection_id=ALERTS_COLLECTION,
            document_id=ID.unique(),
            data={
                "patient_id": str(alert.patient_id),
                "pulse_rate": alert.pulse_rate,
                "severity": alert.severity,
                "message": alert.message
            }
        )
        logger.info(f"Alert created for patient {alert.patient_id} with severity {alert.severity}")
        return result
    except Exception as e:
        logger.error(f"Failed to create alert in db: {e}")
        return None

def get_alerts_for_patient(patient_id: str):
    try:
        response = databases.list_documents(
            database_id=DATABASE_ID,
            collection_id=ALERTS_COLLECTION,
            queries=[
                Query.equal("patient_id", patient_id),
                Query.order_desc("created_at")
            ]
        )
        return response["documents"]
    except Exception as e:
        logger.error(f"Failed to fetch alerts for {patient_id}: {e}")
        return []
