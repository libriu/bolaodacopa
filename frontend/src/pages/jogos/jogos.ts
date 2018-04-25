import { Component } from '@angular/core';
import { NavController,PopoverController,ModalController } from 'ionic-angular';
import { JogosInterface, ApostasInterface } from '../../service/interfaces';
import { BackendService } from '../../service/backend-service';
import { LoginService } from '../../service/login-service';
import { GenericPage } from '../generic-page';

@Component({
  selector: 'page-jogos',
  templateUrl: 'jogos.html'
})
export class JogosPage extends GenericPage{

  jogos : string = "proximos";
  listaJogos : Array<JogosInterface>;
  listaJogosProximos : any;
  listaJogosAnteriores : any;
  imgBasePath : string = "assets/imgs/bandeiras/";
  listaApostasUsuario : Array<ApostasInterface>;
  codApostadorLogado : number;

  constructor(
    public navCtrl: NavController, 
    public popoverCtrl: PopoverController,
    public modalCtrl: ModalController,
    backend: BackendService, 
    login: LoginService
  ) {

    super(modalCtrl,popoverCtrl,login);

    
    backend.obterJogos().subscribe(
      data => this.setListaJogos(data["data"])
    );

    if (login.getIsLogado()){
      backend.obterApostasUsuario(login.getDadosAposta()).subscribe(
        data => this.setListaApostasUsuario(data["data"])
      );
    } else {
      this.setListaApostasUsuario([]);
    }
  }

  setListaJogos(data : any){
    this.listaJogos = data;

    this.listaJogosProximos = this.listaJogos.filter((item) => {
      return (item.jaOcorreu == 0);
    });

    this.listaJogosAnteriores = this.listaJogos.filter((item) => {
      return (item.jaOcorreu == 1);
    });
  }

  setListaApostasUsuario(data:any){
    this.listaApostasUsuario = data;
  }

  public getPathImgBandeira(arquivo : string) : string {
    return this.imgBasePath + arquivo;
  }

  public existeApostaUsuario(cod_jogo : number) : boolean {

    if (this.listaApostasUsuario.length == 0) {
      return false;
    } else {
      let listaAposta = this.listaApostasUsuario.filter((item) => {return (item.cod_jogo==cod_jogo); });
      return (listaAposta.length > 0);
    }

  }

  public getApostaUsuario(cod_jogo : number) : string {
   
    let laposta = this.listaApostasUsuario.filter((item) => {return (item.cod_jogo==cod_jogo); });

    let aposta = laposta[0];

    console.log(aposta.placar_A + " x " + aposta.placar_B);

    return (aposta.placar_A + " x " + aposta.placar_B);
  }

  

  public getPontuacaoUsuario(cod_jogo : number) : number {
    
    let laposta = this.listaApostasUsuario.filter((item) => {return (item.cod_jogo==cod_jogo); });

    let aposta = laposta[0];

    return (aposta.Pontos);
  }

  public getDescJogo(jogo : JogosInterface){    
    if (jogo.cod_Jogo <= 48)
      return "GRUPO "+jogo.Grupo;
    else if (jogo.cod_Jogo >= 49 && jogo.cod_Jogo <= 56)
      return "OITAVAS";
    else if (jogo.cod_Jogo >= 57 && jogo.cod_Jogo <= 60)
      return "QUARTAS";
    else if (jogo.cod_Jogo >= 61 && jogo.cod_Jogo <= 62)
      return "SEMI";
    else if (jogo.cod_Jogo == 63)
      return "3o LUGAR";
    else
      return "FINAL";
  }

}
