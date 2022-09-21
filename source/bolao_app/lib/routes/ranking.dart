import 'package:bolao_app/models/ranking_list.dart';
import 'package:bolao_app/models/usuario.dart';
import 'package:bolao_app/repositories/ranking_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../models/apostador.dart';
import '../models/ranking.dart';
import '../route_generator.dart';
import '../widgets/ranking_filtered_list.dart';


class RankingRoute extends StatefulWidget {

  const RankingRoute({
    Key? key
  }) : super(key: key);

  @override
  State<RankingRoute> createState() => _RankingRouteState();
}

class _RankingRouteState extends State<RankingRoute> {
  late final Future<Ranking?> myRanking;
  late Future<List<Ranking>> list;
  late RankingList rankingList;
  final controller = TextEditingController();
  //Apostador? apostador;

  Future<List<Ranking>> getRanking() async {
    return await RankingRepository().getRanking();
  }

  @override
  void initState() {
    super.initState();
    list = getRanking();
    var user = context.read<Usuario>();
    //Apostador apostador = context.watch<Apostador>();
    if (user.isLoggedOn) {
      myRanking = RankingRepository().getMyRanking(user.login!, user.senha!);
      myRanking.then((value) {
        var ranking = context.read<Ranking>();
        ranking.copy(value!);
      });
    }
    else {
      myRanking = Future.value(null);
      var ranking = context.read<Ranking>();
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
            child: FutureBuilder<List<Ranking>>(
              future: list,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Remember that 'snapshot.data' returns a nullable
                  final data = snapshot.data ?? [];
                  rankingList = RankingList(data);
                  return Column(children: [
                    const Padding(padding: EdgeInsets.all(10), child: Text("Ranking", textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                    Padding(padding: const EdgeInsets.all(10),
                        child: SizedBox(
                            height: 45,
                            width: 370,
                            child: TextField(
                              style: const TextStyle(color: Colors.grey),
                              controller: controller,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(color: Colors.grey)
                                  )
                              ),
                              onChanged: rankingList.filter,
                            )
                        )
                    ),
                    FutureBuilder<Ranking?>(
                      future: myRanking,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // Remember that 'snapshot.data' returns a nullable
                          final pos = snapshot.data?.posicao.toString() ?? "";
                          final pts = snapshot.data?.totalPontos.toString() ?? "";
                          return Padding(padding: const EdgeInsets.all(10), child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(31, 78, 121, 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child:
                              InkWell(child: Row(
                                children: [
                                  SizedBox(width: 70, child: Text(pos, textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold))),
                                  const SizedBox(width: 220, child: Text("Você", textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold))),
                                  SizedBox(width: 70, child: Text(pts, textAlign: TextAlign.right,
                                      style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold))),
                                ],),
                                onTap: () {
                                  Navigator.push(context, RouteGenerator.generateRoute(const RouteSettings(
                                      name: RouteGenerator.homeGamePrevRoute
                                  )));
                                },
                              )
                          ));
                        }
                        // if (snapshot.hasError) {
                        //   return const ErrorWidget();
                        // }
                        return const Text("");
                      },
                    ),
                    //const Divider(height: 30, thickness: 4),
                    Row(
                      children: const [
                        SizedBox(width: 70, child: Icon(
                            Icons.flag,
                            color: Colors.black,
                            size: 22.0
                        )),
                        SizedBox(width: 220, child: Text("Participante", textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                        SizedBox(width: 70, child: Text("Pontos", textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                      ],),
                    ChangeNotifierProvider(
                        create: (context) => rankingList,
                        child: const RankingFilteredList())
                  ]);
                }
                // if (snapshot.hasError) {
                //   return const ErrorWidget();
                // }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
        )
    );
  }
}