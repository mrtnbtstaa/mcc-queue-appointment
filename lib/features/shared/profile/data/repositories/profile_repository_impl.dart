import 'package:fpdart/fpdart.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/api_result.dart';
import '../../../../../core/network/paginated_data.dart';
import '../../../../../core/type_defs.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  const ProfileRepositoryImpl(this.remoteDataSource);

  @override
  ResultFuture<List<ProfileEntity>> getUsers({
    String? search,
    String? course,
  }) async {
    final result = await remoteDataSource.getUsers(
      search: search,
      course: course,
    );
    return switch (result) {
      ApiSuccess<List<ProfileEntity>>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<PaginatedData<ProfileEntity>> getUsersPage({
    String? search,
    String? course,
    required int page,
  }) async {
    final result = await remoteDataSource.getUsersPage(
      search: search,
      course: course,
      page: page,
    );
    return switch (result) {
      ApiSuccess(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<ProfileEntity> getUser(String id) async {
    final result = await remoteDataSource.getUser(id);
    return switch (result) {
      ApiSuccess<ProfileEntity>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<ProfileEntity> getMe() async {
    final result = await remoteDataSource.getMe();
    return switch (result) {
      ApiSuccess<ProfileEntity>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<ProfileEntity> updateMe({
    required String email,
    required String course,
    required String yearLevel,
    required bool isActive,
  }) async {
    final result = await remoteDataSource.updateMe(
      email: email,
      course: course,
      yearLevel: yearLevel,
      isActive: isActive,
    );
    return switch (result) {
      ApiSuccess<ProfileEntity>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<ProfileEntity> updateUser({
    required String id,
    required String name,
    required String studentId,
    required String email,
    required String course,
    required String yearLevel,
    required bool isActive,
  }) async {
    final result = await remoteDataSource.updateUser(
      id: id,
      name: name,
      studentId: studentId,
      email: email,
      course: course,
      yearLevel: yearLevel,
      isActive: isActive,
    );
    return switch (result) {
      ApiSuccess<ProfileEntity>(:final data) => Right(data),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }

  @override
  ResultFuture<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final result = await remoteDataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    return switch (result) {
      ApiSuccess<void>() => const Right(null),
      ApiFailure(:final error) => Left(ServerFailure(error.message)),
    };
  }
}
