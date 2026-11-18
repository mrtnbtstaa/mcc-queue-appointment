import 'package:fpdart/fpdart.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/network/paginated_data.dart';
import '../entities/service_entity.dart';

abstract interface class ServiceRepository {
  Future<Either<Failure, List<ServiceEntity>>> getServices({
    String? search,
    String? category,
    bool? isActive,
  });
  Future<Either<Failure, PaginatedData<ServiceEntity>>> getServicesPage({
    String? search,
    String? category,
    bool? isActive,
    required int page,
  });
  Future<Either<Failure, ServiceEntity>> getService(String id);
  Future<Either<Failure, ServiceEntity>> createService(ServiceEntity service);
  Future<Either<Failure, ServiceEntity>> updateService(
    String id,
    ServiceEntity service,
  );
  Future<Either<Failure, Unit>> setServiceStatus(String id, bool isActive);
}
