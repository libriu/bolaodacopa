import { Component } from '@angular/core';
import { NavController, PopoverController, AlertController,LoadingController, Loading  } from 'ionic-angular';
import { BackendService } from '../../service/backend-service';
import { RankingInterface } from '../../service/interfaces';
import { DetalheApostadorPopoverPage } from '../../popovers/detalhe-apostador/detalhe-apostador';
import { GenericPage } from '../generic-page';
import { ModalController } from 'ionic-angular';
import { LoginService } from '../../service/login-service';

@Component({
  selector: 'page-ranking-principal',
  templateUrl: 'ranking-principal.html'
  })
export class RankingPrincipalPage extends GenericPage {
    listaRanking: Array<RankingInterface>;
    listaRankingOriginal: Array<RankingInterface>;

    public teste: String;
    public loading: Loading;

  constructor(
    public navCtrl: NavController, 
    backend: BackendService, 
    public popoverCtrl: PopoverController,
    public alertCtrl: AlertController,
    public modalCtrl: ModalController,
    public loadingCtrl: LoadingController, 
    public loginService : LoginService
  ) {
    
    super(modalCtrl,popoverCtrl,loginService);


    this.showLoading();

    backend.obterRanking().subscribe(
      data => this.setListaRanking(data["data"])
    );

//    this.hideLoading();
   
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

  public showLoading() {

    this.loading = this.loadingCtrl.create({
      content: 'Carregando...',
      duration: 10000
    });
    this.loading.present();

  }

  public hideLoading() {

    this.loading.dismiss();

  }

}
