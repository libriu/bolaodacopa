import { Component } from '@angular/core';
import { NavController  } from 'ionic-angular';
import { BackendService } from '../../service/backend-service';

@Component({
  selector: 'page-ranking-principal',
  templateUrl: 'ranking-principal.html'
})
export class RankingPrincipalPage {
    listaRanking: Array<{posicao: number, nome: string, foto: string, pontuacao: number}>;
    listaRankingOriginal: any;

  constructor(public navCtrl: NavController, backend: BackendService) {
        
    this.listaRankingOriginal = backend.obterRanking();
    this.listaRanking = this.listaRankingOriginal;

  }

  initializeListaRanking() {
    if (!this.listaRankingOriginal){
      this.listaRankingOriginal = [];
    }
    if (!this.listaRanking){
      this.listaRanking = [];
    }
  }

  getListaRankingFiltrada(ev: any) {
    // Reset items back to all of the items
    this.initializeListaRanking();

    // set val to the value of the searchbar
    let val = ev.target.value;

    // if the value is an empty string don't filter the items
    if (val && val.trim() != '') {
      this.listaRanking = this.listaRankingOriginal.filter((item) => {
        return (item.nome.toLowerCase().indexOf(val.toLowerCase()) > -1);
      })
    } else {
      this.listaRanking = this.listaRankingOriginal;
    }
  }

}
