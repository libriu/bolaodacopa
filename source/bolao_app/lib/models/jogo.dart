import 'package:bolao_app/models/pais.dart';

import 'aposta.dart';

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
  List<Aposta>? apostas;
  bool isBetVisibleToOthers;

  Jogo({required this.codJogo,
    required this.grupo,
    required this.dataHora,
    required this.jaOcorreu,
    required this.rPlacarA,
    required this.rPlacarB,
    required this.codPaisA,
    required this.codPaisB,
    required this.paisA,
    required this.paisB,
    required this.isBetVisibleToOthers,
    this.apostas
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
        paisB: Pais.fromJson(json['paisB']),
        isBetVisibleToOthers: json['isBetVisibleToOthers'] as bool,
        apostas: json['apostas'] == null ? null : List<Aposta>.from(json['apostas'].map((model)=> Aposta.fromJson(model)))
    );
  }

  void copy(Jogo j) {
    codJogo = j.codJogo;
    grupo = j.grupo;
    dataHora = j.dataHora;
    jaOcorreu = j.jaOcorreu;
    rPlacarA = j.rPlacarA;
    codPaisA = j.codPaisA;
    codPaisB = j.codPaisB;
    paisA = j.paisA;
    paisB = j.paisB;
    isBetVisibleToOthers = j.isBetVisibleToOthers;
    apostas = j.apostas;
  }
}