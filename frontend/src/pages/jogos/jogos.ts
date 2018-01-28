import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';

@Component({
  selector: 'page-jogos',
  templateUrl: 'jogos.html'
})
export class JogosPage {

  jogos : string = "proximos";

  constructor(public navCtrl: NavController) {

  }

}
