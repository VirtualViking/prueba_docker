from flask import Flask, jsonify, request
from datetime import datetime

app = Flask(__name__)

# Base de datos en memoria (simple)
tasks = [
    {"id": 1, "title": "Aprender Docker", "completed": False, "created_at": "2024-11-19"},
    {"id": 2, "title": "Configurar GitHub Actions", "completed": False, "created_at": "2024-11-19"}
]

@app.route('/')
def home():
    return jsonify({
        "message": "🚀 API de Tareas - version 2 de docker!",
        "version": "1.0.0",
        "endpoints": {
            "GET /tasks": "Obtener todas las tareas",
            "GET /tasks/<id>": "Obtener una tarea específica",
            "POST /tasks": "Crear una nueva tarea",
            "PUT /tasks/<id>": "Actualizar una tarea",
            "DELETE /tasks/<id>": "Eliminar una tarea"
        }
    })

@app.route('/health')
def health():
    return jsonify({"status": "healthy", "timestamp": datetime.now().isoformat()})

@app.route('/tasks', methods=['GET'])
def get_tasks():
    return jsonify({"tasks": tasks, "total": len(tasks)})

@app.route('/tasks/<int:task_id>', methods=['GET'])
def get_task(task_id):
    task = next((t for t in tasks if t["id"] == task_id), None)
    if task:
        return jsonify(task)
    return jsonify({"error": "Tarea no encontrada"}), 404

@app.route('/tasks', methods=['POST'])
def create_task():
    data = request.get_json()
    
    if not data or 'title' not in data:
        return jsonify({"error": "El campo 'title' es requerido"}), 400
    
    new_task = {
        "id": max([t["id"] for t in tasks]) + 1 if tasks else 1,
        "title": data["title"],
        "completed": data.get("completed", False),
        "created_at": datetime.now().strftime("%Y-%m-%d")
    }
    
    tasks.append(new_task)
    return jsonify(new_task), 201

@app.route('/tasks/<int:task_id>', methods=['PUT'])
def update_task(task_id):
    task = next((t for t in tasks if t["id"] == task_id), None)
    
    if not task:
        return jsonify({"error": "Tarea no encontrada"}), 404
    
    data = request.get_json()
    task["title"] = data.get("title", task["title"])
    task["completed"] = data.get("completed", task["completed"])
    
    return jsonify(task)

@app.route('/tasks/<int:task_id>', methods=['DELETE'])
def delete_task(task_id):
    global tasks
    task = next((t for t in tasks if t["id"] == task_id), None)
    
    if not task:
        return jsonify({"error": "Tarea no encontrada"}), 404
    
    tasks = [t for t in tasks if t["id"] != task_id]
    return jsonify({"message": "Tarea eliminada", "id": task_id})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
