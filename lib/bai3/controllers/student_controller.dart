import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student_model.dart';

class StudentController {
  final CollectionReference _studentsCollection =
      FirebaseFirestore.instance.collection('students');

  // Lấy danh sách realtime
  Stream<List<StudentModel>> getStudentsStream() {
    return _studentsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => StudentModel.fromFirestore(doc))
          .toList();
    });
  }

  // Thêm sinh viên vào CSDL
  Future<void> addStudent(String name, int age, String major) async {
    final data = {
      'name': name,
      'age': age,
      'major': major,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await _studentsCollection.add(data);
  }

  // Xóa sinh viên
  Future<void> deleteStudent(String studentId) async {
    await _studentsCollection.doc(studentId).delete();
  }

  // Nạp dữ liệu mẫu (Seeding)
  Future<void> seedStudents() async {
    final List<Map<String, dynamic>> sampleData = [
      {'name': 'Nguyễn Văn A', 'age': 20, 'major': 'Công nghệ thông tin', 'createdAt': FieldValue.serverTimestamp()},
      {'name': 'Trần Thị B', 'age': 21, 'major': 'Kinh tế', 'createdAt': FieldValue.serverTimestamp()},
      {'name': 'Lê Văn C', 'age': 22, 'major': 'Ngôn ngữ Anh', 'createdAt': FieldValue.serverTimestamp()},
      {'name': 'Phạm Minh D', 'age': 19, 'major': 'Thiết kế đồ họa', 'createdAt': FieldValue.serverTimestamp()},
    ];

    for (var data in sampleData) {
      await _studentsCollection.add(data);
    }
  }
}
