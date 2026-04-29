import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';
import '../utils/constants.dart';

class TodoController {
  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection(AppConstants.tasksCollection);

  // Get stream of list tasks
  Stream<List<TaskModel>> getTasksStream() {
    return _tasksCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => TaskModel.fromFirestore(doc)).toList();
    });
  }

  // Add new task
  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) return;
    await _tasksCollection.add({
      'title': title.trim(),
      'isDone': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Toggle task status
  Future<void> toggleTaskStatus(String id, bool currentStatus) async {
    await _tasksCollection.doc(id).update({
      'isDone': !currentStatus,
    });
  }

  // Delete task
  Future<void> deleteTask(String id) async {
    await _tasksCollection.doc(id).delete();
  }

  // Nạp dữ liệu mẫu
  Future<void> seedTasks() async {
    final List<String> sampleTasks = [
      'Học Flutter cơ bản',
      'Kết nối Firebase Firestore',
      'Xây dựng giao diện quản lý',
      'Đẩy code lên GitHub',
    ];

    for (var title in sampleTasks) {
      await addTask(title);
    }
  }
}
