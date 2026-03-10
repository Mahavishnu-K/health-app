from fastapi import APIRouter, HTTPException
from services.alert_service import get_alerts_for_patient
from utils.logger import logger

router = APIRouter(prefix="/api/v1/alerts", tags=["Alerts"])

@router.get("/{patient_id}")
def get_alerts(patient_id: str):
    """Fetch all alerts generated for a specific patient"""
    try:
        return get_alerts_for_patient(patient_id)
    except Exception as e:
        logger.error(f"Error fetching alerts: {e}")
        raise HTTPException(status_code=500, detail="Failed to fetch alerts")
