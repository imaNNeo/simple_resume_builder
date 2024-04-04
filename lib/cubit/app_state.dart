part of 'app_cubit.dart';

@immutable
class AppState with EquatableMixin {
  final bool isLoading;
  final ResumeData? resumeData;
  final String? error;

  const AppState({
    this.isLoading = false,
    this.resumeData,
    this.error = '',
  });

  // CopyWith
  AppState copyWith({
    bool? isLoading,
    ValueWrapper<ResumeData>? resumeData,
    String? error,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      resumeData: resumeData != null ? resumeData.value : this.resumeData,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        resumeData,
        error,
      ];
}
