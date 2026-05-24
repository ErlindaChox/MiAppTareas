import '../models/task.dart';

class TaskService {
  final List<Task> _tasks = [];

  List<Task> getTasks() {
    return _tasks;
  }

  void addTask(Task task) {
    _tasks.add(task);
  }

  void deleteTask(int id) {
    _tasks.removeWhere((task) => task.id == id);
  }

  void updateTask(Task updatedTask) {
    int index = _tasks.indexWhere((task) => task.id == updatedTask.id);

    if (index != -1) {
      _tasks[index] = updatedTask;
    }
  }
}