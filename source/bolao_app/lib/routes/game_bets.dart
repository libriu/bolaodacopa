import 'package:bolao_app/repositories/ranking_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/aposta.dart';
import '../models/jogo.dart';
import '../models/ranking.dart';
import '../repositories/bet_repository.dart';
import '../repositories/game_repository.dart';
import '../route_generator.dart';

class GameBetsRoute extends StatefulWidget {
  const GameBetsRoute({
    Key? key
  }) : super(key: key);

  @override
  State<GameBetsRoute> createState() => _GameBetsRouteState();
}

class _GameBetsRouteState extends State<GameBetsRoute> with SingleTickerProviderStateMixin{
  late Jogo jogo;
  Future<Jogo?>? game;
  late final DateTime gameDate;
  int counter = 0;

  Future<void> getAllByGame(int codJogo) async {
    jogo.apostas = await BetRepository.getAllByGame(codJogo);
    setState(() {
      game = Future.value(jogo);
    });

  }

  Future<void> getWithBetAllowed() async {
    var jogo = await GameRepository.getWithBetAllowed();
    if (jogo == null || jogo.codJogo == null) {
      setState(() {
        game = Future.value(null);
      });
      return;
    }
    gameDate = DateTime.parse(jogo.dataHora!);
    await getAllByGame(jogo.codJogo!);
  }

  @override
  void initState() {
    super.initState();
    jogo = context.read<Jogo>();
    if (jogo.codJogo != null) {
      gameDate = DateTime.parse(jogo.dataHora!);
      getAllByGame(jogo.codJogo!);
    } else {
      getWithBetAllowed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: FutureBuilder<Jogo?>(
          future: game,
          builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null || snapshot.data!.codJogo == null)
            {
              return const Center(child:Text("Não existem jogos com apostas visíveis a todos"));
            }
            final data = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 2),
                    child: SizedBox(width: width * 0.8,
                        child: const Text("Apostas do Jogo", textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
                ),
                Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: SizedBox(
                      width: width,
                      height: height * 0.20,
                      child: Column(children: [
                                SizedBox(height: height * 0.0125),
                                SizedBox(height: height * 0.0250, child: Text("Jogo " + data.codJogo.toString() + " | " +
                                    gameDate.day.toString().padLeft(2, "0") + "/" +
                                    gameDate.month.toString().padLeft(2, "0") + "/" +
                                    gameDate.year.toString() + " | " +
                                    gameDate.hour.toString().padLeft(2, "0") + ":" +
                                    gameDate.minute.toString().padLeft(2, "0"),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(height: height * 0.0250, child: Text(data.grupo!, textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 14))),
                                Row(children: [
                                  Expanded(child:
                                  SizedBox(height: height * 0.0750, child: Image.network(GameRepository.getUrlFlag(data.codPaisA!)))
                                  ),
                                  Expanded(child:
                                    data.jaOcorreu! == 1 ?
                                    Center(child:Text(data.rPlacarA.toString() + "   X   " + data.rPlacarB.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
                                    :
                                    const Center(child: Text("   X   "))
                                  ),
                                  Expanded(child:
                                  SizedBox(height: height * 0.0750, child: Image.network(GameRepository.getUrlFlag(data.codPaisB!))),
                                  ),
                                ],),
                                Row(children: [
                                  Expanded(child:
                                  Center(child: Text(data.paisA!.nome))
                                  ),
                                  const Expanded(child: Text("")),
                                  Expanded(child:
                                  Center(child: Text(data.paisB!.nome))
                                  ),
                                ],),
                              ],)
                    )
                ),
                Row(
                  children: [
                    SizedBox(width: width * 0.13, child: const Icon(
                        Icons.flag,
                        color: Colors.black,
                        size: 22.0
                    )),
                    SizedBox(width: width * 0.52, child: const Text("Participante", textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                    SizedBox(width: width * 0.15, child: const Text("Placar", textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                    SizedBox(width: width * 0.11, child: const Text("Pts", textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                  ],),
                SizedBox(height: height * 0.5, child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    //shrinkWrap:true,
                    itemCount: data.apostas!.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        counter = 1;
                      }
                      else {
                        if (data.apostas![index].pontos != data.apostas![index-1].pontos) {
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
                                  child: Text(data.apostas![index].apostador!.login.toString(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  onTap: () {
                                    var ranking = context.read<Ranking>();
                                    var rnk = RankingRepository().getRankingByBetter(data.apostas![index].codApostador);
                                    rnk.then((value) {
                                      ranking.copy(value!);
                                      Navigator.push(context, RouteGenerator.generateRoute(const RouteSettings(
                                          name: RouteGenerator.homeGamePrevRoute
                                      )));
                                    });
                                  }
                              )),
                              SizedBox(width: width * 0.15, child:
                              Text(data.apostas![index].placarA.toString() + " X " + data.apostas![index].placarB.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                              ),
                              SizedBox(width: width * 0.11, child:
                              Text(data.apostas![index].pontos.toString(),
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                              ),
                            ],)
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Text("",
                        style: TextStyle(fontSize: 1))
                  //separatorBuilder: (BuildContext context, int index) => const Divider(),
                ))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        })
    );
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
                  onPressed: () => Navigator.pushNamed(context, RouteGenerator.gameBetsRoute)
              ),
            ],
          ),
    );
  }
}




