<%
  dim mensagem
  mensagem = ""
  if request("btnLogin") <> empty then

    if Request("senha") <> empty then
      if Request("senha") = "Sou mais Brasil" then
        session("manut") = "Sou mais Brasil"
     %>
<script language="JavaScript">
<!--
 window.location="administracao.asp"
//-->
</script>
<%    else
        mensagem = "Senha de acesso a manutenção invalida"
      end if
    end if
  end if %>
<html>
<head>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title>Bolao da Copa das Confederações 2013</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<p align="center"><img src="../Imagens/logo.jpg" width="328" height="80"></p>
<div class="mensagem"><%=mensagem%>
</div>
<form name="formCadastro" method="post" action="index.asp">
<table class="Bolao" width="50%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <th colspan="2" height="24">LOGIN PARA ADMINISTRAÇÃO</th>
  </tr>
  <tr align="left">
    <td><div align="left">&nbsp;Senha</div></td>
    <td><div align="left">&nbsp;<input type="password" name="senha" size="20"></div></td>
  </tr>
</table>
<br>
<div align="center">
  <input type="submit" name="btnLogin" value="OK" class="botao">&nbsp;&nbsp;&nbsp;&nbsp;
</div>
</form>
<p>&nbsp;</p>
</body>
</html>
