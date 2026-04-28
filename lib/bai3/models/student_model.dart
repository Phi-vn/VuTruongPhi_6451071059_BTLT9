import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  final String id;
  final String name;
  final int age;
  final String major;

  StudentModel({
    required this.id,
    required this.name,
    required this.age,
    required this.major,
  });

  factory StudentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return StudentModel(
      id: doc.id,
      name: data['name'] ?? '',
      age: data['age'] is int ? data['age'] : int.tryParse(data['age']?.toString() ?? '0') ?? 0,
      major: data['major'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'major': major,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
