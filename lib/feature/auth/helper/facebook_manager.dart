import 'dart:developer';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookManager {
  static FacebookManager? _instance;

  FacebookManager._();

  static FacebookManager get instance => _instance ??= FacebookManager._();

  final auth = FacebookAuth.instance;

  Future onLogin() async {
    try {
      FacebookPermissions? permissions =
          await FacebookAuth.instance.permissions;
      final LoginResult result = await auth.login(
        permissions: [
          'public_profile',
          'email',
          'pages_show_list',
          'pages_messaging',
          'pages_manage_metadata'
        ],
      );
      if (result.status == LoginStatus.success) {
        var json = await auth.getUserData();
        final data = await auth.accessToken;
        json['token'] = data?.token;

        return json;
      } else {
        return '';
      }
    } catch (e) {
      print(e);
    }
  }

  void onLogout() {
    auth.logOut();
  }
}
