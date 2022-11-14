import 'package:flutter/material.dart';

import 'aposta.dart';

class GameBetsList with ChangeNotifier {
  late final List<Aposta> _fullBets;
  List<Aposta> filteredBets = <Aposta>[];

  GameBetsList(List<Aposta> fullBets) {
    _fullBets = fullBets;
    filteredBets = fullBets;
  }
  filter(String texto) {
    filteredBets = _fullBets.where((a) => a.apostador!.login!.toLowerCase().contains(texto.toLowerCase())).toList();
    notifyListeners();
  }
}