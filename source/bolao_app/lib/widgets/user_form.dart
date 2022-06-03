import 'package:bolao_app/models/usuario.dart';
import 'package:bolao_app/repositories/apostador_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/apostador.dart';
import '../route_generator.dart';

class UserForm extends StatefulWidget {

  const UserForm({
    Key? key
  }) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Consumer2<Usuario, Apostador>(
              builder: (context, cache, apostador, _) {
                return Column(
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
                        initialValue: apostador.login,
                        onChanged: (value) {
                          apostador.login = value;
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
                        initialValue: apostador.contato,
                        onChanged: (value) {
                          apostador.contato = value;
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
                        initialValue: apostador.email,
                        onChanged: (value) {
                          apostador.email = value;
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
                        initialValue: apostador.celular,
                        onChanged: (value) {
                          apostador.celular = value;
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
                        initialValue: apostador.cidade,
                        onChanged: (value) {
                          apostador.cidade = value;
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
                                String login = cache.login!;
                                String senha = cache.senha!;
                                try{
                                  await ApostadorRepository.update(login, senha, apostador);
                                  _showDialog('Usuário atualizado com sucesso.');
                                  //Navigator.pop(context);
                                  //Navigator.pushNamed(context, RouteGenerator.activateUserRoute);
                                } catch (e) {
                                _showDialog('$e');
                                }
                              },
                            )
                    ].expand(
                          (widget) => [
                        widget,
                        const SizedBox(
                          height: 24,
                        )
                      ],
                    )
                  ],
                );
              }
          )
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
              onPressed: () => Navigator.pushNamed(context, RouteGenerator.activateUserRoute)
          ),
        ],
      ),
    );
  }
}
