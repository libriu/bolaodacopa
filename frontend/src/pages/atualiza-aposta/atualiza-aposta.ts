import { Component } from '@angular/core';
import { ViewController } from 'ionic-angular';
import { DadosApostaInterface, JogosInterface, DadosAtualizarApostaInterface, RetornoAtualizarApostaInterface } from '../../service/interfaces';
import { BackendService } from '../../service/backend-service';
import { LoginService } from '../../service/login-service';
import { ToastController } from 'ionic-angular/components/toast/toast-controller';
import { ApostasService } from '../../service/apostas-service';

@Component({
  templateUrl: 'atualiza-aposta.html'
})
export class AtualizaApostaPage {

  dadosAposta : DadosApostaInterface;
  itemJogo : JogosInterface;
  placar1 : number;
  placar2 : number;
  imgBasePath : string = "assets/imgs/bandeiras/";

  constructor(
    public viewCtrl: ViewController,
    public backend: BackendService,
    public loginService:LoginService,
    private toastCtrl: ToastController,
    public apostasService: ApostasService
  ) {
    this.itemJogo = apostasService.getJogoParaAtualizar();
    this.dadosAposta = loginService.getDadosAposta();
  }

  public close() {
    this.viewCtrl.dismiss();
  }

  public gravarAposta(){

    if (this.placar1 == null || this.placar2 == null){
      this.toastErro("Falta informar o placar completo!");
      return;
    }

    let dadosEnvio : DadosAtualizarApostaInterface = {
      arg0 : this.dadosAposta.arg0,
      arg1 : this.dadosAposta.arg1,
      cod_jogo : this.itemJogo.cod_Jogo,
      placar_A : this.placar1,
      placar_B : this.placar2
    }

    this.backend.atualizarApostaUsuario(dadosEnvio).subscribe(
      data => this.retornoAtualiza(data["data"]),
      error => this.retornoAtualiza({indSucesso:0,mensagem:error.message})
    );

  }

  private retornoAtualiza(dadosRetorno:RetornoAtualizarApostaInterface){
    if (dadosRetorno.indSucesso == 1) {
        this.apostasService.recuperaApostasUsuario(this.dadosAposta);
        this.toastSucesso(dadosRetorno.mensagem);
        this.close();
    } else {
        this.toastErro(dadosRetorno.mensagem);
    }
  }

  toastSucesso(mensagem:string) {
    let toast = this.toastCtrl.create({
      message: mensagem,
      duration: 1500,
      position: 'bottom'
    });
   
    toast.present();
  }
    
  toastErro(mensagem:string) {
      let toast = this.toastCtrl.create({
        message: mensagem,
        duration: 3000,
        position: 'bottom',
        showCloseButton: true,
        closeButtonText:'OK'
      });
    
      toast.present();
    
  }

  public getPathImgBandeira(arquivo : string) : string {
    return this.imgBasePath + arquivo;
  }

  public getDescJogo(){    
    if (this.itemJogo.cod_Jogo <= 48)
      return "GRUPO "+this.itemJogo.Grupo;
    else if (this.itemJogo.cod_Jogo >= 49 && this.itemJogo.cod_Jogo <= 56)
      return "OITAVAS";
    else if (this.itemJogo.cod_Jogo >= 57 && this.itemJogo.cod_Jogo <= 60)
      return "QUARTAS";
    else if (this.itemJogo.cod_Jogo >= 61 && this.itemJogo.cod_Jogo <= 62)
      return "SEMI";
    else if (this.itemJogo.cod_Jogo == 63)
      return "3o LUGAR";
    else
      return "FINAL";
  }
}