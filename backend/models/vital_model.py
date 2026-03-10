from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class VitalCreate(BaseModel):
    patient_id: str
    pulse_rate: int
    device_id: str
    timestamp: Optional[datetime] = None

class VitalResponse(BaseModel):
    status: str
    pulse_state: str

class VitalDB(BaseModel):
    id: str
    patient_id: str
    pulse_rate: int
    status: str
    recorded_at: Optional[str] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None
