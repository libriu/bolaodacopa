import 'package:bolao_app/models/apostador.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../repositories/apostador_repository.dart';
import '../route_generator.dart';
import '../widgets/drawer.dart';

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  'Login': instance.login,
  'Contato': instance.contato,
  'Email': instance.email,
  'Senha': instance.senha,
  'Celular': instance.celular,
  'Cidade': instance.cidade,
};

@JsonSerializable()
class UserData {
  String? login;
  String? contato;
  String? email;
  String? senha;
  String? repetirSenha;
  String? celular;
  String? cidade;

  UserData({
    this.login,
    this.contato,
    this.email,
    this.senha,
    this.repetirSenha,
    this.celular,
    this.cidade,
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
      drawer: const BolaoDrawer(),
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
                      userData.login = value;
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
                      userData.contato = value;
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
                      userData.email = value;
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
                      userData.senha = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Senha é obrigatório.';
                      }
                      if (userData.repetirSenha == userData.senha) {
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
                      userData.repetirSenha = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Repetir Senha é obrigatório.';
                      }
                      if (userData.repetirSenha == userData.senha) {
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
                      userData.celular = value;
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
                      userData.cidade = value;
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

                      try{
                        Apostador apostador = Apostador();
                        apostador.login = userData.login;
                        apostador.contato = userData.contato;
                        apostador.email = userData.email;
                        apostador.senha = userData.senha;
                        apostador.celular = userData.celular;
                        apostador.cidade = userData.cidade;
                        await ApostadorRepository.create(apostador);
                        _showDialog('Usuário criado. Aguarde sua ativação');
                      } catch (e) {
                        _showDialog('$e');
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
            onPressed: () => Navigator.pushNamed(context, RouteGenerator.homeRoute)
          ),
        ],
      ),
    );
  }
}
