from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from datetime import datetime

from app.database import get_db
from app.models import Recordatorio


router = APIRouter(
    prefix="/recordatorios",
    tags=["Recordatorios"]
)


@router.get("/")
def listar_recordatorios(db: Session = Depends(get_db)):

    recordatorios = db.query(Recordatorio).all()

    return recordatorios



@router.post("/")
def crear_recordatorio(
    mensaje: str,
    fecha_hora: datetime,
    tarea_id: int,
    db: Session = Depends(get_db)
):

    nuevo_recordatorio = Recordatorio(
        mensaje=mensaje,
        fecha_hora=fecha_hora,
        tarea_id=tarea_id
    )

    db.add(nuevo_recordatorio)
    db.commit()
    db.refresh(nuevo_recordatorio)

    return nuevo_recordatorio