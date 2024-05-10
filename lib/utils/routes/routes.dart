import 'package:flutter/material.dart';
import 'package:the_wall/utils/routes/route_name.dart';
import 'package:the_wall/view/screens/auth/login_page.dart';
import 'package:the_wall/view/screens/auth/register.dart';
import 'package:the_wall/view/screens/homescreen/homescreen.dart';
import 'package:the_wall/view/screens/profile/profile_screen.dart';
import 'package:the_wall/viewmodel/controller/auth/auth_control.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RouteNames.registerScreen:
        return MaterialPageRoute(builder: (_) => const Register());
      case RouteNames.authController:
        return MaterialPageRoute(builder: (_) => const AuthController());
      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
