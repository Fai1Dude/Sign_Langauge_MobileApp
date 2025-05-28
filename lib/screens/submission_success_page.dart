import 'package:flutter/material.dart';

class SubmissionSuccessPage extends StatelessWidget {
  const SubmissionSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             const Icon(Icons.check_circle, color: Colors.green, size: 100),
             const SizedBox(height: 20),
             const Text(
               'تم استلام بلاغك بنجاح',
               style: TextStyle(fontSize: 24, color: Colors.green),
             ),
             const SizedBox(height: 40),
             ElevatedButton(
               onPressed: () {
                 // Clear the navigation stack and go back to HomeScreen
                 Navigator.pushNamedAndRemoveUntil(
                   context,
                   '/home',
                   (route) => false,
                 );
               },
               child: const Text('استمرار'),
             ),
           ],
        ),
      ),
    );
  }
}
