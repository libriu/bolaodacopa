
import { ModalController,PopoverController } from 'ionic-angular';
import { LoginPage } from './login/login';
import { LoginService } from '../service/login-service';
import { DetalheUsuarioPopoverPage } from '../popovers/detalhe-usuario/detalhe-usuario';


export class GenericPage {
  constructor(
    public modalCtrl: ModalController,
    public popoverCtrl: PopoverController, 
    public loginService : LoginService) { }

  abreLogin() {
    let modal = this.modalCtrl.create(LoginPage);
    modal.present();
  }

  isLogado():boolean{
    return this.loginService.getIsLogado();
  }

  popoverUsuario(myEvent) {
    let popover = this.popoverCtrl.create(DetalheUsuarioPopoverPage);
    popover.present({
      ev: myEvent
    });
  }
}