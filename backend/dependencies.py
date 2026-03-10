from fastapi import Depends
from utils.security import verify_rpi_key

def get_rpi_auth_dependency():
    """Returns a dependency injecting the valid API key, if present."""
    return Depends(verify_rpi_key)
