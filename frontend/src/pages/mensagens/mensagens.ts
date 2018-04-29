import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';
import { MensagensInterface } from '../../service/interfaces';
import { BackendService } from '../../service/backend-service';
import { GenericPage } from '../generic-page';
import { PopoverController } from 'ionic-angular/components/popover/popover-controller';
import { ModalController } from 'ionic-angular/components/modal/modal-controller';
import { LoginService } from '../../service/login-service';
import { EnviaMensagemPage } from '../envia-mensagem/envia-mensagem';

@Component({
  selector: 'page-mensagens',
  templateUrl: 'mensagens.html'
})
export class MensagensPage extends GenericPage {
    
  listaMensagens : Array<MensagensInterface> = [];
  pagina : number = 0;
  
  constructor(
    public navCtrl: NavController, 
    public popoverCtrl: PopoverController,
    public modalCtrl: ModalController,
    public backend: BackendService, 
    public login: LoginService,
  ) {

    super(modalCtrl,popoverCtrl,login);

    this.backend = backend;

    this.buscarProximaPagina();
    

  }

  buscarProximaPagina(){
    this.pagina = this.pagina+1;

    this.backend.obterMensagens(this.pagina).subscribe(
      data => this.concatListaMensagens(data["data"])
    );
  }

  private concatListaMensagens(arg0: any): any {
    this.listaMensagens = this.listaMensagens.concat(arg0);
  }

  public refreshMensagens(){
    this.pagina = 1;

    this.backend.obterMensagens(this.pagina).subscribe(
      data => this.setListaMensagens(data["data"])
    );
  }

  private setListaMensagens(arg0: any): any {
    this.listaMensagens = arg0;
  }

  public doInfinite(infiniteScroll) {
    console.log('Begin async operation');

    setTimeout(() => {
      this.buscarProximaPagina();
      console.log('Async operation has ended');
      infiniteScroll.complete();
    }, 500);
  }

  public abreEnvioMensagem(){
    let modal = this.modalCtrl.create(EnviaMensagemPage);
    modal.onDidDismiss(data => {
      this.refreshMensagens();
    });
    modal.present();
  }

}
