import 'dart:convert';
import 'package:bolao_app/repositories/bolao_repository.dart';
import 'package:http/http.dart';

import '../models/aposta.dart';


class BetRepository extends BolaoRepository{

  static Future<void> register(String login, String senha, List<Aposta> apostas) async {

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$senha'));

    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: 'bet/registermany');

    // Use a JSON encoded string to send
    var client = Client();
    var result = await client.post(
        httpsUri,
        body: json.encode(apostas),
        headers: {'authorization': basicAuth, 'content-type': 'application/json'});//,

    if (result.statusCode == 400) {
      Map<String, dynamic> j = json.decode(result.body);
      return Future<void>.error(j['message']);
    }
    if (result.statusCode != 200) {
      return Future<void>.error("Ocorreu um erro na gravação das apostas. Por favor, tente mais tarde");
    }
  }

  Future<Aposta?> getByGame(String login, String senha, int codJogo) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$senha'));
    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: 'bet/bygame',
        queryParameters: {'codJogo': '$codJogo'},
    );

    Response result;

    // Use a JSON encoded string to send
    var client = Client();

    try {
      result = await client.get(
          httpsUri,
          headers: {'authorization': basicAuth, 'content-type': 'application/json'});
    }
    finally {
      client.close();
    }
    if (result.statusCode == 200) {
      var mapAposta = json.decode(result.body);
      var apst = Aposta.fromJson(mapAposta);
      return apst;
    }
    else {
      if (result.statusCode != 204) {
        Future<Aposta?>.error("Ocorreu um erro, por favor, tente mais tarde");
      }
    }
    return null;
  }

  static Future<List<Aposta>> getAllByGame(int codJogo) async {
    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: 'bet/allbygame',
        queryParameters: {'codJogo': '$codJogo'}
    );

    Response result;

    // Use a JSON encoded string to send
    var client = Client();

    try {
      result = await client.get(
          httpsUri,
          headers: {'content-type': 'application/json'});
    }
    finally {
      client.close();
    }
    if (result.statusCode == 200) {
      Iterable l = json.decode(result.body);
      List<Aposta> rnk = List<Aposta>.from(l.map((model)=> Aposta.fromJson(model)));
      return rnk;
    }
    if (result.statusCode == 400) {
      Map<String, dynamic> j = json.decode(result.body);
      return Future<List<Aposta>>.error(j['message']);
    }
    if (result.statusCode != 200) {
      return Future<List<Aposta>>.error("Ocorreu um erro, por favor, tente mais tarde");
    }

    return <Aposta>[];
  }

}