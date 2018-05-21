<!-- #include file ="jsonObject.class.asp" -->
<!--#include virtual="/comuns/configuracoes.asp"--> 

<%
    Response.LCID = 1046 ' Brazilian LCID (use your locale code here).

    On Error Resume Next

    ' função para converter array de bytes em string
    Function BytesToStr(bytes)
        Dim Stream
        Set Stream = Server.CreateObject("Adodb.Stream")
        With Stream
            .Type = 1 'adTypeBinary
            .Open
            .Write bytes
            .Position = 0
            .Type = 2 'adTypeText
            .Charset = "UTF-8"
            BytesToStr = .ReadText
            Stream.Close
        End With
        Set Stream = Nothing
    End Function

    ' realizando leitura do body da requisição post
    lngBytesCount = 0
    jsonString = ""

    If Request.TotalBytes > 0 Then
        lngBytesCount = Request.TotalBytes
        jsonString = BytesToStr(Request.BinaryRead(lngBytesCount))
    else
        jsonString = request("json")
    end if

    ' Response.Write jsonString & "<br>"

    ' Fazendo parse da string json para objeto json
    set JSON = New JSONobject
    set dadosLoginObj = JSON.Parse(jsonString)

    codApostador = dadosLoginObj.Value("arg0")
    senha = dadosLoginObj.Value("arg1")

    ' realiza consulta ao banco de dados
    Set conx = Server.CreateObject("ADODB.Connection")
    conx.Open ConnStrMySQL
    Set cmd = Server.CreateObject("ADODB.Command")   
    cmd.ActiveConnection = conx
    cmd.CommandType = &H0001
    cmd.Parameters.Append cmd.CreateParameter("codApostador", 3, &H0001, 20, codApostador)
    cmd.Parameters.Append cmd.CreateParameter("senha", 200, &H0001, 128, senha)
    sql = "SELECT j.* FROM Apostadores a, Jogos j WHERE a.cod_Apostador=? and SHA2(a.senha_apostador,512)=? and j.cod_Aposta=a.cod_Apostador"
    cmd.CommandText = sql
    set resultSet = cmd.Execute
    
    set JSON = New JSONobject
    set JSONarr = New JSONarray

    JSONarr.LoadRecordset resultSet    

    JSON.Add "data", JSONarr   

    JSON.Write()

    ' Fechar e eliminar os objetos Recordsets 
    resultSet.Close
    Set resultSet = Nothing 
  
    ' Fechar e eliminar o objeto da conexÃƒÂ£o 
    Set cmd = Nothing
    conx.Close
    Set conx = Nothing

    If Err.Number <> 0 Then
        set JSON = New JSONobject
        set JSONarr = New JSONarray        
        JSON.Add "data", JSONarr   
        JSON.Write()
        Response.End 
    End If
    On Error GoTo 0

%>