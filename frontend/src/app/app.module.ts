import { BrowserModule } from '@angular/platform-browser';
import { ErrorHandler, NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';
import { IonicApp, IonicErrorHandler, IonicModule } from 'ionic-angular';

import { BolaoDaCopa } from './app.component';
import { HomePage } from '../pages/home/home';

import { StatusBar } from '@ionic-native/status-bar';
import { SplashScreen } from '@ionic-native/splash-screen';
import { RankingPrincipalPage } from '../pages/ranking-principal/ranking-principal';
import { JogosPage } from '../pages/jogos/jogos';
import { MensagensPage } from '../pages/mensagens/mensagens';
import { BackendService } from '../service/backend-service';
import { LoginService } from '../service/login-service';
import { DetalheApostadorPopoverPage } from '../popovers/detalhe-apostador/detalhe-apostador';
import { RegrasPage } from '../pages/regras/regras';
import { LoginPage } from '../pages/login/login';
import { DetalheUsuarioPopoverPage } from '../popovers/detalhe-usuario/detalhe-usuario';
import { ApostasService } from '../service/apostas-service';
import { AtualizaApostaPage } from '../pages/atualiza-aposta/atualiza-aposta';
import { EnviaMensagemPage } from '../pages/envia-mensagem/envia-mensagem';
import { AlteraSenhaPage } from '../pages/altera-senha/altera-senha';

@NgModule({
  declarations: [
    BolaoDaCopa,
    HomePage,
    RankingPrincipalPage,
    JogosPage,
    MensagensPage,
    DetalheApostadorPopoverPage,
    DetalheUsuarioPopoverPage,
    RegrasPage,
    LoginPage,
    AtualizaApostaPage,
    EnviaMensagemPage,
    AlteraSenhaPage
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
    RankingPrincipalPage,
    JogosPage,
    MensagensPage,
    DetalheApostadorPopoverPage,
    DetalheUsuarioPopoverPage,
    RegrasPage,
    LoginPage,
    AtualizaApostaPage,
    EnviaMensagemPage,
    AlteraSenhaPage
  ],
  providers: [
    StatusBar,
    SplashScreen,
    BackendService,
    LoginService,    
    ApostasService,
    {provide: ErrorHandler, useClass: IonicErrorHandler}
  ]
})
export class AppModule {}
