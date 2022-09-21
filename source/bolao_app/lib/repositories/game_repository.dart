import 'dart:convert';
import 'package:bolao_app/repositories/bolao_repository.dart';
import 'package:http/http.dart';
import '../models/jogo.dart';


class GameRepository extends BolaoRepository{

  static String getUrlFlag(int codPais) {
    return BolaoRepository.httpScheme + "://" + BolaoRepository.httpHost + ":" + BolaoRepository.httpPort.toString()
      + "/country/flag?codPais=" + codPais.toString();
  }

  Future<List<Jogo>> getNextGames(String login, String senha, int? codApostador) async {
    return _getGames(login, senha, codApostador, "game/nextwithbets");
  }
  Future<List<Jogo>> getNextGamesAnnonymous(int? codApostador) async {
    return _getGames("", "", codApostador, "game/next");
  }

  Future<List<Jogo>> getPreviousGames(int? codApostador) async {
    return _getGames("", "", codApostador, "game/previous");
  }

  Future<List<Jogo>> _getGames(String login, String senha, int? codApostador, String url) async {
    var codApost = codApostador ?? 0;
    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: url,
        queryParameters: {'codApostador': '$codApost'},
    );

    Map<String, String> header;
    if (login == "") {
      header = {'content-type': 'application/json'};
    } else {
      String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$senha'));
      header = {'authorization': basicAuth, 'content-type': 'application/json'};
    }
    Response result;
    // Use a JSON encoded string to send
    var client = Client();
    try {
      result = await client.get(
          httpsUri,
          headers: header);
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