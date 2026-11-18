class DashboardSummary {
  final String role;
  final int upcomingAppointments;
  final String? queueNumber;
  final String? queueService;
  final String? queueStatus;
  final String? queueStatusDisplay;
  final int queuePosition;
  final int recentRecords;
  final int activeOptions;
  final int todayAppointments;
  final int confirmedAppointments;
  final int changeVsYesterday;
  final int waitingStudents;
  final int averageWaitMinutes;
  final Map<String, dynamic>? nowServing;
  final int completedTransactions;
  final num completionRate;

  const DashboardSummary({
    required this.role,
    required this.upcomingAppointments,
    required this.queueNumber,
    required this.queueService,
    required this.queueStatus,
    required this.queueStatusDisplay,
    required this.queuePosition,
    required this.recentRecords,
    required this.activeOptions,
    required this.todayAppointments,
    required this.confirmedAppointments,
    required this.changeVsYesterday,
    required this.waitingStudents,
    required this.averageWaitMinutes,
    required this.nowServing,
    required this.completedTransactions,
    required this.completionRate,
  });

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    final queue = _map(json['queue']);
    final upcoming = _map(json['upcoming_appointments']);
    final recent = _map(json['recent_records']);
    final catalog = _map(json['catalog']);
    final today = _map(json['today_appointments']);
    final waiting = _map(json['waiting']);
    final completed = _map(json['completed_today']);
    return DashboardSummary(
      role: json['role']?.toString() ?? '',
      upcomingAppointments: _int(upcoming['total']),
      queueNumber: queue['queue_number']?.toString(),
      queueService: queue['service_name']?.toString(),
      queueStatus: queue['status']?.toString(),
      queueStatusDisplay: queue['status_display']?.toString(),
      queuePosition: _int(queue['position']),
      recentRecords: _int(recent['total']),
      activeOptions: _int(catalog['active_options']),
      todayAppointments: _int(today['total']),
      confirmedAppointments: _int(today['confirmed']),
      changeVsYesterday: _int(today['change_vs_yesterday']),
      waitingStudents: _int(waiting['students']),
      averageWaitMinutes: _int(waiting['avg_wait_minutes']),
      nowServing: _mapOrNull(json['now_serving']),
      completedTransactions: _int(completed['transactions']),
      completionRate: completed['completion_rate'] as num? ?? 0,
    );
  }
}

Map<String, dynamic> _map(Object? value) =>
    value is Map<String, dynamic> ? value : const {};

Map<String, dynamic>? _mapOrNull(Object? value) =>
    value is Map<String, dynamic> ? value : null;

int _int(Object? value) =>
    value is num ? value.toInt() : int.tryParse('$value') ?? 0;
