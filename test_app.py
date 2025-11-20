import pytest
import json
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home(client):
    """Test endpoint principal"""
    response = client.get('/')
    assert response.status_code == 200
    data = json.loads(response.data)
    assert 'message' in data
    assert 'version' in data

def test_health(client):
    """Test endpoint de health check"""
    response = client.get('/health')
    assert response.status_code == 200
    data = json.loads(response.data)
    assert data['status'] == 'healthy'

def test_get_tasks(client):
    """Test obtener todas las tareas"""
    response = client.get('/tasks')
    assert response.status_code == 200
    data = json.loads(response.data)
    assert 'tasks' in data
    assert 'total' in data

def test_create_task(client):
    """Test crear una nueva tarea"""
    new_task = {"title": "Nueva tarea de prueba"}
    response = client.post('/tasks',
                          data=json.dumps(new_task),
                          content_type='application/json')
    assert response.status_code == 201
    data = json.loads(response.data)
    assert data['title'] == "Nueva tarea de prueba"
    assert 'id' in data

def test_create_task_without_title(client):
    """Test crear tarea sin título (debe fallar)"""
    response = client.post('/tasks',
                          data=json.dumps({}),
                          content_type='application/json')
    assert response.status_code == 400
