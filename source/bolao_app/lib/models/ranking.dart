import 'apostador.dart';

class Ranking {
  int? codApostador;
  int? totalPontos;
  int? totalAcertos;
  int? posicao;
  Apostador? apostador;

  Ranking({ this.codApostador,
     this.totalPontos,
     this.totalAcertos,
     this.posicao,
     this.apostador});

  factory Ranking.fromJson(dynamic json) {
    return Ranking(codApostador: json['codApostador'] as int,
        totalPontos: json['totalPontos'] as int,
        totalAcertos: json['totalAcertos'] as int,
        posicao: json['posicao'] as int,
        apostador: Apostador.fromJson(json['apostador']));
  }

  void copy(Ranking r) {
    codApostador = r.codApostador;
    totalPontos = r.totalPontos;
    totalAcertos = r.totalAcertos;
    posicao = r.posicao;
    apostador = r.apostador;
  }
}