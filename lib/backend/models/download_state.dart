import '../enums/download_result.dart';

class DownloadState {
  final DownloadResult? result;
  final bool isLoading;

  DownloadState({
    required this.result,
    required this.isLoading,
  });

  const DownloadState.unkown()
      : result = null,
        isLoading = false;

  DownloadState copyIsLoading({required bool isLoading}) => DownloadState(
        result: result,
        isLoading: isLoading,
      );

  @override
  bool operator ==(covariant DownloadState other) =>
      (result == other.result && isLoading == other.isLoading);

  @override
  int get hashCode => Object.hash(result, isLoading);

  @override
  String toString() => 'DownloadState(result: $result, isLoading: $isLoading)';
}
