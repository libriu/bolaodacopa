<!-- #include file ="jsonObject.class.asp" -->
<!--#include virtual="/comuns/configuracoes.asp"--> 

<%
    Response.LCID = 1046 ' Brazilian LCID (use your locale code here).

    On Error Resume Next

'Contem o SMTP padrao para o Envio de Emails
Const strSMTP = "smtp.gmail.com"

'Contem o Componente que é utilizado para o envio de emails:
'    - "ASPMAIL" 
'    - "ASPEMAIL"
'    - "CDONTS"
'    - "CDOSYS"
Const strComponenteEmail = "CDOSYS"

'-----------------------------------------------------
'Funcao: EnviaEmail(p_strNomeFROM, p_strEmailFROM, p_strNomeTO, p_strEmailTO, p_strEmailCC, p_strEmailBCC, p_strTipoEmail, p_strAssuntoEmail, p_strMensagem)
'Sinopse: Envia um email utilizando o componente configurado
'Parametros:
'            p_strNomeFROM          : Contem o Nome do Remetente
'            p_strEmailFROM         : Contem o Email do Remetente
'            p_strNomeTO            : Contem o Nome do Destinatario
'            p_strEmailTO           : Contem o Email ou Emails de quem vai receber a mensagem
'            p_strEmailCC           : Contem o Email ou Emails de quem vai receber a copia da mensagem
'            p_strEmailBCC          : Contem o Email ou Emails de quem vai receber a copia oculta da mensagem
'            p_strTipoEmail         : Tipo de Mensagem que sera enviada ("HTML" ou "TEXTO")
'            p_strAssuntoEmail      : Contem o Assunto do Email
'            p_strMensagem          : Mensagem do Email
'Retorno: String ("OK" quando for executada com sucesso)
'Autor: Gabriel Fróes (www.codigofonte.com.br)
'-----------------------------------------------------

