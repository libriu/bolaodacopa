import 'dart:convert';
import 'package:bolao_app/models/apostador.dart';
import 'package:bolao_app/repositories/bolao_repository.dart';
import 'package:http/http.dart';
import '../models/grupo.dart';


class GroupRepository extends BolaoRepository{

  Future<List<Grupo>> getAll() async {
    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: 'group');

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
      List<Grupo> grp = List<Grupo>.from(l.map((model)=> Grupo.fromJson(model)));
      return grp;
    }
    else {
      Future<List<Grupo>>.error("Ocorreu um erro, por favor, tente mais tarde");
    }
    return <Grupo>[];
  }

  Future<List<Grupo>> getWithMe(String login, String senha) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$senha'));
    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: 'group/withme');

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
      Iterable l = json.decode(result.body);
      List<Grupo> grp = List<Grupo>.from(l.map((model)=> Grupo.fromJson(model)));
      return grp;
    }
    else {
      Future<List<Grupo>>.error("Ocorreu um erro, por favor, tente mais tarde");
    }
    return <Grupo>[];
  }


  Future<List<Apostador>> getMembers(int codGrupo) async {
    final httpsUri = Uri(
        scheme: BolaoRepository.httpScheme,
        host: BolaoRepository.httpHost,
        port: BolaoRepository.httpPort,
        path: 'group/members',
        queryParameters: {'codGrupo': '$codGrupo'});

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
      List<Apostador> rnk = List<Apostador>.from(l.map((model)=> Apostador.fromJson(model)));
      return rnk;
    }
    else {
      Future<List<Apostador>>.error("Ocorreu um erro, por favor, tente mais tarde");
    }
    return <Apostador>[];
  }
}