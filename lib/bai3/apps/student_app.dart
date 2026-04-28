import 'package:flutter/material.dart';
import '../views/student_list_view.dart';

class StudentApp extends StatelessWidget {
  const StudentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý Sinh Viên',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const StudentListView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
