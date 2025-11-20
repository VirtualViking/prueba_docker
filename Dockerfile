# Dockerfile - Instrucciones para crear la imagen Docker

# 1. Imagen base: usamos Python 3.11 slim (versión ligera)
FROM python:3.11-slim

# 2. Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# 3. Copiar el archivo de dependencias primero (para aprovechar cache de Docker)
COPY requirements.txt .

# 4. Instalar las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar el código de la aplicación al contenedor
COPY app.py .

# 6. Exponer el puerto donde correrá la aplicación
EXPOSE 5000

# 7. Variables de entorno
ENV FLASK_APP=app.py
ENV FLASK_ENV=production

# 8. Comando para ejecutar la aplicación cuando el contenedor inicie
CMD ["python", "app.py"]
