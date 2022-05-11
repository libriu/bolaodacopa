import 'dart:convert';
import 'dart:io';
import 'package:bolao_app/home.dart';
import 'package:bolao_app/values/preference_keys.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';
import 'models/apostador.dart';

void main() async {
  // handle exceptions caused by making main async
  //WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  //runApp(const MyApp());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Apostador? usuarioLogado;
  Widget _body = const SizedBox(
    child: CircularProgressIndicator(),
    height: 100.0,
    width: 100.0,
  );

  void getUserLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUser = prefs.get(PreferenceKeys.activeUser)?.toString();
    if (jsonUser != null) {
      Map<String, dynamic> mapUser = json.decode(jsonUser);
      Apostador user = Apostador.fromJson(mapUser);
      if (user.login != null && user.senha != null) {
        Auth.authenticate(user).then((Response resp) {
          if (resp.statusCode == 200) {
            mapUser = json.decode(resp.body);
            usuarioLogado = Apostador.fromJson(mapUser);
          }
          getNewBody();
        });
      }
      else {
        getNewBody();
      }
    }
    else {
      getNewBody();
    }

  }

  @override
  void initState() {
    super.initState();
    getUserLocal();
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  void getNewBody() {
    setState(() => _body = MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        //home: HomeRoute(activeUser: usuarioLogado),
        home: HomeRoute(usuarioLogado: usuarioLogado),
        )
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}