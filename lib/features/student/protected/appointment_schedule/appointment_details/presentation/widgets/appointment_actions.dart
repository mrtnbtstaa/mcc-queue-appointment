import 'package:material_ui/material_ui.dart';

import '../../../../../../../core/extensions/double_extension.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/widgets/common_elevated_button.dart';
import '../../../../../../../core/widgets/common_text.dart';
import '../cubit/appointment_details_cubit.dart';

class AppointmentActions extends StatelessWidget {
  const AppointmentActions({super.key, required this.cubit});

  final AppointmentSlipCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // View Live Queue Status Button
        CommonElevatedButton(
          onButtonPressed: cubit.viewLiveQueue,
          backgroundColor: TAppColors.primary,
          borderRadius: 10.0,
          elevatedPadding: const EdgeInsets.symmetric(vertical: 13),
          custom: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart, size: 16, color: TAppColors.surface),
              8.0.width,
              CommonText(
                text: 'View Live Queue Status',
                fontColor: TAppColors.surface,
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
        12.0.height,

        // Reschedule & Cancel Row
        // Row(
        //   children: [
        //     Expanded(
        //       child: CommonElevatedButton(
        //         onButtonPressed: cubit.rescheduleAppointment,
        //         backgroundColor: TAppColors.surface,
        //         borderColor: TAppColors.border,
        //         borderWidth: 1.0,
        //         borderRadius: 10.0,
        //         elevatedPadding: const EdgeInsets.symmetric(vertical: 12),
        //         custom: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Icon(
        //               Icons.calendar_month_outlined,
        //               size: 15,
        //               color: TAppColors.textPrimary,
        //             ),
        //             6.0.width,
        //             CommonText(
        //               text: 'Reschedule',
        //               fontColor: TAppColors.textPrimary,
        //               fontSize: 12.5,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     12.0.width,
        //     Expanded(
        //       child: CommonElevatedButton(
        //         onButtonPressed: cubit.cancelTicket,
        //         backgroundColor: TAppColors.errorBg,
        //         borderColor: TAppColors.errorBorder,
        //         borderWidth: 1.0,
        //         borderRadius: 10.0,
        //         elevatedPadding: const EdgeInsets.symmetric(vertical: 12),
        //         custom: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Icon(
        //               Icons.cancel_outlined,
        //               size: 15,
        //               color: TAppColors.errorIcon,
        //             ),
        //             6.0.width,
        //             Flexible(
        //               child: CommonText(
        //                 text: 'Cancel Ticket',
        //                 fontColor: TAppColors.errorTitle,
        //                 fontSize: 12.5,
        //                 fontWeight: FontWeight.bold,
        //                 maxLine: 1,
        //                 textOverFlow: TextOverflow.ellipsis,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // 16.0.height,

        // // PDF Download Footer Link
        // Center(
        //   child: GestureDetector(
        //     onTap: cubit.downloadSlip,
        //     child: Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Icon(
        //           Icons.picture_as_pdf_outlined,
        //           size: 14,
        //           color: TAppColors.primary,
        //         ),
        //         6.0.width,
        //         Flexible(
        //           child: CommonText(
        //             text: 'Download Gate Pass & Receipt (PDF • 148 KB)',
        //             fontColor: TAppColors.primary,
        //             fontSize: 11.5,
        //             fontWeight: FontWeight.bold,
        //             maxLine: 2,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
