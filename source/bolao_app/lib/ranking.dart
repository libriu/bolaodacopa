import 'dart:convert';
import 'package:bolao_app/values/preference_keys.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'models/apostador.dart';
import 'models/ranking.dart';

class RankingRoute extends StatefulWidget {

  const RankingRoute({
    Key? key, this.usuarioLogado
  }) : super(key: key);

  final Apostador? usuarioLogado;
  @override
  State<RankingRoute> createState() => _RankingRouteState();
}

class _RankingRouteState extends State<RankingRoute> {
  int numItems = 0;
  List<List<DataCell>>? cellList;

  void getRanking(int? codApostador) async {
    final httpsUri = Uri(
        scheme: PreferenceKeys.httpScheme,
        host: PreferenceKeys.httpHost,
        port: PreferenceKeys.httpPort,
        path: 'ranking');

    // Use a JSON encoded string to send
    var client = Client();
    var result = await client.get(
        httpsUri,
        headers: {'content-type': 'application/json'});

    if (result.statusCode == 200) {
      Iterable l = json.decode(result.body);
      List<Ranking> rnk = List<Ranking>.from(l.map((model)=> Ranking.fromJson(model)));
      var lls = <List<DataCell>>[];
      for (var r in rnk) {
        List<DataCell> ls = <DataCell>[];
        DataCell c1 = DataCell(Text(r.posicao!.toString()));
        ls.add(c1);
        DataCell c2 = DataCell(Text(r.apostador.login!));
        ls.add(c2);
        DataCell c3 = DataCell(Text(r.totalPontos!.toString()));
        ls.add(c3);
        DataCell c4 = DataCell(Text(r.totalAcertos!.toString()));
        ls.add(c4);
        lls.add(ls);
        if (codApostador == r.codApostador) {
          List<DataCell> lsEmpty = <DataCell>[];
          lsEmpty.add(const DataCell(Text("")));
          lsEmpty.add(const DataCell(Text("")));
          lsEmpty.add(const DataCell(Text("")));
          lsEmpty.add(const DataCell(Text("")));
          lls.insert(0, lsEmpty);
          lls.insert(0, ls);
        }
      }
      setState(() {
         numItems = lls.length;
         cellList = lls;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.usuarioLogado == null) {
      getRanking(0);
    }
    else {
      getRanking(widget.usuarioLogado?.codApostador!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('Posição'),
                  ),
                  DataColumn(
                    label: Text('Login'),
                  ),
                  DataColumn(
                    label: Text('Pontos'),
                  ),
                  DataColumn(
                    label: Text('Acertos'),
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
                  ),
                )
            ),
    );
  }
}