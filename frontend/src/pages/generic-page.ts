
import { ModalController } from 'ionic-angular';
import { LoginPage } from './login/login';


export class GenericPage {
  constructor(public modalCtrl: ModalController) { }

  abreLogin() {
    let modal = this.modalCtrl.create(LoginPage);
    modal.present();
  }
}