import { BrowserModule } from '@angular/platform-browser';
import { ErrorHandler, NgModule } from '@angular/core';
import { IonicApp, IonicErrorHandler, IonicModule } from 'ionic-angular';

import { BolaoDaCopa } from './app.component';
import { HomePage } from '../pages/home/home';
import { ListPage } from '../pages/list/list';

import { StatusBar } from '@ionic-native/status-bar';
import { SplashScreen } from '@ionic-native/splash-screen';
import { RankingPrincipalPage } from '../pages/ranking-principal/ranking-principal';
import { JogosPage } from '../pages/jogos/jogos';
import { MensagensPage } from '../pages/mensagens/mensagens';
import { BackendService } from '../service/backend-service';

@NgModule({
  declarations: [
    BolaoDaCopa,
    HomePage,
    ListPage,
    RankingPrincipalPage,
    JogosPage,
    MensagensPage
  ],
  imports: [
    BrowserModule,
    IonicModule.forRoot(BolaoDaCopa),
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    BolaoDaCopa,
    HomePage,
    ListPage,
    RankingPrincipalPage,
    JogosPage,
    MensagensPage
  ],
  providers: [
    StatusBar,
    SplashScreen,
    BackendService,
    {provide: ErrorHandler, useClass: IonicErrorHandler}
  ]
})
export class AppModule {}
