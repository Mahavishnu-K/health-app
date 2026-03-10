from fastapi import Security, HTTPException, status
from fastapi.security import APIKeyHeader
from config import settings
from utils.logger import logger

api_key_header_scheme = APIKeyHeader(name="Authorization", auto_error=False)

async def verify_rpi_key(api_key_header: str = Security(api_key_header_scheme)):
    if not api_key_header:
        logger.warning("Unauthenticated request tried to access vital endpoints.")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Missing Authorization header",
        )
    
    prefix = "Bearer "
    if not api_key_header.startswith(prefix):
        logger.warning(f"Invalid auth format received (expected Bearer): {api_key_header}")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid Authorization format. Expected 'Bearer <key>'",
        )
    
    key = api_key_header[len(prefix):]
    if key != settings.rpi_api_key:
        logger.warning("Invalid API Key used to access vital endpoints.")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid API Key",
        )
    
    return key
