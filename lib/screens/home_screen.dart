// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'location_picker_page.dart';
import 'instant_translate_page.dart';
import 'video_translator_page.dart';

/*──────────────────────── الصفحة الرئيسية ────────────────────────*/
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.cameras});

  final List<CameraDescription> cameras; // يُمرَّر من main.dart

  /* زرّ مكالمة طوارئ صغير */
  Widget _emergencyButton(BuildContext context) => ElevatedButton.icon(
        icon: const Icon(Icons.call),
        label: const Text('مكالمة طوارئ'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        onPressed: () => _showEmergencySheet(context),
      );

  /* bottom-sheet لاختيار جهة الطوارئ */
  void _showEmergencySheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _emergencyOption(ctx, Icons.local_hospital, 'الإسعاف'),
          const SizedBox(height: 10),
          _emergencyOption(ctx, Icons.local_police, 'الشرطة'),
          const SizedBox(height: 10),
          _emergencyOption(ctx, Icons.fire_truck, 'الدفاع المدني'),
        ]),
      ),
    );
  }

  Widget _emergencyOption(BuildContext ctx, IconData icon, String label) =>
      ElevatedButton.icon(
        onPressed: () async {
          Navigator.pop(ctx);
          await Navigator.push(
            ctx,
            MaterialPageRoute(builder: (_) => const LocationPickerPage()),
          );
        },
        icon: Icon(icon, size: 28),
        label: Text(label, style: const TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[600],
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(50),
        ),
      );

  /* بلاط واحد */
  Widget _tile(BuildContext ctx,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 40),
            const SizedBox(height: 10),
            Text(title,
                textAlign: TextAlign.center, textDirection: TextDirection.rtl),
          ]),
        ),
      ),
    );
  }

  /*──────────────── UI ────────────────*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6ECF9),
      body: SafeArea(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text('الصفحة الرئيسية',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl),
          ),
          const SizedBox(height: 20),
          _emergencyButton(context),
          const SizedBox(height: 30),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _tile(
                  context,
                  icon: Icons.menu_book,
                  title: 'دروس لغة الإشارة',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LessonsPlaceholder()),
                  ),
                ),
                _tile(
                  context,
                  icon: Icons.g_translate,
                  title: 'لغة الترجمة',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => VideoTranslatorPage(cameras: cameras)),
                  ),
                ),
                _tile(
                  context,
                  icon: Icons.videocam,
                  title: 'الترجمة الفورية',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const InstantTranslatePage()),
                  ),
                ),
                _tile(
                  context,
                  icon: Icons.location_on,
                  title: 'الموقع',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const NoSupportLocationPage()),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

/*──────────────────── صفحات Place-holder ────────────────────*/

class NoSupportLocationPage extends StatelessWidget {
  const NoSupportLocationPage({super.key});

  @override
  Widget build(BuildContext context) => _simpleScaffold(
        'لايوجد حولك موقع يدعم لغة الإشارة',
      );
}

class LessonsPlaceholder extends StatelessWidget {
  const LessonsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) =>
      _simpleScaffold('لم يتم إضافة دروس حتى الآن');
}

/* أداة صغيرة لتوحيد صفحة الرسائل */
Widget _simpleScaffold(String msg) => Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(msg,
            style: const TextStyle(fontSize: 20),
            textDirection: TextDirection.rtl),
      ),
    );
