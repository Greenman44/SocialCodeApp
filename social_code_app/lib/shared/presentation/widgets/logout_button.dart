import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_code_app/shared/presentation/bloc/app_status/app_auth_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          BlocProvider.of<AppAuthBloc>(context).add(const AppLogOutRequest());
        },
        icon: const Icon(Icons.logout));
  }
}
