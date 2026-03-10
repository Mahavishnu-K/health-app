from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime

class UserSignup(BaseModel):
    username: str
    email: EmailStr
    password: str
    first_name: Optional[str] = None
    last_name: Optional[str] = None
    role: Optional[str] = None
    birthdate: Optional[datetime] = None

class UserLogin(BaseModel):
    email: EmailStr
    password: str
