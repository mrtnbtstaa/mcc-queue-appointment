import 'package:fpdart/fpdart.dart';

import '../../../../../../core/errors/failure.dart';
import '../repositories/service_repository.dart';

class SetServiceStatusUseCase {
  final ServiceRepository repository;

  SetServiceStatusUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String id, bool isActive) async {
    return await repository.setServiceStatus(id, isActive);
  }
}
