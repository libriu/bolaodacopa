import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'auth.dart';
import 'create_user.dart';
import 'models/apostador.dart';

class LogonPage extends StatefulWidget {
  final Widget redirectPage;
  final Apostador? usuarioLogado;

  const LogonPage({
    required this.redirectPage,
    required this.usuarioLogado,
    Key? key,
  }) : super(key: key);

  @override
  State<LogonPage> createState() => _LogonPageState();
}

class _LogonPageState extends State<LogonPage> {
  //FormData formData = FormData();
  Apostador user = Apostador();
  // String? nome;
  // String? senha;

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
                  TextButton(
                    child: const Text('Sign in'),
                    onPressed: () {
                        Auth.authenticate(user).then((Response resp) {
                          if (resp.statusCode == 200) {
                              success(context);
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
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CreateUserRoute()),
                      );
                    },
                    child: const Text('Criar novo usuário'),
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

  void success(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? jsonUser = prefs.get(PreferenceKeys.activeUser)?.toString();
    // if (jsonUser != null) {
    //   Map<String, dynamic> mapUser = json.decode(jsonUser);
    //   Apostador user = Apostador.fromJson(mapUser);
    //   setState() {
    //
    //   }
    // }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget.redirectPage),
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
