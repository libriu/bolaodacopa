import { Component } from '@angular/core';
import { ViewController } from 'ionic-angular';
import { LoginService } from '../../service/login-service';

@Component({
  selector: 'popover-detalhe-usuario',
  templateUrl: 'detalhe-usuario.html'
})
export class DetalheUsuarioPopoverPage {
    nomeUsuario : string;
  constructor(public viewCtrl: ViewController, public loginService:LoginService) {
      this.nomeUsuario=loginService.getNomeApostadorLogado();
  }

  logOut(){
    this.loginService.limpaApostadorLogado();
    this.close();
  }

  close() {
    this.viewCtrl.dismiss();
  }


}