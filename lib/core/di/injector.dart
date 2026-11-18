import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/login/data/datasources/login_remote_data_source.dart';
import '../../features/auth/login/data/repositories/login_repository_impl.dart';
import '../../features/auth/login/domain/repositories/login_repository.dart';
import '../../features/auth/login/domain/usecases/login_user.dart';
import '../../features/auth/login/presentation/cubit/login_cubit.dart';
import '../../features/auth/logout/data/datasources/logout_remote_data_source.dart';
import '../../features/auth/logout/data/repositories/logout_repository_impl.dart';
import '../../features/auth/logout/domain/repositories/logout_repository.dart';
import '../../features/auth/logout/domain/usecases/logout_user.dart';
import '../../features/auth/logout/presentation/cubit/logout_cubit.dart';
import '../../features/auth/register/data/datasources/register_remote_data_source.dart';
import '../../features/auth/register/data/repositories/register_repository_impl.dart';
import '../../features/auth/register/domain/repositories/register_repository.dart';
import '../../features/auth/register/domain/usecases/register_user.dart';
import '../../features/auth/register/presentation/cubit/register_cubit.dart';
import '../../features/shared/appointment_schedules/data/datasources/appointment_schedule_remote_datasource.dart';
import '../../features/shared/appointment_schedules/data/datasources/appointment_schedule_remote_datasource_impl.dart';
import '../../features/shared/appointment_schedules/data/repositories/appointment_schedule_repository_impl.dart';
import '../../features/shared/appointment_schedules/domain/repositories/appointment_schedule_repository.dart';
import '../../features/shared/appointment_schedules/domain/usecases/create_appointment_schedule.dart';
import '../../features/shared/appointment_schedules/domain/usecases/get_appointment_schedule.dart';
import '../../features/shared/appointment_schedules/domain/usecases/get_appointment_schedules.dart';
import '../../features/shared/appointment_schedules/domain/usecases/set_appointment_schedule_status.dart';
import '../../features/shared/appointment_schedules/domain/usecases/update_appointment_schedule.dart';
import '../../features/shared/appointment_schedules/presentation/bloc/manage_schedules_bloc.dart';
import '../../features/shared/appointments/data/datasources/appointment_remote_data_source.dart';
import '../../features/shared/appointments/data/datasources/appointment_remote_data_source_impl.dart';
import '../../features/shared/appointments/data/repositories/appointment_repository_impl.dart';
import '../../features/shared/appointments/domain/repositories/appointment_repository.dart';
import '../../features/shared/appointments/domain/usecases/create_appointment.dart';
import '../../features/shared/appointments/domain/usecases/get_appointment.dart';
import '../../features/shared/appointments/domain/usecases/get_appointments.dart';
import '../../features/shared/appointments/domain/usecases/update_appointment.dart';
import '../../features/shared/appointments/domain/usecases/update_appointment_status.dart';
import '../../features/shared/appointments/presentation/bloc/appointment_bloc.dart';
import '../../features/shared/dashboard/data/dashboard_remote_data_source.dart';
import '../../features/shared/dashboard/presentation/dashboard_cubit.dart';
import '../../features/shared/notifications/data/notification_remote_data_source.dart';
import '../../features/shared/notifications/presentation/notifications_cubit.dart';
import '../../features/shared/profile/data/datasources/profile_remote_data_source.dart';
import '../../features/shared/profile/data/datasources/profile_remote_data_source_impl.dart';
import '../../features/shared/profile/data/repositories/profile_repository_impl.dart';
import '../../features/shared/profile/domain/repositories/profile_repository.dart';
import '../../features/shared/profile/domain/usecases/change_password.dart';
import '../../features/shared/profile/domain/usecases/get_my_profile.dart';
import '../../features/shared/profile/domain/usecases/get_user.dart';
import '../../features/shared/profile/domain/usecases/get_users.dart';
import '../../features/shared/profile/domain/usecases/update_my_profile.dart';
import '../../features/shared/profile/presentation/cubit/profile_cubit.dart';
import '../../features/shared/queue/data/datasources/queue_remote_data_source.dart';
import '../../features/shared/queue/data/datasources/queue_remote_data_source_impl.dart';
import '../../features/shared/queue/data/repositories/queue_repository_impl.dart';
import '../../features/shared/queue/domain/repositories/queue_repository.dart';
import '../../features/shared/queue/domain/usecases/create_queue.dart';
import '../../features/shared/queue/domain/usecases/get_queue.dart';
import '../../features/shared/queue/domain/usecases/get_queues.dart';
import '../../features/shared/queue/domain/usecases/set_queue_status.dart';
import '../../features/shared/queue/presentation/bloc/queue_bloc.dart';
import '../../features/shared/services/data/datasources/service_remote_data_source.dart';
import '../../features/shared/services/data/repositories/service_repository_impl.dart';
import '../../features/shared/services/domain/repositories/service_repository.dart';
import '../../features/shared/services/domain/usecases/create_service.dart';
import '../../features/shared/services/domain/usecases/get_service.dart';
import '../../features/shared/services/domain/usecases/get_services.dart';
import '../../features/shared/services/domain/usecases/update_service.dart';
import '../../features/shared/services/domain/usecases/update_service_status.dart';
import '../../features/shared/services/presentation/bloc/manage_services_bloc.dart';
import '../../features/shared/transaction_history/data/datasources/transaction_remote_data_source.dart';
import '../../features/shared/transaction_history/data/datasources/transaction_remote_data_source_impl.dart';
import '../../features/shared/transaction_history/data/repositories/transaction_repository_impl.dart';
import '../../features/shared/transaction_history/domain/repositories/transaction_repository.dart';
import '../../features/shared/transaction_history/domain/usecases/create_transaction.dart';
import '../../features/shared/transaction_history/domain/usecases/get_transaction.dart';
import '../../features/shared/transaction_history/domain/usecases/get_transactions.dart';
import '../../features/shared/transaction_history/domain/usecases/set_transaction_status.dart';
import '../../features/shared/transaction_history/presentation/cubit/transaction_cubit.dart';
import '../../features/staff/students/presentation/cubit/students_cubit.dart';
import '../../features/staff/view_appointments/presentation/cubit/view_appointments_cubit.dart';
import '../auth/auth_state.dart';
import '../network/api_client.dart';
import '../network/network_module.dart';
import '../storage/secure_token_store.dart';
import '../storage/token_store.dart';

