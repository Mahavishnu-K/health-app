from pydantic_settings import BaseSettings
from typing import Optional

class Settings(BaseSettings):
    appwrite_endpoint: str
    appwrite_project_id: str
    appwrite_api_key: str
    appwrite_database_id: str
    jwt_secret: str
    rpi_api_key: str

    # Firebase — path to service account JSON file
    firebase_credentials_path: Optional[str] = None

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"

settings = Settings()
