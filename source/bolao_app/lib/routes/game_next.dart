import 'package:bolao_app/repositories/game_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/aposta.dart';
import '../models/jogo.dart';
import '../models/ranking.dart';
import '../models/usuario.dart';
import '../repositories/bet_repository.dart';
import '../route_generator.dart';
import '../widgets/game_box.dart';

class GameNextRoute extends StatefulWidget {

  const GameNextRoute({
    Key? key
  }) : super(key: key);

  @override
  State<GameNextRoute> createState() => GameNextRouteState();
}

class GameNextRouteState extends State<GameNextRoute> {
  List<Aposta> apostasAlteradas = <Aposta>[];
  late final Future<List<Jogo>> games;
  late final Usuario usuarioLogado;
  @override
  void initState() {
    super.initState();
    usuarioLogado = context.read<Usuario>();
    var ranking = context.read<Ranking>();
    if (usuarioLogado.isLoggedOn) {
      games = GameRepository().getNextGames(
          usuarioLogado.login!, usuarioLogado.senha!, ranking.codApostador);
    }
    else {
      games = GameRepository().getNextGamesAnnonymous(ranking.codApostador);
    }
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
              //final itemKey = ValueKey<String>("jogo" + data[index].codJogo.toString());
              //GlobalKey<GameBoxState> itemKey = GlobalKey();
              return GameBox(jogo: data[index], changeBetCallback: betChanged,);
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

  void betChanged(Aposta aposta) {
    apostasAlteradas.removeWhere((element) => element.codJogo == aposta.codJogo);
    apostasAlteradas.add(aposta);
  }

  void saveBets() async {
    String login = usuarioLogado.login!;
    String senha = usuarioLogado.senha!;
    try {
      await BetRepository.register(login, senha, apostasAlteradas);
      _showDialog('Apostas gravadas com sucesso.');
    } catch (e) {
      _showDialog('$e');
    }
  }

  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.push(context, RouteGenerator.generateRoute(const RouteSettings(
                    name: RouteGenerator.homeGameNextRoute
                )));
              }
          ),
        ],
      ),
    );
  }
}
