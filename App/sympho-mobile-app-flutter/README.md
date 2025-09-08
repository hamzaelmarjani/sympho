<div style="text-align: center;">

# 📱 Sympho Mobile App—Flutter

Open source, free, Well designed, user-friendly, and easy to use Flutter mobile app for - [Sympho](https://github.com/hamzaelmarjani/sympho) project.

</div>

---

## Features

- **Beautiful & Friendly UI/UX** — built with [Shadcn/ui](https://ui.shadcn.com/) style. ✅
  Special thanks to the author of [shadcn_flutter](https://pub.dev/packages/shadcn_flutter) for his great package. ✅
- **Ready to Publish app** — for both **iOS** and **Android**. ✅
- **State management** - thanks to [Provider](https://pub.dev/packages/provider). ✅
- Send prompt to **API server**, and handle the response & errors. ✅
- Display/play the generated audios on the app. ✅
- **20+ ElevenLabs voices** for both genders male/female. ✅
- Advanced voice settings: **Stability**, **Similarity**, **Style**, **Speed** and **Speacker Boost**. ✅
- Store generated audios locally, **secured**, thanks to [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage). ✅
- Ability to save the generated audios to **device files**. ✅
- Ability to share the generated audios with **Platform Share Modal**, thanks to [share_plus](https://pub.dev/packages/share_plus). ✅
- **Remove** the generated audios from the app and locale storage. ⏳
- Implement app **Settings** page to let theuser change the theme, colors, sizes and more. ⏳
- **Persist** the latest used voice settings, latest used voice id and more UI state for seamless user-expereince. ⏳

---

## Services

**Sympho** project comes with many AI Speech solutions, the available until now:

- TTS: Text-to-Speech. ✅
- STT: Speech-to-Text API. ⏳
- TTD: Text-to-Dialogue API. ⏳
- TTV: Text-to-Voice API. ⏳
- TTM: Text-to-Music API. ⏳
- SFX: Sound Effects API. ⏳
- VC: Voice Changer API. ⏳
- AUI: Audio Isolation API. ⏳
- DUB: Dubbing API. ⏳

---

## Usage

1. Install [Dart](https://dart.dev/get-dart) language and set up [](https://docs.flutter.dev/get-started/install)the Flutter environment.

2. Download this [repository](https://github.com/hamzaelmarjani/sympho/), and open it in your work folder; you can use this [tool](https://download-directory.github.io/) to download only a dir without downloading or cloning the whole repository code.

3. Open the folder in your terminal or command line, then open it on your favorite code editor (VScode, Android Studio, etc).

4. Updating Theme: open `lib/data/theme/shadcn.dart` file, and change the `ShadcnThemer` variable to your desired colors, sizes, fonts, etc.
 
5. Updating Voices Male/Female: open `lib/data/voices/male-female/.dart` file, and change `isPro` field to `true` or `false` to make the voice `Pro` or `Free`. **_IMPORTANT_**: Don't change the voice `id` field, otherwise ElevenLabs will not detect this voice.

6. Run your server app. Optional: Update the `baseUrl` variable in `lib/data/urls/server.dart` file with your API server url, default url is `http://localhost:8080` if you didn't change it.

7. **_NOTE_**: If you want to run the app on Android device or emulator, run this command first: `adb reverse tcp:8080 tcp:8080` change 8080 with your API server Port.

8. Run the app on your emulator or real device.

---

## Build & Publish

Before building the app, make sure you have updated the app icon, app name, app package name and app splash screen.

- App Icon:
  + Update the app icon under: `assets/app-icon.png`, use a tool like [appicon.co](https://appicon.co/) or [icon.kitchen](https://icon.kitchen/) to generate the app icon.
  + Open the project folder on the terminal or command line.
  + Make sure you install the dependencies, run: `flutter pub get`.
  + Generate the app icon, run: `dart run icons_launcher:create`.


- App Name & Package Name:
   + Open the file `pubspec.yaml` and update the `app_name`, `package_name` and `bundle_name` variables, you can find them below `package_rename_config`.
   + Open the project folder on the terminal or command line.
   + Make sure you install the dependencies, run: `flutter pub get`.
   + Generate the app names, run: `dart run package_rename`.


- App Splash Screen:
    + Update the splash screen under: `assets/splash-screen.png`, make ure the image is vertical 9:16.
    + Open the project folder on the terminal or command line.
    + Make sure you install the dependencies, run: `flutter pub get`.
    + Generate the app icon, run: `dart run flutter_native_splash:create`.
    + NOTE: if you want to remove the splash screen, you can run: `dart run flutter_native_splash:remove`.

Your app now readies to **build and publish**. Follow the flutter [official guide—iOS](https://flutter.dev/docs/deployment/ios), or the flutter [official guide—Android](https://flutter.dev/docs/deployment/android) to build and publish the app.


## License

Licensed under either of:

- [MIT License](LICENSE-MIT)
- [Apache License, Version 2.0](LICENSE-APACHE)

at your option.

---

## Contributing

Contributions are welcome! Please feel free to:

- Open issues for bugs or feature requests
- Submit pull requests with improvements
- Improve documentation or examples
- Add tests or benchmarks

Before contributing, please ensure your code follows Rust conventions and includes appropriate tests.

---

## 📬 Contact & Hire Me

🚀 Want to add more advanced features to this app?  I’ve got you covered! You can hire me.

**Company or Startup?** I can work **full-time** or **part-time**, 👉 **Remote** or **On-site**.

💌 Reach me at: **hamzaelmarjani@gmail.com**

✨ Thank you!

---

## Support

If you like this project, consider supporting me on Patreon 💖

[![patreon](https://img.shields.io/badge/Support-Open_Source-black?style=for-the-badge&logo=Patreon&logoColor=white)](https://www.patreon.com/elmarjanihamza/gift)

---

❤️ Thanks for reading, Happy Coding 💻