import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController();
    final user = authController.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ - MSSV: 6451071059'),
        automaticallyImplyLeading: false, // Prevent physical back navigation to Login
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.green, size: 100),
            const SizedBox(height: 24),
            const Text(
              'Xin chào, bạn đã đăng nhập với email:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              user?.email ?? 'Không xác định',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('ĐĂNG XUẤT'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50),
              ),
              onPressed: () async {
                await authController.signOut();
                if (context.mounted) {
                  Navigator.pop(context); // Go back to login screen
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
