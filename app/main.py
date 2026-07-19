from fastapi import FastAPI

from app.database import Base, engine

import app.models

from app.routes import usuarios
from app.routes import hogares
from app.routes import tareas
from app.routes import recordatorios


Base.metadata.create_all(
    bind=engine
)


app = FastAPI(
    title="API HogarFacil"
)


app.include_router(usuarios.router)
app.include_router(hogares.router)
app.include_router(tareas.router)
app.include_router(recordatorios.router)


@app.get("/")
def inicio():
    return {
        "mensaje": "Backend HogarFacil funcionando"
    }