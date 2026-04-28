import 'package:flutter/material.dart';
import '../controllers/student_controller.dart';

class StudentFormView extends StatefulWidget {
  const StudentFormView({Key? key}) : super(key: key);

  @override
  State<StudentFormView> createState() => _StudentFormViewState();
}

class _StudentFormViewState extends State<StudentFormView> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _majorController = TextEditingController();
  final StudentController _controller = StudentController();
  final _formKey = GlobalKey<FormState>();

  bool _isSaving = false;

  Future<void> _saveStudent() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    
    try {
      await _controller.addStudent(
        _nameController.text.trim(),
        int.parse(_ageController.text.trim()),
        _majorController.text.trim(),
      );
      if (mounted) {
        Navigator.pop(context); // Trở về danh sách sau khi đăng thành công
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Có lỗi xảy ra: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm sinh viên - MSSV: 6451071059', style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.teal.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Họ và Tên sinh viên',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (val) => val != null && val.trim().isEmpty ? 'Không được để trống' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Tuổi',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.cake),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Chưa nhập tuổi';
                  if (int.tryParse(val) == null) return 'Tuổi phải là một số';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _majorController,
                decoration: InputDecoration(
                  labelText: 'Chuyên ngành',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.school),
                ),
                validator: (val) => val != null && val.trim().isEmpty ? 'Không được để trống' : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _isSaving ? null : _saveStudent,
                  icon: _isSaving ? const SizedBox.shrink() : const Icon(Icons.save),
                  label: _isSaving ? const CircularProgressIndicator() : const Text('LƯU THÔNG TIN', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
