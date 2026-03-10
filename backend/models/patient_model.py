from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from uuid import UUID

class PatientDB(BaseModel):
    id: UUID
    name: str
    age: int
    doctor_id: UUID
    family_user_id: UUID
    created_at: datetime
