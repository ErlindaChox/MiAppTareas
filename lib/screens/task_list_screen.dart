import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskService _taskService = TaskService();

  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.isEmpty) return;

    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _controller.text,
      description: '',
      isCompleted: false,
    );

    setState(() {
      _taskService.addTask(task);
    });

    _controller.clear();
  }

  void _deleteTask(int id) {
    setState(() {
      _taskService.deleteTask(id);
    });
  }

  void _updateTask(Task task) {
    final TextEditingController editController =
        TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar tarea'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              labelText: 'Nuevo nombre',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedTask = Task(
                  id: task.id,
                  title: editController.text,
                  description: task.description,
                  isCompleted: task.isCompleted,
                );

                setState(() {
                  _taskService.updateTask(updatedTask);
                });

                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasks = _taskService.getTasks();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Tareas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Nueva tarea',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Agregar'),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  return Card(
                    child: ListTile(
                      title: Text(task.title),

                      onTap: () {
                        _updateTask(task);
                      },

                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteTask(task.id);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}