from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from uuid import UUID

class VitalCreate(BaseModel):
    patient_id: UUID
    pulse_rate: int
    device_id: str
    timestamp: Optional[datetime] = None

class VitalResponse(BaseModel):
    status: str
    pulse_state: str

class VitalDB(BaseModel):
    id: UUID
    patient_id: UUID
    pulse_rate: int
    status: str
    recorded_at: datetime
