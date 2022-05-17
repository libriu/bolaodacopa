import 'dart:convert';
import 'package:bolao_app/values/preference_keys.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';

import 'home.dart';

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  'Login': instance.Login,
  'Contato': instance.Contato,
  'Email': instance.Email,
  'Senha': instance.Senha,
  'Celular': instance.Celular,
  'Cidade': instance.Cidade,
};

@JsonSerializable()
class UserData {
  String? Login;
  String? Contato;
  String? Email;
  String? Senha;
  String? RepetirSenha;
  String? Celular;
  String? Cidade;

  UserData({
    this.Login,
    this.Contato,
    this.Email,
    this.Senha,
    this.RepetirSenha,
    this.Celular,
    this.Cidade,
  });

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

class CreateUserRoute extends StatefulWidget {

  const CreateUserRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateUserRoute> createState() => _CreateUserRouteState();
}

class _CreateUserRouteState extends State<CreateUserRoute> {
  final _formKey = GlobalKey<FormState>();
  UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criação de novo usuário'),

      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ...[
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Ex: Joao Paulo',
                      labelText: 'Login/Nome Único',
                    ),
                    onChanged: (value) {
                      userData.Login = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Login/Nome Único é obrigatório.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Ex: Turma da Natação',
                      labelText: 'Indicação',
                    ),
                    onChanged: (value) {
                      userData.Contato = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Contato é obrigatório.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'E-mail',
                      labelText: 'E-mail',
                    ),
                    onChanged: (value) {
                      userData.Email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'E-mail é obrigatório.';
                      }
                      else {
                        bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                        if (!emailValid) {
                          return 'E-mail inválido.';
                        }
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Senha',
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      userData.Senha = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Senha é obrigatório.';
                      }
                      if (userData.RepetirSenha == userData.Senha) {
                        return null;
                      }
                      return 'Senhas não conferem.';
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Repetir Senha',
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      userData.RepetirSenha = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Repetir Senha é obrigatório.';
                      }
                      if (userData.RepetirSenha == userData.Senha) {
                        return null;
                      }
                      return 'Senhas não conferem.';
                    },
                  ),
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Telefone Celular',
                      labelText: 'Telefone Celular',
                    ),
                    onChanged: (value) {
                      userData.Celular = value;
                    },
                  ),
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Cidade',
                      labelText: 'Cidade',
                    ),
                    onChanged: (value) {
                      userData.Cidade = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Cidade é obrigatório.';
                      }
                      return null;
                    },
                  ),
                  TextButton(
                    child: const Text('Criar'),
                    onPressed: () async {

                      var valid = _formKey.currentState!.validate();
                      if (!valid) {
                        return;
                      }
                      final httpsUri = Uri(
                          scheme: PreferenceKeys.httpScheme,
                          host: PreferenceKeys.httpHost,
                          port: PreferenceKeys.httpPort,
                          path: 'user/create');

                      // Use a JSON encoded string to send
                      var client = Client();
                      var result = await client.post(
                          httpsUri,
                          body: json.encode(userData.toJson()),
                          headers: {'content-type': 'application/json'});//,
                          //encoding: Encoding.getByName("utf-8"));

                      if (result.statusCode == 200) {
                        _showDialog('Usuário criado. Aguarde sua ativação');
                      } else {
                        _showDialog('Ocorreu um erro. Por favor tente mais tarde.');
                      }
                    },
                  ),
                ].expand(
                      (widget) => [
                    widget,
                    const SizedBox(
                      height: 24,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeRoute(usuarioLogado: null)),
              )
            },
          ),
        ],
      ),
    );
  }
}