final getIt = GetIt.instance;

void registerDependencies() {
  getIt.registerLazySingleton<RegisterRemoteDataSource>(
    () => RegisterRemoteDataSource(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(getIt<RegisterRemoteDataSource>()),
  );

  getIt.registerLazySingleton<RegisterUser>(
    () => RegisterUser(getIt<RegisterRepository>()),
  );

  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<RegisterUser>()),
  );
}

void loginDependencies() {
  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSource(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(getIt<LoginRemoteDataSource>()),
  );

  getIt.registerLazySingleton<LoginUser>(
    () => LoginUser(getIt<LoginRepository>()),
  );

  getIt.registerFactory<LoginCubit>(
    () =>
        LoginCubit(getIt<LoginUser>(), getIt<TokenStore>(), getIt<AuthState>()),
  );
}

void logoutDependencies() {
  getIt.registerLazySingleton<LogoutRemoteDataSource>(
    () => LogoutRemoteDataSource(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<LogoutRepository>(
    () => LogoutRepositoryImpl(getIt<LogoutRemoteDataSource>()),
  );
  getIt.registerLazySingleton<LogoutUser>(
    () => LogoutUser(getIt<LogoutRepository>(), getIt<TokenStore>()),
  );
  getIt.registerFactory<LogoutCubit>(
    () => LogoutCubit(
      getIt<LogoutUser>(),
      getIt<TokenStore>(),
      getIt<AuthState>(),
    ),
  );
}

void serviceDependencies() {
  getIt.registerLazySingleton<ServiceRemoteDataSource>(
    () => ServiceRemoteDataSource(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<ServiceRepository>(
    () => ServiceRepositoryImpl(getIt<ServiceRemoteDataSource>()),
  );
  getIt.registerLazySingleton<CreateServiceUseCase>(
    () => CreateServiceUseCase(getIt<ServiceRepository>()),
  );
  getIt.registerLazySingleton<GetServiceUseCase>(
    () => GetServiceUseCase(getIt<ServiceRepository>()),
  );
  getIt.registerLazySingleton<GetServicesUseCase>(
    () => GetServicesUseCase(getIt<ServiceRepository>()),
  );
  getIt.registerLazySingleton<UpdateServiceUseCase>(
    () => UpdateServiceUseCase(getIt<ServiceRepository>()),
  );
  getIt.registerLazySingleton<SetServiceStatusUseCase>(
    () => SetServiceStatusUseCase(getIt<ServiceRepository>()),
  );

  getIt.registerFactory<ManageServicesBloc>(
    () => ManageServicesBloc(
      createService: getIt<CreateServiceUseCase>(),
      getService: getIt<GetServiceUseCase>(),
      getServices: getIt<GetServicesUseCase>(),
      updateService: getIt<UpdateServiceUseCase>(),
      setServiceStatus: getIt<SetServiceStatusUseCase>(),
    ),
  );
}

void appointmentSlotDependencies() {
  // Datasource
  getIt.registerLazySingleton<AppointmentScheduleRemoteDataSource>(
    () => AppointmentScheduleRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  // Repository
  getIt.registerLazySingleton<AppointmentScheduleRepository>(
    () => AppointmentScheduleRepositoryImpl(
      getIt<AppointmentScheduleRemoteDataSource>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton<GetAppointmentSchedules>(
    () => GetAppointmentSchedules(getIt<AppointmentScheduleRepository>()),
  );

  getIt.registerLazySingleton<GetAppointmentSchedule>(
    () => GetAppointmentSchedule(getIt<AppointmentScheduleRepository>()),
  );

  getIt.registerLazySingleton<CreateAppointmentSchedule>(
    () => CreateAppointmentSchedule(getIt<AppointmentScheduleRepository>()),
  );

  getIt.registerLazySingleton<UpdateAppointmentSchedule>(
    () => UpdateAppointmentSchedule(getIt<AppointmentScheduleRepository>()),
  );

  getIt.registerLazySingleton<SetAppointmentScheduleStatus>(
    () => SetAppointmentScheduleStatus(getIt<AppointmentScheduleRepository>()),
  );

  // Bloc
  getIt.registerFactory<ManageSchedulesBloc>(
    () => ManageSchedulesBloc(
      getAppointmentSchedules: getIt<GetAppointmentSchedules>(),
      getAppointmentSchedule: getIt<GetAppointmentSchedule>(),
      createAppointmentSchedule: getIt<CreateAppointmentSchedule>(),
      updateAppointmentSchedule: getIt<UpdateAppointmentSchedule>(),
      setAppointmentScheduleStatus: getIt<SetAppointmentScheduleStatus>(),
      getServices: getIt<GetServicesUseCase>(),
    ),
  );
}

void appointmentDependencies() {
  getIt.registerLazySingleton<AppointmentRemoteDataSource>(
    () => AppointmentRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<AppointmentRepository>(
    () => AppointmentRepositoryImpl(getIt<AppointmentRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetAppointments>(
    () => GetAppointments(getIt<AppointmentRepository>()),
  );

  getIt.registerLazySingleton<GetAppointment>(
    () => GetAppointment(getIt<AppointmentRepository>()),
  );

  getIt.registerLazySingleton<CreateAppointment>(
    () => CreateAppointment(getIt<AppointmentRepository>()),
  );

  getIt.registerLazySingleton<UpdateAppointment>(
    () => UpdateAppointment(getIt<AppointmentRepository>()),
  );

  getIt.registerLazySingleton<SetAppointmentStatus>(
    () => SetAppointmentStatus(getIt<AppointmentRepository>()),
  );

  getIt.registerFactory<AppointmentBloc>(
    () => AppointmentBloc(
      getAppointments: getIt<GetAppointments>(),
      getAppointment: getIt<GetAppointment>(),
      createAppointment: getIt<CreateAppointment>(),
      updateAppointment: getIt<UpdateAppointment>(),
      setAppointmentStatus: getIt<SetAppointmentStatus>(),
    ),
  );

  getIt.registerFactory<ViewAppointmentsCubit>(
    () => ViewAppointmentsCubit(
      getAppointments: getIt<GetAppointments>(),
      setAppointmentStatus: getIt<SetAppointmentStatus>(),
    ),
  );
}

void queueDependencies() {
  getIt.registerLazySingleton<QueueRemoteDataSource>(
    () => QueueRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<QueueRepository>(
    () => QueueRepositoryImpl(getIt<QueueRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetQueues>(
    () => GetQueues(getIt<QueueRepository>()),
  );

  getIt.registerLazySingleton<GetQueue>(
    () => GetQueue(getIt<QueueRepository>()),
  );

  getIt.registerLazySingleton<CreateQueue>(
    () => CreateQueue(getIt<QueueRepository>()),
  );

  getIt.registerLazySingleton<SetQueueStatus>(
    () => SetQueueStatus(getIt<QueueRepository>()),
  );

  getIt.registerFactory<QueueBloc>(
    () => QueueBloc(
      getQueues: getIt<GetQueues>(),
      setQueueStatus: getIt<SetQueueStatus>(),
      createTransaction: getIt<CreateTransaction>(),
    ),
  );
}

void profileDependencies() {
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileRemoteDataSource>()),
  );
  getIt.registerLazySingleton<GetMyProfile>(
    () => GetMyProfile(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton<GetUsers>(
    () => GetUsers(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton<GetUser>(
    () => GetUser(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton<UpdateMyProfile>(
    () => UpdateMyProfile(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton<ChangePassword>(
    () => ChangePassword(getIt<ProfileRepository>()),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      getMyProfile: getIt<GetMyProfile>(),
      updateMyProfile: getIt<UpdateMyProfile>(),
      changePasswordUseCase: getIt<ChangePassword>(),
    ),
  );
  getIt.registerFactory<StudentsCubit>(() => StudentsCubit(getIt<GetUsers>()));
}

void notificationDependencies() {
  getIt.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSource(getIt<ApiClient>()),
  );
  getIt.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(getIt<NotificationRemoteDataSource>()),
  );
}

void dashboardDependencies() {
  getIt.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSource(getIt<ApiClient>()),
  );
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(getIt<DashboardRemoteDataSource>()),
  );
}

void transactionHistoryDependencies() {
  getIt.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(getIt<TransactionRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetTransactions>(
    () => GetTransactions(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<GetTransaction>(
    () => GetTransaction(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<CreateTransaction>(
    () => CreateTransaction(getIt<TransactionRepository>()),
  );

  getIt.registerLazySingleton<SetTransactionStatus>(
    () => SetTransactionStatus(getIt<TransactionRepository>()),
  );

  getIt.registerFactory<TransactionCubit>(
    () => TransactionCubit(
      getTransactions: getIt<GetTransactions>(),
      setTransactionStatus: getIt<SetTransactionStatus>(),
    ),
  );
}

Future<void> configureDependencies({required String apiBaseUrl}) async {
  // Infrastructure
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<TokenStore>(
    () => SecureTokenStore(getIt<FlutterSecureStorage>()),
  );
  getIt.registerLazySingleton<AuthState>(AuthState.new);

  // Network
  getIt.registerLazySingleton<ApiClient>(() {
    final tokenStore = getIt<TokenStore>();
    final authState = getIt<AuthState>();

    return buildApiClient(
      baseUrl: apiBaseUrl,
      tokenStore: tokenStore,
      onRefreshFailed: () async {
        await tokenStore.clear();
        authState.setSignedOut();
      },
    );
  });

  // ── Feature: auth / register / login / logout ───
  registerDependencies();
  loginDependencies();
  logoutDependencies();
  // ── Feature: auth / register / login / logout ───

  // ── Feature: service ───
  serviceDependencies();
  // ── Feature: service ───

  // ── Feature: Appointment slot ───
  appointmentSlotDependencies();
  // ── Feature: Appointment slot ───

  // ── Feature: Appointment ───
  appointmentDependencies();
  // ── Feature: Appointment ───

  // ── Feature: Queue ───
  queueDependencies();
  // ── Feature: Queue ───

  // ── Feature: Transaction history ───
  transactionHistoryDependencies();
  // ── Feature: Transaction history ───

  profileDependencies();
  notificationDependencies();
  dashboardDependencies();
}
