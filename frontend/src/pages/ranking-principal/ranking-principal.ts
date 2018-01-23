import { Component } from '@angular/core';
import { NavController  } from 'ionic-angular';
import { BackendService } from '../../service/backend-service';

@Component({
  selector: 'page-ranking-principal',
  templateUrl: 'ranking-principal.html'
})
export class RankingPrincipalPage {
    listaRanking: Array<{posicao: number, nome: string, foto: string, pontuacao: number}>;

  constructor(public navCtrl: NavController, backend: BackendService) {
        
    this.listaRanking = backend.obterRanking();

  }

}
