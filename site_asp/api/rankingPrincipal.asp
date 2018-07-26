<!-- #include file ="jsonObject.class.asp" -->
<!--#include virtual="/comuns/configuracoes.asp"--> 

<%
    Response.LCID = 1046 ' Brazilian LCID (use your locale code here).

    On Error Resume Next

    Set conx = Server.CreateObject("ADODB.Connection")
    conx.Open ConnStrMySQL 

    sql = "SELECT 0 as posicao, Apostadores.nome, Apostas.Total_Pontos pontuacao,Apostadores.cod_Apostador codApostador FROM Apostadores, Apostas WHERE Apostadores.cod_Apostador = Apostas.cod_Apostador and Apostadores.Ativo ORDER BY Apostas.Total_Pontos DESC, Apostadores.nome, Apostadores.cod_Apostador"

    set resultSet = Server.CreateObject("ADODB.Recordset")
    
    resultSet.Open sql, conx

    ' instantiate the class
    set JSONarr = New JSONarray

    JSONarr.LoadRecordset resultSet
    
    intLinha = 0

    intPosicao = 0

    intTotalPontosJogadorAcima = 0

    intPontuacao = 0

    ' JSONarr.Write()

    for each item in JSONarr.items

        intLinha = intLinha + 1  

        if isObject(item) and typeName(item) = "JSONobject" then
            
            intPontuacao = cint(item.Value("pontuacao"))

            if intPontuacao = 0 OR intPontuacao <> intTotalPontosJogadorAcima then

                intPosicao = intLinha

            end if

            item.Change "posicao", intPosicao

            intTotalPontosJogadorAcima = intPontuacao

        end if

    next

    set JSON = New JSONobject
    
    JSON.Add "data", JSONarr

    JSON.Write()

    ' Fechar e eliminar os objetos Recordsets 
    resultSet.Close
    Set resultSet = Nothing 
  
    ' Fechar e eliminar o objeto da conexÃ£o 
  
    conx.Close
    Set conx = Nothing   

%>