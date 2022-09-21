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
  //late Usuario usuarioLogado;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<Usuario,Ranking>(
        builder: (context, usuarioLogado, ranking, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(children: [
                const Padding(padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 2),
                    child: SizedBox(width: 320,
                    child: Text("Cartão de Apostas", textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
                ),
                IconButton(icon: const Icon(Icons.save),
                    color: usuarioLogado.codApostador == ranking.codApostador? Colors.black : Colors.grey,
                    onPressed: saveBets)
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
                        SizedBox(width: 70, height: 25, child: Text(ranking.posicao.toString(), textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18))),
                        SizedBox(width: 220, height: 25, child: Text(ranking.apostador!.login!, textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                        SizedBox(width: 70, height: 25, child: Text(ranking.totalPontos.toString(), textAlign: TextAlign.right,
                            style: const TextStyle(fontSize: 17))),
                      ],),
                    const SizedBox(width: 340, child: Divider(thickness: 2)),
                    Row(children: [
                      SizedBox(width: 360, height: 25, child: Text(ranking.apostador!.contato!, textAlign: TextAlign.center,
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
                  children: const [
                    GamePreviousRoute(),
                    GameNextRoute()
                  ],
                  controller: _tabController,
                ),
              ),
            ],
          );
        })
    );
  }

  void saveBets() {
  }
}




