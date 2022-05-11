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

  Apostador.fromJson(Map<String, dynamic> json) {
    codApostador = json['codApostador'];
    login = json['login'];
    contato = json['contato'];
    email = json['email'];
    senha = json['senha'];
    codApostAtivador = json['codApostAtivador'];
    ativo = json['ativo'];
    celular = json['celular'];
    acessoGestaoTotal = json['acessoGestaoTotal'];
    acessoAtivacao = json['acessoAtivacao'];
    cidade = json['cidade'];
    ranking = json['ranking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['codApostador'] = codApostador;
    data['login'] = login;
    data['contato'] = contato;
    data['email'] = email;
    data['senha'] = senha;
    data['codApostAtivador'] = codApostAtivador;
    data['ativo'] = ativo;
    data['celular'] = celular;
    data['acessoGestaoTotal'] = acessoGestaoTotal;
    data['acessoAtivacao'] = acessoAtivacao;
    data['cidade'] = cidade;
    data['ranking'] = ranking;

    return data;
  }
}