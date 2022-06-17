import 'package:bolao_app/routes/ranking.dart';
import 'package:bolao_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'game.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Bolão da Copa 2022"),
          ),
          bottomNavigationBar: Container(
            color: const Color(0xFF3F5AA6),
            child: const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Colors.blue,
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
          body: const TabBarView(
          children: <Widget>[
            RankingRoute(),
            GameRoute(),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}