import 'package:fpdart/fpdart.dart';

import '../../../../../../core/errors/failure.dart';
import '../entities/service_entity.dart';
import '../repositories/service_repository.dart';

class GetServiceUseCase {
  final ServiceRepository repository;

  GetServiceUseCase(this.repository);

  Future<Either<Failure, ServiceEntity>> call(String id) async {
    return await repository.getService(id);
  }
}
