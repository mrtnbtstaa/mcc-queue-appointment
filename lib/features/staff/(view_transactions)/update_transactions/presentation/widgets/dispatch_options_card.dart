import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/extensions/double_extension.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/common_text.dart';
import '../cubit/update_transactions_cubit.dart';
import '../cubit/update_transactions_state.dart';

class DispatchOptionsCard extends StatelessWidget {
  const DispatchOptionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateTransactionCubit>();

    return BlocBuilder<UpdateTransactionCubit, UpdateTransactionState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: state.isMultiChannelDispatchEnabled,
                onChanged: (val) => cubit.toggleDispatch(val ?? true),
                activeColor: TAppColors.primary,
              ),
              8.0.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: 'Instant Student Multi-channel Dispatch',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontColor: TAppColors.textPrimary,
                    ),
                    4.0.height,
                    CommonText(
                      text:
                          'Notify ${state.studentName} immediately via SMS alert (+63 912 345 6789) & Student Portal Mobile Push Notification.',
                      fontSize: 11,
                      fontColor: TAppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
