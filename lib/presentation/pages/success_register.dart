import 'package:fic4_flutter_auth_bloc/presentation/pages/root_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../../bloc/login/login_bloc.dart';
import '../../data/models/request/login_model.dart';

class SuccessRegisterPage extends StatelessWidget {
  const SuccessRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline_outlined,
                color: Colors.green,
                size: 50,
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text('Successful!',
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              Text(
                'You have successfully registered in\nour app and start working in it.',
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ],
          ),
          Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                   Get.offAll(const Home());
                },
                  builder: ((context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    final requestModel = LoginModel(
                      email: Get.arguments['email'],
                      password: Get.arguments['password'],
                    );

                    context
                        .read<LoginBloc>()
                        .add(DoLoginEvent(loginModel: requestModel));
                  },
                  child: Text(
                    "Start Shopping",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                );
              }))),
        ],
      )),
    );
  }
}
