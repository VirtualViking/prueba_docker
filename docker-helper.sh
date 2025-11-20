#!/bin/bash

# Script de comandos útiles para gestionar la aplicación con Docker

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

IMAGE_NAME="task-api"
CONTAINER_NAME="task-api-container"
PORT="5000"

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}   🐳 Task API - Docker Helper   ${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

function show_menu() {
    echo "Selecciona una opción:"
    echo ""
    echo "1) 🏗️  Construir imagen Docker"
    echo "2) 🚀 Ejecutar contenedor"
    echo "3) 🛑 Detener contenedor"
    echo "4) 🗑️  Eliminar contenedor"
    echo "5) 📋 Ver logs"
    echo "6) 📊 Ver contenedores activos"
    echo "7) 🔄 Reconstruir y ejecutar"
    echo "8) 🧪 Ejecutar tests en contenedor"
    echo "9) 🔍 Inspeccionar contenedor"
    echo "10) 🧹 Limpiar imágenes no usadas"
    echo "11) 🌐 Abrir en navegador"
    echo "0) ❌ Salir"
    echo ""
}

function build_image() {
    echo -e "${YELLOW}Construyendo imagen Docker...${NC}"
    docker build -t ${IMAGE_NAME}:latest .
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Imagen construida exitosamente${NC}"
    else
        echo -e "${RED}❌ Error al construir imagen${NC}"
    fi
}

function run_container() {
    echo -e "${YELLOW}Ejecutando contenedor...${NC}"
    docker run -d -p ${PORT}:5000 --name ${CONTAINER_NAME} ${IMAGE_NAME}:latest
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Contenedor ejecutándose en http://localhost:${PORT}${NC}"
    else
        echo -e "${RED}❌ Error al ejecutar contenedor${NC}"
        echo -e "${YELLOW}Tip: El contenedor ya podría estar corriendo. Intenta detenerlo primero (opción 3)${NC}"
    fi
}

function stop_container() {
    echo -e "${YELLOW}Deteniendo contenedor...${NC}"
    docker stop ${CONTAINER_NAME}
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Contenedor detenido${NC}"
    else
        echo -e "${RED}❌ Error al detener contenedor${NC}"
    fi
}

function remove_container() {
    echo -e "${YELLOW}Eliminando contenedor...${NC}"
    docker rm ${CONTAINER_NAME}
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Contenedor eliminado${NC}"
    else
        echo -e "${RED}❌ Error al eliminar contenedor${NC}"
    fi
}

function show_logs() {
    echo -e "${YELLOW}Mostrando logs (Ctrl+C para salir)...${NC}"
    docker logs -f ${CONTAINER_NAME}
}

function show_containers() {
    echo -e "${YELLOW}Contenedores activos:${NC}"
    docker ps
    echo ""
    echo -e "${YELLOW}Todos los contenedores:${NC}"
    docker ps -a
}

function rebuild_and_run() {
    echo -e "${YELLOW}Reconstruyendo y ejecutando...${NC}"
    docker stop ${CONTAINER_NAME} 2>/dev/null
    docker rm ${CONTAINER_NAME} 2>/dev/null
    build_image
    run_container
}

function run_tests() {
    echo -e "${YELLOW}Ejecutando tests en contenedor...${NC}"
    docker run --rm ${IMAGE_NAME}:latest pytest test_app.py -v
}

function inspect_container() {
    echo -e "${YELLOW}Información del contenedor:${NC}"
    docker inspect ${CONTAINER_NAME}
}

function cleanup_images() {
    echo -e "${YELLOW}Limpiando imágenes no usadas...${NC}"
    docker image prune -f
    echo -e "${GREEN}✅ Limpieza completada${NC}"
}

function open_browser() {
    URL="http://localhost:${PORT}"
    echo -e "${YELLOW}Abriendo ${URL} en el navegador...${NC}"
    
    # Detectar sistema operativo y abrir navegador
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        xdg-open ${URL} 2>/dev/null || echo -e "${RED}No se pudo abrir el navegador${NC}"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        open ${URL}
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        start ${URL}
    else
        echo -e "${YELLOW}Abre manualmente: ${URL}${NC}"
    fi
}

# Main loop
while true; do
    show_menu
    read -p "Opción: " option
    echo ""
    
    case $option in
        1) build_image ;;
        2) run_container ;;
        3) stop_container ;;
        4) remove_container ;;
        5) show_logs ;;
        6) show_containers ;;
        7) rebuild_and_run ;;
        8) run_tests ;;
        9) inspect_container ;;
        10) cleanup_images ;;
        11) open_browser ;;
        0) 
            echo -e "${GREEN}¡Hasta luego! 👋${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Opción inválida${NC}"
            ;;
    esac
    
    echo ""
    read -p "Presiona Enter para continuar..."
    clear
done
