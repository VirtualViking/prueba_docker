# 🚀 API de Tareas - Aprende Docker y GitHub Actions

Una API REST simple con Flask para aprender Docker, GitHub Actions y CI/CD.

## 📋 Tabla de Contenidos

- [Requisitos](#requisitos)
- [¿Qué es Docker?](#qué-es-docker)
- [Conceptos Clave de Docker](#conceptos-clave-de-docker)
- [Instalación](#instalación)
- [Uso con Docker](#uso-con-docker)
- [Uso sin Docker](#uso-sin-docker)
- [Endpoints de la API](#endpoints-de-la-api)
- [GitHub Actions](#github-actions)
- [Comandos Docker Útiles](#comandos-docker-útiles)

---

## 🔧 Requisitos

- **Docker** instalado en tu máquina
- **Git** para clonar el repositorio
- **(Opcional)** Python 3.11+ si quieres ejecutar sin Docker

---

## 🐳 ¿Qué es Docker?

**Docker** es una plataforma que permite empaquetar tu aplicación y todas sus dependencias en un "contenedor". Piensa en un contenedor como una caja que tiene todo lo que tu app necesita para funcionar:

- ✅ El código de tu aplicación
- ✅ Python (o el lenguaje que uses)
- ✅ Todas las librerías necesarias
- ✅ La configuración del sistema

**Ventajas:**
- 🎯 **"Funciona en mi máquina" ya no es excusa** - Si funciona en Docker, funciona en cualquier lugar
- 🚀 **Despliegue fácil** - Lleva tu contenedor a cualquier servidor
- 📦 **Aislamiento** - Tu app no interfiere con otras apps
- 🔄 **Consistencia** - El mismo ambiente en desarrollo, testing y producción

---

## 🎓 Conceptos Clave de Docker

### 1. **Imagen (Image)**
Es una plantilla de solo lectura que contiene todo lo necesario para ejecutar tu aplicación. Es como una "foto" de tu app lista para usar.

### 2. **Contenedor (Container)**
Es una instancia en ejecución de una imagen. Es como "darle vida" a la foto. Puedes tener múltiples contenedores de la misma imagen.

### 3. **Dockerfile**
Es un archivo de texto con instrucciones para crear una imagen Docker. Es como una receta de cocina.

### 4. **Docker Hub**
Es un repositorio en la nube donde puedes guardar y compartir tus imágenes Docker (como GitHub pero para imágenes).

---

## 📥 Instalación

### 1. Instalar Docker

**Windows/Mac:**
- Descarga [Docker Desktop](https://www.docker.com/products/docker-desktop)
- Ejecuta el instalador
- Reinicia tu computadora

**Linux:**
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```

### 2. Verificar Instalación
```bash
docker --version
docker run hello-world
```

---

## 🐳 Uso con Docker

### Opción 1: Usando Docker directamente

#### Paso 1: Construir la imagen
```bash
# Construir la imagen con el nombre 'task-api' y tag 'latest'
docker build -t task-api:latest .

# Ver tus imágenes
docker images
```

**¿Qué hace este comando?**
- `docker build` - Construye una imagen
- `-t task-api:latest` - Le da un nombre (task-api) y una etiqueta (latest)
- `.` - Usa el Dockerfile del directorio actual

#### Paso 2: Ejecutar el contenedor
```bash
# Ejecutar el contenedor
docker run -d -p 5000:5000 --name mi-task-api task-api:latest

# Verificar que está corriendo
docker ps
```

**¿Qué hace este comando?**
- `docker run` - Crea y ejecuta un contenedor
- `-d` - Modo "detached" (en segundo plano)
- `-p 5000:5000` - Mapea puerto 5000 de tu máquina al 5000 del contenedor
- `--name mi-task-api` - Le da un nombre al contenedor
- `task-api:latest` - Usa esta imagen

#### Paso 3: Probar la API
```bash
# Ver logs del contenedor
docker logs mi-task-api

# Hacer una petición
curl http://localhost:5000
curl http://localhost:5000/tasks
```

### Opción 2: Usando Docker Compose (Más fácil)

```bash
# Construir e iniciar
docker-compose up -d

# Ver logs
docker-compose logs -f

# Detener
docker-compose down

# Reconstruir después de cambios
docker-compose up -d --build
```

**¿Por qué usar Docker Compose?**
- ✅ Un solo comando para todo
- ✅ Configuración en un archivo YAML
- ✅ Fácil para gestionar múltiples contenedores

---

## 🖥️ Uso sin Docker (Desarrollo local)

```bash
# Crear entorno virtual
python -m venv venv

# Activar entorno virtual
# En Windows:
venv\Scripts\activate
# En Mac/Linux:
source venv/bin/activate

# Instalar dependencias
pip install -r requirements.txt

# Ejecutar la aplicación
python app.py

# Ejecutar tests
pytest test_app.py -v
```

---

## 📡 Endpoints de la API

### GET `/`
Información general de la API
```bash
curl http://localhost:5000/
```

### GET `/health`
Estado de salud de la aplicación
```bash
curl http://localhost:5000/health
```

### GET `/tasks`
Obtener todas las tareas
```bash
curl http://localhost:5000/tasks
```

### GET `/tasks/<id>`
Obtener una tarea específica
```bash
curl http://localhost:5000/tasks/1
```

### POST `/tasks`
Crear una nueva tarea
```bash
curl -X POST http://localhost:5000/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Mi nueva tarea", "completed": false}'
```

### PUT `/tasks/<id>`
Actualizar una tarea
```bash
curl -X PUT http://localhost:5000/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{"title": "Tarea actualizada", "completed": true}'
```

### DELETE `/tasks/<id>`
Eliminar una tarea
```bash
curl -X DELETE http://localhost:5000/tasks/1
```

---

## 🤖 GitHub Actions

El proyecto incluye un pipeline de CI/CD que se ejecuta automáticamente cuando haces push:

1. ✅ **Build and Test** - Instala dependencias y ejecuta tests
2. 🐳 **Build Docker** - Construye la imagen Docker
3. 🧪 **Test Docker Image** - Prueba que la imagen funciona correctamente

### Configurar GitHub Actions

1. Crea un repositorio en GitHub
2. Sube tu código:
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/tu-usuario/tu-repo.git
git push -u origin main
```

3. Ve a la pestaña "Actions" en GitHub para ver el pipeline en ejecución

### (Opcional) Subir a Docker Hub

1. Crea una cuenta en [Docker Hub](https://hub.docker.com)
2. En GitHub, ve a Settings → Secrets and variables → Actions
3. Agrega estos secrets:
   - `DOCKER_USERNAME` - Tu usuario de Docker Hub
   - `DOCKER_PASSWORD` - Tu token de Docker Hub
4. Descomenta las secciones de login y push en `.github/workflows/docker-ci.yml`

---

## 🛠️ Comandos Docker Útiles

### Gestión de Contenedores

```bash
# Ver contenedores corriendo
docker ps

# Ver TODOS los contenedores (incluso detenidos)
docker ps -a

# Detener un contenedor
docker stop mi-task-api

# Iniciar un contenedor detenido
docker start mi-task-api

# Reiniciar un contenedor
docker restart mi-task-api

# Eliminar un contenedor (debe estar detenido)
docker rm mi-task-api

# Forzar eliminación de contenedor corriendo
docker rm -f mi-task-api

# Ver logs de un contenedor
docker logs mi-task-api

# Seguir logs en tiempo real
docker logs -f mi-task-api

# Ejecutar un comando dentro del contenedor
docker exec -it mi-task-api bash
```

### Gestión de Imágenes

```bash
# Ver todas las imágenes
docker images

# Eliminar una imagen
docker rmi task-api:latest

# Eliminar imágenes no usadas
docker image prune

# Ver espacio usado por Docker
docker system df

# Limpiar todo (cuidado!)
docker system prune -a
```

### Información y Debugging

```bash
# Ver información detallada de un contenedor
docker inspect mi-task-api

# Ver estadísticas en tiempo real
docker stats

# Ver procesos corriendo en un contenedor
docker top mi-task-api
```

### Tags y Versiones

```bash
# Crear diferentes versiones de tu imagen
docker build -t task-api:v1.0 .
docker build -t task-api:v2.0 .
docker build -t task-api:latest .

# Ver todas las versiones
docker images task-api
```

---

## 🎯 Flujo de Trabajo Típico

1. **Desarrollas tu código**
2. **Construyes la imagen**: `docker build -t task-api .`
3. **Pruebas localmente**: `docker run -p 5000:5000 task-api`
4. **Commiteas y pusheas a GitHub**
5. **GitHub Actions construye y testea automáticamente**
6. **Subes la imagen a Docker Hub** (opcional)
7. **Despliegas en producción** desde Docker Hub

---

## 📚 Recursos Adicionales

- [Documentación oficial de Docker](https://docs.docker.com)
- [Docker Hub](https://hub.docker.com)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Flask Documentation](https://flask.palletsprojects.com)

---

## 🐛 Troubleshooting

### Puerto 5000 ya está en uso
```bash
# Ver qué está usando el puerto
lsof -i :5000

# Usar otro puerto
docker run -p 3000:5000 task-api
```

### Cambios no se reflejan
```bash
# Reconstruir la imagen sin cache
docker build --no-cache -t task-api .
```

### Contenedor no inicia
```bash
# Ver logs para diagnosticar
docker logs mi-task-api

# Ejecutar interactivamente para ver errores
docker run -it task-api
```

---

## ✨ Próximos Pasos

- 🔹 Agregar una base de datos (PostgreSQL) con Docker Compose
- 🔹 Implementar autenticación JWT
- 🔹 Agregar más tests
- 🔹 Deploy en Railway, Render o AWS
- 🔹 Configurar monitoring con Prometheus

---

**¡Listo! Ahora sabes usar Docker 🐳**
