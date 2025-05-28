import 'package:flutter/material.dart';

/// رسالة ثابتة تُعرض عندما لا تتوفّر مواقع تدعم لغة الإشارة.
class NoSignLocationPage extends StatelessWidget {
  const NoSignLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الموقع')),
      body: const Center(
        child: Text(
          'لا يوجد حولك موقع يدعم لغة الإشارة',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, color: Colors.red),
        ),
      ),
    );
  }
}
