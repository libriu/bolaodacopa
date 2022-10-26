import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/usuario.dart';
import '../route_generator.dart';
import '../repositories/user_repository.dart';

enum TipoMenu {
  completo,
  intermediario,
  padrao,
  deslogado
}

class BolaoDrawer extends StatelessWidget {
  const BolaoDrawer({ Key? key }) : super(key: key);

  List<Widget> getItensMenu(BuildContext context, Usuario usuarioLogado) {
    var listOfItems = <Widget>[];
    String nomeLogin = usuarioLogado.login ?? "Usuário não registrado";
    String email = usuarioLogado.email ?? "";
    TipoMenu tipoMenu = getTipoMenu(usuarioLogado);
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
    if (tipoMenu == TipoMenu.deslogado) {
      ListTile itemLogon = ListTile(
        leading: const Icon(Icons.login),
        title: const Text('Iniciar sessão'),
          onTap: () => Navigator.pushNamed(context, RouteGenerator.logonRoute)
      );
      listOfItems.add(itemLogon);
    }
    ListTile itemHome =  ListTile(
        leading: const Icon(Icons.home),
        title: const Text('Home'),
        onTap: () => Navigator.pushNamed(context, RouteGenerator.homeRoute)
    );
    listOfItems.add(itemHome);

    ListTile itemRegras = ListTile(
        leading: const Icon(Icons.rule),
        title: const Text('Regras'),
        onTap: () => Navigator.pushNamed(context, RouteGenerator.regraRoute)
    );
    listOfItems.add(itemRegras);

    // ListTile itemRanking =  ListTile(
    //     leading: const Icon(Icons.article_outlined),
    //     title: const Text('Ranking'),
    //     onTap: () => Navigator.pushNamed(context, RouteGenerator.rankingRoute)
    // );
    // listOfItems.add(itemRanking);

    // if (tipoMenu != TipoMenu.deslogado) {
    //   ListTile itemMessages = const ListTile(
    //     leading: Icon(Icons.message),
    //     title: Text('Mensagens'),
    //   );
    //   listOfItems.add(itemMessages);
    //   ListTile itemGrupos = const ListTile(
    //     leading: Icon(Icons.group),
    //     title: Text('Grupos'),
    //   );
    //   listOfItems.add(itemGrupos);
    //   ListTile itemPerfil = const ListTile(
    //     leading: Icon(Icons.account_circle),
    //     title: Text('Perfil'),
    //   );
    //   listOfItems.add(itemPerfil);
    //   ListTile itemConfig = const ListTile(
    //     leading: Icon(Icons.settings),
    //     title: Text('Configurações'),
    //   );
    //   listOfItems.add(itemConfig);
    // }
    if (tipoMenu == TipoMenu.intermediario || tipoMenu == TipoMenu.completo) {
      ListTile itemActivate = ListTile(
          leading: const Icon(Icons.monetization_on),
          title: const Text('Ativar apostadores'),
          onTap: () => Navigator.pushNamed(context, RouteGenerator.activateUserRoute)
      );
      listOfItems.add(itemActivate);
    }
    if (tipoMenu != TipoMenu.deslogado) {
      ListTile itemLogoff = ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Terminar sessão'),
          onTap: () {
            UserRepository.logoff().then((value) => usuarioLogado.copy(value));
            Navigator.pushNamed(context, RouteGenerator.homeRoute);
          }
      );
      listOfItems.add(itemLogoff);
    }
    return listOfItems;
  }

  TipoMenu getTipoMenu(Usuario usuarioLogado) {
    if (usuarioLogado.isLoggedOn) {
      if (usuarioLogado.acessoGestaoTotal == 1) {
        return TipoMenu.completo;
      } else if (usuarioLogado.acessoAtivacao == 1){
        return TipoMenu.intermediario;
      } else {
        return TipoMenu.padrao;
      }
    }
    else {
      return TipoMenu.deslogado;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Usuario>(
        builder: (context, cache, _) {
          return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: getItensMenu(context, cache)
              ));
        }
    );
  }
}