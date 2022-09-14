import 'package:bolao_app/models/usuario.dart';
import 'package:bolao_app/repositories/ranking_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ranking.dart';

class RankingOldRoute extends StatefulWidget {

  const RankingOldRoute({
    Key? key
  }) : super(key: key);

  @override
  State<RankingOldRoute> createState() => _RankingOldRouteState();
}

class _RankingOldRouteState extends State<RankingOldRoute> {
  late final Future<Ranking?> myRanking;
  late final Future<List<List<DataCell>>> cellList;

  Future<List<List<DataCell>>> getRanking() async {
    var rnk = await RankingRepository().getRanking();
    var lls = <List<DataCell>>[];
    for (Ranking r in rnk) {
      List<DataCell> ls = <DataCell>[];
      DataCell c1 = DataCell(Text(r.posicao.toString()));
      ls.add(c1);
      DataCell c2 = DataCell(Text(r.apostador!.login!));
      ls.add(c2);
      DataCell c3 = DataCell(Text(r.totalPontos.toString()));
      ls.add(c3);
      DataCell c4 = DataCell(Text(r.totalAcertos.toString()));
      ls.add(c4);
      lls.add(ls);
    }
    return lls;
  }

  @override
  void initState() {
    super.initState();
    cellList = getRanking();
    var user = context.read<Usuario>();
    if (user.isLoggedOn) {
      myRanking = RankingRepository().getMyRanking(user.login!, user.senha!);
    }
    else {
      myRanking = Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Ranking"),
      // ),
      // drawer: const BolaoDrawer(),
        body: SizedBox(
            width: double.infinity,
            child: Column(children: [
              FutureBuilder<Ranking?>(
                future: myRanking,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // Remember that 'snapshot.data' returns a nullable
                    final data = snapshot.data?.posicao.toString() ?? "";
                    return Center(child: Text("Sua posição é: $data"),);
                  }
                  // if (snapshot.hasError) {
                  //   return const ErrorWidget();
                  // }
                  return const Text("");
                },
              ),
              FutureBuilder<List<List<DataCell>>>(
                future: cellList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // Remember that 'snapshot.data' returns a nullable
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
                          snapshot.data!.length,
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
                            cells: snapshot.data![index], //<DataCell>[DataCell(Text('Row $index'))],
                          ),
                        )
                    );
                  }
                  // if (snapshot.hasError) {
                  //   return const ErrorWidget();
                  // }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ])
        )
    );
  }
}