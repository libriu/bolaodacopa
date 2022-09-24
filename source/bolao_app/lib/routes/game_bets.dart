import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/aposta.dart';
import '../models/jogo.dart';
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

  late final Future<Jogo?> game;
  late final DateTime gameDate;
  late Future<List<Aposta>> list;

  @override
  void initState() {
    super.initState();
    var jogo = context.read<Jogo>();
    if (jogo.codJogo != null) {
      game = Future.value(jogo);
    } else {
      game = GameRepository.getWithBetAllowed();
    }
    game.then((value) {
      gameDate = DateTime.parse(value!.dataHora!);

      try {
        list = BetRepository.getAllByGame(value.codJogo!);
      } catch (e) {
        list = Future.value([]);
        _showDialog('$e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 2),
                        child: SizedBox(width: 320,
                            child: Text("Apostas do Jogo", textAlign: TextAlign.center,
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
                      width: 400,
                      height: 170,
                      child: FutureBuilder<Jogo?>(
                        future: game,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            // Remember that 'snapshot.data' returns a nullable
                            final data = snapshot.data!;
                            return Column(children: [
                            const SizedBox(height: 10),
                            SizedBox(height: 20, child: Text("Jogo " + data.codJogo.toString() + " | " +
                              gameDate.day.toString().padLeft(2, "0") + "/" +
                              gameDate.month.toString().padLeft(2, "0") + "/" +
                              gameDate.year.toString() + " | " +
                              gameDate.hour.toString().padLeft(2, "0") + ":" +
                              gameDate.minute.toString().padLeft(2, "0"),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(height: 20, child: Text(data.grupo!, textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14))),
                            Row(children: [
                              Expanded(child:
                                SizedBox(height: 30, child: Image.network(GameRepository.getUrlFlag(data.codPaisA!)))
                              ),
                              Expanded(child:
                              data.jaOcorreu! == 1 ?
                                Text(data.rPlacarA.toString() + "   X   " + data.rPlacarB.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                                :
                                const Text("   X   ")
                              ),
                              Expanded(child:
                                SizedBox(height: 30, child: Image.network(GameRepository.getUrlFlag(data.codPaisB!))),
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
                            ],);
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                      }
                    ),
                  )
                ),
                SizedBox(child: FutureBuilder<List<Aposta>>(
                  future: list,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data ?? [];
                      return Column(children: const [
                        Text("")
                      ]);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                ))
                ],
        )
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




