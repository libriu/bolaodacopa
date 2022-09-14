import 'package:bolao_app/models/usuario.dart';
import 'package:bolao_app/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/apostador.dart';
import 'models/ranking.dart';

class BolaoApp extends StatelessWidget {

  const BolaoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, Color> color =
    {
      50 :const Color.fromRGBO(31, 78, 121, .1),
      100:const Color.fromRGBO(31, 78, 121, .2),
      200:const Color.fromRGBO(31, 78, 121, .3),
      300:const Color.fromRGBO(31, 78, 121, .4),
      400:const Color.fromRGBO(31, 78, 121, .5),
      500:const Color.fromRGBO(31, 78, 121, .6),
      600:const Color.fromRGBO(31, 78, 121, .7),
      700:const Color.fromRGBO(31, 78, 121, .8),
      800:const Color.fromRGBO(31, 78, 121, .9),
      900:const Color.fromRGBO(31, 78, 121, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xFF1F4E79, color);
    return MultiProvider(
        providers: [
          Provider(create: (context) => Usuario()),
          Provider(create: (context) => Apostador()),
          Provider(create: (context) => Ranking())
        ],
        child: MaterialApp(
          onGenerateTitle: (context) => "Bolão da Copa 2022",
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.generateRoute,
          theme: ThemeData(
            //primaryColor: const Color.fromRGBO(31, 78, 121, 1)
            primarySwatch: colorCustom,
          ),
          initialRoute: RouteGenerator.splashRoute,
        )
    );
  }

}