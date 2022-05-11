import 'package:flutter/material.dart';
import 'auth.dart';
import 'logon.dart';
import 'models/apostador.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({
    Key? key, this.usuarioLogado,
  }) : super(key: key);

  final Apostador? usuarioLogado;

  @override
  State<HomeRoute> createState() => _HomeRouteState(usuarioLogado: usuarioLogado);
}
class _HomeRouteState extends State<HomeRoute> {
  String nomeApostador = "";
  var listOfItems = <Widget>[];
  Apostador? usuarioLogado;

  _HomeRouteState({this.usuarioLogado});

  void _menuHeader(String nomeLogin) {
    listOfItems.clear();
    DrawerHeader dh = DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.indigo,
      ),
      child: Text(
        nomeLogin,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );

    listOfItems.add(dh);
  }
  void _menuDeslogado() {
    ListTile item1 = ListTile(
      leading: const Icon(Icons.login),
      title: const Text('Iniciar sessão'),
      onTap: () {
        Navigator.push(
        context,
          MaterialPageRoute(builder: (context) => LogonPage(redirectPage: widget, usuarioLogado: usuarioLogado)),
        );
      },
    );
    listOfItems.add(item1);
  }
  void _menuPadrao() {
    ListTile item1 = const ListTile(
      leading: Icon(Icons.message),
      title: Text('Mensagens'),
    );
    listOfItems.add(item1);
    ListTile item2 = ListTile(
      leading: const Icon(Icons.logout),
      title: const Text('Terminar sessão'),
      onTap: _terminarSessao
    );
    listOfItems.add(item2);
  }

  void _menuIntermediario() {
    ListTile item1 = const ListTile(
      leading: Icon(Icons.message),
      title: Text('Mensagens'),
    );
    listOfItems.add(item1);
    ListTile item2 = const ListTile(
      leading: Icon(Icons.group),
      title: Text('Grupos'),
    );
    listOfItems.add(item2);
    ListTile item3 = ListTile(
      leading: const Icon(Icons.logout),
      title: const Text('Terminar sessão'),
      onTap: _terminarSessao
    );
    listOfItems.add(item3);
  }
  void _menuCompleto() {
    ListTile item1 = const ListTile(
      leading: Icon(Icons.message),
      title: Text('Mensagens'),
    );
    listOfItems.add(item1);
    ListTile item2 = const ListTile(
      leading: Icon(Icons.group),
      title: Text('Grupos'),
    );
    listOfItems.add(item2);
    ListTile item3 = const ListTile(
      leading: Icon(Icons.account_circle),
      title: Text('Perfil'),
    );
    listOfItems.add(item3);
    ListTile item4 = const ListTile(
      leading: Icon(Icons.settings),
      title: Text('Configurações'),
    );
    listOfItems.add(item4);
    ListTile item5 = ListTile(
      leading: const Icon(Icons.logout),
      title: const Text('Terminar sessão'),
      onTap: _terminarSessao
    );
    listOfItems.add(item5);
  }

  void _getMenuItems() async{
    //final inheritedWidget = UserInheritedWidget.of(context);
    if (usuarioLogado != null && usuarioLogado!.login != null) {
      nomeApostador = usuarioLogado!.login!;
      _menuHeader(nomeApostador);
      if (usuarioLogado!.acessoGestaoTotal == 1) {
        _menuCompleto();
      } else if (usuarioLogado!.acessoAtivacao == 1){
        _menuIntermediario();
      } else {
        _menuPadrao();
      }
    }
    else {
      _menuHeader('Usuário não registrado');
      _menuDeslogado();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getMenuItems();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bolão da Copa 2022'),
      ),
      drawer: Drawer(
         child: ListView(
           padding: EdgeInsets.zero,
           children: listOfItems,
         )),
      body: const Text("Home Page"),
    );
  }

  void _terminarSessao() {
    Auth.logoff();
    setState(() {
      usuarioLogado = null;
    });
    Navigator.pop(context);
  }
}
