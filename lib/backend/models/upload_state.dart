import 'package:dwalldrop/backend/enums/upload_result.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class UploadState {
  final UploadResult? result;
  final bool isLoading;

  const UploadState({
    required this.result,
    required this.isLoading,
  });

  const UploadState.unknown()
      : isLoading = false,
        result = null;

  UploadState copyIsLoading({required bool isLoading}) => UploadState(
        result: result,
        isLoading: isLoading,
      );

  @override
  bool operator ==(covariant UploadState other) =>
      (result == other.result && isLoading == other.isLoading);

  @override
  int get hashCode => Object.hashAll([
        result,
        isLoading,
      ]);

  @override
  String toString() => 'AuthState(result: $result, isLoading: $isLoading)';
}
