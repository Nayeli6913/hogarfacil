from fastapi import APIRouter, Depends, BackgroundTasks
from sqlalchemy.orm import Session, joinedload

from app.database import get_db
from app.models import Tarea
from app.auth import obtener_usuario_actual


router = APIRouter(
    prefix="/tareas",
    tags=["Tareas"]
)


# ---------------------------------
# Tarea asíncrona
# ---------------------------------

def enviar_notificacion(titulo: str):

    print(
        f"Notificación enviada para la tarea: {titulo}"
    )



# ---------------------------------
# Listar tareas protegido con token
# y usando eager loading
# ---------------------------------

@router.get("/")
def listar_tareas(
    db: Session = Depends(get_db),
    usuario_id: str = Depends(obtener_usuario_actual)
):

    tareas = db.query(Tarea).options(
        joinedload(Tarea.hogar)
    ).all()


    resultado = []


    for tarea in tareas:

        resultado.append(
            {
                "id": tarea.id,
                "titulo": tarea.titulo,
                "descripcion": tarea.descripcion,
                "prioridad": tarea.prioridad,
                "estado": tarea.estado,
                "hogar": {
                    "id": tarea.hogar.id,
                    "nombre": tarea.hogar.nombre
                } if tarea.hogar else None
            }
        )


    return resultado



# ---------------------------------
# Crear tarea con proceso asíncrono
# ---------------------------------

@router.post("/")
def crear_tarea(
    titulo: str,
    descripcion: str,
    prioridad: str,
    estado: str,
    hogar_id: int,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
    usuario_id: str = Depends(obtener_usuario_actual)
):


    nueva_tarea = Tarea(

        titulo=titulo,

        descripcion=descripcion,

        prioridad=prioridad,

        estado=estado,

        hogar_id=hogar_id

    )


    db.add(nueva_tarea)

    db.commit()

    db.refresh(nueva_tarea)



    # Ejecuta después de responder
    background_tasks.add_task(
        enviar_notificacion,
        titulo
    )



    return nueva_tarea