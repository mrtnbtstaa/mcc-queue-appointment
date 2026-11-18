import 'package:fpdart/fpdart.dart';

import '../../../../../../core/errors/failure.dart';
import '../entities/service_entity.dart';
import '../repositories/service_repository.dart';

class UpdateServiceUseCase {
  final ServiceRepository repository;

  UpdateServiceUseCase(this.repository);

  Future<Either<Failure, ServiceEntity>> call(
    String id,
    ServiceEntity service,
  ) async {
    return await repository.updateService(id, service);
  }
}
