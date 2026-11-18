import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_result.dart';
import '../domain/notification_entity.dart';

class NotificationRemoteDataSource {
  final ApiClient apiClient;

  const NotificationRemoteDataSource(this.apiClient);

  Future<ApiResult<int>> getUnreadCount() => apiClient.get<int>(
    'v1/notifications/unread-count/',
    decode: (json) {
      final root = json as Map<String, dynamic>;
      final data = root['data'];
      if (data is num) return data.toInt();
      final map = data is Map<String, dynamic> ? data : root;
      return ((map['unread_count'] ?? map['count'] ?? map['unreadCount'])
                  as num?)
              ?.toInt() ??
          0;
    },
  );

  Future<ApiResult<List<NotificationEntity>>> getUnread() =>
      apiClient.get<List<NotificationEntity>>(
        'v1/notifications/',
        query: const {'is_read': false},
        decode: (json) {
          final root = json as Map<String, dynamic>;
          final data = root['data'];
          final list = data is List
              ? data
              : data is Map<String, dynamic>
              ? (data['results'] ?? data['items'] ?? const []) as List
              : const <dynamic>[];
          return list
              .map(
                (item) =>
                    NotificationEntity.fromJson(item as Map<String, dynamic>),
              )
              .toList();
        },
      );

  Future<ApiResult<void>> markRead(String id) =>
      apiClient.post<void>('v1/notifications/$id/read/', decode: (_) {});

  Future<ApiResult<void>> markAllRead() =>
      apiClient.post<void>('v1/notifications/read-all/', decode: (_) {});
}
