import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';
import { BackendService } from '../../service/backend-service';
import { CompileDirectiveMetadata } from '@angular/compiler';

@Component({
  selector: 'page-regras',
  templateUrl: 'regras.html'
})
export class RegrasPage {

    regras : Array<{titulo: string, conteudoHtml: string, dataHoraAtualizacao: string}>;

  constructor(public navCtrl: NavController, backend: BackendService) {

    this.regras = backend.obterRegras();

    
  }

}
