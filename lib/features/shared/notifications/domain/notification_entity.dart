class NotificationEntity {
  final String id;
  final String title;
  final String message;
  final DateTime? createdAt;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.message,
    this.createdAt,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      NotificationEntity(
        id: json['id']?.toString() ?? '',
        title:
            (json['title'] ??
                    json['verb'] ??
                    json['notification_type'] ??
                    'Notification')
                .toString(),
        message: (json['message'] ?? json['description'] ?? json['body'] ?? '')
            .toString(),
        createdAt: DateTime.tryParse((json['created_at'] ?? '').toString()),
      );
}
