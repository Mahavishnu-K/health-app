import json
import os
import tempfile
from pydantic_settings import BaseSettings
from typing import Optional

class Settings(BaseSettings):
    appwrite_endpoint: str
    appwrite_project_id: str
    appwrite_api_key: str
    appwrite_database_id: str
    jwt_secret: str
    rpi_api_key: str

    # Firebase — either a file path OR the JSON content as a string (for Render/cloud)
    firebase_credentials_path: Optional[str] = None
    firebase_credentials_json: Optional[str] = None

    # CORS — comma-separated list of allowed origins
    cors_origins: str = "*"

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"

    def get_firebase_credentials_path(self) -> Optional[str]:
        """
        Returns a valid path to Firebase credentials.
        - If FIREBASE_CREDENTIALS_PATH is set and the file exists, use it.
        - If FIREBASE_CREDENTIALS_JSON is set (for cloud deployment), write it
          to a temp file and return that path.
        """
        # Option 1: Direct file path (local dev)
        if self.firebase_credentials_path and os.path.exists(self.firebase_credentials_path):
            return self.firebase_credentials_path

        # Option 2: JSON string from env var (Render / cloud deployment)
        if self.firebase_credentials_json:
            try:
                creds = json.loads(self.firebase_credentials_json)
                tmp = tempfile.NamedTemporaryFile(
                    mode="w", suffix=".json", delete=False
                )
                json.dump(creds, tmp)
                tmp.close()
                return tmp.name
            except json.JSONDecodeError:
                return None

        return None

settings = Settings()
