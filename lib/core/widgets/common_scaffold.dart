import 'package:material_ui/material_ui.dart';

import '../../core/theme/app_colors.dart';

class CommonScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color backgroundColor;
  final bool resizeToAvoidBottomInset;
  final Widget? drawer;

  // Optional parameters for responsive control
  final bool isResponsive;
  final double maxContentWidth;
  final double desktopPadding;
  final double mobilePadding;

  const CommonScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor = TAppColors.background,
    this.resizeToAvoidBottomInset = true,
    this.isResponsive = true, // Defaults to responsive behavior
    this.maxContentWidth = 480.0, // Standard form/card width on desktop/web
    this.desktopPadding = 32.0,
    this.mobilePadding = 20.0,
  });

  // Tablet & Desktop breakpoint threshold
  static const double tabletBreakpoint = 768.0;

  @override
  Widget build(BuildContext context) {
    // Wrap body with responsive layout logic if enabled
    final Widget wrappedBody = LayoutBuilder(
      builder: (context, constraints) {
        if (!isResponsive) {
          return body;
        }

        final bool isDesktopOrTablet = constraints.maxWidth >= tabletBreakpoint;

        final Widget responsiveContent = SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktopOrTablet ? desktopPadding : mobilePadding,
            vertical: 24.0,
          ),
          child: SizedBox(
            width: isDesktopOrTablet ? maxContentWidth : double.infinity,
            child: body,
          ),
        );

        return Align(
          alignment: isDesktopOrTablet ? Alignment.center : Alignment.topCenter,
          child: responsiveContent,
        );
      },
    );

    if (appBar != null) {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar,
        drawer: drawer,
        drawerBarrierDismissible: true,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: SafeArea(child: wrappedBody),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(child: wrappedBody),
      drawer: drawer,
      drawerBarrierDismissible: true,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
