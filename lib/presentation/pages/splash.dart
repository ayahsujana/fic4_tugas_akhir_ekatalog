import 'package:fic4_flutter_auth_bloc/data/localsources/auth_local_storage.dart';
import 'package:fic4_flutter_auth_bloc/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'root_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void checkLoginAuth() {
    Future.delayed(const Duration(seconds: 2), () async {
      final auth = await AuthLocalStorage().getToken();
      if (auth.isNotEmpty) {
        Get.offAll(const Home());
      } else {
        Get.offAll(const LoginPage());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkLoginAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo/logo.jpg",
                width: 300.0,
                height: 300.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'FIC4/5 Auth BloC',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      )),
    );
  }
}
