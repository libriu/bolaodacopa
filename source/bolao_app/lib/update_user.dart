import 'dart:convert';
import 'package:bolao_app/values/preference_keys.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'home.dart';
import 'models/apostador.dart';

class UpdateUserRoute extends StatefulWidget {

  const UpdateUserRoute({
    Key? key, this.usuarioLogado, required this.user, required this.redirectPage
  }) : super(key: key);

  final Apostador? usuarioLogado;
  final Apostador user;
  final PageName redirectPage;

  @override
  State<UpdateUserRoute> createState() => _UpdateUserRouteState(user: user);
}

class _UpdateUserRouteState extends State<UpdateUserRoute> {

  final _formKey = GlobalKey<FormState>();
  Apostador? user;

  _UpdateUserRouteState({this.user});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
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
                        initialValue: user?.login,
                        onChanged: (value) {
                          user?.login = value;
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
                        initialValue: user?.contato,
                        onChanged: (value) {
                          user?.contato = value;
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
                        initialValue: user?.email,
                        onChanged: (value) {
                          user?.email = value;
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
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: 'Telefone Celular',
                          labelText: 'Telefone Celular',
                        ),
                        initialValue: user?.celular,
                        onChanged: (value) {
                          user?.celular = value;
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
                        initialValue: user?.cidade,
                        onChanged: (value) {
                          user?.cidade = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Cidade é obrigatório.';
                          }
                          return null;
                        },
                      ),
                      TextButton(
                        child: const Text('Atualizar'),
                        onPressed: () async {

                          var valid = _formKey.currentState!.validate();
                          if (!valid) {
                            return;
                          }
                          String? login = widget.usuarioLogado?.login;
                          String? senha = widget.usuarioLogado?.senha;
                          String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$senha'));

                          final httpsUri = Uri(
                              scheme: PreferenceKeys.httpScheme,
                              host: PreferenceKeys.httpHost,
                              port: PreferenceKeys.httpPort,
                              path: 'user/update');

                          // Use a JSON encoded string to send
                          var client = Client();
                          var result = await client.post(
                              httpsUri,
                              body: json.encode(user!.toJson()),
                              headers: {'authorization': basicAuth, 'content-type': 'application/json'});

                          if (result.statusCode == 200) {
                            _showDialog('Usuário alterado com sucesso');
                            //Navigator.of(context).pop();
                          } else {
                            _showDialog('Ocorreu um erro. Por favor, tente mais tarde.');
                            //Navigator.of(context).pop();
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
          )
        ],
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
                MaterialPageRoute(builder: (context) => HomeRoute(
                    page: widget.redirectPage,
                    usuarioLogado: widget.usuarioLogado)),
              )
            },
          ),
        ],
      ),
    );
  }
}
