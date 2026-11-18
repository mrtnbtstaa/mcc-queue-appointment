import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/style/font.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../../../../../shared/queue/domain/entities/queue_entity.dart';

class CounterDetailsRow extends StatelessWidget {
  final QueueItemModel? mine;

  const CounterDetailsRow({super.key, required this.mine});

  String get _positionText {
    final position = mine?.position ?? 0;
    if (mine == null) return '—';
    if (position <= 0) return mine!.statusLabel;
    return '${_ordinal(position)} in queue';
  }

  String get _waitText {
    final position = mine?.position ?? 0;
    if (position <= 0) return mine?.statusLabel ?? '—';
    return '~${position * 5} min';
  }

  String _ordinal(int value) {
    if (value % 100 >= 11 && value % 100 <= 13) return '${value}th';
    return switch (value % 10) {
      1 => '${value}st',
      2 => '${value}nd',
      3 => '${value}rd',
      _ => '${value}th',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _InfoBox(
            icon: Icons.group_outlined,
            label: 'Position in line',
            value: _positionText,
          ),
        ),
        10.0.width,
        Expanded(
          child: _InfoBox(
            icon: Icons.access_time,
            label: 'Estimated Wait',
            value: _waitText,
          ),
        ),
      ],
    );
  }
}

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoBox({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: TAppColors.inputFill,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: TAppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: TAppColors.textMuted),
          8.0.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: label,
                  fontSize: TFont.font8,
                  fontColor: TAppColors.textMuted,
                  maxLine: 1,
                  textOverFlow: TextOverflow.ellipsis,
                ),
                CommonText(
                  text: value,
                  fontSize: TFont.font10,
                  fontWeight: FontWeight.bold,
                  fontColor: TAppColors.textPrimary,
                  maxLine: 1,
                  textOverFlow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
