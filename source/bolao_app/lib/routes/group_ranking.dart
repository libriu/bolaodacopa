import 'package:bolao_app/models/usuario.dart';
import 'package:bolao_app/repositories/ranking_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/grupo.dart';
import '../models/ranking.dart';
import '../repositories/group_repository.dart';
import '../widgets/drawer.dart';


class GroupRankingRoute extends StatefulWidget {

  const GroupRankingRoute({
    Key? key
  }) : super(key: key);

  @override
  State<GroupRankingRoute> createState() => _GroupRankingRouteState();
}

class _GroupRankingRouteState extends State<GroupRankingRoute> {
  late final Future<List<Grupo>> grupos;
  String? selectedItem;
  List<Ranking> lista = [];

  Future<List<Ranking>> getRanking(int codGrupo) async {
    return await RankingRepository().getByGroup(codGrupo);
  }

  @override
  void initState() {
    super.initState();
    //list = new List<Ranking>() as Future<List<Ranking>>;
    var user = context.read<Usuario>();
    if (user.isLoggedOn) {
      grupos = GroupRepository().getWithMe(user.login!, user.senha!);
    }
    else {
      grupos = GroupRepository().getAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ranking de Grupos"),
      ),
      drawer: const BolaoDrawer(),
        body:
          Column(children: [
              const Padding(padding: EdgeInsets.all(10), child:
                Center(child: Text("Ranking de Grupos", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
              FutureBuilder<List<Grupo>>(
                future: grupos,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // Remember that 'snapshot.data' returns a nullable
                    final ddlist = snapshot.data ?? [];
                    return DropdownButton<String>(
                      value: selectedItem,
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        getRanking(int.parse(value!)).then((rnk) {
                          selectedItem = value;
                          setState(() {
                            lista = rnk;
                          });
                        });
                      },
                      items: ddlist.map<DropdownMenuItem<String>>((Grupo value) {
                        return DropdownMenuItem<String>(
                          value: value.codGrupo.toString(),
                          child: Text(value.nome),
                        );
                      }).toList(),
                    );

                  }
                  return const Text("");
                },
              ),
              const Divider(height: 30, thickness: 4),
              Row(
                children: const [
                  SizedBox(width: 70, child: Icon(
                      Icons.flag,
                      color: Colors.black,
                      size: 22.0
                  )),
                  SizedBox(width: 220, child: Text("Participante", textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                  SizedBox(width: 70, child: Text("Pontos", textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                ],),
              ListView.separated(
                  padding: const EdgeInsets.all(8),
                  shrinkWrap:true,
                  itemCount: lista.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: index % 2 == 0 ? const Color.fromRGBO(242, 242, 242, 1): Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 70, child:
                            Text(lista[index].posicao.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                            ),
                            SizedBox(width: 220, child: InkWell(
                                child: Text(lista[index].apostador!.login.toString(),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            )),
                            SizedBox(width: 70, child:
                            Text(lista[index].totalPontos.toString(),
                                textAlign: TextAlign.right,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
                            ),
                          ],)
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Text("",
                      style: TextStyle(fontSize: 1))
              )
            ])
    );
  }
}