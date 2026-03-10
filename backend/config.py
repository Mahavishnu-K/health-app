from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    appwrite_endpoint: str
    appwrite_project_id: str
    appwrite_api_key: str
    appwrite_database_id: str
    jwt_secret: str
    rpi_api_key: str
    fcm_server_key: str

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"

settings = Settings()
