import 'package:flutter/material.dart';

import '../models/jogo.dart';
import '../repositories/game_repository.dart';

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
            // Row(children: [
            //   Expanded(child: Column(children: [
            //     Image.network("https://10.0.2.2:44357/country/flag?codPais=1"),
            //     const Text("Pais 1")
            //   ])),
            //   Expanded(child: Column(children: const [
            //     Text("OITAVAS"),
            //     Text("X")
            //   ])),
            //   Expanded(child: Column(children: [
            //     Image.network("https://10.0.2.2:44357/country/flag?codPais=2"),
            //     const Text("Pais 2")
            //   ])),
            // ],),
            Row(children: [
              Expanded(child:
              Image.network(GameRepository.getUrlFlag(game.codPaisA)),
              ),
              Expanded(child:
              Center(child: Text(game.grupo)),
              ),
              Expanded(child:
              Image.network(GameRepository.getUrlFlag(game.codPaisB)),
              ),
            ],),
            Row(children: [
              Expanded(child:
              Center(child: Text(game.paisA.nome))
              ),
              const Expanded(child:
              Center(child: Text("X"))
              ),
              Expanded(child:
              Center(child: Text(game.paisB.nome))
              ),
            ],)
          ],)
      ),
    );
  }
}
