import 'package:dwalldrop/authentication/models/auth_state.dart';
import 'package:dwalldrop/authentication/provider/notifier/auth_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
