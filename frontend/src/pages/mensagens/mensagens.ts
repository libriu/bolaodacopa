import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';
import { MensagensInterface } from '../../service/interfaces';
import { BackendService } from '../../service/backend-service';

@Component({
  selector: 'page-mensagens',
  templateUrl: 'mensagens.html'
})
export class MensagensPage {
    
  listaMensagens : Array<MensagensInterface> = [];
  pagina : number = 0;
  backend: BackendService;

  constructor(public navCtrl: NavController, backend: BackendService) {

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


}
