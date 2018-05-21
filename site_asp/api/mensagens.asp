<!-- #include file ="jsonObject.class.asp" -->
<!--#include virtual="/comuns/configuracoes.asp"--> 

<%
    Response.LCID = 1046 ' Brazilian LCID (use your locale code here).

    ' On Error Resume Next

    ' numero da pagina
    dim pagina
    pagina = 1
    ' pagina = request("pagina")
    if request("pagina") <> empty and request("pagina") > 0 then
        pagina = request("pagina")
    end if

    ' Response.Write pagina & "<br>"

    ' offSet em relação ao primeiro registro
    dim offset
    offset = 0
    offSet = ( cint(pagina) - 1 ) * 20

    ' Response.Write offSet & "<br>"

    Set conx = Server.CreateObject("ADODB.Connection")
    conx.Open ConnStrMySQL
    Set cmd = Server.CreateObject("ADODB.Command")   
    cmd.ActiveConnection = conx
    cmd.CommandType = &H0001
    cmd.Parameters.Append cmd.CreateParameter("offset", 3, &H0001, 4, offSet)
    sql = "SELECT m.data_msg,m.hora_msg,a.nome,m.mensagem FROM Mensagens m, Apostadores a WHERE a.cod_Apostador = m.cod_Apostador ORDER BY m.cod_Mensagem DESC LIMIT ? , 20"
    cmd.CommandText = sql
    set resultSet = cmd.Execute
    
    ' instantiate the class
    set JSONarr = New JSONarray

    JSONarr.LoadRecordset resultSet

    set JSON = New JSONobject
    
    JSON.Add "data", JSONarr

    JSON.Write()

    ' Fechar e eliminar os objetos Recordsets 
    resultSet.Close
    Set resultSet = Nothing 
  
    ' Fechar e eliminar o objeto da conexÃƒÂ£o 
    Set cmd = Nothing
    conx.Close
    Set conx = Nothing

    ' If Err.Number <> 0 Then
    '    Response.Write (Err.Description)   
    '    Response.End 
    ' End If
    ' On Error GoTo 0

%>