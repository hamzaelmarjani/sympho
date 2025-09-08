import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/components/app-bar/bar.dart';
import 'package:sympho/components/prompt/sender.dart';
import 'package:sympho/components/prompt/settings/settings.dart';
import 'package:sympho/components/prompt/textarea.dart';
import 'package:sympho/components/prompt/voices/voices.dart';
import 'package:sympho/provider/data/audios.dart';
import 'package:sympho/provider/data/prompt.dart';
import 'package:sympho/provider/data/settings.dart';
import 'package:sympho/provider/ui/generate.dart';
import 'package:sympho/provider/ui/navbar.dart';
import 'package:sympho/data/theme/shadcn.dart';
import 'components/generations/snapshot.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Force the app to keep the splash screen until we load the necessary elements.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Force the device be on portraitUp mode only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// Force the app to use dark mode only
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
  );

  runApp(
    MultiProvider(
      /// Put all your providers within: initAllProviders
      providers: [
        ChangeNotifierProvider(create: (_) => NavbarProvider()),
        ChangeNotifierProvider(create: (_) => PromptTextProvider()),
        ChangeNotifierProvider(create: (_) => PromptVoiceProvider()),
        ChangeNotifierProvider(
          create: (_) => PromptVoiceGenderFilterProvider(),
        ),
        ChangeNotifierProvider(create: (_) => PromptSettingsProvider()),
        ChangeNotifierProvider(create: (_) => GenerateTTSProcessProvider()),
        ChangeNotifierProvider(create: (_) => GeneratedAudiosProvider()),
      ],
      child: ShadcnApp(
        debugShowCheckedModeBanner: false,
        theme: ShadcnThemer().shadcnTheme,
        home: SymphoApp(),
      ),
    ),
  );
}

class SymphoApp extends StatefulWidget {
  const SymphoApp({super.key});

  @override
  State<SymphoApp> createState() => _SymphoAppState();
}

class _SymphoAppState extends State<SymphoApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// We can call all Initialization method required by our widgets

      /// 1. Stored `GeneratedAudio` instance if exists
      GeneratedAudiosProvider generatedAudiosProvider =
          Provider.of<GeneratedAudiosProvider>(context, listen: false);
      await generatedAudiosProvider.collectGeneratedAudios();

      /// 2. remove the Splash screen persistent
      FlutterNativeSplash.remove();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: ShadcnThemer().shadcnTheme.colorScheme.background,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        child: Consumer<NavbarProvider>(
          builder: (context, navbar, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UIAppBar().withPadding(horizontal: 8),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          children: [PromptTextArea(), GenerationsSnapshot()],
                        ).gap(16),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [PromptVoices(), PromptSettings()],
                          ),
                          PromptSender(),
                        ],
                      ).gap(16),
                    ],
                  ).gap(16).withPadding(all: 8),
                ),
              ],
            ).gap(8);
          },
        ),
      ),
    );
  }
}
