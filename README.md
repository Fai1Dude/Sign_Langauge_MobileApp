# ESHARA – Assistive Sign‑Language App

**ESHARA** (إشارة) is a Flutter mobile application that helps Deaf/HoH users communicate and access emergency services in Arabic‐speaking regions.
The project demonstrates:

* Camera access and live‑view UI.
* A *Video Translator* placeholder that can later integrate a TFLite sign‑language model.
* Instant text‑to‑avatar translation using Rive animations.
* Location picker & emergency short‑cuts.
* Modern Flutter 3.22 setup (Material 3, null‑safety) with Kotlin DSL Gradle files.
### There's also apk file that can be downloaded into android device to see the program directly named (Eshara.apk) you can see it on the main repo no need for entering folders
---

## 📂 Project structure

```text
assets/
  images/                 # sample icons / avatars
  rive/                   # avatar.riv + other animations
lib/
  main.dart               # app entry
  screens/
    splash_screen.dart
    signup_screen.dart
    home_screen.dart
    location_picker_page.dart
    instant_translate_page.dart
    video_translator_page.dart   # camera & tflite placeholder
    submission_success_page.dart
  widgets/                # (optional) reusable widgets
  l10n/                   # localisation (AR / EN)
android/                  # Kotlin‑DSL Gradle config
ios/                      # Xcode project
README.md
```

---

## 🚀 Getting started

### Prerequisites

| Tool                   | Minimum version  |
| ---------------------- | ---------------- |
| Flutter SDK            | **3.22**         |
| Android Studio / Xcode | Flamingo / 15.x  |
| Android NDK            | r27 (for tflite) |

```bash
# clone
$ git clone https://github.com/your‑org/eshara.git
$ cd eshara

# fetch packages
$ flutter pub get

# run on device / emulator
$ flutter run
```

> **Note** : The current `video_translator_page` uses a dummy timer, not a real ML model.  To integrate one, add `model.tflite` & `labels.txt` under `assets/` and restore the TFLite logic (see commented code).

---

## 🔑 Features overview

| Screen                 | Description                                                                                                                        |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| **Splash**             | Minimal branded splash then nav to Sign‑Up                                                                                         |
| **Sign‑Up**            | E‑mail + password form (placeholder auth)                                                                                          |
| **Home**               | Tiles for *Sign‑Language Lessons*, *Instant Translate*, *Video Translate*, *Nearby Locations* + *Emergency Call* sheet             |
| **Instant Translate**  | Arabic text → Rive 3D avatar signing (stub with single `avatar.riv`)                                                               |
| **Video Translate**    | Opens front camera, shows “جارى الترجمة …” spinner then "احتاج المساعدة" after 5 s, with **استمرار** button → *Submission Success* |
| **Location Picker**    | Google Maps place‑picker → message “لايوجد حولك موقع يدعم لغة الاشارة”                                                             |
| **Submission Success** | Tick icon + back‑to‑Home                                                                                                           |

---

## 🛠 Customising

1. **Add your ML model**

   * Place `model.tflite` and `labels.txt` in `assets/` and list them in `pubspec.yaml`.
2. **Rive avatar**

   * Export a `.riv` file with artboards named after each sign (`hello`, `yes`, …) to `assets/rive/avatar.riv`.
3. **Maps API key**

   * Put your key in `android/app/src/main/AndroidManifest.xml`:

   ```xml
   <meta-data android:name="com.google.android.geo.API_KEY"
              android:value="YOUR_KEY_HERE"/>
   ```

---

## 🤝 Contributing

Pull requests are welcome!  Please open an issue first to discuss changes.

1. Fork → 2. Create feature branch → 3. Commit/push → 4. PR.
