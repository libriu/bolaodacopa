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

    nome = TirarAcento(dadosLoginObj.Value("arg0"))
    senha = dadosLoginObj.Value("arg1")

    ' realiza consulta ao banco de dados

    Set conx = Server.CreateObject("ADODB.Connection")
    conx.Open ConnStrMySQL
    Set cmd = Server.CreateObject("ADODB.Command")   
    cmd.ActiveConnection = conx
    cmd.CommandType = &H0001
    cmd.Parameters.Append cmd.CreateParameter("nome", 200, &H0001, 50, nome)
    cmd.Parameters.Append cmd.CreateParameter("senha", 200, &H0001, 128, senha)
    sql = "select a.cod_Apostador, a.nome, a.Ativo, a.senha_apostador from Apostadores a where a.nome= ? and SHA2(a.senha_apostador,512) = ?"
    cmd.CommandText = sql
    set resultSet = cmd.Execute
    
    set JSON = New JSONobject
    set JSONdata = New JSONobject

    if not resultSet.Eof then

        senhaStr = resultSet("senha_apostador")

        ' instantiate the class
        set JSONarr = New JSONarray

        JSONarr.LoadRecordset resultSet

        ativo = 0        
        
        for each item in JSONarr.items
	        if isObject(item) and typeName(item) = "JSONobject" then
                JSONdata.Add "apostador", item
                ativo = cint(item.Value("Ativo"))        
	        end if        
        next
        if ativo = 1 then
            if senhaStr <> nome then 
                JSONdata.Add "indSucesso",1
                JSONdata.Add "mensagem","Login realizado com sucesso!"
            else
                JSONdata.Add "indSucesso",2
                JSONdata.Add "mensagem","Favor alterar sua senha!"
            end if
        else
            JSONdata.Add "indSucesso",0
            JSONdata.Add "mensagem","Login inativo."
        end if
    else
        JSONdata.Add "indSucesso",0
        JSONdata.Add "mensagem","Nome do Apostador ou Senha incorretos."
    end if

    JSON.Add "data", JSONdata   

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
        set JSONerro = New JSONobject
        JSONerro.Add "indSucesso",0
        JSONerro.Add "mensagem","Falha na tentativa de login: " & Err.Description
        JSON.Add "data", JSONerro
        JSON.Write()
        Response.End 
    End If
    On Error GoTo 0

%>