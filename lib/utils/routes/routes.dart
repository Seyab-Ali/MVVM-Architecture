import 'package:flutter/material.dart';
import 'package:mvvm_architecture/utils/routes/routes_name.dart';
import 'package:mvvm_architecture/view/signup_screen.dart';

import '../../view/home_screen.dart';
import '../../view/login_screen.dart';

class Routes {

   static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RouteName.login:
        return MaterialPageRoute(builder: (context) => const LoginScrren());
      case RouteName.signup:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No Route Defined'),
            ),
          );
        }
        );
    }
  }
}