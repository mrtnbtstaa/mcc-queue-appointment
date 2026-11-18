import '../type_defs.dart';

abstract interface class UseCase<Type, Params> {
  ResultFuture<Type> call(Params params);
}

class NoParams {
  const NoParams();
}
