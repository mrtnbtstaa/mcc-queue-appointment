import 'package:material_ui/material_ui.dart';

class CommonNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;

  const CommonNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF7A1822),
      unselectedItemColor: Colors.grey,
      selectedFontSize: 11,
      unselectedFontSize: 11,
      items: items,
    );
  }
}
