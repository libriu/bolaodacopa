import 'dart:convert';
import 'package:bolao_app/repositories/bolao_repository.dart';
import 'package:bolao_app/values/preference_keys.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/usuario.dart';

class UserRepository extends BolaoRepository {

  static Future<Response> logon(Usuario user) async {
    final httpsUri = Uri(
    scheme: BolaoRepository.httpScheme,
    host: BolaoRepository.httpHost,
    port: BolaoRepository.httpPort,
    path: 'user/authenticate');

    Response result;
    // Use a JSON encoded string to send
    var client = Client();
    try {
      result = await client.post(
          httpsUri,
          body: json.encode(user.toJson()),
          headers: {'content-type': 'application/json'});//,
    }
    finally {
      client.close();
    }

    if (result.statusCode == 200) {
      Map<String, dynamic> mapUser = json.decode(result.body);
      Usuario usuario = Usuario.fromJson(mapUser);
      usuario.senha = user.senha;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(PreferenceKeys.activeUser, json.encode(usuario.toJson()));
    }
    return result;

    }

  static Future<Usuario> getFromLocal() async {
    Usuario usuarioLogado = Usuario();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUser = prefs.get(PreferenceKeys.activeUser)?.toString();
    if (jsonUser != null) {
      Map<String, dynamic> mapUser = json.decode(jsonUser);
      Usuario user = Usuario.fromJson(mapUser);
      user.isLoggedOn = true;
      return user;
    }
    usuarioLogado.isLoggedOn = false;
    return usuarioLogado;
  }

  static Future<Usuario> logonFromLocal() async {
    Usuario usuarioLogado = Usuario();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUser = prefs.get(PreferenceKeys.activeUser)?.toString();
    if (jsonUser != null) {
      Map<String, dynamic> mapUser = json.decode(jsonUser);
      Usuario user = Usuario.fromJson(mapUser);
      if (user.login != null && user.senha != null) {
        Response resp = await UserRepository.logon(user);
        if (resp.statusCode == 200) {
          mapUser = json.decode(resp.body);
          usuarioLogado = Usuario.fromJson(mapUser);
          usuarioLogado.senha = user.senha;
          usuarioLogado.isLoggedOn = true;
          return usuarioLogado;
        }
      }
    }
    usuarioLogado.isLoggedOn = false;
    return usuarioLogado;
  }

  static Future<Usuario> logoff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(PreferenceKeys.activeUser);
    return Usuario();
  }
}