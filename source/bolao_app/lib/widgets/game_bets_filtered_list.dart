import 'package:bolao_app/models/game_bets_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ranking.dart';
import '../repositories/ranking_repository.dart';
import '../route_generator.dart';
import '../models/ranking_list.dart';

class GameBetsFilteredList extends StatefulWidget {
  const GameBetsFilteredList({
    Key? key
  }) : super(key: key);

  @override
  State<GameBetsFilteredList> createState() => _GameBetsFilteredListState();
}

class _GameBetsFilteredListState extends State<GameBetsFilteredList> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    final listaApostas = Provider.of<GameBetsList>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView.separated(
        padding: const EdgeInsets.all(8),
        //shrinkWrap:true,
        itemCount: listaApostas.filteredBets.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            counter = 1;
          }
          else {
            if (listaApostas.filteredBets[index].pontos != listaApostas.filteredBets[index-1].pontos) {
              counter = index + 1;
            }
          }
          return Container(
              height: height * 0.05,
              decoration: BoxDecoration(
                color: index % 2 == 0 ? const Color.fromRGBO(242, 242, 242, 1): Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  SizedBox(width: width * 0.13, child:
                  Text(counter.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                  ),
                  SizedBox(width: width * 0.52, child: InkWell(
                      child: Text(listaApostas.filteredBets[index].apostador!.login.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      onTap: () {
                        var ranking = context.read<Ranking>();
                        var rnk = RankingRepository().getRankingByBetter(listaApostas.filteredBets[index].codApostador);
                        rnk.then((value) {
                          ranking.copy(value!);
                          Navigator.push(context, RouteGenerator.generateRoute(const RouteSettings(
                              name: RouteGenerator.homeGamePrevRoute
                          )));
                        });
                      }
                  )),
                  SizedBox(width: width * 0.15, child:
                  Text(listaApostas.filteredBets[index].placarA.toString() + " X " + listaApostas.filteredBets[index].placarB.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                  ),
                  SizedBox(width: width * 0.11, child:
                  Text(listaApostas.filteredBets[index].pontos.toString(),
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                  ),
                ],)
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Text("",
            style: TextStyle(fontSize: 1))
      //separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}