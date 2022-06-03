import 'package:bolao_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../route_generator.dart';
import '../repositories/user_repository.dart';

class SplashRoute extends StatelessWidget {
  const SplashRoute({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Usuario>(
        builder: (context, cache, _) {
          UserRepository.logonFromLocal().then((value) {
                cache.copy(value);
                Navigator.pushNamed(context, RouteGenerator.homeRoute);
              });
          return const Center(child:SizedBox(
            child: CircularProgressIndicator(),
            height: 40.0,
            width: 40.0,
          ));
        }
    );
  }
}