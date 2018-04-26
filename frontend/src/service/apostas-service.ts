import { ApostasInterface, DadosApostaInterface } from "./interfaces";
import { BackendService } from "./backend-service";

export class ApostasService {
    listaApostasUsuario : Array<ApostasInterface>;

    constructor (
        public backend: BackendService
    ) {
    }

    public recuperaApostasUsuario(dadosAposta : DadosApostaInterface) {
        this.backend.obterApostasUsuario(dadosAposta).subscribe(
            data => this.setListaApostasUsuario(data["data"])
        );          
    }

    public limpaApostasUsuario(){
        this.listaApostasUsuario=null;
    }

    private setListaApostasUsuario(data:any){
        this.listaApostasUsuario = data;
    }

    public existeApostaUsuario(cod_jogo : number) : boolean {
    
        if (!this.listaApostasUsuario || this.listaApostasUsuario.length == 0) {
            return false;
        } else {
            let listaAposta = this.listaApostasUsuario.filter((item) => {return (item.cod_jogo==cod_jogo); });
            return (listaAposta.length > 0);
        }

    }

    public getDescApostaUsuario(cod_jogo : number) : string {

        if (this.listaApostasUsuario){

            let laposta = this.listaApostasUsuario.filter((item) => {return (item.cod_jogo==cod_jogo); });

            if (laposta.length>0){
                let aposta = laposta[0];    
                return ("Sua aposta: "+aposta.placar_A + " x " + aposta.placar_B);
            } else {
                return ("Aposte agora!");
            }

        } else {
            return ("***");
        }
    }

    
    public getPontuacaoUsuario(cod_jogo : number) : string {
    
        if (this.listaApostasUsuario){

            let laposta = this.listaApostasUsuario.filter((item) => {return (item.cod_jogo==cod_jogo); });

            if (laposta.length>0){
                let aposta = laposta[0];    
                return ("Seus pontos no jogo: "+aposta.Pontos);
            } else {
                return ("Seus pontos no jogo: 0");
            }

        } else {
            return ("Seus pontos no jogo: 0");
        }
    }
    
  
}