import 'dart:convert';
import 'package:bolao_app/values/preference_keys.dart';
//import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/apostador.dart';

// class UserInheritedWidget extends InheritedWidget {
//   const UserInheritedWidget({
//     Key? key,
//     required this.user,
//     required Widget child}) : super(key: key, child: child);
//
//   final Apostador? user;
//
//   @override
//   bool updateShouldNotify(UserInheritedWidget oldWidget) {
//     return user!.codApostador != oldWidget.user!.codApostador;
//   }
//
//   static UserInheritedWidget of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<UserInheritedWidget>() as UserInheritedWidget;
//   }
// }

class Auth {

  static Future<Response> authenticate(Apostador user) async {
    final httpsUri = Uri(
    scheme: 'https',
    host: '10.0.2.2',
    port: 44357,
    path: 'user/authenticate');

    // Use a JSON encoded string to send
    var client = Client();
    var result = await client.post(
    httpsUri,
    //body: {'Login': 'elmo', 'Senha': 'elmo1233'});//,
    body: json.encode(user.toJson()),
    headers: {'content-type': 'application/json'});//,
    //encoding: Encoding.getByName("utf-8"));

    if (result.statusCode == 200) {
      Map<String, dynamic> mapUser = json.decode(result.body);
      Apostador apostador = Apostador.fromJson(mapUser);
      apostador.senha = user.senha;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(PreferenceKeys.activeUser, json.encode(apostador.toJson()));
    }
    return result;
    // String basicAuth =
    //     'Basic ' + base64Encode(utf8.encode('$nome:$senha'));
    // print(basicAuth);

    // Response r = await get('https://api.somewhere.io',
    //     headers: <String, String>{'authorization': basicAuth});
    // print(r.statusCode);
    // print(r.body);

    // Future<Response> callAPI(param) async {
    //   await dio.post('/api/test',
    //       data: {'param': param},
    //       options: Options(headers: <String, String>{'authorization': auth}));
    // }

    }

  static Future<void> logoff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(PreferenceKeys.activeUser);
  }
}