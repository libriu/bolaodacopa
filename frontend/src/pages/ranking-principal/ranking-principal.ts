import { Component } from '@angular/core';
import { NavController, PopoverController, AlertController  } from 'ionic-angular';
import { BackendService } from '../../service/backend-service';
import { RankingInterface } from '../../service/interfaces';
import { DetalheApostadorPopoverPage } from '../../popovers/detalhe-apostador/detalhe-apostador';

@Component({
  selector: 'page-ranking-principal',
  templateUrl: 'ranking-principal.html'
})
export class RankingPrincipalPage {
    listaRanking: Array<RankingInterface>;
    listaRankingOriginal: Array<RankingInterface>;

    teste: String;

  constructor(public navCtrl: NavController, backend: BackendService, public popoverCtrl: PopoverController,public alertCtrl: AlertController) {
           
    backend.obterRanking().subscribe(
      data => this.setListaRanking(data["data"])
    );
    
  }

  setListaRanking(data : any){
    this.listaRankingOriginal = data;
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

  presentPopover(myEvent) {
    let popover = this.popoverCtrl.create(DetalheApostadorPopoverPage);
    popover.present({
      ev: myEvent
    });
  }

  public getTeste(){
    return this.teste;
  }

}
