import 'package:bolao_app/models/pais.dart';

class Jogo {
  int codJogo;
  String grupo;
  String dataHora;
  int jaOcorreu;
  int rPlacarA;
  int rPlacarB;
  int codPaisA;
  int codPaisB;
  Pais paisA;
  Pais paisB;

  Jogo({required this.codJogo,
    required this.grupo,
    required this.dataHora,
    required this.jaOcorreu,
    required this.rPlacarA,
    required this.rPlacarB,
    required this.codPaisA,
    required this.codPaisB,
    required this.paisA,
    required this.paisB
  });

  factory Jogo.fromJson(dynamic json) {
    return Jogo(codJogo: json['codJogo'] as int,
        grupo: json['grupo'] as String,
        dataHora: json['dataHora'] as String,
        jaOcorreu: json['jaOcorreu'] as int,
        rPlacarA: json['rPlacarA'] as int,
        rPlacarB: json['rPlacarB'] as int,
        codPaisA: json['codPaisA'] as int,
        codPaisB: json['codPaisB'] as int,
        paisA: Pais.fromJson(json['paisA']),
        paisB: Pais.fromJson(json['paisB']),);
  }
}