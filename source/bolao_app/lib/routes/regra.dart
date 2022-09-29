

import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class Pontuacao {
  Pontuacao({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.aposta,
    required this.resultado,
    required this.pontos,
    this.isExpanded = false,
  });

  int id;
  String titulo;
  String descricao;
  bool isExpanded;
  String aposta;
  String resultado;
  int pontos;


  static List<Pontuacao> matriz() {


    Pontuacao ponto1 = Pontuacao(id: 1,pontos: 10,titulo: "Acertou o placar do jogo.",descricao:"O apostador acertou o placar em cheio.",aposta:'Aposta:       Time "A" 3 x 1 Time "B"',resultado:'Resultado:  Time "A" 3 x 1 Time "B"',isExpanded: false);
    Pontuacao ponto2 = Pontuacao(id: 2,pontos: 5,titulo: "Errou o placar do jogo, mas acertou quem venceu o jogo e o placar do vencedor.",descricao:"O apostador acertou quem venceu a partida, acertou o placar do vencedor, mas errou o placar do perdedor.",aposta:"Aposta:       Time A 3 x 1 Time B",resultado:"Resultado: Time A 3 x 2 Time B",isExpanded: true);
    Pontuacao ponto3 = Pontuacao(id: 3,pontos: 5,titulo: "Acertou que seria empate, mas errou o placar.",descricao:"O apostador acertou que o jogo seria empate, mas errou o placar exato.",aposta:"Aposta:       Time A 1 x 1 Time B",resultado:"Resultado:  Time A 2 x 2 Time B",isExpanded: true);
    Pontuacao ponto4 = Pontuacao(id: 4,pontos: 4,titulo: "Errou o placar, mas acertou quem venceu o jogo e o placar do perdedor.",descricao:"O apostador acertou quem venceu a partida, acertou o placar do perdedor, mas errou o placar do vencedor.",aposta:"Aposta:       Time A 3 x 1 Time B",resultado:"Resultado:  Time A 2 x 1 Time B",isExpanded: true);
    Pontuacao ponto5 = Pontuacao(id: 5,pontos: 3,titulo: "Acertou apenas quem venceu o jogo.",descricao:"O apostador acertou quem venceu a partida, mas não acertou o placar do vencedor nem do perdedor.",aposta:"Aposta:       Time A 2 x 1 Time B",resultado:"Resultado:  Time A 3 x 0 Time B",isExpanded: true);
    Pontuacao ponto6 = Pontuacao(id: 6,pontos: 1,titulo: "Placar invertido.",descricao:"Ninguém pode alegar que tem azar no Bolão da Copa! O apostadorfez uma aposta de placar invertido.",aposta:"Aposta:       Time A 2 x 1 Time B",resultado:"Resultado:  Time A 1 x 2 Time B",isExpanded: true);

    List<Pontuacao> placar = [ponto1, ponto2, ponto3, ponto4, ponto5, ponto6];

    return placar;

  }

}



class RegraRoute extends StatefulWidget {
  const RegraRoute({Key? key}) : super(key: key);

  @override
  State<RegraRoute> createState() => _RegraRouteState();
}

