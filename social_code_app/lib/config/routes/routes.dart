import 'package:flutter/material.dart';
import 'package:social_code_app/features/auth/presentation/pages/login_page.dart';
import 'package:social_code_app/features/auth/presentation/pages/profile_page.dart';
import 'package:social_code_app/features/auth/presentation/pages/register_page.dart';
import 'package:social_code_app/features/messaging/presentation/pages/popular_page.dart';
import 'package:social_code_app/features/messaging/presentation/pages/welcome_page.dart';

var routes = <String, Widget>{
  "/home": const WelcomePage(),
  "/profile": const ProfilePage(),
  "/popular": const PopularPage(),
  "/login": LoginPage(),
  "/register": RegisterPage(),
};
