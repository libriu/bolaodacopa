class Pais {
  int codPais;
  String nome;
  String arquivo;

  Pais({required this.codPais,
    required this.nome,
    required this.arquivo
  });

  factory Pais.fromJson(dynamic json) {
    return Pais(codPais: json['codPais'] as int,
        nome: json['nome'] as String,
        arquivo: json['arquivo'] as String);
  }
}