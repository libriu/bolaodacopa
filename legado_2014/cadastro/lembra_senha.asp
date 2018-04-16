<%
  dim mensagem
  mensagem = ""
  if request("btnLogin") <> empty then

    if request("login") = "" then 
       mensagem = "Favor informar o Nome do Apostador."
    else
       if request("lembrete") = "" then
          mensagem = "Favor informar o Código para Recuperação de Senha."
       else
    'Abrindo Conexão mySQL - Forma usada em 2010
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Database=bolaodacopa2013;uid=bolaodacopa;pwd=Brasil;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2013
         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=mysql.bolaodacopa.unositehospedagem.com.br;Database=bolaodacopa;uid=bolaodacopa;pwd=vasco97;option=3"
         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 

          
		  sql = "SELECT * FROM Apostadores WHERE nome = '" & request("login") & "';"
          
		  'set rs = conx.execute(sql)
          set rs = Server.CreateObject("ADODB.Recordset")
		  rs.Open sql, conx
		  
		  if rs.eof then
             mensagem = "Nome do Apostador inválido."
          else
             if rs("cod_acesso") <> request("lembrete") then
                mensagem = "Código para recuperação de senha não confere. Informe o Código correto ou entre em contato com o administrador."
             else
                mensagem = "Sua senha é : " & rs("senha_apostador")
             end if
          end if 
          rs.close
          set rs = nothing   
          conx.close
		  set conx = nothing   
       end if
    end if
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
<title>Bolao da Copa do Mundo no Brasil 2014 - Solicitação de Senha</title>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">


<table width="80%" align="center">
<tr> 
<td width="20%" aling="lef"><center><img src="../Imagens/logo_copa.jpg" width="80" height="80"></center></td>
<td width="60%" aling="center"><center><img src="../Imagens/logo.jpg" width="328" height="80"></center></td>
<td width="20%" aling="right"><center>&nbsp;</center></td>
</tr>
</table>


<div class="mensagem"><%=mensagem%>
</div>
<form name="formCadastro" method="post" action="lembra_senha.asp">
<table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <th colspan="2" height="24">SOLICITAÇÃO DE SENHA | <%= day(now()) & "/" & month(now()) & "/" & year(now()) & " - " & time() %></th>
  </tr>
  <tr>
    <td><div align="left">&nbsp;Nome do Apostador</div></td>
    <td><div align="left">&nbsp;<input type="text" name="login" size="50"></div></td>
  </tr>
  <tr>    
  <td><div align="left">&nbsp;Código para recuperação de Senha</div></td>
    <td><div align="left">&nbsp;<input type="text" name="lembrete" size="50"></div></td>
  </tr>
</table>
<br>
<div align="center">
  <input type="submit" name="btnLogin" value="Solicitar" class="botao">&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">
</div>
</form>
<p>&nbsp;</p>
<div align="center" class="texto">Se você esqueceu a sua senha, solicite por meio desta página utilizando o código para recuperação de senha gerado pelo administrador.</div>
</body>
</html>
