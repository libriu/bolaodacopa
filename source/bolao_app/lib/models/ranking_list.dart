import 'package:bolao_app/models/ranking.dart';
import 'package:flutter/material.dart';

class RankingList with ChangeNotifier {
  late final List<Ranking> _fullRanking;
  List<Ranking> filteredRanking = <Ranking>[];

  RankingList(List<Ranking> fullRanking) {
    _fullRanking = fullRanking;
    filteredRanking = fullRanking;
  }
  filter(String texto) {
    filteredRanking = _fullRanking.where((r) => r.apostador!.login!.toLowerCase().contains(texto.toLowerCase())).toList();
    notifyListeners();
  }
}