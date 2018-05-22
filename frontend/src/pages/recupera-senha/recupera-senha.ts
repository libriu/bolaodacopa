import { Component } from '@angular/core';
import { ToastController } from 'ionic-angular';


import { Platform, NavParams, ViewController } from 'ionic-angular';
import { BackendService } from '../../service/backend-service';
import { RetornoRecuperarSenhaInterface, DadosRecuperarSenhaInterface } from '../../service/interfaces';
import { LoginService } from '../../service/login-service';
import { ApostasService } from '../../service/apostas-service';

@Component({
  templateUrl: 'recupera-senha.html'
})
export class RecuperaSenhaPage {

    public nome : string;
    
    constructor(
        public platform: Platform,
        public params: NavParams,
        public viewCtrl: ViewController,
        public backend: BackendService,
        public loginService:LoginService,
        private toastCtrl: ToastController,
        public apostasService: ApostasService
    ) {

    }

    public recuperarSenha(){

        if (this.nome == null || this.nome == ""){
            this.toastErro("Favor preencher o nome do usuario!");
        } else {
            let dadosRecuperaSenha : DadosRecuperarSenhaInterface = {
                arg0 :this.nome
            };       

            this.backend.recuperarSenha(dadosRecuperaSenha).subscribe(
                data => this.retornoRecupera(data["data"]),
                error => this.retornoRecupera({indSucesso:0,mensagem:error.message})
                //error => this.retornoLogin({"apostador":{"cod_Apostador":37,"nome":"Andre Muniz"},"indSucesso":1,"mensagem":"Login realizado com sucesso!"},secret)
            );
        }
    }

    private retornoRecupera(dadosRetorno:RetornoRecuperarSenhaInterface){
        if (dadosRetorno.indSucesso == 1) {
            this.toastSucesso(dadosRetorno.mensagem);
            this.dismiss();
        } else {
            this.toastErro(dadosRetorno.mensagem);
        }
      }
    
    dismiss() {
        this.viewCtrl.dismiss();
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

}