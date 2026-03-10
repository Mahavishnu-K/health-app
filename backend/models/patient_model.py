from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from uuid import UUID

class PatientDB(BaseModel):
    id: str
    name: str
    age: int
    doctor_id: str
    family_user_id: str
    medical_condition: Optional[str] = None
    admission_date: Optional[datetime] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None
