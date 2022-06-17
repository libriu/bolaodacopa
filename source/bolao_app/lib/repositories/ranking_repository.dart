import 'dart:convert';

import 'package:bolao_app/repositories/bolao_repository.dart';
import 'package:http/http.dart';
import '../models/ranking.dart';

class RankingRepository extends BolaoRepository{

  Future<Ranking?> getMyRanking(String login, String senha) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$senha'));
    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: 'ranking/my');

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
      var mapRanking = json.decode(result.body);
      var rnk = Ranking.fromJson(mapRanking);
      return rnk;
    }
    else {
      Future<List<Ranking>>.error("Ocorreu um erro, por favor, tente mais tarde");
    }
    return null;
  }

  Future<List<Ranking>> getRanking() async {
    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: 'ranking');

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
      List<Ranking> rnk = List<Ranking>.from(l.map((model)=> Ranking.fromJson(model)));
      return rnk;
    }
    else {
      Future<List<Ranking>>.error("Ocorreu um erro, por favor, tente mais tarde");
    }
    return <Ranking>[];
  }
}