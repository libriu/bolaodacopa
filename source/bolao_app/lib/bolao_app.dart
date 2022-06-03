import 'package:bolao_app/models/usuario.dart';
import 'package:bolao_app/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/apostador.dart';

class BolaoApp extends StatelessWidget {

  const BolaoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => Usuario()),
          Provider(create: (context) => Apostador())
        ],
        child: MaterialApp(
          onGenerateTitle: (context) => "Bolão da Copa 2022",
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.generateRoute,
          theme: ThemeData(
            primarySwatch: Colors.indigo,
          ),
          initialRoute: RouteGenerator.splashRoute,
        )
    );
  }
}