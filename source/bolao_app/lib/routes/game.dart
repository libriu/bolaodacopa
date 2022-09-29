import 'package:bolao_app/models/usuario.dart';
import 'package:bolao_app/routes/game_next.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ranking.dart';
import 'game_previous.dart';

class GameRoute extends StatefulWidget {
  const GameRoute({
    Key? key, required this.initialTab
  }) : super(key: key);

  final int initialTab;
  @override
  State<GameRoute> createState() => _GameRouteState();
}

class _GameRouteState extends State<GameRoute> with SingleTickerProviderStateMixin{
  late final TabController _tabController;
  final GlobalKey<GameNextRouteState> _myKey = GlobalKey();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints sizes) {
          //final height = MediaQuery.of(context).size.height;
          //final width = MediaQuery.of(context).size.width;
          final width = sizes.maxWidth;
          //final height = sizes.maxHeight;
          return Consumer2<Usuario,Ranking>(
          builder: (context, usuarioLogado, ranking, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(children: [
                  Padding(padding: EdgeInsets.only(top: 10, left: width * 0.15, right: width * 0.025, bottom: 2),
                      child: SizedBox(width: width * 0.7, child: const Text("Cartão de Apostas", textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
                  ),
                  IconButton(icon: const Icon(Icons.save),
                      color: usuarioLogado.codApostador == ranking.codApostador? Colors.black : Colors.grey,
                      onPressed: () {
                        if (usuarioLogado.codApostador == ranking.codApostador) {
                          _myKey.currentState?.saveBets();
                        }
                      } )
                ]),

                Padding(padding: const EdgeInsets.all(10), child:
                  (ranking.codApostador != null) ?
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(138, 179, 207, 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: width * 0.175, height: 25, child: Text(ranking.posicao.toString(), textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 18))),
                          SizedBox(width: width * 0.55, height: 25, child: Text(ranking.apostador!.login!, textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                          SizedBox(width: width * 0.175, height: 25, child: Text(ranking.totalPontos.toString(), textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 17))),
                        ],),
                      SizedBox(width: width * 0.90, child: const Divider(thickness: 2)),
                      Row(children: [
                        SizedBox(width: width * 0.90, height: 25, child: Text(ranking.apostador!.contato!, textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18))),
                      ],)
                    ],)
                )
                :
                const Text("")
                ),

                SizedBox(height: 40, child: TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: const Color.fromRGBO(31, 78, 121, 1),
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
                )),
                Expanded(
                  child: TabBarView(
                    children: [
                      const GamePreviousRoute(),
                      GameNextRoute(key : _myKey)
                    ],
                    controller: _tabController,
                  ),
                ),
              ],
            );
          });
      })
    );
  }
}




