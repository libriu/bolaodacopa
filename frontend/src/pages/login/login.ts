import { Component } from '@angular/core';
import { ToastController } from 'ionic-angular';


import { Platform, NavParams, ViewController } from 'ionic-angular';
import { BackendService } from '../../service/backend-service';
import { DadosLoginInterface, RetornoLoginInterface } from '../../service/interfaces';
import * as CryptoJS from 'crypto-js';
import { LoginService } from '../../service/login-service';

@Component({
  templateUrl: 'login.html'
})
export class LoginPage {

    public nome : string;
    public senha: string;
    
    constructor(
        public platform: Platform,
        public params: NavParams,
        public viewCtrl: ViewController,
        public backend: BackendService,
        public loginService:LoginService,
        private toastCtrl: ToastController
    ) {

    }

    public entrar(){
        let dadosLogin : DadosLoginInterface = {
            arg0 :this.nome,
            arg1:CryptoJS.SHA512(this.senha).toString()
        };       

        this.backend.fazerLogin(dadosLogin).subscribe(
            data => this.retornoLogin(data["data"])
        );
    }

    retornoLogin(data){
        let dadosRetorno : RetornoLoginInterface = data;

        if (dadosRetorno.indSucesso == 1) {
            this.loginService.setApostadorLogado(dadosRetorno.apostador);
            this.toastSucesso(dadosRetorno.mensagem);
            this.dismiss();
        } else {
            this.loginService.limpaApostadorLogado();
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
          position: 'bottom',
          showCloseButton: true,
          closeButtonText:'OK'
        });
       
        toast.present();
      
    }


}