// lib/screens/instant_translate_page.dart
import 'package:flutter/material.dart';

class InstantTranslatePage extends StatefulWidget {
  const InstantTranslatePage({super.key});

  @override
  State<InstantTranslatePage> createState() => _InstantTranslatePageState();
}

class _InstantTranslatePageState extends State<InstantTranslatePage> {
  final TextEditingController _controller = TextEditingController();
  bool _showImage = false;        // نتحكَّم في إظهار الصورة

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الترجمة الفورية')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              textDirection: TextDirection.rtl,
              decoration: const InputDecoration(
                labelText: 'اكتب الكلمات بالعربية',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  // في النسخة المبسَّطة نظهر صورة ثابتة فقط
                  setState(() => _showImage = true);
                }
              },
              child: const Text('ترجمة'),
            ),
            const SizedBox(height: 30),
            if (_showImage)
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/salam.jpeg',    // غيّر المسار إذا لزم
                    fit: BoxFit.contain,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
