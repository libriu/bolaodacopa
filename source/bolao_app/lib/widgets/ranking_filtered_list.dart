import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ranking.dart';
import '../route_generator.dart';
import '../models/ranking_list.dart';
//import 'package:url_launcher/url_launcher.dart';

class RankingFilteredList extends StatelessWidget {
  const RankingFilteredList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lista = Provider.of<RankingList>(context);

    return Expanded(
        child: Consumer<Ranking>(
          builder: (context, ranking, _) {
            return ListView.separated(
                padding: const EdgeInsets.all(8),
                //shrinkWrap:true,
                itemCount: lista.filteredRanking.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: index % 2 == 0 ? const Color.fromRGBO(242, 242, 242, 1): Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 70, child:
                          Text(lista.filteredRanking[index].posicao.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                          ),
                          SizedBox(width: 220, child: InkWell(child:
                          Text(lista.filteredRanking[index].apostador!.login.toString(),
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              onTap: () {
                                ranking.copy(lista.filteredRanking[index]);
                                Navigator.push(context, RouteGenerator.generateRoute(const RouteSettings(
                                    name: RouteGenerator.homeGamePrevRoute
                                )));
                              }
                          )),
                          SizedBox(width: 70, child:
                          Text(lista.filteredRanking[index].totalPontos.toString(),
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
        )
    );
  }
}