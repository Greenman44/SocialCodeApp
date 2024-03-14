// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_code_app/config/routes/routes.dart';
import 'package:social_code_app/features/auth/presentation/widgets/widgets.dart';
import 'package:social_code_app/features/auth/domain/entities/login_params.dart';
import 'package:social_code_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:social_code_app/injection_container.dart';
import 'package:social_code_app/shared/presentation/bloc/app_status/app_auth_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
      child: BlocProvider<LoginBloc>(
        create: (context) => sl(),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginErrorMessage) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                state.error.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              )));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            bloc: sl(),
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: const Center(child: Text("Login")),
                ),
                body: SingleChildScrollView(
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
                        const Text("Welcome back, you`ve been missed"),
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
                        BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                          if (state is SignInLoading) {
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
                              text: const Text("Sign In",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              func: () {
                                BlocProvider.of<LoginBloc>(context).add(
                                    LoginAttempt(LoginParams(email.text.trim(),
                                        password.text.trim())));
                              },
                            );
                          }
                        }),
                        const SizedBox(
                          height: 25,
                        ),
                        // state is GoogleLoading
                        //     #? AuthenticationButton(
                        //         showLoader: true,
                        //         authenticationMethod: AuthenticationMethod.google,
                        //         onPressed: () {})
                        //     : AuthenticationButton(
                        //         authenticationMethod: AuthenticationMethod.google,
                        //         onPressed: () {
                        //           BlocProvider.of<LoginBloc>(context)
                        //               .add(LoginGoogleAttempt());
                        //         }),
                        // const SizedBox(
                        //   height: 25,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Not signed in?"),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            routes["/register"]!,
                                        settings: const RouteSettings(
                                            name: "/register")));
                              },
                              child: const Text(
                                "  Register now",
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
