import 'package:equatable/equatable.dart';

class AppointmentSlipState extends Equatable {
  final bool isDownloaded;

  const AppointmentSlipState({this.isDownloaded = false});

  AppointmentSlipState copyWith({bool? isDownloaded}) {
    return AppointmentSlipState(
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }

  @override
  List<Object?> get props => [isDownloaded];
}
