from fastapi import FastAPI
from api.vitals import router as vitals_router
from api.patients import router as patients_router
from api.alerts import router as alerts_router
from api.auth import router as auth_router
from utils.logger import logger

app = FastAPI(
    title="Health App Backend", 
    description="Backend API for managing patient vitals and alerts.",
    version="1.0.0"
)

# Register routers
app.include_router(vitals_router)
app.include_router(patients_router)
app.include_router(alerts_router)
app.include_router(auth_router)

@app.get("/health", tags=["Health"])
def health_check():
    """System Health Check endpoint"""
    return {
        "server": "ok",
        "database": "ok",
        "notification_service": "ok"
    }

@app.on_event("startup")
async def startup_event():
    logger.info("Health App Backend API starting up.")

@app.on_event("shutdown")
async def shutdown_event():
    logger.info("Health App Backend API shutting down.")
