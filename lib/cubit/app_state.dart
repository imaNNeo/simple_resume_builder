part of 'app_cubit.dart';

@immutable
class AppState with EquatableMixin {
  final bool isLoading;
  final ResumeData? resumeData;
  final Uint8List? pdfBytes;
  final String? error;

  const AppState({
    this.isLoading = false,
    this.resumeData,
    this.pdfBytes,
    this.error = '',
  });

  // CopyWith
  AppState copyWith({
    bool? isLoading,
    ValueWrapper<ResumeData>? resumeData,
    ValueWrapper<Uint8List>? pdfBytes,
    String? error,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      resumeData: resumeData != null ? resumeData.value : this.resumeData,
      pdfBytes: pdfBytes != null ? pdfBytes.value : this.pdfBytes,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        resumeData,
        pdfBytes,
        error,
      ];
}
