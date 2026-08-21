from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session


from app.database import get_db
from app.models import Usuario

from app.schemas import (
    UsuarioCreate,
    UsuarioResponse
)

from app.auth import (
    hash_password,
    verify_password,
    crear_token
)


router = APIRouter(
    prefix="/usuarios",
    tags=["Usuarios"]
)



# -----------------------------
# Crear usuario
# -----------------------------

@router.post("/", response_model=UsuarioResponse)
def crear_usuario(
    usuario: UsuarioCreate,
    db: Session = Depends(get_db)
):

    existe = db.query(Usuario).filter(
        Usuario.correo == usuario.correo
    ).first()


    if existe:

        raise HTTPException(
            status_code=400,
            detail="El correo ya está registrado."
        )


    nuevo_usuario = Usuario(

        nombre=usuario.nombre,

        correo=usuario.correo,

        password=hash_password(
            usuario.password
        ),

        telefono=usuario.telefono
    )


    db.add(nuevo_usuario)

    db.commit()

    db.refresh(nuevo_usuario)


    return nuevo_usuario




# -----------------------------
# Listar usuarios
# -----------------------------

@router.get("/", response_model=list[UsuarioResponse])
def listar_usuarios(
    db: Session = Depends(get_db)
):

    usuarios = db.query(Usuario).all()

    return usuarios




# -----------------------------
# Obtener usuario por ID
# -----------------------------

@router.get("/{id}", response_model=UsuarioResponse)
def obtener_usuario(
    id: int,
    db: Session = Depends(get_db)
):

    usuario = db.query(Usuario).filter(
        Usuario.id == id
    ).first()


    if not usuario:

        raise HTTPException(
            status_code=404,
            detail="Usuario no encontrado"
        )


    return usuario




# -----------------------------
# Login con OAuth2 para Swagger
# -----------------------------

@router.post("/login")
def login(
    datos: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db)
):

    # Swagger manda el correo en username
    usuario = db.query(Usuario).filter(
        Usuario.correo == datos.username
    ).first()



    if not usuario:

        raise HTTPException(
            status_code=401,
            detail="Correo o contraseña incorrectos"
        )



    contraseña_correcta = verify_password(
        datos.password,
        usuario.password
    )



    if not contraseña_correcta:

        raise HTTPException(
            status_code=401,
            detail="Correo o contraseña incorrectos"
        )



    token = crear_token(
        {
            "sub": str(usuario.id),
            "correo": usuario.correo
        }
    )



    return {

        "access_token": token,

        "token_type": "bearer"

    }