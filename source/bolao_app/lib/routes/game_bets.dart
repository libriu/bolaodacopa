import 'package:bolao_app/repositories/ranking_repository.dart';
import 'package:bolao_app/widgets/game_bets_filtered_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/aposta.dart';
import '../models/game_bets_list.dart';
import '../models/jogo.dart';
import '../models/ranking.dart';
import '../models/usuario.dart';
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
  Jogo? jogo;
  Future<Jogo?>? game;
  late final DateTime gameDate;
  int counter = 0;
  final controller = TextEditingController();
  //late final Future<Ranking?> myRanking;

  Future<void> getAllByGame(int codJogo) async {
    jogo!.apostas = await BetRepository.getAllByGame(codJogo);
    setState(() {
      game = Future.value(jogo);
    });

  }

  Future<void> getWithBetAllowed() async {
    jogo = await GameRepository.getWithBetAllowed();
    if (jogo == null || jogo!.codJogo == null) {
      setState(() {
        game = Future.value(Jogo());
      });
      return;
    }
    gameDate = DateTime.parse(jogo!.dataHora!);
    await getAllByGame(jogo!.codJogo!);
  }

  @override
  void initState() {
    super.initState();
    jogo = context.read<Jogo>();
    if (jogo!.codJogo != null) {
      gameDate = DateTime.parse(jogo!.dataHora!);
      getAllByGame(jogo!.codJogo!);
    } else {
      getWithBetAllowed();
    }
    // var user = context.read<Usuario>();
    // if (user.isLoggedOn) {
    //   myRanking = RankingRepository().getMyRanking(user.login!, user.senha!);
    //   myRanking.then((value) {
    //     var ranking = context.read<Ranking>();
    //     ranking.copy(value!);
    //   });
    // }
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
            final listaApostas = GameBetsList(data.apostas ?? []);
            return SingleChildScrollView(child: Column(
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
                      height: height * 0.18,
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
                Padding(padding: const EdgeInsets.all(5),
                    child: SizedBox(
                        height: height * 0.05,
                        width: width * 0.9,
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
                          onChanged: listaApostas.filter,
                        )
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
                SizedBox(height: height * 0.45, child: ChangeNotifierProvider(
                  create: (context) => listaApostas,
                  child: const GameBetsFilteredList()))
              ],
            ));
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




