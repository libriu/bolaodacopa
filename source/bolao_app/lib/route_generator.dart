import 'package:bolao_app/routes/activate_user.dart';
import 'package:bolao_app/routes/create_user.dart';
import 'package:bolao_app/routes/game.dart';
import 'package:bolao_app/routes/home.dart';
import 'package:bolao_app/routes/logon.dart';
import 'package:bolao_app/routes/ranking.dart';
import 'package:bolao_app/routes/splash.dart';
import 'package:bolao_app/routes/update_user.dart';
import 'package:flutter/material.dart';

class RouteGenerator {

  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String rankingRoute = '/ranking';
  static const String createUserRoute = '/user/create';
  static const String activateUserRoute = '/user/activate';
  static const String gameRoute = '/game';
  static const String logonRoute = '/logon';
  static const String updateUserRoute = '/user/update';
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashRoute(),
        );
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeRoute(),
        );
      case rankingRoute:
        return MaterialPageRoute(
          builder: (_) => const RankingRoute(),
        );
      case activateUserRoute:
        return MaterialPageRoute(
            builder: (_) => const ActivateUserRoute()
        );
      case updateUserRoute:
        return MaterialPageRoute(
            builder: (_) => const UpdateUserRoute()
        );
      case createUserRoute:
        return MaterialPageRoute(
            builder: (_) => const CreateUserRoute()
        );
      case gameRoute:
        return MaterialPageRoute(
            builder: (_) => const GameRoute()
        );
      case logonRoute:
        return MaterialPageRoute(
            builder: (_) => const LogonRoute()
        );
      default:
        throw const FormatException("Route not found");
    }
  }
}
// 5.
class RouteException implements Exception {
  final String message;
  const RouteException( this.message);
}
