
import { ModalController } from 'ionic-angular';
import { LoginPage } from './login/login';
import { LoginService } from '../service/login-service';


export class GenericPage {
  constructor(public modalCtrl: ModalController, public loginService : LoginService) { }

  abreLogin() {
    let modal = this.modalCtrl.create(LoginPage);
    modal.present();
  }

  isLogado():boolean{
    return this.loginService.getIsLogado();
  }
}