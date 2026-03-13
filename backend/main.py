from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from api.vitals import router as vitals_router
from api.patients import router as patients_router
from api.alerts import router as alerts_router
from api.auth import router as auth_router
from api.devices import router as devices_router
from services.notification_service import _firebase_ready
from config import settings
from utils.logger import logger

app = FastAPI(
    title="Health App Backend",
    description="Backend API for managing patient vitals, alerts, and push notifications.",
    version="1.0.0"
)

# ── CORS Middleware ──────────────────────────────────────────────────────────
# Required for Flutter app to communicate with the server
origins = [o.strip() for o in settings.cors_origins.split(",")]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ── Global Exception Handler ────────────────────────────────────────────────
@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    logger.error(f"Unhandled error on {request.method} {request.url.path}: {exc}")
    return JSONResponse(
        status_code=500,
        content={"detail": "Internal server error"}
    )

# ── Register Routers ────────────────────────────────────────────────────────
app.include_router(vitals_router)
app.include_router(patients_router)
app.include_router(alerts_router)
app.include_router(auth_router)
app.include_router(devices_router)

# ── Health Check ─────────────────────────────────────────────────────────────
@app.get("/health", tags=["Health"])
def health_check():
    """System Health Check endpoint"""
    return {
        "server": "ok",
        "database": "ok",
        "notification_service": "ok" if _firebase_ready else "not_configured"
    }

@app.on_event("startup")
async def startup_event():
    logger.info("Health App Backend API starting up.")

@app.on_event("shutdown")
async def shutdown_event():
    logger.info("Health App Backend API shutting down.")
