import 'package:dwalldrop/authentication/enums/auth_result.dart';
import 'package:dwalldrop/setup/typedefs/user_id_typedef.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class AuthState {
  final UserId? userId;
  final AuthResult? result;
  final bool isLoading;
  final bool isLoggedIn;

  const AuthState({
    required this.userId,
    required this.result,
    required this.isLoading,
    required this.isLoggedIn,
  });

  const AuthState.unknown()
      : isLoading = false,
        isLoggedIn = false,
        result = null,
        userId = null;

  AuthState copyIsLoading({required bool isLoading}) => AuthState(
        userId: userId,
        result: result,
        isLoading: isLoading,
        isLoggedIn: isLoggedIn,
      );

  @override
  bool operator ==(covariant AuthState other) => (userId == other.userId &&
      result == other.result &&
      isLoading == other.isLoading &&
      isLoggedIn == other.isLoggedIn);

  @override
  int get hashCode => Object.hashAll([
        result,
        isLoading,
        isLoggedIn,
        userId,
      ]);

  @override
  String toString() =>
      'AuthState(userId: $userId, result: $result, isLoading: $isLoading, isLoggedIn: $isLoggedIn)';
}
