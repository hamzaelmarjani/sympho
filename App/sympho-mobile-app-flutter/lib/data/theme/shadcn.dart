import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ShadcnThemer {
  ThemeData shadcnTheme = ThemeData(
    colorScheme: ColorSchemes.darkDefaultColor.copyWith(
      primary: () => Color(0xFF2ec4b6),
      secondary: () => Color(0xFFffbf69),
      background: () => Color(0xFF0B0E0E),
      foreground: () => Color(0xFFFFFFFF),
      primaryForeground: () => Color(0xFF121A19),
      secondaryForeground: () => Color(0xFF121A1A),
      border: () => Color(0xFF2D4142),
      card: () => Color(0xFF151C1C),
      cardForeground: () => Color(0xFFFFFFFF),
    ),
    radius: 0.5,
    typography: Typography.geist(
      sans: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );

  Color primary() => ColorSchemes.darkDefaultColor.primary;
  Color secondary() => Color(0xFFffbf69);
  Color border() => ColorSchemes.darkDefaultColor.border;
}
