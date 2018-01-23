export class BackendService {

    ranking : Array<{posicao: number, nome: string, foto: string, pontuacao: number}>;

    constructor (){}

    public obterRanking() : Array<any> {
        
        this.ranking = [];

        //ToDo - buscar do backend o ranking
        this.ranking.push({posicao:1,nome:"Andre", foto:"assets/imgs/andre.jpg", pontuacao:10});
        this.ranking.push({posicao:1,nome:"Helson", foto:"assets/imgs/helson.jpg", pontuacao:10});
        this.ranking.push({posicao:1,nome:"Luis Angelo", foto:"assets/imgs/luis.jpg", pontuacao:10});
        this.ranking.push({posicao:1,nome:"Piures", foto:"assets/imgs/piures.jpg", pontuacao:10});
        //

        return(this.ranking);
    }
}