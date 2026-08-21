# HogarFácil

## 1. Descripción del proyecto

HogarFácil es una aplicación móvil desarrollada con Flutter que permite gestionar información relacionada con hogares, tareas y recordatorios. El proyecto utiliza una arquitectura cliente-servidor, donde la aplicación móvil se comunica con un backend desarrollado con FastAPI.

## 2. Tecnologías utilizadas

* Flutter
* Dart
* FastAPI
* Python
* SQLAlchemy
* MySQL
* XAMPP
* Android Emulator
* Git y GitHub

## 3. Requisitos del entorno

Para ejecutar el proyecto se requiere tener instalado:

* Flutter SDK
* Dart SDK incluido con Flutter
* Android Studio
* Android SDK
* Android Emulator
* Python
* XAMPP
* Git

## 4. Configuración del frontend

El proyecto Flutter se encuentra en:

```text
C:\hogarfacil
```

Para verificar la instalación de Flutter:

```bash
flutter --version
```

Para verificar que el entorno esté correctamente configurado:

```bash
flutter doctor
```

Para instalar las dependencias del proyecto:

```bash
flutter pub get
```

La aplicación utiliza, entre otras, la dependencia `http` para realizar las comunicaciones con el backend.

## 5. Configuración del emulador Android

Para verificar los dispositivos virtuales disponibles:

```bash
emulator -list-avds
```

Para iniciar el emulador configurado:

```bash
emulator -avd Pixel_6
```

Una vez iniciado el emulador, se puede verificar que Flutter lo reconozca mediante:

```bash
flutter devices
```

Para ejecutar la aplicación:

```bash
flutter run
```

## 6. Configuración del backend

El backend se encuentra en:

```text
C:\Users\Usuario\OneDrive\Documentos 1\hogarfacil
```

El backend está desarrollado utilizando FastAPI y se ejecuta mediante Uvicorn.

Ingresar a la carpeta:

```bash
cd "C:\Users\Usuario\OneDrive\Documentos 1\hogarfacil"
```

Crear el entorno virtual:

```bash
python -m venv venv
```

Activar el entorno virtual en Windows PowerShell:

```powershell
.\venv\Scripts\Activate.ps1
```

Instalar las dependencias:

```bash
pip install fastapi uvicorn sqlalchemy pymysql python-jose passlib[bcrypt] python-multipart pydantic email-validator cachetools
```

## 7. Configuración de la base de datos

La aplicación utiliza MySQL mediante XAMPP.

La base de datos utilizada es:

```text
hogarfacil
```

La configuración utilizada para la conexión es:

```text
mysql+pymysql://root:@localhost:3307/hogarfacil
```

El servidor MySQL de XAMPP utiliza el puerto:

```text
3307
```

Antes de ejecutar el backend se debe iniciar MySQL desde el panel de control de XAMPP.

## 8. Ejecución del backend

Desde la carpeta del backend y con el entorno virtual activado:

```bash
uvicorn app.main:app --reload
```

El servidor estará disponible en:

```text
http://127.0.0.1:8000
```

La documentación interactiva de FastAPI puede consultarse en:

```text
http://127.0.0.1:8000/docs
```

## 9. Endpoints principales

El backend cuenta con rutas relacionadas con:

* Usuarios
* Hogares
* Tareas
* Recordatorios

Entre los endpoints utilizados se encuentra:

```text
POST /usuarios/login
```

El inicio de sesión utiliza el correo electrónico como usuario y la contraseña para realizar la autenticación.

## 10. Ejecución completa del proyecto

Para ejecutar el proyecto completo se deben realizar los siguientes pasos:

### Paso 1. Iniciar MySQL

Abrir XAMPP y activar:

```text
MySQL
```

### Paso 2. Ejecutar el backend

```powershell
cd "C:\Users\Usuario\OneDrive\Documentos 1\hogarfacil"
.\venv\Scripts\Activate.ps1
uvicorn app.main:app --reload
```

### Paso 3. Iniciar el emulador Android

```powershell
emulator -avd Pixel_6
```

### Paso 4. Ejecutar Flutter

En otra terminal:

```powershell
cd C:\hogarfacil
flutter pub get
flutter run
```

## 11. Comandos útiles

Verificar Flutter:

```bash
flutter doctor
```

Ver dispositivos disponibles:

```bash
flutter devices
```

Instalar dependencias Flutter:

```bash
flutter pub get
```

Limpiar el proyecto Flutter:

```bash
flutter clean
```

Volver a instalar dependencias:

```bash
flutter pub get
```

Ejecutar la aplicación:

```bash
flutter run
```

Verificar la versión de Python:

```bash
python --version
```

Verificar las dependencias instaladas:

```bash
pip list
```

Ejecutar FastAPI:

```bash
uvicorn app.main:app --reload
```

## 12. Control de versiones

El proyecto utiliza Git para controlar las versiones del código fuente.

Para consultar el estado del repositorio:

```bash
git status
```

Para agregar los cambios:

```bash
git add .
```

Para crear un commit:

```bash
git commit -m "Documentación de configuración del entorno"
```

Para enviar los cambios al repositorio remoto:

```bash
git push
```

## 13. Resultado

Una vez configurados MySQL, el backend, el emulador Android y Flutter, la aplicación HogarFácil puede ejecutarse desde el emulador y comunicarse con el backend mediante la API desarrollada con FastAPI.
