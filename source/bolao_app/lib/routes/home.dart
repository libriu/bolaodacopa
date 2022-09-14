import 'package:bolao_app/routes/ranking.dart';
import 'package:bolao_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'game.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({ Key? key, required this.initialTab, required this.initialGameTab }) : super(key: key);
  final int initialTab;
  final int initialGameTab;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: initialTab,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Bolão da Copa 2022"),
          ),
          bottomNavigationBar: Container(
            color: const Color(0xFF1F4E79),
            child: const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  text: "Ranking",
                  icon: Icon(Icons.bar_chart),
                ),
                Tab(
                  text: "Jogos",
                  icon: Icon(Icons.sports_soccer),
                ),
                Tab(
                  text: "Mensagens",
                  icon: Icon(Icons.message_outlined),
                )
              ],
            ),
          ),
          drawer: const BolaoDrawer(),
          body: TabBarView(
          children: <Widget>[
            const RankingRoute(),
            GameRoute(initialTab: initialGameTab),
            const Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}