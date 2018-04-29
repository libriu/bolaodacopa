export interface RankingInterface {posicao: number, nome: string, pontuacao: number, codApostador: number}
export interface JogosInterface {cod_Jogo: number, data_jogo: string, Grupo: string, hora_jogo: string, jaOcorreu: number, r_placar_A: number, r_placar_B: number, time1: string, time2: string, arq_time_1:string, arq_time_2:string, diff:number}
export interface MensagensInterface {data_msg:string,hora_msg:string,nome:string,mensagem:string}
export interface ApostadorInterface {cod_Apostador:number,nome:string}
export interface DadosLoginInterface {arg0:string,arg1:string}
export interface RetornoLoginInterface {indSucesso:number,mensagem:string,apostador:ApostadorInterface}
export interface ApostasInterface {cod_Aposta:number,cod_jogo:number,placar_A:number,placar_B:number,Pontos:number}
export interface DadosApostaInterface {arg0:number,arg1:string}
export interface DadosAtualizarApostaInterface{arg0:number,arg1:string,cod_jogo:number,placar_A:number,placar_B:number}
export interface RetornoAtualizarApostaInterface {indSucesso:number,mensagem:string}
export interface DadosEnviarMensagemInterface{arg0:number,arg1:string,mensagem:string}
export interface RetornoEnviarMensagemInterface {indSucesso:number,mensagem:string}
