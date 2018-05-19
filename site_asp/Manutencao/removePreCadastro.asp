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



  if DateAdd("h", FusoHorario, now) >= cdate(DataInicioCopaFormatado) then
    response.write ("Período ativiação de cadastrado já ultrapassado!!!<br>")
    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")
  else

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






<script language="JavaScript">
<!--
function retornar() {
 window.location="../index.asp"
 }
//-->
</script>

<%

 if Session("manut") = empty then
    response.write ("Usuário não autorizado!!!<br>")
    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")
 else 

    Set conx = Server.CreateObject("ADODB.Connection")
    conx.Open ConnStrMySQL 

	
    sql = "Select * from Apostadores where nome = '" & session("usuario") & "'"

    set rs_usuario = Server.CreateObject("ADODB.Recordset")

    rs_usuario.Open sql, conx 


    if request("btnIncluir") <> empty then
 
       todo_check = split(request("check"),",")

       qtde = 0

       if rs_usuario("acesso_gestao_total") = 0 then

          usuario_responsavel = rs_usuario("nome")

       else


          sql = "Select * from Apostadores where cod_Apostador = " & request("cmbAtualizar")

          set rs2 = Server.CreateObject("ADODB.Recordset")

          rs2.Open sql, conx 

          usuario_responsavel = rs2("nome")

          rs2.Close 
          Set rs2 = Nothing


       end if

       strResultado = ""
       erroemail = 0

       set rs3 = Server.CreateObject("ADODB.Recordset")

       for contador = lbound(todo_check) to ubound(todo_check)


          if request("contato_" & trim(todo_check(contador))) = "" then
            sql = "UPDATE Apostadores set Ativo = 1, Pago = 1, controle_inclusao = '" & usuario_responsavel & "' WHERE cod_Apostador = " & todo_check(contador)
          else
            sql = "UPDATE Apostadores set Ativo = 1, Pago = 1, controle_inclusao = '" & usuario_responsavel & "', contato = '" & request("contato_" & trim(todo_check(contador))) & "' WHERE cod_Apostador = " & todo_check(contador)
          end if

          conx.execute(sql)

         qtde = qtde + 1

         sql = "Select * from Apostadores where cod_Apostador = " & todo_check(contador)

         rs3.Open sql, conx 

         strResultado = EnviaEmail("Bolao da Copa do Mundo 2018", "bolaodacopa2018.online@gmail.com", rs3("nome"), rs3("email"), "", "", "TEXTO", "Bolao da Copa do Mundo 2018 - Ativação de Usuário", "Usuário do bolão ativado. Usuario: " & rs3("nome") & " - Senha: " & rs3("senha_apostador") & " - www.bolaodacopa2018.online")

         if strResultado = "OK" then   
           strResultado = ""
         else
           erroemail = 1
         end if

         rs3.Close 
 
       next 

         Set rs3 = Nothing

       Mensagem = qtde & " apostador(es) ativado(s) com sucesso sob a responsabilidade de " & usuario_responsavel 

       if erroemail = 1 then
         Mensagem = Mensagem & " - Não foi possível enviar algum(ns) email(s) de confirmação"
       end if

    end if


%>


<html>
<head>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title><%=TituloPagina%> - Inclusão de Apostadores</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">


<div class="mensagem">
  <% response.write Mensagem & "<BR>" %>
</div>
<BR>

<form name="formInclusao" method="post" action="administracao.asp">
  <table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr>
      <th colspan="7" height="24">ATIVACAO DE APOSTADORES | <%= day(DateAdd("h", FusoHorario, now)) & "/" & month(DateAdd("h",  FusoHorario, now)) & "/" & year(DateAdd("h",  FusoHorario, now)) & " - " & hour(DateAdd("h",  FusoHorario, now)) & ":" & minute(DateAdd("h",  FusoHorario, now)) & ":" & second(DateAdd("h",  FusoHorario, now)) %>
      </th>
    </tr>
    <tr>
      <th colspan="2" >USUÁRIO LOGADO :
      </th>
      <th colspan="5" align="left"><%=rs_usuario("nome")%>
      </th>
    </tr>
    <tr>
      <th colspan="2" >USUÁRIO RESPONSÁVEL PELO FINANCEIRO:
      </th>

      <th colspan="5" align="left">


<% 
  
  if rs_usuario("acesso_gestao_total") = 0 then

%>

    <%=rs_usuario("nome")%>

<%

  else 

%>

    <select name="cmbAtualizar">


<%

  sql = "Select * from Apostadores where acesso_ativacao = 1 order by nome"

  set rs1 = Server.CreateObject("ADODB.Recordset")

  rs1.Open sql, conx 

  While not rs1.EOF

 %>
     <option value="<%= rs1("cod_Apostador")%>" 

<%
     if rs_usuario("nome") = rs1("nome") then
       response.write " selected>"
     else
       response.write ">"
     end if
     response.write (rs1("nome") & "</option>")


     rs1.MoveNext



  wend
 

  rs1.Close 
  Set rs1 = Nothing

%> 

  </select>


<%

  end if

%>


      </th>

    </tr>


  </table>

<br>
<br>




<table width="50%" border="0" cellspacing="2" cellpadding="2" align="center" class="Bolao">
  <tr>
    <th colspan="70">APOSTADORES PRE-CADASTRADOS - SELECIONE OS QUE DEVEM SER ATIVADOS SOB RESPONSABILIDADE DO USUÁRIO ACIMA</th>
  </tr>
  <tr>
    <td class="Titulo" width="10%">Selecione</td>
    <td class="Titulo" width="20%">Nome</td>
    <td class="Titulo" width="20%">Contato</td>
   </tr>
  <%
     intLinha = 0

     sql =		 "   SELECT * FROM Apostadores"
	 sql = sql & "	  WHERE Apostadores.Ativo = 0"
	 sql = sql & " ORDER BY Apostadores.nome"


     set rs = Server.CreateObject("ADODB.Recordset")

     rs.Open sql, conx 

     while not rs.eof
		
                intLinha = intLinha + 1  
                
	if intLinha mod 2 = 0 then
%>			<tr class="LinhaPar">
<%	else %>
			<tr class="LinhaImpar">
<%	end if %>

		<td width="10%"> <input type="checkbox" name="check" value="<%=rs("cod_Apostador")%>"> </td>

       <td  width="20%"><%= rs("nome") %></td>
       <td  width="20%">
           <input type="text" name="contato_<%=rs("cod_Apostador")%>" maxlength="50" size="50" value="<%=rs("contato")%>">&nbsp;&nbsp;&nbsp; 
       </td>

<%
       rs.MoveNext
    wend
%>
</table>


<%
  
  ' Fechar os objetos Recordsets 
  rs.Close
  rs_usuario.Close
   
  ' Eliminar os objetos Recordsets 
  Set rs = Nothing 
  Set rs_usuario = Nothing 
  ' Fechar o objeto da conexÃ£o 
  conx.Close 
 
 ' Eliminar o objeto da conexÃ£o 
  Set conx = Nothing 

%>

<br>
  <div align="center">
    <input type="submit" name="btnIncluir" value="Atualizar" class="botao">&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">
  </div>
<p>&nbsp;</p>


</form>

</body>
</html>
<%
	
end if

%>
<% end if %>