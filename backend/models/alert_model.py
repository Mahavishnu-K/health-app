from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class AlertCreate(BaseModel):
    patient_id: str
    pulse_rate: Optional[int] = None
    severity: str
    message: str
    is_read: Optional[bool] = None

class AlertDB(AlertCreate):
    id: str
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None
