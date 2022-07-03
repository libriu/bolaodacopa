import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/aposta.dart';
import '../models/usuario.dart';
import '../repositories/bet_repository.dart';

class BetBox extends StatefulWidget {

  const BetBox({
    Key? key, required this.codJogo
  }) : super(key: key);

  final int codJogo;

  @override
  State<BetBox> createState() => _BetBoxState();
}

class _BetBoxState extends State<BetBox> {

  late final Future<Aposta?> aposta;

  @override
  void initState() {
    super.initState();
    var user = context.read<Usuario>();
    if (user.isLoggedOn) {
      aposta = BetRepository().getByGame(user.login!, user.senha!, widget.codJogo);
    }
    else {
      aposta = Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<Aposta?>(
      future: aposta,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Remember that 'snapshot.data' returns a nullable
          final placarA = snapshot.data?.placarA.toString();
          final placarB = snapshot.data?.placarB.toString();
          if (snapshot.data != null) {
            return Center(child: Text("Sua aposta: $placarA x $placarB"));
          }
          return const Text("");
        }
        // if (snapshot.hasError) {
        //   return const ErrorWidget();
        // }
        return const Text("");
      },
    );
  }
}
