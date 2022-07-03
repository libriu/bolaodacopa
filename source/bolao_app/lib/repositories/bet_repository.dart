import 'dart:convert';
import 'package:bolao_app/repositories/bolao_repository.dart';
import 'package:http/http.dart';

import '../models/aposta.dart';


class BetRepository extends BolaoRepository{

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

}