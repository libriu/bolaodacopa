import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/jogo.dart';
import '../models/ranking.dart';
import '../models/usuario.dart';
import '../repositories/game_repository.dart';

class GameBox extends StatelessWidget {
  const GameBox({ Key? key, required this.game }) : super(key: key);

  final Jogo game;

  @override
  Widget build(BuildContext context) {
    final gameDate = DateTime.parse(game.dataHora);
    final usuarioLogado = context.read<Usuario>();
    final ranking = context.read<Ranking>();
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: SizedBox(
          width: 400,
          height: 170,
          child: Column(children: [
            const SizedBox(height: 10),
            SizedBox(height: 20, child: InkWell(
                child: Text("Jogo " + game.codJogo.toString() + " | " +
                    gameDate.day.toString().padLeft(2, "0") + "/" +
                    gameDate.month.toString().padLeft(2, "0") + "/" +
                    gameDate.year.toString() + " | " +
                    gameDate.hour.toString().padLeft(2, "0") + ":" +
                    gameDate.minute.toString().padLeft(2, "0"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                onTap: () {
                  //ranking.copy(lista.filteredRanking[index]);
                  //Navigator.push(context, RouteGenerator.generateRoute(const RouteSettings(
                      //name: RouteGenerator.homeGamePrevRoute
                  //)));
                }
            )),
            SizedBox(height: 20, child: Text(game.grupo, textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14))),
            Row(children: [
              Expanded(child:
              SizedBox(height: 60, child: Image.network(GameRepository.getUrlFlag(game.codPaisA))),
              // SvgPicture.asset(
              //   "assets/images/flags/" + game.paisA.arquivo,
              //   height: 60,
              //   //width: 120,
              //   //placeholderBuilder: (_) =>
              //   //const CircularProgressIndicator(),
              // )
              ),
              Expanded(child:
              (game.isBetVisibleToOthers ?
              ((game.apostas != null && game.apostas!.isNotEmpty) ?
                  Column(children: [
                    Text(game.apostas![0].placarA.toString() + "   X   " + game.apostas![0].placarB.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text("Aposta")
                  ],)
                :
              Column(children: const [
                Text("X",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("")
              ]))
              :
              ((!usuarioLogado.isLoggedOn || usuarioLogado.codApostador != ranking.codApostador) ?
              Column(children: const [
                Text("X",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("")
              ],)
              :

              // Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center , children: [
              // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //   IconButton(alignment: Alignment.bottomCenter,icon: const Icon(Icons.arrow_drop_up), iconSize: 40, onPressed: addNumber),
              //   //const SizedBox(width: 10),
              //   //const Expanded(child: Text("")),
              //   //const Expanded(child: SizedBox()),
              //   IconButton(alignment: Alignment.bottomCenter,icon: const Icon(Icons.arrow_drop_up), iconSize: 40, onPressed: addNumber)
              //   ]),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:const [
              //     Expanded(child: SizedBox(height: 30, width: 30, child: Center(child: TextField(decoration: InputDecoration(
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             width: 1), //<-- SEE HERE
              //       ),
              //     ),)))),
              //     Expanded(child: SizedBox(height: 30, width: 30, child: Text("X",
              //         textAlign: TextAlign.center,
              //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
              //     Expanded(child: SizedBox(height: 30, width: 30, child: Center(child: TextField(decoration: InputDecoration(
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             width: 1), //<-- SEE HERE
              //       ),
              //     ),)))),
              //   ]),
              // SizedBox(height: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //   Center(child: IconButton(alignment: Alignment.center,icon: const Icon(Icons.arrow_drop_down), iconSize: 40, onPressed: addNumber)),
              //     const SizedBox(width: 10),
              //   //const Expanded(child: SizedBox()),
              //     Center(child: IconButton(alignment: Alignment.center,icon: const Icon(Icons.arrow_drop_down), iconSize: 40, onPressed: addNumber)),
              //   ])),
              // ],)

              // Row(children: const [
              //   NumberInputWithIncrementDecrement(),
              //   Text("X"),
              //   NumberInputWithIncrementDecrement()
              // ])

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max, children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: [
                  //IconButton(icon: const Icon(Icons.arrow_drop_up), iconSize: 30, onPressed: addNumber),
                  InkWell(child: const Icon(Icons.arrow_drop_up, size: 36.0), onTap: addNumber),
                  const SizedBox(height: 30, width: 30, child: Center(child:TextField(decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1), //<-- SEE HERE
                    ))))),
                  InkWell(child: const Icon(Icons.arrow_drop_down, size: 36.0), onTap: addNumber)
                  //IconButton(icon: const Icon(Icons.arrow_drop_down), iconSize: 30, onPressed: addNumber),
                ]),
                const Text("X"),
                Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: [
                  //IconButton(icon: const Icon(Icons.arrow_drop_up), iconSize: 30, onPressed: addNumber),
                  InkWell(child: const Icon(Icons.arrow_drop_up, size: 36.0), onTap: addNumber),
                  const SizedBox(height: 30, width: 30, child: Center(child:TextField(decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1), //<-- SEE HERE
                      ))))),
                  InkWell(child: const Icon(Icons.arrow_drop_down, size: 36.0), onTap: addNumber)
                  //IconButton(icon: const Icon(Icons.arrow_drop_down), iconSize: 30, onPressed: addNumber),
                ]),
              ],)


              ))
              ),
              Expanded(child:
              SizedBox(height: 60, child: Image.network(GameRepository.getUrlFlag(game.codPaisB))),
              ),
            ],),

            Row(children: [
              Expanded(child:
              Center(child: Text(game.paisA.nome))
              ),
              const Expanded(child: Text("")
                //game.jaOcorreu == 0 ? const Center(child: Text("X")) : Center(child: Text(game.rPlacarA.toString() + ' X ' + game.rPlacarB.toString())),
              ),
              Expanded(child:
              Center(child: Text(game.paisB.nome))
              ),
            ],),
            //Expanded(child: SizedBox(height: 60, child: BetBox(codJogo: game.codJogo))),
            Expanded(child:
              game.jaOcorreu == 0 ? const Center(child: Text("")) :
              Column(children: [
                const Divider(),
                Center(child: Row(children: [
                  const SizedBox(width: 20),
                  const Text("Placar do jogo: ", textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16)),
                  SizedBox(width: 180, child: Text(game.rPlacarA.toString() + ' X ' + game.rPlacarB.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                  (game.isBetVisibleToOthers && game.apostas != null && game.apostas!.isNotEmpty) ?
                    Text(game.apostas![0].pontos.toString() +  " pts.", textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo))
                    :
                    const Text("")
                ],))
              ],)
            ),
          ],)
      ),
    );
  }

  void addNumber() {
  }
}
