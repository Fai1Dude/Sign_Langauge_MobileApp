/* ─────────── lib/screens/signup_screen.dart ─────────── */
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'home_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.cameras});

  /// القائمة التي استُخرجت في `main.dart`
  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6ECF9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('تسجيل دخول', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),
            _buildTextField(label: 'الاسم'),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'البريد الإلكتروني',
              keyboard: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            _buildTextField(label: 'كلمة المرور', obscure: true),
            const SizedBox(height: 30),

            /* زر تسجيل الدخول */
            ElevatedButton(
              onPressed: () {
                // بعد “التسجيل” انتقل لواجهة المنزل مع تمرير الكاميرات
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomeScreen(cameras: cameras),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('تسجيل الدخول'),
            ),
            const SizedBox(height: 20),

            /* تسجيل عبر Google – غير مفعّل الآن */
            ElevatedButton.icon(
              onPressed: () {/* TODO: Google sign-in */},
              icon: const Icon(Icons.login),
              label: const Text('التسجيل عبر Google'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                side: const BorderSide(color: Colors.grey),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 20),

            /* رابط إنشاء حساب جديد – تحوّل لشاشة أخرى عند اللزوم */
            ElevatedButton.icon(
              onPressed: () {/* TODO: Navigate to sign-up form */},
              icon: const Icon(Icons.person_add),
              label: const Text('ليس لدي حساب؟ تسجيل جديد'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                side: const BorderSide(color: Colors.grey),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* حقل نصي جاهز للاستخدام */
  Widget _buildTextField({
    required String label,
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      obscureText: obscure,
      keyboardType: keyboard,
      textDirection: TextDirection.rtl,
    );
  }
}
