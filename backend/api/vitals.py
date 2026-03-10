from fastapi import APIRouter, Depends, BackgroundTasks, HTTPException, status
from models.vital_model import VitalCreate, VitalResponse
from services.vital_service import VitalPipeline
from utils.security import verify_rpi_key
from utils.logger import logger

router = APIRouter(prefix="/api/v1/vitals", tags=["Vitals"])

@router.post("", response_model=VitalResponse, status_code=status.HTTP_201_CREATED)
def receive_vitals(
    vital: VitalCreate, 
    background_tasks: BackgroundTasks,
    api_key: str = Depends(verify_rpi_key)
):
    """
    Endpoint for Raspberry Pi to send vital signs.
    Requires Authorization: Bearer <RPI_SECRET_KEY>
    """
    try:
        pipeline = VitalPipeline(background_tasks)
        response = pipeline.process_vital(vital)
        return response
    except ValueError as ve:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(ve)
        )
    except Exception as e:
        logger.error(f"Error processing vital: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to process vital data"
        )
