export interface RankingInterface {posicao: number, nome: string, pontuacao: number, codApostador: number}
export interface JogosInterface {cod_Jogo: number, data_jogo: string, Grupo: string, hora_jogo: string, jaOcorreu: number, r_placar_A: number, r_placar_B: number, time1: string, time2: string, arq_time_1:string, arq_time_2:string}
export interface MensagensInterface {data_msg:string,hora_msg:string,nome:string,mensagem:string}
export interface ApostadorInterface {cod_Apostador:number,nome:string}
export interface DadosLoginInterface {arg0:string,arg1:string}
export interface RetornoLoginInterface {indSucesso:number,mensagem:string,apostador:ApostadorInterface}