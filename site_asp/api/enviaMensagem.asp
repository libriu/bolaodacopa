<!-- #include file ="jsonObject.class.asp" -->

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
    set dadosEnviaMensagemObj = JSON.Parse(jsonString)

    codApostador = dadosEnviaMensagemObj.Value("arg0")
    senha = dadosEnviaMensagemObj.Value("arg1")
    mensagem = dadosEnviaMensagemObj.Value("mensagem")

    ' realiza consulta ao banco de dados
    ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=50.62.209.75;Database=bolaodacopa2018;uid=bolaodacopa;pwd=Brasil2018;option=3"

    Set conx = Server.CreateObject("ADODB.Connection")
    conx.Open ConnStrMySQL

    ' primeira validação: usuário e senha devem estar corretos

    Set cmd = Server.CreateObject("ADODB.Command")   
    cmd.ActiveConnection = conx
    cmd.CommandType = &H0001
    cmd.Parameters.Append cmd.CreateParameter("codApostador", 3, &H0001, 20, codApostador)
    cmd.Parameters.Append cmd.CreateParameter("senha", 200, &H0001, 128, senha)
    sql = "SELECT a.Ativo FROM Apostadores a WHERE a.cod_Apostador=? and SHA2(a.senha_apostador,512)=?"
    cmd.CommandText = sql
    set resultSet = cmd.Execute

    set JSONdata = New JSONobject
    set JSON = New JSONobject

    if not resultSet.Eof then
        
        ' segunda validação: usuário deve estar ativo  
        ativo = resultSet("Ativo")

        if ativo = 0 then
            JSONdata.Add "indSucesso",0
            JSONdata.Add "mensagem","Login inativo."
        else

            ' agora faz a inserção da mensagem

            Set cmd = Nothing
            Set cmd = Server.CreateObject("ADODB.Command")   
            cmd.ActiveConnection = conx
            cmd.CommandType = &H0001
            cmd.Parameters.Append cmd.CreateParameter("codApostador", 3, &H0001, 20, codApostador)
            cmd.Parameters.Append cmd.CreateParameter("mensagem", 200, &H0001, 2000, mensagem)            
            sql = "insert into Mensagens select ? as cod_Apostador, max(cod_Mensagem)+1 as cod_Mensagem, DATE_FORMAT(date_add(CURRENT_TIMESTAMP(),INTERVAL 4 hour),'%d/%m/%Y') as data_msg, DATE_FORMAT(date_add(CURRENT_TIMESTAMP(),INTERVAL 4 hour), '%H:%i:%s') as hora_msg, ? as mensagem from Mensagens"
            cmd.CommandText = sql
            ra = 0
            set resultSet = cmd.Execute(ra)

            If Err.Number <> 0 Then
                JSONdata.Add "indSucesso",0
                JSONdata.Add "mensagem","Falha ao enviar mensagem: " & Err.Description
            elseif ra > 0 then
                JSONdata.Add "indSucesso",1
                JSONdata.Add "mensagem","Mensagem enviada com sucesso!"
            else
                JSONdata.Add "indSucesso",0
                JSONdata.Add "mensagem","Não foi possível enviar mensagem."
            End If                

        end if            

    else
        JSONdata.Add "indSucesso",0
        JSONdata.Add "mensagem","Nome do Apostador ou Senha incorretos."
    end if

    JSON.Add "data", JSONdata   
    JSON.Write()
    
    ' Fechar e eliminar os objetos Recordsets 
    ' resultSet.Close não precisa, se der close dá erro.
    Set resultSet = Nothing 
    
    ' Fechar e eliminar o objeto da conexão
    Set cmd = Nothing
    conx.Close
    Set conx = Nothing

    If Err.Number <> 0 Then
        set JSON = New JSONobject
        set JSONerro = New JSONobject
        JSONerro.Add "indSucesso",0
        JSONerro.Add "mensagem","Falha ao enviar mensagem: " & Err.Description
        JSON.Add "data", JSONerro
        JSON.Write()
        Response.End 
    End If
    On Error GoTo 0

%>