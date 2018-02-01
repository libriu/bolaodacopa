export class LoginService {

    codApostadorLogado : number;

    constructor (){

        //obter cod_Apostador quando o usuário fizer login
        this.codApostadorLogado=1;

    }

    public getCodApostadorLogado() : number {
        return this.codApostadorLogado;
    }

}