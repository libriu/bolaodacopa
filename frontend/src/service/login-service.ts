import { ApostadorInterface } from "./interfaces";

export class LoginService {

    apostadorLogado : ApostadorInterface = null;
    isLogado : boolean = false;
    secret : string;

    constructor (){
    }

    public setApostadorLogado(apostadorLogado : ApostadorInterface, secret : string){
        this.apostadorLogado = apostadorLogado;
        this.isLogado = true;
        this.secret = secret;
    }    

    public limpaApostadorLogado(){
        this.apostadorLogado = null;
        this.isLogado = false;
        this.secret = null;
    }

    public getIsLogado() : boolean {
        return this.isLogado;
    }

    public getCodApostadorLogado(){
        if (this.isLogado) {
            return this.apostadorLogado.cod_Apostador;
        } else {
            return 0;
        }
    }

    public getNomeApostadorLogado(){
        if (this.isLogado) {
            return this.apostadorLogado.nome;
        } else {
            return "Zé Ninguém";
        }
    }

}