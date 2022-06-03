import 'dart:convert';

import 'package:bolao_app/repositories/bolao_repository.dart';
import 'package:http/http.dart';

import '../models/ranking.dart';

class RankingRepository extends BolaoRepository{

  Future<List<Ranking>> getRanking(int? codApostador) async {
    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: 'ranking');

    // Use a JSON encoded string to send
    var client = Client();
    var result = await client.get(
        httpsUri,
        headers: {'content-type': 'application/json'});

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