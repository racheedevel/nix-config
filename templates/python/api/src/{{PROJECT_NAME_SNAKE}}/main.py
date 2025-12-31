from fastapi import FastAPI

from .config import settings

app = FastAPI(
    title="{{PROJECT_NAME}}",
    version="0.1.0",
)


@app.get("/")
async def root():
    return {"message": "Hello from {{PROJECT_NAME}}"}


@app.get("/health")
async def health():
    return {"status": "healthy"}
