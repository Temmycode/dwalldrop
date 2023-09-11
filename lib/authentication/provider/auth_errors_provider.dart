import 'package:dwalldrop/authentication/logic/auth_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authErrorProvider = Provider<String>((ref) {
  return AuthClient.error;
});
