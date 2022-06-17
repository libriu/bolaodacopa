import 'package:bolao_app/repositories/game_repository.dart';
import 'package:flutter/material.dart';
import '../models/jogo.dart';
import '../route_generator.dart';
import '../widgets/game_box.dart';

class GameNextRoute extends StatefulWidget {

  const GameNextRoute({
    Key? key
  }) : super(key: key);

  @override
  State<GameNextRoute> createState() => _GameNextRouteState();
}

class _GameNextRouteState extends State<GameNextRoute> {

  late final Future<List<Jogo>> games;

  @override
  void initState() {
    super.initState();
    games = GameRepository().getNextGames();
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
              return GameBox(game: data[index]);
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
