import 'dart:convert';
import 'package:bolao_app/models/apostador.dart';
import 'package:bolao_app/repositories/bolao_repository.dart';
import 'package:http/http.dart';

class ApostadorRepository extends BolaoRepository{

  Future<List<Apostador>> getUserToActivate(String login, String senha) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$senha'));
    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: 'user/toactivate');

    var client = Client();
    var result = await client.get(
        httpsUri,
        headers: {'authorization': basicAuth, 'content-type': 'application/json'});

    if (result.statusCode == 200) {
      Iterable l = json.decode(result.body);
      List<Apostador> aps = List<Apostador>.from(l.map((model)=> Apostador.fromJson(model)));
      return aps;
    }
    else {
      if (result.statusCode == 400) {
        Map<String, dynamic> j = json.decode(result.body);
        return Future<List<Apostador>>.error(j['message']);
      }
      else {
        return Future<List<Apostador>>.error("Ocorreu um erro, por favor, tente mais tarde");
      }
    }
  }

  static Future<void> activate(String login, String senha, List<Apostador> apostadores) async {

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$senha'));

    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: 'user/activate');

    // Use a JSON encoded string to send
    var client = Client();
    var result = await client.post(
        httpsUri,
        body: json.encode(apostadores),
        headers: {'authorization': basicAuth, 'content-type': 'application/json'});//,

    if (result.statusCode == 400) {
      Map<String, dynamic> j = json.decode(result.body);
      return Future<void>.error(j['message']);
    }
    if (result.statusCode != 200) {
      return Future<void>.error("Ocorreu um erro na ativação dos usuários. Por favor, tente mais tarde");
    }
  }

  static Future<void> update(String login, String senha, Apostador apostador) async {

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$senha'));

    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: 'user/update');

    // Use a JSON encoded string to send
    var client = Client();
    var result = await client.post(
        httpsUri,
        body: json.encode(apostador.toJson()),
        headers: {'authorization': basicAuth, 'content-type': 'application/json'});

    if (result.statusCode != 200) {
      return Future<void>.error("Ocorreu um erro na atualização do usuário. Por favor, tente mais tarde");
    }
  }

  static Future<void> create(Apostador apostador) async {

    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: 'user/create');

    Response result;
    // Use a JSON encoded string to send
    var client = Client();
    try {
      result = await client.post(
          httpsUri,
          body: json.encode(apostador.toJson()),
          headers: {'content-type': 'application/json'});//,
      //encoding: Encoding.getByName("utf-8"));
    }
    finally {
      client.close();
    }

    if (result.statusCode != 200) {
      return Future<void>.error("Ocorreu um erro na criação do usuário. Por favor, tente mais tarde");
    }
  }

}