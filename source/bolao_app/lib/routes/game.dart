import 'package:bolao_app/routes/game_next.dart';
import 'package:flutter/material.dart';
import 'game_previous.dart';

class GameRoute extends StatefulWidget {
  const GameRoute({
    Key? key
  }) : super(key: key);

  @override
  State<GameRoute> createState() => _GameRouteState();
}

class _GameRouteState extends State<GameRoute> with SingleTickerProviderStateMixin{
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.blue,
            tabs: const [
              Tab(
                text: 'ANTERIORES',
              ),
              Tab(
                text: 'PRÓXIMOS',
              )
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              children: const [
                GamePreviousRoute(),
                GameNextRoute()
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}




