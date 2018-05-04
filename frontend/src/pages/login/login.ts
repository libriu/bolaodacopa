import { Component } from '@angular/core';
import { ToastController } from 'ionic-angular';


import { Platform, NavParams, ViewController } from 'ionic-angular';
import { BackendService } from '../../service/backend-service';
import { DadosLoginInterface, RetornoLoginInterface } from '../../service/interfaces';
import * as CryptoJS from 'crypto-js';
import { LoginService } from '../../service/login-service';
import { ApostasService } from '../../service/apostas-service';
import { ModalController } from 'ionic-angular/components/modal/modal-controller';
import { AlteraSenhaPage } from '../altera-senha/altera-senha';

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
        private toastCtrl: ToastController,
        public apostasService: ApostasService,
        public modalCtrl: ModalController
    ) {

    }

    public entrar(){
        let secret=CryptoJS.SHA512(this.senha).toString();
        let dadosLogin : DadosLoginInterface = {
            arg0 :this.nome,
            arg1:secret
        };       

        this.backend.fazerLogin(dadosLogin).subscribe(
            data => this.retornoLogin(data["data"],secret),
            error => this.retornoLogin({indSucesso:0,mensagem:error.message},secret)
            //error => this.retornoLogin({"apostador":{"cod_Apostador":37,"nome":"Andre Muniz"},"indSucesso":1,"mensagem":"Login realizado com sucesso!"},secret)
            //error => this.retornoLogin({"indSucesso":2,"mensagem":"Favor alterar sua senha!"},secret)
        );
    }

    retornoLogin(data,secret){
        let dadosRetorno : RetornoLoginInterface = data;

        if (dadosRetorno.indSucesso == 1) {
            this.loginService.setApostadorLogado(dadosRetorno.apostador,secret);
            this.apostasService.recuperaApostasUsuario(this.loginService.getDadosAposta());
            this.toastSucesso(dadosRetorno.mensagem);
            this.dismiss();
        } else if (dadosRetorno.indSucesso == 2) {            
            this.toastErro(dadosRetorno.mensagem);
            let modal = this.modalCtrl.create(AlteraSenhaPage);
            modal.present();
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
          duration: 3000,
          position: 'bottom',
          showCloseButton: true,
          closeButtonText:'OK'
        });
       
        toast.present();
      
    }


}