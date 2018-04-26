import { Component } from '@angular/core';
import { NavController,PopoverController,ModalController } from 'ionic-angular';
import { JogosInterface } from '../../service/interfaces';
import { BackendService } from '../../service/backend-service';
import { LoginService } from '../../service/login-service';
import { GenericPage } from '../generic-page';
import { ApostasService } from '../../service/apostas-service';

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
  codApostadorLogado : number;

  constructor(
    public navCtrl: NavController, 
    public popoverCtrl: PopoverController,
    public modalCtrl: ModalController,
    public backend: BackendService, 
    login: LoginService,
    public apostas: ApostasService
  ) {

    super(modalCtrl,popoverCtrl,login);
    
    this.buscarJogos();
  }

  private buscarJogos(){
    this.backend.obterJogos().subscribe(
      data => this.setListaJogos(data["data"])
    );
  }

  public refreshJogos(){
    this.buscarJogos();
    if (this.isLogado()){
      this.apostas.limpaApostasUsuario();
      this.apostas.recuperaApostasUsuario(this.loginService.getDadosAposta());
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
  
  public getPathImgBandeira(arquivo : string) : string {
    return this.imgBasePath + arquivo;
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

  public getDescApostaUsuario(cod_jogo : number){
    return this.apostas.getDescApostaUsuario(cod_jogo);
  }

  public getPontuacaoUsuario(cod_jogo : number) : string{
    return this.apostas.getPontuacaoUsuario(cod_jogo);
  }

}
