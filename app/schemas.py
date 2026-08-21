from pydantic import BaseModel, EmailStr, ConfigDict



class UsuarioCreate(BaseModel):

    nombre: str
    correo: EmailStr
    password: str
    telefono: str



class UsuarioResponse(BaseModel):

    id: int
    nombre: str
    correo: EmailStr
    telefono: str


    model_config = ConfigDict(
        from_attributes=True
    )



class Login(BaseModel):

    correo: EmailStr
    password: str
    