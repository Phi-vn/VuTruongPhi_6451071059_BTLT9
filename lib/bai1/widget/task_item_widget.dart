import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../controllers/todo_controller.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel task;
  final TodoController controller;

  const TaskItemWidget({
    Key? key,
    required this.task,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        controller.deleteTask(task.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: CheckboxListTile(
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          value: task.isDone,
          onChanged: (bool? value) {
            controller.toggleTaskStatus(task.id, task.isDone);
          },
        ),
      ),
    );
  }
}
