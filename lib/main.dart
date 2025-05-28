import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'screens/splash_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/location_picker_page.dart';
import 'screens/instant_translate_page.dart';
import 'screens/video_translator_page.dart';
import 'screens/submission_success_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();          // ← نحصل على الكاميرات مرة واحدة فقط
  runApp(MyApp(cameras: cameras));                   // ← نمرِّرها إلى MyApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.cameras});
  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESHARA App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Arial'),
      initialRoute: '/',
      routes: {
        '/':        (_) => const SplashScreen(),
        '/signup':  (_) => SignUpScreen(cameras: cameras),   // ← سنعدّله بالأسفل
        '/home':    (_) => HomeScreen(cameras: cameras),     // ← تمرير الكاميرات
        '/location':(_) => const LocationPickerPage(),
        '/instant': (_) => const InstantTranslatePage(),
        '/video':   (_) => VideoTranslatorPage(cameras: cameras),
        '/success': (_) => const SubmissionSuccessPage(),
      },
    );
  }
}