class _RegraRouteState extends State<RegraRoute> {
  final List<Pontuacao> _pontuacao = Pontuacao.matriz();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bolão da Copa 2022"),
      ),
      drawer: const BolaoDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(
              width: 450,
              height: 50,
              child: Card(
                elevation: 50,
                color: Color(0xFF1F4E79),
                child: Center(
                  child: Text('Entenda mais o bolão',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                  children: [
                    const SizedBox(
                        width: 400,
                        height: 80,
                        child: Center(child: Text('História do Bolão',textAlign: TextAlign.justify, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
                    ),
                    const SizedBox(
                        width: 400,
                        height: 80,
                        child: Text('O Bolão da Copa teve sua primeira edição em 2002, adicionando animação para os participantes e sorte para o Brasil, que alcançou o pentacampeonato.',textAlign: TextAlign.justify, style: TextStyle(fontSize: 15),)
                    ),
                    const SizedBox(
                        width: 400,
                        height: 150,
                        child: Text('A cada ano, o número de participantes foi subindo até que, em 2018, o Bolão da Copa ganhou sua versão para Smartphones e ganhou o mundo, com aparição na TV e com participantes da Inglaterra, EUA, Austrália, Londres, Portugal, etc. O foco sempre será na diversão de familiares, amigos e amigos dos amigos. Jogos aparentemente menos badalados como Marrocos x Irã (2018) se tornam um clássico na nossa brincadeira. Essa será a sétima edição do Bolão da Copa. Esperamos que você se divirta com a gente!',textAlign: TextAlign.justify, style: TextStyle(fontSize: 15),)
                    ),
                    const SizedBox(
                        width: 400,
                        height: 70,
                        child: Center(child: Text('Pontuação',textAlign: TextAlign.center, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: ExpansionPanelList.radio(
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() => _pontuacao[index].isExpanded = !isExpanded);
                        },
                        children: _pontuacao.map<ExpansionPanel>((Pontuacao pontuacao) {
                          return ExpansionPanelRadio(
                            value: pontuacao.id,
                            canTapOnHeader: true,
                            headerBuilder: (BuildContext context, bool isExpanded) {
                              return ListTile(
                                leading: CircleAvatar(child: Text(pontuacao.pontos.toString())),
                                title: Text(pontuacao.titulo),
                              );
                            },
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(pontuacao.descricao),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 12.0),
                                  child: Text("Exemplo:",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 12.0),
                                  child:  Text(pontuacao.aposta, style: const TextStyle(fontSize: 15),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 12.0),
                                  child:  Text(pontuacao.resultado, style: const TextStyle(fontSize: 15),),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                        width: 400,
                        height: 80,
                        child: Center(child: Text('Pontuação Ponderada',textAlign: TextAlign.center, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
                    ),
                    const ListTile(
                      leading: Icon(Icons.sports_soccer),
                      title: Text('Multiplicada por 2 | Jogos 49 a 60 (OITAVAS E QUARTAS DE FINAIS)'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.sports_soccer),
                      title: Text('Multiplicada por 3 | Jogos 61 a 63 (SEMI-FINAIS e DISPUTA DE 3º LUGAR'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.sports_soccer),
                      title: Text( 'Multiplicada por 4 | GRANDE FINAL DA COPA DO MUNDO 2022'),
                    ),
                    const SizedBox(
                        width: 400,
                        height: 70,
                        child: Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Text('OBS: Resultados dos jogos para efeito de pontuação, só nos 90min de bola rolando. Prorrogação e disputas de pênaltis estão fora.',textAlign: TextAlign.justify, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        )
                    ),
                    const SizedBox(
                        width: 400,
                        height: 70,
                        child: Center(child: Text('Premiação',textAlign: TextAlign.center, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
                    ),
                    const SizedBox(
                        width: 400,
                        height: 50,
                        child: Center(child: Text('Em suma, assim será a divisão da premiação deste bolão:',textAlign: TextAlign.justify, style: TextStyle(fontSize: 15),))
                    ),
                    const ListTile(
                      leading: Icon(Icons.emoji_events, color: Colors.amber, size: 35),
                      title: Text('1º lugar                               : 50% do arrecadado.'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.emoji_events, color: Colors.amber, size: 33),
                      title: Text('2º lugar                               : 25% do arrecadado.'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.emoji_events, color: Colors.amber, size: 31),
                      title: Text('3º lugar                               : 10% do arrecadado.'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.emoji_events, color: Colors.amber, size: 29),
                      title: Text('4º lugar                               : 6% do arrecadado.'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.emoji_events, color: Colors.amber, size: 27),
                      title: Text('5º lugar                               : 4% do arrecadado.'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.emoji_events, color: Colors.amber, size: 25),
                      title: Text( 'Maior quantidade de acertos de placares: 5% do arrecadado.'),
                    ),
                    const SizedBox(
                        width: 400,
                        height: 100,
                        child: Center(child: Text('Prazo limite de apostas',textAlign: TextAlign.center, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
                    ),
                    const SizedBox(
                        width: 400,
                        height: 50,
                        child: Text('O Bolão da Copa oferece total reflexibilidade para que os participantes realizem suas apostas. É possível preencher as apostas de uma só vez, como também é possível preenchê-las pouco a pouco, à medida que as rodadas vão se aproximando.',textAlign: TextAlign.justify, style: TextStyle(fontSize: 15),)
                    ),
                    const SizedBox(
                        width: 400,
                        height: 50,
                        child: Text('Atenção: O prazo para incluir ou alterar apostas é 23h59 do dia anterior a cada partida.',textAlign: TextAlign.justify, style: TextStyle(fontSize: 15),)
                    ),
                    const SizedBox(
                        width: 400,
                        height: 50,
                        child: Text('Essa regra tem por objetivo dar transparência à nossa brincadeira. Assim, no dia de cada jogo, a inclusão ou a alteração de apostas estarão bloqueadas, e as apostas de todos os participantes estarão disponíveis para consulta. Todo mundo acompanha as apostas de todo mundo, podendo torcer a favor (ou contra) um placar, a depender da situação.',textAlign: TextAlign.justify, style: TextStyle(fontSize: 15),)
                    ),

                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}