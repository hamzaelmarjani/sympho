import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/provider/ui/navbar.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:sympho/data/theme/shadcn.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavbarProvider>(
      builder: (context, navbar, _) {
        return shadcn.NavigationBar(
          alignment: shadcn.NavigationBarAlignment.spaceBetween,
          labelType: shadcn.NavigationLabelType.all,
          surfaceBlur: 12,
          expanded: true,
          expands: true,
          onSelected: (index) {
            navbar.set(index);
          },
          index: navbar.index,
          children: [
            navbarTab('Generator', LucideIcons.audioLines, navbar.index == 0),
            navbarTab('Explore', BootstrapIcons.compass, navbar.index == 1),
          ],
        );
      },
    );
  }
}

shadcn.NavigationItem navbarTab(String label, IconData icon, bool active) {
  return shadcn.NavigationItem(
    style: shadcn.ButtonStyle.muted(density: ButtonDensity.icon),
    selectedStyle: shadcn.ButtonStyle.muted(density: ButtonDensity.icon),
    label: Text(
      label,
      style: GoogleFonts.rubik(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: active ? ShadcnThemer().primary() : null,
      ),
    ),
    child: Icon(
      icon,
      color: active ? ShadcnThemer().primary() : null,
      size: 28,
    ),
  );
}
