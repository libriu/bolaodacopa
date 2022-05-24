import 'dart:convert';

import 'package:bolao_app/home.dart';
import 'package:bolao_app/update_user.dart';
import 'package:bolao_app/values/preference_keys.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'models/apostador.dart';

class ActivateUserRoute extends StatefulWidget {

  const ActivateUserRoute({
    Key? key, this.usuarioLogado
  }) : super(key: key);

  final Apostador? usuarioLogado;

  @override
  State<ActivateUserRoute> createState() => _ActivateUserRouteState();
}

class _ActivateUserRouteState extends State<ActivateUserRoute> {
  int numItems = 0;
  List<bool>? selected; //= List<bool>.generate(numItems, (int index) => false);
  List<Apostador>? apostadores;
  List<List<DataCell>>? cellList;
  //var cellList = <DataCell>[][];


  void getApostadores() async {
    String? login = widget.usuarioLogado?.login;
    String? senha = widget.usuarioLogado?.senha;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$senha'));

    final httpsUri = Uri(
        scheme: PreferenceKeys.httpScheme,
        host: PreferenceKeys.httpHost,
        port: PreferenceKeys.httpPort,
        path: 'user/toactivate');

    // Use a JSON encoded string to send
    var client = Client();
    var result = await client.get(
        httpsUri,
        headers: {'authorization': basicAuth, 'content-type': 'application/json'});

    if (result.statusCode == 200) {
      Iterable l = json.decode(result.body);
      List<Apostador> aps = List<Apostador>.from(l.map((model)=> Apostador.fromJson(model)));
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
            setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context)
                    {
                      return UpdateUserRoute(
                          usuarioLogado: widget.usuarioLogado,
                          user: a,
                          redirectPage: PageName.activateUser);
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
    }
    else {
      if (result.statusCode == 400) {
        Map<String, dynamic> j = json.decode(result.body);
        _showDialog(j['message']);
      }
      else {
        _showDialog("Ocorreu um erro, por favor, tente mais tarde");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getApostadores();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child:
      Column(
        children: <Widget>[
          DataTable(
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
              rows: List<DataRow>.generate(
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
          ),
          ElevatedButton(
            onPressed: () {
              _activate();
            },
            child: const Text('Ativar usuários'),
          ),
        ],
      )
    );
  }

  void _activate() async {
    List<Apostador> apsToActivate = <Apostador>[];
    for (int i = 0; i < selected!.length; i++) {
      if (selected![i]) {
        apsToActivate.add(apostadores![i]);
      }
    }

    String? login = widget.usuarioLogado?.login;
    String? senha = widget.usuarioLogado?.senha;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$senha'));

    final httpsUri = Uri(
        scheme: PreferenceKeys.httpScheme,
        host: PreferenceKeys.httpHost,
        port: PreferenceKeys.httpPort,
        path: 'user/activate');

    // Use a JSON encoded string to send
    var client = Client();
    var result = await client.post(
        httpsUri,
        body: json.encode(apsToActivate),
        headers: {'authorization': basicAuth, 'content-type': 'application/json'});//,

    if (result.statusCode == 200) {
      getApostadores();
    }
    else{
      if (result.statusCode == 400) {
        Map<String, dynamic> j = json.decode(result.body);
        _showDialog(j['message']);
      }
      else {
        _showDialog("Ocorreu um erro na ativação dos usuários, por favor, tente mais tarde");
      }
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
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
    );
  }
}