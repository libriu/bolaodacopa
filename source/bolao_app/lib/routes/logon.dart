import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../route_generator.dart';
import '../repositories/user_repository.dart';
import '../models/usuario.dart';

class LogonRoute extends StatefulWidget {
  const LogonRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<LogonRoute> createState() => _LogonRouteState();
}

class _LogonRouteState extends State<LogonRoute> {
  Usuario user = Usuario();
  Usuario? usuarioLogado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Autenticação'),
      ),
      body: Form(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ...[
                  const Image(image: AssetImage('assets/images/2022.png'), height: 200,),
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Login/Nome Único',
                      labelText: 'Login/Nome Único',
                    ),
                    onChanged: (value) => setState(() => user.login = value),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Senha',
                    ),
                    obscureText: true,
                    onChanged: (value) => setState(() => user.senha = value),
                  ),
                  Consumer<Usuario>(
                      builder: (context, cache, _) {
                        return TextButton(
                          child: const Text('Entrar'),
                          onPressed: () {
                            UserRepository.logon(user).then((Response resp) {
                              if (resp.statusCode == 200) {
                                UserRepository.getFromLocal().then((value) => cache.copy(value));
                                Navigator.pushNamed(context, RouteGenerator.homeRoute);
                              }
                              else {
                                if (resp.statusCode == 400) {
                                  Map<String, dynamic> j = json.decode(resp.body);
                                  _showDialog(j['message']);
                                }
                                else {
                                  _showDialog("Ocorreu um erro na autenticação, por favor, tente mais tarde");
                                }
                              }
                            });
                          },
                        );
                      }
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => const CreateUserRoute()),
                  //     );
                  //   },
                  //   child: const Text('Criar novo usuário'),
                  // ),
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
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
