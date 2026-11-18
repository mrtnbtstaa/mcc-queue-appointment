import '../../../../../../core/network/api_client.dart';
import '../../../../../../core/network/api_result.dart';
import '../../../../../../core/network/paginated_data.dart';
import '../models/service_dto.dart';

class ServiceRemoteDataSource {
  ServiceRemoteDataSource(this._client);
  final ApiClient _client;

  Future<ApiResult<List<ServiceDto>>> getServices({
    String? search,
    String? category,
    bool? isActive,
  }) async {
    return _client.get<List<ServiceDto>>(
      'v1/document-services/',
      query: {
        'page_size': 100,
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
        'category': ?category,
        'is_active': ?isActive,
      },
      requireAuth: true,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        final list = body['data'] as List<dynamic>;
        return list
            .map((e) => ServiceDto.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
  }

  Future<ApiResult<PaginatedData<ServiceDto>>> getServicesPage({
    String? search,
    String? category,
    bool? isActive,
    required int page,
    int pageSize = 10,
  }) async {
    return _client.get<PaginatedData<ServiceDto>>(
      'v1/document-services/',
      query: {
        'page': page,
        'page_size': pageSize,
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
        'category': ?category,
        'is_active': ?isActive,
      },
      requireAuth: true,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        final data = body['data'] as List<dynamic>;
        final pagination =
            (body['meta'] as Map<String, dynamic>)['pagination']
                as Map<String, dynamic>;
        return PaginatedData(
          items: data
              .map((item) => ServiceDto.fromJson(item as Map<String, dynamic>))
              .toList(),
          page: (pagination['page'] as num).toInt(),
          totalPages: (pagination['total_pages'] as num).toInt(),
        );
      },
    );
  }

  Future<ApiResult<ServiceDto>> getService(String id) async {
    return _client.get<ServiceDto>(
      'v1/document-services/$id/',
      requireAuth: true,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        return ServiceDto.fromJson(body['data'] as Map<String, dynamic>);
      },
    );
  }

  Future<ApiResult<ServiceDto>> createService(ServiceDto dto) async {
    return _client.post<ServiceDto>(
      'v1/document-services/',
      body: dto.toJson(),
      requireAuth: true,
      isIdempotent: false,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        return ServiceDto.fromJson(body['data'] as Map<String, dynamic>);
      },
    );
  }

  Future<ApiResult<ServiceDto>> updateService(String id, ServiceDto dto) async {
    return _client.patch<ServiceDto>(
      // Using PATCH for partial_update
      'v1/document-services/$id/',
      body: dto.toJson(),
      requireAuth: true,
      isIdempotent: true,
      decode: (json) {
        final body = json as Map<String, dynamic>;
        return ServiceDto.fromJson(body['data'] as Map<String, dynamic>);
      },
    );
  }

  // THE CUSTOM ACTION
  Future<ApiResult<void>> setServiceStatus(String id, bool isActive) async {
    return _client.patch<void>(
      // Could be POST depending on backend, usually PATCH/POST for actions
      'v1/document-services/$id/status/',
      body: {'is_active': isActive},
      requireAuth: true,
      isIdempotent: true,
      decode: (_) {},
    );
  }
}
