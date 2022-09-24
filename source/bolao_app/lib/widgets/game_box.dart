import 'package:bolao_app/models/aposta.dart';
import 'package:bolao_app/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/jogo.dart';
import '../models/ranking.dart';
import '../models/usuario.dart';
import '../repositories/game_repository.dart';

class GameBox extends StatefulWidget {
  const GameBox({ Key? key, required this.jogo, required this.changeBetCallback }) : super(key: key);
  final Function(Aposta) changeBetCallback;
  final Jogo jogo;

  @override
  State<GameBox> createState() => GameBoxState();
}

class GameBoxState extends State<GameBox> {

  late Jogo game;
  late final DateTime gameDate;
  late final Usuario usuarioLogado;
  late final Ranking ranking;
  late Aposta aposta;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    usuarioLogado = context.read<Usuario>();
    ranking = context.read<Ranking>();
    game = Jogo(codJogo: widget.jogo.codJogo,
        grupo: widget.jogo.grupo,
        dataHora: widget.jogo.dataHora,
        jaOcorreu: widget.jogo.jaOcorreu,
        rPlacarA: widget.jogo.rPlacarA,
        rPlacarB: widget.jogo.rPlacarB,
        codPaisA: widget.jogo.codPaisA,
        codPaisB: widget.jogo.codPaisB,
        paisA: widget.jogo.paisA,
        paisB: widget.jogo.paisB,
        isBetVisibleToOthers: widget.jogo.isBetVisibleToOthers,
        apostas: widget.jogo.apostas);
    gameDate = DateTime.parse(game.dataHora!);
    if (usuarioLogado.isLoggedOn && usuarioLogado.codApostador == ranking.codApostador && !game.isBetVisibleToOthers!) {
      if (game.apostas != null && game.apostas!.isNotEmpty) {
        aposta = game.apostas![0];
        _controller1.text = aposta.placarA.toString();
        _controller2.text = aposta.placarB.toString();
      }
      else {
        aposta = Aposta(codApostador: usuarioLogado.codApostador!,
            codJogo: game.codJogo!,
            placarA: 0,
            placarB: 0,
            pontos: 0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  var jogo = context.read<Jogo>();
                  jogo.copy(game);
                  Navigator.pushNamed(context, RouteGenerator.gameBetsRoute);
                }
            )),
            SizedBox(height: 20, child: Text(game.grupo!, textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14))),
            Row(children: [
              Expanded(child:
                SizedBox(height: 60, child: Image.network(GameRepository.getUrlFlag(game.codPaisA!)))
              ),
              Expanded(child:
              (game.isBetVisibleToOthers! ?
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max, children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: [
                  //IconButton(icon: const Icon(Icons.arrow_drop_up), iconSize: 30, onPressed: addNumber),
                  InkWell(child: const Icon(Icons.arrow_drop_up, size: 36.0),
                      onTap: () {
                        addNumberA(_controller1);
                      } ),
                  SizedBox(height: 30, width: 45, child:
                    // TextField(
                    //   onChanged: (value) {
                    //     aposta.placarA = int.parse(value);
                    //   },
                    //   decoration: const InputDecoration(
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           width: 1), //<-- SEE HERE
                    //     )))
                    TextFormField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          //contentPadding: const EdgeInsets.all(8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1.0),
                          ),
                        ),
                        controller: _controller1,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                          signed: false,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onTap: () => _controller1.selection = TextSelection(baseOffset: 0, extentOffset: _controller1.value.text.length),
                        onChanged: (value) {
                          aposta.placarA = int.parse(value);
                          widget.changeBetCallback(aposta);
                        },
                      )
                  ),
                  InkWell(child: const Icon(Icons.arrow_drop_down, size: 36.0),
                      onTap: () {
                        decNumberA(_controller1);
                      } )
                  //IconButton(icon: const Icon(Icons.arrow_drop_down), iconSize: 30, onPressed: addNumber),
                ]),
                const Text("X"),
                Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: [
                  //IconButton(icon: const Icon(Icons.arrow_drop_up), iconSize: 30, onPressed: addNumber),
                  InkWell(child: const Icon(Icons.arrow_drop_up, size: 36.0),
                      onTap: () {
                        addNumberB(_controller2);
                        } ),
                  SizedBox(height: 30, width: 45, child:
                    // TextField(decoration: InputDecoration(
                    //   enabledBorder: OutlineInputBorder(
                    //     borderSide: BorderSide(
                    //         width: 1), //<-- SEE HERE
                    //   )))
                    TextFormField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        //contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                      ),
                      controller: _controller2,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                        signed: false,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onTap: () => _controller2.selection = TextSelection(baseOffset: 0, extentOffset: _controller2.value.text.length),
                      onChanged: (value) {
                        aposta.placarB = int.parse(value);
                        widget.changeBetCallback(aposta);
                      },
                    )
                  ),
                  InkWell(child: const Icon(Icons.arrow_drop_down, size: 36.0),
                      onTap: () {
                        decNumberB(_controller2);
                      } )
                  //IconButton(icon: const Icon(Icons.arrow_drop_down), iconSize: 30, onPressed: addNumber),
                ]),
              ],)


              ))
              ),
              Expanded(child:
              SizedBox(height: 60, child: Image.network(GameRepository.getUrlFlag(game.codPaisB!))),
              ),
            ],),

            Row(children: [
              Expanded(child:
              Center(child: Text(game.paisA!.nome))
              ),
              const Expanded(child: Text("")
                //game.jaOcorreu == 0 ? const Center(child: Text("X")) : Center(child: Text(game.rPlacarA.toString() + ' X ' + game.rPlacarB.toString())),
              ),
              Expanded(child:
              Center(child: Text(game.paisB!.nome))
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
                  (game.isBetVisibleToOthers! && game.apostas != null && game.apostas!.isNotEmpty) ?
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

  void addNumberA(TextEditingController c) {
    int x = int.tryParse(c.text) ?? 0;
    x++;
    aposta.placarA = x;
    c.text = x.toString();
    widget.changeBetCallback(aposta);
  }
  void addNumberB(TextEditingController c) {
    int x = int.tryParse(c.text) ?? 0;
    x++;
    aposta.placarB = x;
    c.text = x.toString();
    widget.changeBetCallback(aposta);
  }
  void decNumberA(TextEditingController c) {
    int x = int.tryParse(c.text) ?? 0;
    if (x > 0 ) x--;
    aposta.placarA = x;
    c.text = x.toString();
    widget.changeBetCallback(aposta);
  }
  void decNumberB(TextEditingController c) {
    int x = int.tryParse(c.text) ?? 0;
    if (x > 0 ) x--;
    aposta.placarB = x;
    c.text = x.toString();
    widget.changeBetCallback(aposta);
  }
}
