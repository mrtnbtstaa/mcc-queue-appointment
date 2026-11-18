import 'package:material_ui/material_ui.dart';

import '../constants/sidebar.dart';
import '../theme/app_colors.dart';

class SidebarMenuItem {
  final String title;
  final IconData icon;
  final IconData? activeIcon;

  const SidebarMenuItem({
    required this.title,
    required this.icon,
    this.activeIcon,
  });
}

class CommonSidebar extends StatelessWidget {
  final String institutionName;
  final String departmentName;
  final String systemName;
  final ImageProvider? userAvatar;
  final List<TSidebarMenu> menuItems;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final VoidCallback? onClose;

  const CommonSidebar({
    super.key,
    this.institutionName = 'Mabalacat City College',
    this.departmentName = "Registrar's Office",
    this.systemName = 'Student Services System',
    this.userAvatar,
    required this.menuItems,
    required this.selectedIndex,
    required this.onItemSelected,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: TAppColors.primary,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Header Section (Logo, Title, Close Button)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.school_outlined,
                      color: TAppColors.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          institutionName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          departmentName,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 11,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          systemName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onClose != null)
                    IconButton(
                      onPressed: onClose,
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white70,
                        size: 20,
                      ),
                      splashRadius: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const Divider(
              color: TAppColors.dividerColor,
              height: 1,
              thickness: 1,
            ),
            const SizedBox(height: 12),

            //  Navigation Items List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: menuItems.length,
                separatorBuilder: (_, _) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  final isSelected = index == selectedIndex;

                  return Material(
                    color: isSelected
                        ? TAppColors.dividerColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => onItemSelected(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected ? (item.icon) : item.icon,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.5,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
