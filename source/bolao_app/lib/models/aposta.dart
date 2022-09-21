class Aposta {
  int codApostador;
  int codJogo;
  int placarA;
  int placarB;
  int pontos;


  Aposta({required this.codApostador,
    required this.codJogo,
    required this.placarA,
    required this.placarB,
    required this.pontos,
  });

  factory Aposta.fromJson(dynamic json) {
    return Aposta(codApostador: json['codApostador'] as int,
        codJogo: json['codJogo'] as int,
        placarA: json['placarA'] as int,
        placarB: json['placarB'] as int,
        pontos: json['pontos'] as int);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CodApostador'] = codApostador;
    data['CodJogo'] = codJogo;
    data['placarA'] = placarA;
    data['placarB'] = placarB;
    data['Pontos'] = pontos;
    return data;
  }
}