import 'package:dwalldrop/authentication/enums/auth_result.dart';
import 'package:dwalldrop/authentication/provider/auth_state_provider.dart';
import 'package:dwalldrop/backend/services/shared_prefernce_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoggedInProvider = FutureProvider<bool>((ref) async {
  final loginState = await SharedPrefrenceService.getIsLoggedIn();
  return loginState;
});
