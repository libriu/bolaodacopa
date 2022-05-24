import 'package:bolao_app/activate_user.dart';
import 'package:bolao_app/ranking.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'logon.dart';
import 'models/apostador.dart';

enum PageName {
  ranking,
  activateUser
}

class HomeRoute extends StatefulWidget {
  const HomeRoute({
    Key? key, required this.page, this.usuarioLogado
  }) : super(key: key);

  final PageName page;
  final Apostador? usuarioLogado;

  @override
  State<HomeRoute> createState() => _HomeRouteState(usuarioLogado: usuarioLogado);
}

class _HomeRouteState extends State<HomeRoute> {
  var listOfItems = <Widget>[];
  Widget? body;
  Apostador? usuarioLogado;
  String? title;

  _HomeRouteState({this.usuarioLogado});

  void _menuHeader(String nomeLogin, String email) {
    listOfItems.clear();
    UserAccountsDrawerHeader dh = UserAccountsDrawerHeader(
        accountName: Text(nomeLogin),
        accountEmail: Text(email),
        currentAccountPicture: const CircleAvatar(

          child: Icon(Icons.account_circle_sharp, size: 70)
          // backgroundImage: NetworkImage(
          //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0GnjxegmKNU566LCxG_RlnxvHKC6jwhdZyQ&usqp=CAU"
          // ),
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
    ListTile itemRanking =  ListTile(
      leading: const Icon(Icons.home),
      title: const Text('Ranking'),
      onTap: () {
        Navigator.of(context).pop();
        setState(() {
          title = getPageTitle(PageName.ranking);
          body = getPageWidget(PageName.ranking);
        });
      }
    );
    listOfItems.add(itemRanking);
    ListTile itemMessages = const ListTile(
      leading: Icon(Icons.message),
      title: Text('Mensagens'),
    );
    listOfItems.add(itemMessages);
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
    ListTile itemActivate = ListTile(
        leading: const Icon(Icons.monetization_on),
        title: const Text('Ativar apostadores'),
        onTap: () {
          Navigator.of(context).pop();
          setState(() {
            title = getPageTitle(PageName.activateUser);
            body = getPageWidget(PageName.activateUser);
          });
        }
    );
    listOfItems.add(itemActivate);
    ListTile itemLogoff = ListTile(
      leading: const Icon(Icons.logout),
      title: const Text('Terminar sessão'),
      onTap: _terminarSessao
    );
    listOfItems.add(itemLogoff);
  }

  void _getMenuItems() async{
    if (usuarioLogado != null && usuarioLogado!.login != null) {
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
    body = getPageWidget(widget.page);
    title = getPageTitle(widget.page);
  }

  @override
  Widget build(BuildContext context) {
    _getMenuItems();

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
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

  String getPageTitle(PageName pageName) {
    switch (pageName){
      case PageName.ranking: return "Bolão da Copa - ranking";
      case PageName.activateUser: return "Bolão da Copa - ativar usuários";
      default: return "";
    }
  }

  Widget getPageWidget(PageName pageName) {
    switch (pageName){
      case PageName.ranking: return RankingRoute(usuarioLogado: usuarioLogado);
      case PageName.activateUser: return ActivateUserRoute(usuarioLogado: usuarioLogado);
      default: return const RankingRoute();
    }
  }
}
