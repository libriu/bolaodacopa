<!-- #include file ="jsonObject.class.asp" -->
<!--#include virtual="/comuns/configuracoes.asp"--> 

<%
    Response.LCID = 1046 ' Brazilian LCID (use your locale code here).

    Set conx = Server.CreateObject("ADODB.Connection")
    conx.Open ConnStrMySQL 

    sql = "select a.cod_Apostador, a.nome from Apostadores a where a.nome='Andre Muniz' and SHA2(a.senha_apostador,512) = '4e3b3c612879c77a03e1119c9dd029bd7f7a86356d2e26d9245f70990d100f653cb3773478d29e10c4f9e1fef2cb83f05b63c3171379d07d125348c35a8016ec'"

    set rs_usuario = Server.CreateObject("ADODB.Recordset")
    rs_usuario.Open sql, conx

    ' instantiate the class
    set JSON = New JSONobject

    JSON.LoadRecordset rs_usuario

    ' Response.Write rs_usuario("dataAtual")
    JSON.Write()

    ' Fechar e eliminar os objetos Recordsets 
    rs_usuario.Close
    Set rs_usuario = Nothing 
  
    ' Fechar e eliminar o objeto da conexÃ£o 
  
    conx.Close
    Set conx = Nothing   

%>