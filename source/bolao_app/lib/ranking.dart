import 'package:flutter/material.dart';

import 'models/apostador.dart';

class RankingRoute extends StatefulWidget {

  const RankingRoute({
    Key? key, this.usuarioLogado
  }) : super(key: key);

  final Apostador? usuarioLogado;
  @override
  State<RankingRoute> createState() => _RankingRouteState();
}

class _RankingRouteState extends State<RankingRoute> {

  @override
  Widget build(BuildContext context) {
    return const Text("ranking");
  }
}