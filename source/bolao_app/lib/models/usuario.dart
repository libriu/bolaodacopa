//Classe usada para autenticação

class Usuario {
  bool isLoggedOn = false;
  int? codApostador;
  String? login;
  String? email;
  String? senha;
  int? acessoGestaoTotal;
  int? acessoAtivacao;

  Usuario(
      {this.codApostador,
        this.login,
        this.email,
        this.senha,
        this.acessoGestaoTotal,
        this.acessoAtivacao});

  Usuario.fromJson(Map<String, dynamic> json) {
    codApostador = json['codApostador'];
    login = json['login'];
    email = json['email'];
    senha = json['senha'];
    acessoGestaoTotal = json['acessoGestaoTotal'];
    acessoAtivacao = json['acessoAtivacao'];
  }

  void copy(Usuario u) {
    codApostador = u.codApostador;
    login = u.login;
    email = u.email;
    senha = u.senha;
    acessoGestaoTotal = u.acessoGestaoTotal;
    acessoAtivacao = u.acessoAtivacao;
    isLoggedOn = u.isLoggedOn;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codApostador'] = codApostador;
    data['login'] = login;
    data['email'] = email;
    data['senha'] = senha;
    data['acessoGestaoTotal'] = acessoGestaoTotal;
    data['acessoAtivacao'] = acessoAtivacao;

    return data;
  }
}