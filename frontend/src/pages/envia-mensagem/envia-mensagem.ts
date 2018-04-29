import { Component } from '@angular/core';
import { ViewController } from 'ionic-angular';
import { DadosEnviarMensagemInterface, RetornoEnviarMensagemInterface } from '../../service/interfaces';
import { BackendService } from '../../service/backend-service';
import { LoginService } from '../../service/login-service';
import { ToastController } from 'ionic-angular/components/toast/toast-controller';

@Component({
  templateUrl: 'envia-mensagem.html'
})
export class EnviaMensagemPage {

  dadosEnviarMensagem : DadosEnviarMensagemInterface;
  mensagem : string;

  constructor(
    public viewCtrl: ViewController,
    public backend: BackendService,
    public loginService:LoginService,
    private toastCtrl: ToastController
  ) {
  }

  public close() {
    this.viewCtrl.dismiss();
  }

  public enviarMensagem(){

    if (this.mensagem == null){
      this.toastErro("Falta informar a mensagem!");
      return;
    }

    this.dadosEnviarMensagem = this.loginService.getDadosEnviarMensagem(this.mensagem);

    this.backend.enviarMensagem(this.dadosEnviarMensagem).subscribe(
      data => this.retornoEnvio(data["data"]),
      error => this.retornoEnvio({indSucesso:0,mensagem:error.message})
    );

  }

  private retornoEnvio(dadosRetorno:RetornoEnviarMensagemInterface){
    if (dadosRetorno.indSucesso == 1) {
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

  public getNomeUsuario(){
    return this.loginService.getNomeApostadorLogado();
  }
  
}