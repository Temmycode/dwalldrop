import 'package:dwalldrop/backend/enums/like_result.dart';

class LikeState {
  final LikeResult? result;
  final bool isLoading;

  LikeState({required this.result, required this.isLoading});

  const LikeState.unkown()
      : result = null,
        isLoading = false;

  LikeState copyIsLoading({required bool isLoading}) => LikeState(
        result: result,
        isLoading: isLoading,
      );

  @override
  bool operator ==(covariant LikeState other) =>
      (result == other.result && isLoading == other.isLoading);

  @override
  int get hashCode => Object.hash(result, isLoading);

  @override
  String toString() => 'LikeState(result: $result, isLoading: $isLoading)';
}
