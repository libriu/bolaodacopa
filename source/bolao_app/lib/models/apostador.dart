//Classe usada para ativação e alteração de Apostadores

class Apostador {
  int? codApostador;
  String? login;
  String? contato;
  String? email;
  String? senha;
  int? codApostAtivador;
  int? ativo;
  String? celular;
  int? acessoGestaoTotal;
  int? acessoAtivacao;
  String? cidade;
  int? ranking;

  Apostador(
      {this.codApostador,
        this.login,
        this.contato,
        this.email,
        this.senha,
        this.codApostAtivador,
        this.ativo,
        this.celular,
        this.acessoGestaoTotal,
        this.acessoAtivacao,
        this.cidade,
        this.ranking});

  factory Apostador.fromJson(Map<String, dynamic> json) {
    return Apostador(
    codApostador: json['codApostador'] as int?,
    login: json['login']as String?,
    contato: json['contato'] as String?,
    email: json['email'] as String?,
    senha: json['senha'] as String?,
    codApostAtivador: json['codApostAtivador'] as int?,
    ativo: json['ativo'] as int?,
    celular: json['celular'] as String?,
    acessoGestaoTotal: json['acessoGestaoTotal'] as int?,
    acessoAtivacao: json['acessoAtivacao'] as int?,
    cidade: json['cidade']  as String?,
    ranking: json['ranking'] as int?);
  }

  void copy(Apostador a) {
    codApostador = a.codApostador;
    login = a.login;
    contato = a.contato;
    email = a.email;
    senha = a.senha;
    codApostAtivador = a.codApostAtivador;
    ativo = a.ativo;
    celular = a.celular;
    acessoGestaoTotal = a.acessoGestaoTotal;
    acessoAtivacao = a.acessoAtivacao;
    cidade = a.cidade;
    ranking = a.ranking;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (codApostador != null) data['CodApostador'] = codApostador;
    if (login != null) data['Login'] = login;
    if (contato != null) data['Contato'] = contato;
    if (email != null) data['Email'] = email;
    if (senha != null) data['Senha'] = senha;
    if (codApostAtivador != null) data['CodApostAtivador'] = codApostAtivador;
    if (ativo != null) data['Ativo'] = ativo;
    if (celular != null) data['Celular'] = celular;
    if (acessoGestaoTotal != null) data['AcessoGestaoTotal'] = acessoGestaoTotal;
    if (acessoAtivacao != null) data['AcessoAtivacao'] = acessoAtivacao;
    if (cidade != null) data['Cidade'] = cidade;
    if (ranking != null) data['Ranking'] = ranking;

    return data;
  }
}