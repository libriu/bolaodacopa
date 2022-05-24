import 'apostador.dart';

class Ranking {
  int codApostador;
  int totalPontos;
  int totalAcertos;
  int posicao;
  Apostador apostador;

  Ranking({required this.codApostador,
    required this.totalPontos,
    required this.totalAcertos,
    required this.posicao,
    required this.apostador});

  factory Ranking.fromJson(dynamic json) {
    return Ranking(codApostador: json['codApostador'] as int,
        totalPontos: json['totalPontos'] as int,
        totalAcertos: json['totalAcertos'] as int,
        posicao: json['posicao'] as int,
        apostador: Apostador.fromJson(json['apostador']));
  }
}