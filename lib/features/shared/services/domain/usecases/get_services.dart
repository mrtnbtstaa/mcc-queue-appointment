import 'package:fpdart/fpdart.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/network/paginated_data.dart';
import '../entities/service_entity.dart';
import '../repositories/service_repository.dart';

class GetServicesUseCase {
  final ServiceRepository repository;

  GetServicesUseCase(this.repository);

  Future<Either<Failure, List<ServiceEntity>>> call({
    String? search,
    String? category,
    bool? isActive,
  }) async {
    return await repository.getServices(
      search: search,
      category: category,
      isActive: isActive,
    );
  }

  Future<Either<Failure, PaginatedData<ServiceEntity>>> callPage({
    String? search,
    String? category,
    bool? isActive,
    required int page,
  }) => repository.getServicesPage(
    search: search,
    category: category,
    isActive: isActive,
    page: page,
  );
}
