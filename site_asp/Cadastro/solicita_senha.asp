<%

   FusoHorario = 4
   FormatoData = "Americano"
   TituloPagina = "Bolão da Copa do Mundo 2018"
   DataInicioCopa = "14/06/2018"


   if FormatoData = "Americano" then
     DataInicioCopaFormatado = Mid(DataInicioCopa,4,2) & "/" & left(DataInicioCopa,2) & "/" & mid(DataInicioCopa,7,4)
   else
     DataInicioCopaFormatado = DataInicioCopa
   end if



    'Abrindo Conexão mySQL - Forma usada em 2010
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Database=bolaodacopa2013;uid=bolaodacopa;pwd=Brasil;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2013
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=mysql.bolaodacopa.unositehospedagem.com.br;Database=bolaodacopa;uid=bolaodacopa;pwd=vasco97;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2018
         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=50.62.209.75;Database=bolaodacopa2018;uid=bolaodacopa;pwd=Brasil2018;option=3"


%>




<%

'Contem o SMTP padrao para o Envio de Emails
Const strSMTP = "smtp.gmail.com"

'Contem o Componente que é utilizado para o envio de emails:
'    - "ASPMAIL" 
'    - "ASPEMAIL"
'    - "CDONTS"
'    - "CDOSYS"
Const strComponenteEmail = "CDOSYS"
%>

<%
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
    On Error Resume Next
    
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
%>







<%

  dim mensagem
  mensagem = ""
  if request("btnLogin") <> empty then

         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 

	
	sql = "SELECT * FROM Apostadores WHERE nome = '" & request("login") & "' and Apostadores.Ativo"	

	set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open sql, conx     
	
    if rs.eof then
      mensagem = "Nome do Apostador inválido."
    else
      if rs("email") = "." then
        mensagem = "Apostador sem e-mail cadastrado. Entre em contato com o administrador."
      else

       Dim strResultado
       strResultado = EnviaEmail("Bolao da Copa do Mundo 2018", "bolaodacopa2018.online@gmail.com", request("login"), rs("email"), "", "", "TEXTO", "Bolao da Copa do Mundo 2018 - Senha", request("login") & ", sua senha é " & rs("senha_apostador"))


'        Dim msg
'        Set msg = Server.CreateObject("CDONTS.NewMail")
'        msg.From = "piures@uol.com.br"
'        msg.To = rs("email")
'        msg.Subject = "Senha - Bolão Copa do Mundo no Brasil 2014"
'        msg.Body = request("login") & ", sua senha é " & rs("senha_apostador")
'        msg.Send
'        Set msg = Nothing

         if strResultado =  "OK" then   
            mensagem = "Senha enviada com sucesso para " & rs("email")
        else
            mensagem = "O envio da senha não deu certo. Favor enviar esta mensagem ao administrador " & strResultado
        end if
      end if
    end if
    rs.close
    set rs = nothing
    conx.close
	Set conx = Nothing
'  else
 '   session.abandon
  end if %>
<script language="JavaScript">
<!--
function retornar() {
 window.location="index.asp"
 }
//-->
</script>
<html>
<head>
<title><%=TituloPagina%> - Solicitação de Senha</title>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">

<table width="80%" align="center">
<tr> 
<%
     if DateAdd("h", FusoHorario, now) >= DateAdd("d",-1,DataInicioCopaFormatado) then

%>

<td width="30%" aling="lef"><center><img src="../imagens/logo_copa.jpg" width="80" height="80"></center></td>

<%   else %>


<td width="15%" aling="lef"><center><a href="precadastro.asp"><img src="../imagens/preinscricao.gif" width="80" height="50"></a></center></td>
<td width="15%" aling="lef"><center><img src="../imagens/logo_copa.jpg" width="80" height="80"></center></td>

<% end if %>


<td width="40%" aling="center"><center><img src="../imagens/logo.jpg" width="328" height="80"></center></td>
<td width="15%" aling="right"><center>&nbsp;<a href="../index.asp"><img src="../imagens/Ranking_Principal_link.jpg"></a><br></center>
<center>&nbsp;<a href="../rankingacertos.asp"><img src="../imagens/Ranking_Acertos_link.jpg"></a><br></center>
<center>&nbsp;<a href="../rankingGrupos.asp"><img src="../imagens/Ranking_Grupos_link.jpg"></a></center></td>
<td width="15%" aling="right"><center>&nbsp;<a href="../cadastro"><img src="../imagens/aposta.gif"></a><br></center>
<center>&nbsp;<a href="../regras.asp"><img src="../imagens/regras.jpg"></a><br></center>
<center>&nbsp;<a href="../estatistica.asp"><img src="../imagens/estatisticas.jpg"></a></center></td>
</tr>
</table>

<br>
<div class="mensagem"><%=mensagem%>
</div>
<br>
<form name="formCadastro" method="post" action="solicita_senha.asp">
<table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <th colspan="2" height="24">SOLICITAÇÃO DE SENHA | <%= day(DateAdd("h", FusoHorario, now)) & "/" & month(DateAdd("h",  FusoHorario, now)) & "/" & year(DateAdd("h",  FusoHorario, now)) & " - " & hour(DateAdd("h",  FusoHorario, now)) & ":" & minute(DateAdd("h",  FusoHorario, now)) & ":" & second(DateAdd("h",  FusoHorario, now)) %></th>
  </tr>
  <tr>
    <td><div align="left">&nbsp;Nome do Apostador</div></td>
    <td><div align="left">&nbsp;<input type="text" name="login" size="50"></div></td>
  </tr>
</table>
<br>
<div align="center">
  <input type="submit" name="btnLogin" value="Solicitar" class="botao">&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">
</div>
</form>
<p>&nbsp;</p>
<div align="center" class="texto">Se você esqueceu a sua senha, solicite por meio desta página que ela será enviada para o e-mail cadastrado.</div>
</body>
</html>
