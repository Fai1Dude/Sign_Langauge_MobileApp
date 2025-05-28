// lib/screens/video_translator_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoTranslatorPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const VideoTranslatorPage({super.key, required this.cameras});

  @override
  State<VideoTranslatorPage> createState() => _VideoTranslatorPageState();
}

class _VideoTranslatorPageState extends State<VideoTranslatorPage> {
  late CameraController _cam;
  bool _camReady = false, _camError = false;

  // ــــــ حالة الرسالة ــــــ
  String _display = 'جاري الترجمة';
  late Timer _ellipsisTimer;
  Timer? _resultTimer;
  int _dotCount = 0;
  bool _finished = false;

  /*────────── تهيئة ─────────*/
  @override
  void initState() {
    super.initState();
    _initCamera();
    _startEllipsis();
  }

  Future<void> _initCamera() async {
    // إذن الكاميرا
    if (!(await Permission.camera.request()).isGranted ||
        widget.cameras.isEmpty) {
      setState(() => _camError = true);
      return;
    }

    // اختر الكاميرا الأمامية إن وُجدت
    final desc = widget.cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
      orElse: () => widget.cameras.first,
    );

    _cam = CameraController(
      desc,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    try {
      await _cam.initialize();
      setState(() => _camReady = true);
    } catch (_) {
      setState(() => _camError = true);
    }
  }

  /*────────── مؤشّر الترجمة المتحرك ─────────*/
  void _startEllipsis() {
    // يغيّر النقاط كل 400 مللي ثانية
    _ellipsisTimer = Timer.periodic(const Duration(milliseconds: 400), (_) {
      if (_finished) return;
      setState(() {
        _dotCount = (_dotCount + 1) % 4; // 0‒3
        _display = 'جاري الترجمة' + '.' * _dotCount;
      });
    });

    // بعد 5 ثوانٍ: النتيجة النهائية
    _resultTimer = Timer(const Duration(seconds: 5), () {
      _finished = true;
      _ellipsisTimer.cancel();
      setState(() => _display = 'احتاج المساعدة');
    });
  }

  /*────────── تنظيف ─────────*/
  @override
  void dispose() {
    if (_camReady) _cam.dispose();
    _ellipsisTimer.cancel();
    _resultTimer?.cancel();
    super.dispose();
  }

  /*────────── واجهة المستخدم ─────────*/
  @override
  Widget build(BuildContext context) {
    if (_camError) {
      return const Scaffold(
        body: Center(
          child: Text(
            'تعذّر فتح الكاميرا',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    if (!_camReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          // الكاميرا في الوسط
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: _cam.value.aspectRatio,
                child: CameraPreview(_cam),
              ),
            ),
          ),
          // شريط الترجمة
          Container(
            width: double.infinity,
            color: Colors.black12,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              _display,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          // زر «استمرار» يظهر فقط بعد الانتهاء
          if (_finished)
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/success'),
                child: const Text('استمرار'),
              ),
            ),
        ],
      ),
    );
  }
}
