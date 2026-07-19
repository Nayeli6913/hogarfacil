from sqlalchemy import Column, Integer, String, Text, Date, DateTime, ForeignKey
from sqlalchemy.orm import relationship

from app.database import Base


class Usuario(Base):
    __tablename__ = "usuarios"

    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(100), nullable=False)
    correo = Column(String(100), unique=True, nullable=False)
    password = Column(String(255), nullable=False)
    telefono = Column(String(20))
    fecha_registro = Column(Date)

    miembros = relationship("MiembroHogar", back_populates="usuario")
    asignaciones = relationship("AsignacionTarea", back_populates="usuario")


class Hogar(Base):
    __tablename__ = "hogares"

    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(100), nullable=False)
    direccion = Column(String(200))
    fecha_creacion = Column(Date)

    miembros = relationship("MiembroHogar", back_populates="hogar")
    tareas = relationship("Tarea", back_populates="hogar")


class MiembroHogar(Base):
    __tablename__ = "miembro_hogar"

    id = Column(Integer, primary_key=True, index=True)

    usuario_id = Column(Integer, ForeignKey("usuarios.id"))
    hogar_id = Column(Integer, ForeignKey("hogares.id"))

    rol = Column(String(50))

    usuario = relationship("Usuario", back_populates="miembros")
    hogar = relationship("Hogar", back_populates="miembros")


class Tarea(Base):
    __tablename__ = "tareas"

    id = Column(Integer, primary_key=True, index=True)

    titulo = Column(String(100), nullable=False)
    descripcion = Column(Text)
    prioridad = Column(String(20))
    fecha_limite = Column(Date)
    estado = Column(String(20))

    hogar_id = Column(Integer, ForeignKey("hogares.id"))

    hogar = relationship("Hogar", back_populates="tareas")
    asignaciones = relationship("AsignacionTarea", back_populates="tarea")
    recordatorios = relationship("Recordatorio", back_populates="tarea")


class AsignacionTarea(Base):
    __tablename__ = "asignacion_tarea"

    id = Column(Integer, primary_key=True, index=True)

    tarea_id = Column(Integer, ForeignKey("tareas.id"))
    usuario_id = Column(Integer, ForeignKey("usuarios.id"))

    fecha_asignacion = Column(Date)

    tarea = relationship("Tarea", back_populates="asignaciones")
    usuario = relationship("Usuario", back_populates="asignaciones")


class Recordatorio(Base):
    __tablename__ = "recordatorios"

    id = Column(Integer, primary_key=True, index=True)

    mensaje = Column(String(200))
    fecha_hora = Column(DateTime)

    tarea_id = Column(Integer, ForeignKey("tareas.id"))

    tarea = relationship("Tarea", back_populates="recordatorios")