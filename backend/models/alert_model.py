from pydantic import BaseModel
from datetime import datetime
from uuid import UUID

class AlertCreate(BaseModel):
    patient_id: UUID
    pulse_rate: int
    severity: str
    message: str

class AlertDB(AlertCreate):
    id: UUID
    created_at: datetime
