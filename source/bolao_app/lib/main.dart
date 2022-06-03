import 'dart:io';
import 'package:flutter/material.dart';
import 'bolao_app.dart';

void main() async {
  // handle exceptions caused by making main async
  //WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const BolaoApp());

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}