Function EnviaEmail(p_strNomeFROM, p_strEmailFROM, p_strNomeTO, p_strEmailTO, p_strEmailCC, p_strEmailBCC, p_strTipoEmail, p_strAssuntoEmail, p_strMensagem)

    ' *********************
    ' Utilizando o ASPMAIL
    ' *********************

    If strComponenteEmail = "ASPMAIL" Then
        'Variáveis e Objetos
        Dim objASPMail
        Set objASPMail = Server.CreateObject ("SMTPsvg.Mailer")
        objASPMail.FromName        = p_strNomeFROM
        objASPMail.FromAddress     = p_strEmailFROM
        objAspMail.RemoteHost      = strSMTP
        objAspMail.AddRecipient    p_strNomeTO, p_strEmailTO
        If Not p_strEmailCC = "" Then
            objAspMail.Addcc           "", p_strEmailCC
        End If
        If Not p_strEmailBCC = "" Then
            objAspMail.AddBcc          "", p_strEmailBCC
        End If
        objAspMail.Subject         =  p_strAssuntoEmail
        objAspMail.BodyText        = p_strMensagem
        'Verificando o tipo de mensagem (default é TEXTO)
        If p_strTipoEmail = "HTML" Then
            objAspMail.ContentType = "text/html"
        End If
        'Verifica se a mensagem foi enviada com sucesso e retorna a funcao
        If objAspMail.SendMail Then
            EnviaEmail = "OK"
        Else
            EnviaEmail = "Não foi possível enviar o email, por favor entre em contato com <a href='mailto:" & p_strEmailTO & "?subject=Erro%20ao%20enviar%20email%20pelo%20site'>" & p_strEmailTO & "</a> e escreva o erro abaixo."
        End If
        'Destruindo Objetos
        Set objAspMail = Nothing
        If Err.Number <> 0 Then
            EnviaEmail = EnviaEmail & "<br>Erro:" & Err.Description
        End If
        Exit Function
    End If 'Fim da Utilização do ASPMAIL

    ' *********************
    ' Utilizando o ASPEMAIL
    ' *********************
    If strComponenteEmail = "ASPEMAIL" Then
        'Variáveis e Objetos
        Dim objASPEMail
        Set objASPEMail = Server.CreateObject ("Persits.MailSender")
        objASPEMail.FromName        = p_strNomeFROM
        objASPEMail.From            = p_strEmailFROM
        objASPEMail.Host            = ServidorSMTP
        objASPEMail.AddAddress        p_strEmailTO, p_strNomeTO
        If Not p_strEmailCC = "" Then
            objASPEMail.AddCc           p_strEmailCC, ""
        End If
        If Not p_strEmailBCC = "" Then
            objASPEMail.AddBcc            p_strEmailBCC, ""
        End If
        objASPEMail.Subject         = p_strAssuntoEmail
        objASPEMail.Body            = p_strMensagem
        'Verificando o tipo de mensagem (default é TEXTO)
        If p_strTipoEmail = "HTML" Then
            objASPEMail.IsHTML = True
        End If
        'Verifica se a mensagem foi enviada com sucesso e retorna a funcao
        If objASPEMail.Send Then
            EnviaEmail = "OK"
        Else
            EnviaEmail = "Não foi possível enviar o email, por favor entre em contato com <a href='mailto:" & p_strEmailTO & "?subject=Erro%20ao%20enviar%20email%20pelo%20site'>" & p_strEmailTO & "</a> e escreva o erro abaixo."
        End If
        'Destruindo Objetos
        Set objASPEMail = Nothing
        If Err.Number <> 0 Then
            EnviaEmail = EnviaEmail & "<br>Erro:" & Err.Description
        End If
        Exit Function
    End If 'Fim da Utilização do ASPEMAIL

    ' *********************
    ' Utilizando o CDONTS
    ' *********************
    If strComponenteEmail = "CDONTS" Then
        'Variáveis e Objetos
        Dim objCDONTS
        Set objCDONTS = Server.CreateObject ("CDONTS.NewMail")
        objCDONTS.From        = p_strEmailFROM
        objCDONTS.To          = p_strEmailTO
        objCDONTS.CC          = p_strEmailCC
        objCDONTS.BCC         = p_strEmailBCC
        objCDONTS.Subject     = p_strAssuntoEmail
        objCDONTS.Body        = p_strMensagem
        'Verificando o tipo de mensagem (default é TEXTO)
        If p_strTipoEmail = "HTML" Then
            objCDONTS.BodyFormat = 0
            objCDONTS.MailFormat = 0
        End If
        'Verifica se a mensagem foi enviada com sucesso e retorna a funcao
        Call objCDONTS.Send
        If Err.Number = 0 Then
            EnviaEmail = "OK"
        Else
            EnviaEmail = "Não foi possível enviar o email, por favor entre em contato com <a href='mailto:" & p_strEmailTO & "?subject=Erro%20ao%20enviar%20email%20pelo%20site'>" & p_strEmailTO & "</a> e escreva o erro abaixo."
        End If
        'Destruindo Objetos
        Set objCDONTS = Nothing
        If Err.Number <> 0 Then
            EnviaEmail = EnviaEmail & "<br>Erro:" & Err.Description
        End If
        Exit Function
    End If 'Fim da Utilização do CDONTS

    ' *********************
    ' Utilizando o CDOSYS
    ' *********************
    If strComponenteEmail = "CDOSYS" Then
        Dim objCDOSYS
        Dim objCDOSYSConf
        Set objCDOSYS        = Server.CreateObject("CDO.Message") 
        Set objCDOSYSConf    = Server.CreateObject ("CDO.Configuration") 
        'Configurando o envio de e-mail
        objCDOSYSConf.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver") = strSMTP
        objCDOSYSConf.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465 
        objCDOSYSConf.Fields("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
        objCDOSYSConf.Fields("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 30 
        objCDOSYSConf.Fields("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 
        objCDOSYSConf.Fields("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = true 
        objCDOSYSConf.Fields("http://schemas.microsoft.com/cdo/configuration/sendusername") = "bolaodacopa2018.online@gmail.com" 
        objCDOSYSConf.Fields("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "Brasil2018" 
        objCDOSYSConf.Fields.update 
        Set objCDOSYS.Configuration = objCDOSYSConf 
        objCDOSYS.From        = p_strEmailFROM
        objCDOSYS.To        = p_strEmailTO
        objCDOSYS.CC        = p_strEmailCC
        objCDOSYS.BCC        = p_strEmailBCC
        objCDOSYS.Subject    = p_strAssuntoEmail
        'Verificando o tipo de mensagem (default é TEXTO)
        If p_strTipoEmail = "HTML" Then
            objCDOSYS.HTMLBody    = p_strMensagem
        Else
            objCDOSYS.TextBody    = p_strMensagem
        End If
        'Verifica se a mensagem foi enviada com sucesso e retorna a funcao
        Call objCDOSYS.Send
        If Err.Number = 0 Then
            EnviaEmail = "OK"
        Else
            EnviaEmail = "Não foi possível enviar o email, por favor entre em contato com <a href='mailto:" & p_strEmailTO & "?subject=Erro%20ao%20enviar%20email%20pelo%20site'>" & p_strEmailTO & p_strEmailFROM & "</a> e escreva o erro abaixo."
        End If
        'Destruindo Objetos
        Set objCDOSYSConf = Nothing
        Set objCDOSYS = Nothing
        If Err.Number <> 0 Then
            EnviaEmail = EnviaEmail & "<br>Erro:" & Err.Description
        End If
        Exit Function
    End If 'Fim da Utilização do CDOSYS

End Function

    ' fun??o para converter array de bytes em string
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

    ' realizando leitura do body da requisi??o post
    lngBytesCount = 0
    jsonString = ""

    If Request.TotalBytes > 0 Then
        lngBytesCount = Request.TotalBytes
        jsonString = BytesToStr(Request.BinaryRead(lngBytesCount))
    else
        jsonString = request("json")
    end if

     Response.Write jsonString & "<br>"

    ' Fazendo parse da string json para objeto json
    set JSON = New JSONobject
    set dadosRecuperaSenha = JSON.Parse(jsonString)

    nomeStr = TirarAcento(dadosRecuperaSenha.Value("arg0"))

    ' realiza consulta ao banco de dados

    Set conx = Server.CreateObject("ADODB.Connection")
    conx.Open ConnStrMySQL
    Set cmd = Server.CreateObject("ADODB.Command")   
    cmd.ActiveConnection = conx
    cmd.CommandType = &H0001
    cmd.Parameters.Append cmd.CreateParameter("nome", 200, &H0001, 50, nomeStr)
    sql = "select a.nome, a.Ativo, a.email, a.senha_apostador from Apostadores a where a.nome= ?"
    cmd.CommandText = sql
    set resultSet = cmd.Execute
    
    set JSON = New JSONobject
    set JSONdata = New JSONobject

    if not resultSet.Eof then

        ' instantiate the class
        set JSONarr = New JSONarray

        JSONarr.LoadRecordset resultSet
        
        for each item in JSONarr.items
	        if isObject(item) and typeName(item) = "JSONobject" then
                JSONdata.Add "apostador", item
                ativoInt = cint(item.Value("Ativo"))
                senhaStr = cstr(item.Value("senha_apostador"))        
                emailStr = cstr(item.Value("email"))        
	        end if        
        next

        if ativoInt = 0 then
            JSONdata.Add "indSucesso",0
            JSONdata.Add "mensagem","Login inativo." 
        else

            if emailStr = "." or emailStr = "" then
                JSONdata.Add "indSucesso",0
                JSONdata.Add "mensagem","Apostador sem e-mail cadastrado. Contate com o administrador."
        
            else

        '   Chamar o emvio do email
            
                Dim strResultado
                strResultado = EnviaEmail("Bolao da Copa do Mundo 2018", "bolaodacopa2018.online@gmail.com",nomeStr, emailStr, "", "", "TEXTO", "Bolao da Copa do Mundo 2018 - Senha", nomeStr & ", sua senha: " & senhaStr)
 
                if strResultado =  "OK" then   
                    JSONdata.Add "indSucesso",1
                    JSONdata.Add "mensagem","Senha enviada com sucesso para o email cadastrado!"

                else
                    JSONdata.Add "indSucesso",0
                    JSONdata.Add "mensagem","O envio da senha nao deu certo. Favor enviar esta mensagem ao administrador " & strResultado
        
                end if 

            end if

        end if

    else
        JSONdata.Add "indSucesso",0
        JSONdata.Add "mensagem","Nome do Apostador incorretos."
    end if

    JSON.Add "data", JSONdata   

    JSON.Write()

    ' Fechar e eliminar os objetos Recordsets 
    resultSet.Close
    Set resultSet = Nothing 
  
    ' Fechar e eliminar o objeto da conex?ƒ?£o 
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