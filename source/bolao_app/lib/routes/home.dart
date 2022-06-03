import 'package:bolao_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bolão da Copa 2022"),
      ),
      drawer: const BolaoDrawer(),
      body: const Text("Home do Bolão da Copa 2022"),
    );
  }
}