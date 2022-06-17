import 'dart:convert';
import 'package:bolao_app/repositories/bolao_repository.dart';
import 'package:http/http.dart';
import '../models/jogo.dart';


class GameRepository extends BolaoRepository{

  static String getUrlFlag(int codPais) {
    return BolaoRepository.httpScheme + "://" + BolaoRepository.httpHost + ":" + BolaoRepository.httpPort.toString()
      + "/country/flag?codPais=" + codPais.toString();
  }

  Future<List<Jogo>> getNextGames() async {
    return _getGames("game/next");
  }

  Future<List<Jogo>> getPreviousGames() async {
    return _getGames("game/previous");
  }

  Future<List<Jogo>> _getGames(String url) async {
    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: url);

    Response result;
    // Use a JSON encoded string to send
    var client = Client();
    try {
      result = await client.get(
          httpsUri,
          headers: {'content-type': 'application/json'});
    }
    finally{
      client.close();
    }

    if (result.statusCode == 200) {
      Iterable l = json.decode(result.body);
      List<Jogo> jog = List<Jogo>.from(l.map((model)=> Jogo.fromJson(model)));
      return jog;
    }
    else {
      Future<List<Jogo>>.error("Ocorreu um erro, por favor, tente mais tarde");
    }
    return <Jogo>[];
  }
}