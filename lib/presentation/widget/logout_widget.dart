import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/localsources/auth_local_storage.dart';
import '../pages/login_page.dart';

class LogoutFunction {
  logoutNow(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Logout :('),
            content: const Text('Are you sure want to logout?'),
            actions: [
              TextButton(
                  onPressed: () => Get.back(), child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    AuthLocalStorage().removeToken();
                    Get.offAll(const LoginPage());
                  },
                  child: const Text('Yes')),
            ],
          );
        });
  }
}
