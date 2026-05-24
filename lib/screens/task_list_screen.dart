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

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = _taskService.getTasks();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Tareas'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Nueva tarea',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {

                if (_controller.text.isNotEmpty) {

                  Task nuevaTask = Task(
                    id: tasks.length + 1,
                    title: _controller.text,
                    description: '',
                    isCompleted: false,
                  );

                  setState(() {
                    _taskService.addTask(nuevaTask);
                  });

                  _controller.clear();
                }

              },

              child: const Text('Agregar'),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,

                itemBuilder: (context, index) {

                  return Card(
                    child: ListTile(
                      title: Text(tasks[index].title),

                      trailing: IconButton(
                        icon: const Icon(Icons.delete),

                        onPressed: () {

                          setState(() {
                            _taskService.deleteTask(tasks[index].id);
                          });

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