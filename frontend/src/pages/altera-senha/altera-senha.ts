import { Component } from '@angular/core';
import { ToastController } from 'ionic-angular';


import { Platform, NavParams, ViewController } from 'ionic-angular';
import { BackendService } from '../../service/backend-service';
import { RetornoLoginInterface, DadosAlterarSenhaInterface } from '../../service/interfaces';
import * as CryptoJS from 'crypto-js';
import { LoginService } from '../../service/login-service';
import { ApostasService } from '../../service/apostas-service';

@Component({
  templateUrl: 'altera-senha.html'
})
export class AlteraSenhaPage {

    public nome : string;
    public senhaAtual: string;
    public novaSenha: string;
    public confirmeNovaSenha: string;
    
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

    public alterarSenha(){

        if (this.nome == null || this.nome == "" ||
            this.senhaAtual == null || this.senhaAtual == "" ||
            this.novaSenha == null || this.novaSenha == "" ||
            this.confirmeNovaSenha == null || this.confirmeNovaSenha == ""){
            this.toastErro("Favor preencher todos os campos!");
        } else if (this.novaSenha != this.confirmeNovaSenha) {
            this.toastErro("Confirmação de senha não confere!");
        } else {
            let secret=CryptoJS.SHA512(this.senhaAtual).toString();
            let dadosAlteraSenha : DadosAlterarSenhaInterface = {
                arg0 :this.nome,
                arg1:secret,
                arg2:this.novaSenha
            };       

            this.backend.alterarSenha(dadosAlteraSenha).subscribe(
                data => this.retornoLogin(data["data"],secret),
                error => this.retornoLogin({indSucesso:0,mensagem:error.message},secret)
                //error => this.retornoLogin({"apostador":{"cod_Apostador":37,"nome":"Andre Muniz"},"indSucesso":1,"mensagem":"Login realizado com sucesso!"},secret)
            );
        }
    }

    retornoLogin(data,secret){
        let dadosRetorno : RetornoLoginInterface = data;

        if (dadosRetorno.indSucesso == 1) {
            this.loginService.setApostadorLogado(dadosRetorno.apostador,secret);
            this.apostasService.recuperaApostasUsuario(this.loginService.getDadosAposta());
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
          duration: 3000,
          position: 'bottom',
          showCloseButton: true,
          closeButtonText:'OK'
        });
       
        toast.present();      
    }

}