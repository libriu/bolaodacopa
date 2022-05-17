import 'dart:convert';
import 'package:bolao_app/values/preference_keys.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/apostador.dart';

class Auth {

  static Future<Response> authenticate(Apostador user) async {
    final httpsUri = Uri(
    scheme: PreferenceKeys.httpScheme,
    host: PreferenceKeys.httpHost,
    port: PreferenceKeys.httpPort,
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

    }

  static Future<void> logoff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(PreferenceKeys.activeUser);
  }
}