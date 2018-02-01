import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';
import { BackendService } from '../../service/backend-service';
import { LoginService } from '../../service/login-service';

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
  listaApostasUsuario : Array<{cod_Aposta:number,cod_Jogo: number,placar_A:number,placar_B:number,Pontos:number}>;
  codApostadorLogado : number;

  constructor(public navCtrl: NavController, backend: BackendService, login: LoginService) {

    this.codApostadorLogado = login.getCodApostadorLogado();

    this.listaJogos = backend.obterJogos();

    this.listaJogosProximos = this.listaJogos.filter((item) => {
      return (item.jaOcorreu == 0);
    });

    this.listaJogosAnteriores = this.listaJogos.filter((item) => {
      return (item.jaOcorreu == 1);
    });

    this.listaApostasUsuario = backend.obterApostasUsuario(this.codApostadorLogado);

  }

  public getPathImgBandeira(arquivo : string) : string {
    return this.imgBasePath + arquivo;
  }

  public existeApostaUsuario(cod_jogo : number) : boolean {

    if (this.listaApostasUsuario.length == 0) {
      return false;
    } else {
      let listaAposta = this.listaApostasUsuario.filter((item) => {return (item.cod_Jogo==cod_jogo); });
      return (listaAposta.length > 0);
    }

  }

  public getApostaUsuario(cod_jogo : number) : string {
    let result = "";

    let laposta = this.listaApostasUsuario.filter((item) => {return (item.cod_Jogo==cod_jogo); });

    let aposta = laposta[0];

    return (aposta.placar_A + " x " + aposta.placar_B);
  }

  

  public getPontuacaoUsuario(cod_jogo : number) : number {
    let result = "";

    let laposta = this.listaApostasUsuario.filter((item) => {return (item.cod_Jogo==cod_jogo); });

    let aposta = laposta[0];

    return (aposta.Pontos);
  }

}
