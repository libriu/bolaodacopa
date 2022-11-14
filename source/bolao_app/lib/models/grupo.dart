class Grupo {
  int codGrupo;
  String nome;
  int codApostResponsavel;

  Grupo({required this.codGrupo,
    required this.nome,
    required this.codApostResponsavel
  });

  factory Grupo.fromJson(dynamic json) {
    return Grupo(codGrupo: json['codGrupo'] as int,
        nome: json['nome'] as String,
        codApostResponsavel: json['codApostResponsavel'] as int);
  }
}