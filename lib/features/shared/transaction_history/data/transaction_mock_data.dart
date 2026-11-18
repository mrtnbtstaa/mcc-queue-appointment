// transaction_mock_data.dart
import 'package:material_ui/material_ui.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../domain/model.dart';

class TransactionMockData {
  static final List<TransactionModel> transactions = [
    const TransactionModel(
      id: 'txn_001',
      icon: Icons.school_outlined,
      iconColor: Colors.red,
      title: 'Enrollment (Verification & Clearance)',
      date: 'Sep 28, 2026',
      refNo: '2026-0928-003',
      queueInfo: 'Q009 (Window 2)',
      queueNo: 'Q009',
      statusText: 'Completed',
      statusBgColor: TAppColors.statusOpenBg,
      statusTextColor: TAppColors.statusOpenText,
      staffRemarks: '“Enrollment assessment validated and officially tagged as enrolled for 1st Semester.”',
      evaluator: 'Carlos Reyes (ID #0218)',
      progressionSteps: [
        TimelineStepModel(
          title: 'Submitted',
          subtitle: 'Sep 28, 2026 • 08:15 AM (Online portal)',
          isCompleted: true,
        ),
        TimelineStepModel(
          title: 'Processing / Under Evaluation',
          subtitle: 'Sep 28, 2026 • Verified at Window 2',
          isCompleted: true,
        ),
        TimelineStepModel(
          title: 'Ready for Release / Completed',
          subtitle: 'Completed on Sep 28, 2026',
          isCompleted: true,
        ),
      ],
    ),
    const TransactionModel(
      id: 'txn_002',
      icon: Icons.verified_outlined,
      iconColor: Colors.blue,
      title: 'Certificate of Registration (COR)',
      date: 'Sep 20, 2026',
      refNo: '2026-0920-001',
      queueInfo: 'Q004 (Window 3)',
      queueNo: 'Q004',
      statusText: 'Completed',
      statusBgColor: TAppColors.statusOpenBg,
      statusTextColor: TAppColors.statusOpenText,
      staffRemarks: '“Official COR stamped and released at Counter 3.”',
      evaluator: 'Ana Lim (ID #0305)',
      progressionSteps: [
        TimelineStepModel(
          title: 'Submitted',
          subtitle: 'Sep 20, 2026 • 10:05 AM (Online portal)',
          isCompleted: true,
        ),
        TimelineStepModel(
          title: 'Processing / Under Evaluation',
          subtitle: 'Sep 20, 2026 • Printed at Window 3',
          isCompleted: true,
        ),
        TimelineStepModel(
          title: 'Ready for Release / Completed',
          subtitle: 'Claimed at Counter 3',
          isCompleted: true,
        ),
      ],
    ),
    const TransactionModel(
      id: 'txn_003',
      icon: Icons.description_outlined,
      iconColor: Colors.deepOrange,
      title: 'Transcript of Records (TOR)',
      date: 'Sep 15, 2026',
      refNo: '2026-0915-002',
      queueInfo: 'Q019 (Window Active)',
      queueNo: 'Q019',
      statusText: 'In Progress',
      statusBgColor: Color(0xFFFEF3C7),
      statusTextColor: Color(0xFF92400E),
      isInProgress: true,
      staffRemarks: '“Academic records being validated with College of Computer Studies. Expected release: Oct 5, 2026.”',
      evaluator: 'Maria Santos (ID #0412)',
      progressionSteps: [
        TimelineStepModel(
          title: 'Submitted',
          subtitle: 'Sep 15, 2026 • 09:24 AM (Online portal)',
          isCompleted: true,
        ),
        TimelineStepModel(
          title: 'Processing / Under Evaluation',
          subtitle: 'Sep 16, 2026 • Active in progress at Window 3',
          isInProgress: true,
        ),
        TimelineStepModel(
          title: 'Ready for Release / Completed',
          subtitle: 'Estimated pickup at Counter 4',
        ),
      ],
    ),
    const TransactionModel(
      id: 'txn_004',
      icon: Icons.tune,
      iconColor: Colors.purple,
      title: 'Subject Adjustment',
      date: 'Sep 10, 2026',
      refNo: '2026-0910-004',
      queueInfo: 'Q002 (Window 1)',
      queueNo: 'Q002',
      statusText: 'Completed',
      statusBgColor: TAppColors.statusOpenBg,
      statusTextColor: TAppColors.statusOpenText,
      staffRemarks: '“Adding/Dropping form approved by Program Head and updated in student portal.”',
      evaluator: 'Roberto Cruz (ID #0119)',
      progressionSteps: [
        TimelineStepModel(
          title: 'Submitted',
          subtitle: 'Sep 10, 2026 • 01:40 PM (Walk-in)',
          isCompleted: true,
        ),
        TimelineStepModel(
          title: 'Processing / Under Evaluation',
          subtitle: 'Sep 10, 2026 • Encoded at Window 1',
          isCompleted: true,
        ),
        TimelineStepModel(
          title: 'Ready for Release / Completed',
          subtitle: 'Updated COR generated',
          isCompleted: true,
        ),
      ],
    ),
  ];
}
