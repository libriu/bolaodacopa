import 'package:bolao_app/repositories/game_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/aposta.dart';
import '../models/jogo.dart';
import '../models/ranking.dart';
import '../models/usuario.dart';
import '../route_generator.dart';
import '../widgets/game_box.dart';

class GamePreviousRoute extends StatefulWidget {

  const GamePreviousRoute({
    Key? key
  }) : super(key: key);

  @override
  State<GamePreviousRoute> createState() => _GamePreviousRouteState();
}

class _GamePreviousRouteState extends State<GamePreviousRoute> {

  late final Future<List<Jogo>> games;

  @override
  void initState() {
    super.initState();
    var usuarioLogado = context.read<Usuario>();
    var ranking = context.read<Ranking>();
    games = GameRepository().getPreviousGames(ranking.codApostador);
  }


  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<List<Jogo>>(
      future: games,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Remember that 'snapshot.data' returns a nullable
          final data = snapshot.data ?? [];
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            //shrinkWrap:true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final itemKey = ValueKey<String>("jogo" + data[index].codJogo.toString());
              return GameBox(key: itemKey, jogo: data[index], changeBetCallback: doNothing);
              // return Container(
              //   height: 50,
              //   child: Center(child: Text('Entry ${entries[index]}')),
              // );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          );
        }
        // if (snapshot.hasError) {
        //   return const ErrorWidget();
        // }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void doNothing(Aposta a) {}

  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(message),
            actions: [
              TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pushNamed(context, RouteGenerator.homeRoute)
              ),
            ],
          ),
    );
  }
}
