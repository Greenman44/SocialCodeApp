// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_code_app/features/auth/domain/entities/login_params.dart';
import 'package:social_code_app/features/auth/presentation/pages/login_page.dart';
import 'package:social_code_app/features/auth/presentation/widgets/widgets.dart';
import 'package:social_code_app/injection_container.dart';
import 'package:social_code_app/shared/presentation/bloc/app_status/app_auth_bloc.dart';

import '../bloc/auth_bloc.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppAuthBloc, AppState>(
      listener: (context, state) {
        if (state.status == AppStatus.authenticated) {
          Navigator.of(context).popUntil(
            (route) => (route.settings.name != "/login" &&
                route.settings.name != "/register"),
          );
        }
      },
      child: BlocProvider<RegisterBloc>(
        create: (context) => sl(),
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is SignUpMessageError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                state.messageError.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              )));
            }
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
              bloc: sl(),
              builder: ((context, state) {
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: const Center(child: Text("Register")),
                  ),
                  body: SafeArea(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Icon(
                            Icons.lock,
                            size: 100,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text("Lets create an account for you"),
                          const SizedBox(
                            height: 25,
                          ),
                          EmailTextField(email: email),
                          const SizedBox(
                            height: 25,
                          ),
                          PasswordTextField(
                            password: password,
                            hintText: "Password",
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          PasswordTextField(
                            password: confirmPassword,
                            hintText: "Confirm your password",
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          BlocBuilder<RegisterBloc, RegisterState>(
                            builder: (context, state) {
                              if (state is Loading) {
                                return SignInButton(
                                  email: email,
                                  password: password,
                                  text: const CircularProgressIndicator(),
                                  func: () {},
                                );
                              } else {
                                return SignInButton(
                                    email: email,
                                    password: password,
                                    text: const Text("Sign Up",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                    func: () {
                                      if (password.text !=
                                          confirmPassword.text) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                          "Passwords must macth",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )));
                                        return;
                                      }
                                      BlocProvider.of<RegisterBloc>(context)
                                          .add(SignUpAttempt(LoginParams(
                                              email.text.trim(),
                                              password.text.trim())));
                                    });
                              }
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: LoginPage().build));
                                },
                                child: const Text(
                                  "  Login now",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
                );
              })),
        ),
      ),
    );
  }
}
