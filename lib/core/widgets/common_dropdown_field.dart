import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';

class CommonDropdownField<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final IconData? prefixIcon;
  final String? Function(T?)? validator;
  final bool enabled;

  const CommonDropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText = 'Select an option',
    this.prefixIcon,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: TAppColors.inputFill,
        hintText: hintText,
        hintStyle: const TextStyle(color: TAppColors.textHint, fontSize: 14),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, size: 18, color: TAppColors.textHint)
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: TAppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: TAppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: TAppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: TAppColors.errorBorder),
        ),
      ),
      icon: Icon(Icons.arrow_drop_down, color: TAppColors.textMuted),
      items: items,
      onChanged: enabled ? onChanged : null,
      validator: validator,
    );
  }
}
