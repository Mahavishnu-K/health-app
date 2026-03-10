from pydantic import BaseModel
from typing import Optional

class DeviceTokenRegister(BaseModel):
    user_id: str
    fcm_token: str
    device_type: Optional[str] = "android"  # "android" or "ios"
