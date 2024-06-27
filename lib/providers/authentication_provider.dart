import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:edoc_tabcom/core/utils/extension/common_function.dart';
import 'package:edoc_tabcom/core/utils/local_storage.dart';

import '../services/auth_service.dart';

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider(ref);
});

class AuthProvider {
  final Ref ref;
  AuthProvider(this.ref);
  late final _authService = ref.read(authServiceProvider);
  bool get isAuthenticated => UserPreferences.instance.getToken() != '';
  // bool get isAuthenticated => false;
  Future<bool> login(BuildContext context, String username, String password) async {
    try {
      final inputFormData = {'grant_type': 'password', 'scope': 'offline_access edoc', 'client_id': 'edoc_App', 'username': 'hethong@edoc.edu.vn', 'password': 'Hethong@edoc2023'};
      final result = await _authService.login(inputFormData);
      UserPreferences.instance.saveToken(result.accessToken ?? '');
      // UserPreferences.instance.saveUserId(result. ?? 0);
      return true;
    } on DioException catch (e) {
      CommonFunction.showSnackBar('Tài khoản hoặc mật khẩu không đúng', context, Colors.red);
      return false;
    } catch (e) {
      CommonFunction.showSnackBar('Tài khoản chưa được kích hoạt', context, Colors.red);
      return false;
    }
  }

  // Login with google
  Future<bool> loginWithGoogle(BuildContext ctx) async {
    try {
      const List<String> scopes = <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ];
      final GoogleSignInAccount? result = await GoogleSignIn(scopes: scopes).signIn();
      if (result != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await result.authentication;
        // final AuthCredential credential = GoogleAuthProvider.credential(
        //   accessToken: googleSignInAuthentication.accessToken,
        //   idToken: googleSignInAuthentication.idToken,
        // );
        final responseRegisterGG = await _authService.registerUserWithGoogle({
          'appName': 'Angular',
          'code': result.id,
          'email': result.email,
          'name': result.displayName,
        });
        await login(ctx, responseRegisterGG.email ?? '', responseRegisterGG.tempPassword ?? '');
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      final result = await _authService.register({"userName": name, "emailAddress": email, "password": password, "appName": 'Angular'});
      if (result['result']['message'] == 'Email đã được đăng ký') {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      final checkExistEmail = await _authService.checkMailExist({"email": email});
      if (checkExistEmail) {
        await _authService.forgotPassword({"email": email, "appName": 'Angular'});
        // if (result['result']['message'] == 'Email không tồn tại') {
        //   return false;
        // }
      } else {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> resetPassword(String email, String otp, String newPassword) async {
    try {
      final result = await _authService.resetPassword({"email": email, "otp": otp, "new_password": newPassword});
      if (result['result']['message'] == 'Mã OTP không đúng') {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  void logout() {
    UserPreferences.instance.clearAuth();
  }
}
