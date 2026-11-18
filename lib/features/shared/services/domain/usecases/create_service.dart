import 'package:fpdart/fpdart.dart';

import '../../../../../../core/errors/failure.dart';
import '../entities/service_entity.dart';
import '../repositories/service_repository.dart';

class CreateServiceUseCase {
  final ServiceRepository repository;

  CreateServiceUseCase(this.repository);

  Future<Either<Failure, ServiceEntity>> call(ServiceEntity service) async {
    // Optional: Add domain validation rules here before calling the repository
    return await repository.createService(service);
  }
}
