import 'package:bolao_app/routes/ranking.dart';
import 'package:bolao_app/routes/regra.dart';
import 'package:bolao_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ranking.dart';
import '../models/usuario.dart';
import '../route_generator.dart';
import 'game.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({ Key? key, required this.initialTab, required this.initialGameTab }) : super(key: key);
  final int initialTab;
  final int initialGameTab;
  @override
  Widget build(BuildContext context) {
    var ranking = context.read<Ranking>();
    return DefaultTabController(
        initialIndex: initialTab,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Bolão da Copa 2022"),
          ),
          bottomNavigationBar: Container(
            color: const Color(0xFF1F4E79),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.all(5.0),
              indicatorColor: Colors.white,
              tabs: const [
                Tab(
                  text: "Ranking",
                  icon: Icon(Icons.bar_chart),
                ),
                Tab(
                  text: "Jogos",
                  icon: Icon(Icons.sports_soccer),
                ),
                Tab(
                  text: "Regras",
                  icon: Icon(Icons.message_outlined),
                )
              ],
              onTap: (index) {
                var usuarioLogado = context.read<Usuario>();
                var ranking = context.read<Ranking>();
                if (index == 1)  {
                  if (usuarioLogado.isLoggedOn) {
                    ranking.codApostador = usuarioLogado.codApostador;
                  }
                  else {
                    ranking.codApostador = null;
                  }
                  Navigator.push(context, RouteGenerator.generateRoute(const RouteSettings(
                    name: RouteGenerator.homeGameNextRoute
                    )));
                }
              } ,
            ),
          ),
          drawer: const BolaoDrawer(),
          body: TabBarView(
          children: <Widget>[
            const RankingRoute(),
            GameRoute(initialTab: initialGameTab),
            const RegraRoute(),
          ],
        ),
      ),
    );
  }
}