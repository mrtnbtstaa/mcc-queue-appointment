import 'package:equatable/equatable.dart';

import '../../domain/entities/profile_entity.dart';

enum ProfileTab { personalInfo, accountSecurity }

class ProfileState extends Equatable {
  final ProfileEntity? profile;
  final ProfileTab activeTab;
  final bool isLoading;
  final bool isSaving;
  final bool isChangingPassword;
  final String? error;
  final String? successMessage;

  const ProfileState({
    this.profile,
    this.activeTab = ProfileTab.personalInfo,
    this.isLoading = false,
    this.isSaving = false,
    this.isChangingPassword = false,
    this.error,
    this.successMessage,
  });

  ProfileState copyWith({
    ProfileEntity? profile,
    ProfileTab? activeTab,
    bool? isLoading,
    bool? isSaving,
    bool? isChangingPassword,
    String? error,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) => ProfileState(
    profile: profile ?? this.profile,
    activeTab: activeTab ?? this.activeTab,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
    isChangingPassword: isChangingPassword ?? this.isChangingPassword,
    error: clearError ? null : error ?? this.error,
    successMessage: clearSuccess ? null : successMessage ?? this.successMessage,
  );

  @override
  List<Object?> get props => [
    profile,
    activeTab,
    isLoading,
    isSaving,
    isChangingPassword,
    error,
    successMessage,
  ];
}
