# 🚀 Guía Rápida de Inicio

## ⚡ Inicio Rápido con Docker (Recomendado)

### 1️⃣ Construir la imagen
```bash
docker build -t task-api .
```

### 2️⃣ Ejecutar el contenedor
```bash
docker run -d -p 5000:5000 --name task-api-container task-api
```

### 3️⃣ Verificar que funciona
```bash
curl http://localhost:5000
```

¡Listo! Tu API está corriendo en http://localhost:5000

---

## 🎮 Usando el Script Helper (Más fácil)

```bash
# Dar permisos de ejecución
chmod +x docker-helper.sh

# Ejecutar el script
./docker-helper.sh
```

El script te mostrará un menú interactivo con todas las opciones.

---

## 🛠️ Usando Makefile (Para desarrolladores)

```bash
# Ver todos los comandos disponibles
make help

# Construir imagen
make build

# Ejecutar contenedor
make run

# Ver logs
make logs

# Detener y limpiar
make clean

# Reconstruir todo
make rebuild
```

---

## 📦 Usando Docker Compose (La más simple)

```bash
# Iniciar todo
docker-compose up -d

# Ver logs
docker-compose logs -f

# Detener
docker-compose down

# Reconstruir después de cambios
docker-compose up -d --build
```

---

## 🧪 Probar la API

### Con curl:
```bash
# Ver todas las tareas
curl http://localhost:5000/tasks

# Crear una tarea
curl -X POST http://localhost:5000/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Mi primera tarea"}'

# Ver una tarea específica
curl http://localhost:5000/tasks/1
```

### Con el navegador:
Abre http://localhost:5000 en tu navegador

---

## 📝 Comandos Docker Esenciales

```bash
# Ver contenedores corriendo
docker ps

# Ver logs
docker logs task-api-container

# Detener contenedor
docker stop task-api-container

# Reiniciar contenedor
docker restart task-api-container

# Eliminar contenedor
docker rm task-api-container

# Ver imágenes
docker images

# Eliminar imagen
docker rmi task-api
```

---

## 🐛 Problemas Comunes

### El puerto 5000 ya está en uso
```bash
# Usar otro puerto
docker run -d -p 3000:5000 --name task-api-container task-api
```

### El contenedor ya existe
```bash
# Eliminar el contenedor existente
docker rm -f task-api-container

# Luego ejecutar de nuevo
docker run -d -p 5000:5000 --name task-api-container task-api
```

### Los cambios no se reflejan
```bash
# Reconstruir sin cache
docker build --no-cache -t task-api .
```

---

## 🎯 Siguiente Paso

Lee el README.md completo para entender más sobre Docker, GitHub Actions y todos los detalles del proyecto.

¡Disfruta aprendiendo Docker! 🐳
