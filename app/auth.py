from datetime import datetime, timedelta, timezone

from jose import jwt, JWTError
from passlib.context import CryptContext

from fastapi import Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer


SECRET_KEY = "hogarfacil2026"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60


pwd_context = CryptContext(
    schemes=["bcrypt"],
    deprecated="auto"
)


oauth2_scheme = OAuth2PasswordBearer(
    tokenUrl="/usuarios/login"
)



def hash_password(password: str):

    return pwd_context.hash(password)



def verify_password(password: str, hashed: str):

    return pwd_context.verify(
        password,
        hashed
    )



def crear_token(data: dict):

    datos = data.copy()

    expire = datetime.now(timezone.utc) + timedelta(
        minutes=ACCESS_TOKEN_EXPIRE_MINUTES
    )

    datos.update({
        "exp": expire
    })


    token = jwt.encode(
        datos,
        SECRET_KEY,
        algorithm=ALGORITHM
    )

    return token



# Validar usuario autenticado
def obtener_usuario_actual(
    token: str = Depends(oauth2_scheme)
):

    try:

        payload = jwt.decode(
            token,
            SECRET_KEY,
            algorithms=[ALGORITHM]
        )


        usuario_id = payload.get("sub")


        if usuario_id is None:
            raise HTTPException(
                status_code=401,
                detail="Token inválido"
            )


        return usuario_id


    except JWTError:

        raise HTTPException(
            status_code=401,
            detail="Token inválido o expirado"
        )