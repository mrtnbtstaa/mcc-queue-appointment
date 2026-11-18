import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';

abstract final class CommonSnackbar {
  static void show(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? TAppColors.errorTitle : TAppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  static void showError(BuildContext context, String message) =>
      show(context, message, isError: true);

  static void showSuccess(BuildContext context, String message) =>
      show(context, message);
}
