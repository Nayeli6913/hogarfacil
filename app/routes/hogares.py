from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session, joinedload

from app.database import get_db
from app.models import Hogar
from app.cache import get_cache, set_cache, delete_cache


router = APIRouter(
    prefix="/hogares",
    tags=["Hogares"]
)


# GET - Listar hogares con caché y eager loading
@router.get("/")
def listar_hogares(db: Session = Depends(get_db)):

    # 1. Buscar primero en caché
    hogares_cache = get_cache("hogares")

    if hogares_cache:
        return {
            "origen": "cache",
            "hogares": hogares_cache
        }


    # 2. Si no existe en caché consulta MySQL
    hogares = db.query(Hogar).options(
        joinedload(Hogar.tareas)
    ).all()


    resultado = []

    for hogar in hogares:
        resultado.append(
            {
                "id": hogar.id,
                "nombre": hogar.nombre,
                "direccion": hogar.direccion,
                "tareas": [
                    {
                        "id": tarea.id,
                        "titulo": tarea.titulo,
                        "estado": tarea.estado
                    }
                    for tarea in hogar.tareas
                ]
            }
        )


    # 3. Guardar resultado en caché
    set_cache(
        "hogares",
        resultado
    )


    return {
        "origen": "mysql",
        "hogares": resultado
    }



# POST - Crear hogar e invalidar caché
@router.post("/")
def crear_hogar(
    nombre: str,
    direccion: str,
    db: Session = Depends(get_db)
):

    nuevo_hogar = Hogar(
        nombre=nombre,
        direccion=direccion
    )


    db.add(nuevo_hogar)
    db.commit()
    db.refresh(nuevo_hogar)


    # Invalidar caché porque cambió la información
    delete_cache("hogares")


    return nuevo_hogar