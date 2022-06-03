import 'package:bolao_app/models/usuario.dart';
import 'package:bolao_app/repositories/ranking_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ranking.dart';
import '../widgets/drawer.dart';

class RankingRoute extends StatefulWidget {

  const RankingRoute({
    Key? key
  }) : super(key: key);

  @override
  State<RankingRoute> createState() => _RankingRouteState();
}

class _RankingRouteState extends State<RankingRoute> {
  int numItems = 0;
  List<List<DataCell>>? cellList;

  void getRanking(int? codApostador) async {
      var rnk = await RankingRepository().getRanking(codApostador);
      var lls = <List<DataCell>>[];
      for (Ranking r in rnk) {
        List<DataCell> ls = <DataCell>[];
        DataCell c1 = DataCell(Text(r.posicao.toString()));
        ls.add(c1);
        DataCell c2 = DataCell(Text(r.apostador.login!));
        ls.add(c2);
        DataCell c3 = DataCell(Text(r.totalPontos.toString()));
        ls.add(c3);
        DataCell c4 = DataCell(Text(r.totalAcertos.toString()));
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ranking"),
      ),
      drawer: const BolaoDrawer(),
      body: SizedBox(
          width: double.infinity,
          child: Consumer<Usuario>(
              builder: (context, cache, _) {
                if (!cache.isLoggedOn) {
                  getRanking(0);
                }
                else {
                  getRanking(cache.codApostador!);
                }
                return DataTable(
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
                );
              }
          )
      )
    );
  }
}