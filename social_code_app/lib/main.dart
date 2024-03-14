import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_code_app/config/theme/app_theme.dart';
import 'package:social_code_app/firebase_options.dart';
import 'package:social_code_app/features/messaging/presentation/pages/welcome_page.dart';
import 'package:social_code_app/injection_container.dart';
import 'package:social_code_app/shared/presentation/bloc/app_status/app_auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initializedDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => AppSt();
}

class AppSt extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppAuthBloc>(
        create: (context) => sl(),
        child: SafeArea(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'CodeGram',
              theme: AppTheme().theme(),
              home: const WelcomePage()),
        ));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      AppAuthBloc bloc = sl();
      bloc.logOut.call();
    } else if (state == AppLifecycleState.detached) {
      AppAuthBloc bloc = sl();
      bloc.logOut.call();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
