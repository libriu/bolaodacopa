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
    set dadosAtualizaObj = JSON.Parse(jsonString)

    codApostador = dadosAtualizaObj.Value("arg0")
    senha = dadosAtualizaObj.Value("arg1")
    cod_jogo = dadosAtualizaObj.Value("cod_jogo")
    placar_A = dadosAtualizaObj.Value("placar_A")
    placar_B = dadosAtualizaObj.Value("placar_B")

    ' realiza consulta ao banco de dados

    Set conx = Server.CreateObject("ADODB.Connection")
    conx.Open ConnStrMySQL

    ' primeira validação: deve estar no prazo para aposta

    Set cmd = Server.CreateObject("ADODB.Command")   
    cmd.ActiveConnection = conx
    cmd.CommandType = &H0001
    cmd.Parameters.Append cmd.CreateParameter("cod_jogo", 3, &H0001, 11, cod_jogo)
    sql = "select 1 from Resultados r where cod_Jogo = ? and datediff(STR_TO_DATE(data_jogo, '%d/%m/%Y'),date_add(CURRENT_TIMESTAMP(),INTERVAL 4 hour)) > 0"
    cmd.CommandText = sql
    set resultSet = cmd.Execute

    set JSONdata = New JSONobject
    set JSON = New JSONobject

    if not resultSet.Eof then

        ' segunda validação: usuário e senha devem estar corretos
        Set cmd = Nothing
        Set cmd = Server.CreateObject("ADODB.Command")   
        cmd.ActiveConnection = conx
        cmd.CommandType = &H0001
        cmd.Parameters.Append cmd.CreateParameter("codApostador", 3, &H0001, 20, codApostador)
        cmd.Parameters.Append cmd.CreateParameter("senha", 200, &H0001, 128, senha)
        sql = "SELECT a.Ativo FROM Apostadores a WHERE a.cod_Apostador=? and SHA2(a.senha_apostador,512)=?"
        cmd.CommandText = sql
        set resultSet = cmd.Execute

        if not resultSet.Eof then
            
            ' terceira validação: usuário deve estar ativo  
            ativo = resultSet("Ativo")

            if ativo = 0 then
                JSONdata.Add "indSucesso",0
                JSONdata.Add "mensagem","Login inativo."
            else

                ' agora faz a inserção/atualização da aposta

                Set cmd = Nothing
                Set cmd = Server.CreateObject("ADODB.Command")   
                cmd.ActiveConnection = conx
                cmd.CommandType = &H0001
                cmd.Parameters.Append cmd.CreateParameter("codApostador", 3, &H0001, 20, codApostador)
                cmd.Parameters.Append cmd.CreateParameter("cod_jogo", 3, &H0001, 11, cod_jogo)
                cmd.Parameters.Append cmd.CreateParameter("placar_A", 3, &H0001, 11, placar_A)
                cmd.Parameters.Append cmd.CreateParameter("placar_B", 3, &H0001, 11, placar_B)
                cmd.Parameters.Append cmd.CreateParameter("placar_Aa", 3, &H0001, 11, placar_A)
                cmd.Parameters.Append cmd.CreateParameter("placar_Bb", 3, &H0001, 11, placar_B)
                sql = "INSERT INTO Jogos(cod_Aposta,cod_jogo,placar_A,placar_B) VALUES (?,?,?,?) ON DUPLICATE KEY UPDATE placar_A=?,placar_B=?"
                cmd.CommandText = sql
                ra = 0
                set resultSet = cmd.Execute(ra)

                If Err.Number <> 0 Then
                    JSONdata.Add "indSucesso",0
                    JSONdata.Add "mensagem","Falha ao atualizar aposta: " & Err.Description
                elseif ra > 0 then
                    JSONdata.Add "indSucesso",1
                    JSONdata.Add "mensagem","Aposta realizada com sucesso!"
                else
                    JSONdata.Add "indSucesso",0
                    JSONdata.Add "mensagem","Nao foi possivel atualizar aposta."
                End If                

            end if            

        else
            JSONdata.Add "indSucesso",0
            JSONdata.Add "mensagem","Nome do Apostador ou Senha incorretos."
        end if

    else
        JSONdata.Add "indSucesso",0
        JSONdata.Add "mensagem","Prazo expirado para aposta neste jogo."
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
        JSONerro.Add "mensagem","Falha ao atualizar aposta: " & Err.Description
        JSON.Add "data", JSONerro
        JSON.Write()
        Response.End 
    End If
    On Error GoTo 0

%>