<!-- #include file ="jsonObject.class.asp" -->
<!--#include virtual="/comuns/configuracoes.asp"--> 

<%
    Response.LCID = 1046 ' Brazilian LCID (use your locale code here).

    On Error Resume Next

    ' fun��o para converter array de bytes em string
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

    ' realizando leitura do body da requisi��o post
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
    set dadosAlteraSenhaObj = JSON.Parse(jsonString)

    nome = TirarAcento(dadosAlteraSenhaObj.Value("arg0"))
    senhaAtual = dadosAlteraSenhaObj.Value("arg1")
    novaSenha = TirarAcento(dadosAlteraSenhaObj.Value("arg2"))

    ' realiza consulta ao banco de dados

    Set conx = Server.CreateObject("ADODB.Connection")
    conx.Open ConnStrMySQL
    Set cmd = Server.CreateObject("ADODB.Command")   
    cmd.ActiveConnection = conx
    cmd.CommandType = &H0001
    cmd.Parameters.Append cmd.CreateParameter("nome", 200, &H0001, 50, nome)
    cmd.Parameters.Append cmd.CreateParameter("senhaAtual", 200, &H0001, 128, senhaAtual)

    sql = "select a.cod_Apostador, a.nome, a.Ativo from Apostadores a where a.nome= ? and SHA2(a.senha_apostador,512) = ?"

    cmd.CommandText = sql
    set resultSet = cmd.Execute
    
    set JSON = New JSONobject
    set JSONdata = New JSONobject

    if not resultSet.Eof then

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
        
        resultSet.Close

        if ativo = 1 then

            Set cmd = Nothing
            Set cmd = Server.CreateObject("ADODB.Command")   
            cmd.ActiveConnection = conx
            cmd.CommandType = &H0001
            cmd.Parameters.Append cmd.CreateParameter("novaSenha", 200, &H0001, 128, novaSenha)
            cmd.Parameters.Append cmd.CreateParameter("nome", 200, &H0001, 50, nome)        
            sql = "update Apostadores a set a.senha_apostador = ? where a.nome= ?"
            cmd.CommandText = sql
            ra = 0
            set resultSet = cmd.Execute(ra)

            If Err.Number <> 0 Then
                JSONdata.Add "indSucesso",0
                JSONdata.Add "mensagem","Falha ao alterar senha: " & Err.Description
            elseif ra > 0 then
                JSONdata.Add "indSucesso",1
                JSONdata.Add "mensagem","Senha alterada com sucesso!"
            else
                JSONdata.Add "indSucesso",0
                JSONdata.Add "mensagem","Nao foi possivel alterar a senha."
            End If

        else
            JSONdata.Add "indSucesso",0
            JSONdata.Add "mensagem","Login inativo."
        end if
        
    else
        JSONdata.Add "indSucesso",0
        JSONdata.Add "mensagem","Nome do Apostador ou Senha incorretos."
        resultSet.Close
    end if

    JSON.Add "data", JSONdata   

    JSON.Write()

    ' Fechar e eliminar os objetos Recordsets 
    ' resultSet.Close
    Set resultSet = Nothing 
  
    ' Fechar e eliminar o objeto da conex�o
    Set cmd = Nothing
    conx.Close
    Set conx = Nothing

    If Err.Number <> 0 Then
        set JSON = New JSONobject
        set JSONerro = New JSONobject
        JSONerro.Add "indSucesso",0
        JSONerro.Add "mensagem","Falha na tentativa de alterar senha: " & Err.Description
        JSON.Add "data", JSONerro
        JSON.Write()
        Response.End 
    End If
    On Error GoTo 0

%>