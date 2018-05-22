import { Component } from '@angular/core';
import { ViewController } from 'ionic-angular';
import { LoginService } from '../../service/login-service';
import { ApostasService } from '../../service/apostas-service';
import { AlteraSenhaPage } from '../../pages/altera-senha/altera-senha';
import { RecuperaSenhaPage } from '../../pages/recupera-senha/recupera-senha';
import { ModalController } from 'ionic-angular/components/modal/modal-controller';

@Component({
  selector: 'popover-detalhe-usuario',
  templateUrl: 'detalhe-usuario.html'
})
export class DetalheUsuarioPopoverPage {
    nomeUsuario : string;
  constructor(
    public viewCtrl: ViewController, 
    public loginService:LoginService,
    public apostasService:ApostasService,
    public modalCtrl:ModalController
  ) {
      this.nomeUsuario=loginService.getNomeApostadorLogado();
  }

  logOut(){
    this.loginService.limpaApostadorLogado();
    this.apostasService.limpaApostasUsuario();
    this.close();
  }

  close() {
    this.viewCtrl.dismiss();
  }

  abreAlteraSenha(){
    let modal = this.modalCtrl.create(AlteraSenhaPage);
    modal.present();
    this.close();
  }

  abreRecuperaSenha(){
    let modal = this.modalCtrl.create(RecuperaSenhaPage);
    modal.present();
    this.close();
  }


}