import 'package:flutter/material.dart';
import '../controllers/todo_controller.dart';
import '../models/task_model.dart';
import '../widget/task_item_widget.dart';

class TodoHomeView extends StatefulWidget {
  const TodoHomeView({Key? key}) : super(key: key);

  @override
  State<TodoHomeView> createState() => _TodoHomeViewState();
}

class _TodoHomeViewState extends State<TodoHomeView> {
  final TodoController _controller = TodoController();

  void _showAddTaskDialog() {
    final TextEditingController textController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Thêm công việc',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: textController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Nhập tiêu đề công việc',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    _controller.addTask(textController.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Lưu'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách công việc - MSSV: 6451071059'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            tooltip: 'Thêm việc mẫu',
            icon: const Icon(Icons.auto_awesome),
            onPressed: () async {
              await _controller.addTask('Tập thể dục buổi sáng');
              await _controller.addTask('Hoàn thiện UI Flutter Bài 1');
              await _controller.addTask('Ôn thi kết thúc môn Di động');
              await _controller.addTask('Nộp bài tập trên hệ thống trường');
            },
          ),
        ],
      ),
      body: StreamBuilder<List<TaskModel>>(
        stream: _controller.getTasksStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Đã có lỗi xảy ra! \n${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Chưa có công việc nào. Hãy thêm mới!'),
            );
          }

          final tasks = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskItemWidget(
                task: tasks[index],
                controller: _controller,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
