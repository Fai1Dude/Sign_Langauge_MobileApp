// lib/screens/no_lessons_page.dart
import 'package:flutter/material.dart';

class NoLessonsPage extends StatelessWidget {
  const NoLessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('دروس لغة الإشارة')),
      body: const Center(
        child: Text(
          'لم يتم إضافة دروس حتى الآن',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
