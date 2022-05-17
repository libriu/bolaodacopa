import 'package:bolao_app/activate_user.dart';
import 'package:bolao_app/ranking.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'logon.dart';
import 'models/apostador.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({
    Key? key, this.usuarioLogado
  }) : super(key: key);
  final Apostador? usuarioLogado;

  @override
  State<HomeRoute> createState() => _HomeRouteState(usuarioLogado: usuarioLogado);
}

class _HomeRouteState extends State<HomeRoute> {

  var listOfItems = <Widget>[];
  Widget body = const RankingRoute();
  Apostador? usuarioLogado;

  _HomeRouteState({this.usuarioLogado});

  void _menuHeader(String nomeLogin, String email) {
    listOfItems.clear();
    UserAccountsDrawerHeader dh = UserAccountsDrawerHeader(
        accountName: Text(nomeLogin),
        accountEmail: Text(email),
        currentAccountPicture: const CircleAvatar(
          backgroundImage: NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0GnjxegmKNU566LCxG_RlnxvHKC6jwhdZyQ&usqp=CAU"
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
        Navigator.of(context).pop();
        Navigator.push(
        context,
          MaterialPageRoute(builder: (context) => LogonPage(usuarioLogado: usuarioLogado)),
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
        leading: const Icon(Icons.monetization_on),
        title: const Text('Ativar apostadores'),
        onTap: () {
          Navigator.of(context).pop();
          setState(() {
            body = ActivateUserRoute(usuarioLogado: usuarioLogado);
          });
        }
    );
    listOfItems.add(item5);
    ListTile item6 = ListTile(
      leading: const Icon(Icons.logout),
      title: const Text('Terminar sessão'),
      onTap: _terminarSessao
    );
    listOfItems.add(item6);
  }

  void _getMenuItems() async{
    //final inheritedWidget = UserInheritedWidget.of(context);
    if (usuarioLogado != null && usuarioLogado!.login != null) {
      //nomeApostador = usuarioLogado!.login!;
      _menuHeader(usuarioLogado!.login!, usuarioLogado!.email!);
      if (usuarioLogado!.acessoGestaoTotal == 1) {
        _menuCompleto();
      } else if (usuarioLogado!.acessoAtivacao == 1){
        _menuIntermediario();
      } else {
        _menuPadrao();
      }
    }
    else {
      _menuHeader('Usuário não registrado', '');
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
      body: body,
    );
  }

  void _terminarSessao() {
    Auth.logoff();
    setState(() {
      body = const RankingRoute();
      usuarioLogado = null;
    });
    Navigator.pop(context);
  }
}
