import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';
import { BackendService } from '../../service/backend-service';

@Component({
  selector: 'page-jogos',
  templateUrl: 'jogos.html'
})
export class JogosPage {

  jogos : string = "proximos";
  listaJogos : Array<{cod_jogo: number, data_jogo: string, grupo: string, hora_jogo: string, jaOcorreu: number, r_placar_A: number, r_placar_B: number, time1: string, time2: string, arq_time_1:string, arq_time_2:string}>;
  listaJogosProximos : any;
  listaJogosAnteriores : any;
  imgBasePath : string = "../../assets/imgs/bandeiras/";

  constructor(public navCtrl: NavController, backend: BackendService) {

    this.listaJogos = backend.obterJogos();

    this.listaJogosProximos = this.listaJogos.filter((item) => {
      return (item.jaOcorreu == 0);
    });

    this.listaJogosAnteriores = this.listaJogos.filter((item) => {
      return (item.jaOcorreu == 1);
    });

  }

  public getPathImgBandeira(arquivo : string) : string {
    return this.imgBasePath + arquivo;
  }

}
