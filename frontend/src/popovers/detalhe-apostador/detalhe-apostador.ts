import { Component } from '@angular/core';
import { ViewController } from 'ionic-angular';

@Component({
  selector: 'popover-detalhe-apostador',
  templateUrl: 'detalhe-apostador.html'
})
export class DetalheApostadorPopoverPage {
  constructor(public viewCtrl: ViewController) {}

  close() {
    this.viewCtrl.dismiss();
  }
}