import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';

import { RankingPrincipalPage } from '../ranking-principal/ranking-principal';
import { JogosPage } from '../jogos/jogos'
import { MensagensPage } from '../mensagens/mensagens'

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  tab1Root = RankingPrincipalPage;
  tab2Root = JogosPage;
  tab3Root = MensagensPage;


  constructor(public navCtrl: NavController) {

  }

}
