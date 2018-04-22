import { ApostadorInterface } from "./interfaces";

export class LoginService {

    apostadorLogado : ApostadorInterface = null;
    isLogado : boolean = false;

    constructor (){
    }

    public setApostadorLogado(apostadorLogado : ApostadorInterface){
        this.apostadorLogado = apostadorLogado;
        this.isLogado = true;
    }    

    public limpaApostadorLogado(){
        this.apostadorLogado = null;
        this.isLogado = false;
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

}