// transaction_model.dart

import 'package:material_ui/material_ui.dart';

class TimelineStepModel {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isInProgress;

  const TimelineStepModel({
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    this.isInProgress = false,
  });
}

class TransactionModel {
  final String id;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String date;
  final String refNo;
  final String queueInfo;
  final String queueNo;
  final String statusText;
  final Color statusBgColor;
  final Color statusTextColor;
  final bool isInProgress;
  final String staffRemarks;
  final String evaluator;
  final List<TimelineStepModel> progressionSteps;

  const TransactionModel({
    required this.id,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.date,
    required this.refNo,
    required this.queueInfo,
    required this.queueNo,
    required this.statusText,
    required this.statusBgColor,
    required this.statusTextColor,
    this.isInProgress = false,
    required this.staffRemarks,
    required this.evaluator,
    required this.progressionSteps,
  });
}
