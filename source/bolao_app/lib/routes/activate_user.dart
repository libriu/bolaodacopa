import 'package:bolao_app/repositories/apostador_repository.dart';
import 'package:bolao_app/routes/update_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/apostador.dart';
import '../models/usuario.dart';
import '../route_generator.dart';
import '../widgets/drawer.dart';

class ActivateUserRoute extends StatefulWidget {

  const ActivateUserRoute({
    Key? key
  }) : super(key: key);

  @override
  State<ActivateUserRoute> createState() => _ActivateUserRouteState();
}

class _ActivateUserRouteState extends State<ActivateUserRoute> {
  int numItems = 0;
  List<bool>? selected; //= List<bool>.generate(numItems, (int index) => false);
  List<Apostador>? apostadores;
  List<List<DataCell>>? cellList;
  //var cellList = <DataCell>[][];


  void getApostadores(Usuario usuarioLogado, Apostador apostador) async {
    String login = usuarioLogado.login!;
    String senha = usuarioLogado.senha!;
    List<Apostador> aps;
    try {
      aps = await ApostadorRepository().getUserToActivate(login, senha);
      var lls = <List<DataCell>>[];
      for (var a in aps) {
        List<DataCell> ls = <DataCell>[];
        DataCell c1 = DataCell(Text(a.login!));
        ls.add(c1);
        DataCell c2 = DataCell(Text(a.contato!));
        ls.add(c2);
        DataCell c3 = DataCell(IconButton(
          icon: const Icon(Icons.create_sharp),
          tooltip: 'Editar',
          onPressed: () {
            apostador.copy(a);
            setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context)
                  {
                    return const UpdateUserRoute();
                  });
            });
          },
        ));
        ls.add(c3);
        lls.add(ls);
      }
      setState(() {
        apostadores = aps;
        numItems = aps.length;
        selected = List<bool>.generate(numItems, (int index) => false);
        cellList = lls;
      });
    } catch (e) {
      _showDialog('$e');
      return;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bolão da Copa 2022"),
      ),
      drawer: const BolaoDrawer(),
      body: SizedBox(
            width: double.infinity,
            child:
              Consumer2<Usuario,Apostador>(
              builder: (context, cache, apostador, _) {
                if (apostadores == null) getApostadores(cache, apostador);
                return
                  Column(
                    children: <Widget>[
                      Expanded (child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text('Apostador'),
                        ),
                        DataColumn(
                          label: Text('Contato'),
                        ),
                        DataColumn(
                          label: Text(''),
                        ),
                      ],
                      rows:
                        List<DataRow>.generate(
                            numItems,
                                (int index) => DataRow(
                              color: MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                    // All rows will have the same selected color.
                                    if (states.contains(MaterialState.selected)) {
                                      return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                                    }
                                    // Even rows will have a grey color.
                                    if (index.isEven) {
                                      return Colors.grey.withOpacity(0.3);
                                    }
                                    return null; // Use default value for other states and odd rows.
                                  }),
                              cells: cellList![index], //<DataCell>[DataCell(Text('Row $index'))],
                              selected: selected![index],
                              onSelectChanged: (bool? value) {
                                setState(() {
                                  selected![index] = value!;
                                });
                              },
                            ),
                          )
                      )),
                      ElevatedButton(
                      onPressed: () {
                        _activate(cache, apostador);
                      },
                      child: const Text('Ativar usuários'),
                      )
                ]
                );
              }),
          )
      );
  }

  void _activate(Usuario usuarioLogado, Apostador apostador) async {
    List<Apostador> apsToActivate = <Apostador>[];
    for (int i = 0; i < selected!.length; i++) {
      if (selected![i]) {
        apsToActivate.add(apostadores![i]);
      }
    }

    String login = usuarioLogado.login!;
    String senha = usuarioLogado.senha!;
    try {
      await ApostadorRepository.activate(login, senha, apsToActivate);
      _showDialog('Usuário(s) atualizado(s) com sucesso.');
    } catch (e) {
      _showDialog('$e');
    }
  }

  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) =>
          AlertDialog(
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