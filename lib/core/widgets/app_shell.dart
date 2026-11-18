import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../features/auth/logout/presentation/cubit/logout_cubit.dart';
import '../../features/auth/logout/presentation/cubit/logout_state.dart';
import '../../features/shared/notifications/presentation/notifications_cubit.dart';
import '../constants/sidebar.dart';
import '../di/injector.dart';
import '../extensions/context_extension.dart';
import '../theme/app_colors.dart';
import 'common_header.dart';
import 'common_navigation_bar.dart';
import 'common_sidebar.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    required this.menuItems,
    required this.bottomItems,
    required this.child,
  });

  final List<TSidebarMenu> menuItems;
  final List<BottomNavigationBarItem> bottomItems;
  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final NotificationsCubit _notificationsCubit;

  @override
  void initState() {
    super.initState();
    _notificationsCubit = getIt<NotificationsCubit>()..startPolling();
  }

  @override
  void dispose() {
    _notificationsCubit.close();
    super.dispose();
  }

  int _selectedIndex(String location) {
    var selected = 0;
    var longestMatch = -1;

    for (var i = 0; i < widget.menuItems.length; i++) {
      final route = widget.menuItems[i].route;
      final matches = location == route || location.startsWith('$route/');
      if (matches && route.length > longestMatch) {
        selected = i;
        longestMatch = route.length;
      }
    }

    return selected;
  }

  void _onSelected(int index) {
    final route = widget.menuItems[index].route;

    _scaffoldKey.currentState?.closeDrawer();

    if (route.toLowerCase() == 'logout' || route == '/logout') {
      // Show confirmation dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => BlocProvider(
          create: (_) => getIt<LogoutCubit>(),
          child: BlocConsumer<LogoutCubit, LogoutState>(
            listener: (context, state) {
              if (state is LogoutIdle) {
                // Or if you added a LogoutSuccess state
                Navigator.pop(ctx);
              }
            },
            builder: (context, state) {
              final isLoading = state is LogoutLoading;
              return AlertDialog(
                title: const Text('Logout'),
                content: isLoading
                    ? const Row(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 16),
                          Text('Logging out...'),
                        ],
                      )
                    : const Text('Are you sure you want to log out?'),
                actions: isLoading
                    ? [] // Hide buttons while loading
                    : [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<LogoutCubit>().submit();
                          },
                          child: const Text('Logout'),
                        ),
                      ],
              );
            },
          ),
        ),
      );
      return;
    }

    if (GoRouterState.of(context).uri.path != route) {
      context.go(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final selected = _selectedIndex(location);
    final isDesktop = context.isDesktop;
    final isMobile = context.isMobile;

    final sidebar = CommonSidebar(
      menuItems: widget.menuItems,
      selectedIndex: selected,
      onItemSelected: _onSelected,
      onClose: isDesktop
          ? null
          : () => _scaffoldKey.currentState?.closeDrawer(),
    );

    return BlocProvider.value(
      value: _notificationsCubit,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: TAppColors.background,
        appBar: const CommonHeader(),
        drawer: isDesktop ? null : Drawer(width: 280, child: sidebar),
        body: Row(
          children: [
            if (isDesktop) sidebar,
            Expanded(child: widget.child),
          ],
        ),
        bottomNavigationBar: isMobile && selected < 5
            ? CommonNavigationBar(
                items: widget.bottomItems,
                currentIndex: selected,
                onTap: _onSelected,
              )
            : null,
      ),
    );
  }
}
