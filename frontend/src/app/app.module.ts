import { BrowserModule } from '@angular/platform-browser';
import { ErrorHandler, NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';
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
import { LoginService } from '../service/login-service';
import { RankingInterface } from '../service/interfaces';
import { DetalheApostadorPopoverPage } from '../popovers/detalhe-apostador/detalhe-apostador';
import { RegrasPage } from '../pages/regras/regras';

@NgModule({
  declarations: [
    BolaoDaCopa,
    HomePage,
    ListPage,
    RankingPrincipalPage,
    JogosPage,
    MensagensPage,
    DetalheApostadorPopoverPage,
    RegrasPage
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    IonicModule.forRoot(BolaoDaCopa),
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    BolaoDaCopa,
    HomePage,
    ListPage,
    RankingPrincipalPage,
    JogosPage,
    MensagensPage,
    DetalheApostadorPopoverPage,
    RegrasPage
  ],
  providers: [
    StatusBar,
    SplashScreen,
    BackendService,
    LoginService,
    {provide: ErrorHandler, useClass: IonicErrorHandler}
  ]
})
export class AppModule {}
