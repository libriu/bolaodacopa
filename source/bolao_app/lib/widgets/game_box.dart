import 'package:flutter/material.dart';
import '../models/jogo.dart';
import '../repositories/game_repository.dart';
import 'bet_box.dart';

class GameBox extends StatelessWidget {
  const GameBox({ Key? key, required this.game }) : super(key: key);

  final Jogo game;

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
          height: 200,
          child: Column(children: [
            const SizedBox(height: 30),
            SizedBox(height: 30, child: Text(game.dataHora)),
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
              Center(child: Text(game.grupo)),
              ),
              Expanded(child:
              SizedBox(height: 60, child: Image.network(GameRepository.getUrlFlag(game.codPaisB))),
              ),
            ],),
            Row(children: [
              Expanded(child:
              Center(child: Text(game.paisA.nome))
              ),
              Expanded(child:
              game.jaOcorreu == 0 ? const Center(child: Text("X")) : Center(child: Text(game.rPlacarA.toString() + ' X ' + game.rPlacarB.toString())),
              ),
              Expanded(child:
              Center(child: Text(game.paisB.nome))
              ),
            ],),
            Expanded(child: SizedBox(height: 60, child: BetBox(codJogo: game.codJogo)))
          ],)
      ),
    );
  }
}
