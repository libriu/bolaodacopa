<%


  dim mensagem
  mensagem = "No primeiro acesso você deve alterar sua senha!!!"
  if request("btnLogin") <> empty then

    'Abrindo Conexão mySQL
    
    'Abrindo Conexão mySQL - Forma usada em 2010
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Database=bolaodacopa2013;uid=bolaodacopa;pwd=Brasil;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2013
         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=mysql.bolaodacopa.unositehospedagem.com.br;Database=bolaodacopa;uid=bolaodacopa;pwd=vasco97;option=3"
         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 


    sql = "SELECT * FROM Apostadores WHERE nome = '" & request("login") & "' and senha_apostador = '" & Request("senha") & "' and Apostadores.Ativo"
   
    set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conx 

    if rs.eof then
       rs.close
       set rs = nothing
	   conx.close
	   Set conx = Nothing
       mensagem = "Nome do Apostador ou senha inválido(a)."
    else
      session("usuario") = request("login")
      rs.close
      set rs = nothing
      conx.close
      Set conx = Nothing 

      if request("login") = request("senha") then


     %>

<script language="JavaScript">
<!--
 window.location="altera_senha.asp"
//-->
</script>
<%  


      else


     %>

<script language="JavaScript">
<!--
 window.location="Cadastro.asp"
//-->
</script>
<%  

      end if
    end if
  else

     if request("btnMensagem") <> empty then
 
    'Abrindo Conexão mySQL - Forma usada em 2010
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Database=bolaodacopa2013;uid=bolaodacopa;pwd=Brasil;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2013
         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=mysql.bolaodacopa.unositehospedagem.com.br;Database=bolaodacopa;uid=bolaodacopa;pwd=vasco97;option=3"
         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 

     sql = "SELECT * FROM Apostadores WHERE nome = '" & request("login") & "' and senha_apostador = '" & Request("senha") & "' and Apostadores.Ativo"

     set rs = Server.CreateObject("ADODB.Recordset")
     rs.Open sql, conx 

     if rs.eof then
        rs.close
        set rs = nothing
 	   conx.close
 	   Set conx = Nothing
       mensagem = "Nome do Apostador ou senha inválido(a)."
     else
       session("usuario") = request("login")
       rs.close
       set rs = nothing
       conx.close
       Set conx = Nothing 




      if request("login") = request("senha") then


     %>

<script language="JavaScript">
<!--
 window.location="altera_senha.asp"
//-->
</script>
<%  


      else


     %>

<script language="JavaScript">
<!--
 window.location="Mensagens.asp"
//-->
</script>
<%  

      end if

    end if
    else

     if request("btnGerenciar") <> empty then
 
    'Abrindo Conexão mySQL - Forma usada em 2010
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Database=bolaodacopa2013;uid=bolaodacopa;pwd=Brasil;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2013
         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=mysql.bolaodacopa.unositehospedagem.com.br;Database=bolaodacopa;uid=bolaodacopa;pwd=vasco97;option=3"
         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 

     sql = "SELECT * FROM Apostadores WHERE nome = '" & request("login") & "' and senha_apostador = '" & Request("senha") & "' and Apostadores.Ativo"

     set rs = Server.CreateObject("ADODB.Recordset")
     rs.Open sql, conx 

     if rs.eof then
        rs.close
        set rs = nothing
 	   conx.close
 	   Set conx = Nothing
       mensagem = "Nome do Apostador ou senha inválido(a)."
     else
       session("usuario") = request("login")
       rs.close
       set rs = nothing
       conx.close
       Set conx = Nothing 




      if request("login") = request("senha") then


     %>

<script language="JavaScript">
<!--
 window.location="altera_senha.asp"
//-->
</script>
<%  


      else


     %>

<script language="JavaScript">
<!--
 window.location="Gerenciar_Grupos.asp"
//-->
</script>
<%  

      end if

    end if

    else

      session.abandon

    end if
    end if
  end if %>


  <script language="JavaScript">
  <!--
  function retornar() {
   window.location="../index.asp"
   }
  function buscar_senha() {
   window.location="solicita_senha.asp"
   }
  function alterar_senha() {
   window.location="altera_senha.asp"
   }
  //-->
  </script>


<html>
<head>
<title>Bolao da Copa das Confederações 2013</title>
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
<form name="formCadastro" method="post" action="index.asp">
<table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <th colspan="2" height="24">LOGIN PARA CADASTRAMENTO DE PLACARES E ENVIO DE MENSAGENS</th>
  </tr>
  <tr>
    <td><div align="left">&nbsp;Nome do Apostador</div></td>
    <td><div align="left">&nbsp;<input type="text" name="login" size="50"></div></td>
  </tr>
  <tr align="left">
    <td><div align="left">&nbsp;Senha</div></td>
    <td><div align="left">&nbsp;<input type="password" name="senha" size="20"></div></td>
  </tr>
</table>
<br>
<div align="center">
  <input type="submit" name="btnLogin" value="Atualizar Apostas" class="botao">&nbsp;&nbsp;
  <input type="submit" name="btnMensagem" value="Enviar Mensagem" class="botao">&nbsp;&nbsp;
  <input type="submit" name="btnGerenciar" value="Gerenciar Seus Grupos" class="botao">&nbsp;&nbsp;
  <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<div align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<div align="center">
  <input type="submit" name="btnLembrarSenha" value="Solicitar Senha" class="botao" onClick="buscar_senha();return false;">&nbsp;&nbsp;
  <input type="submit" name="btnAlterarSenha" value="Alterar Senha" class="botao" onClick="alterar_senha();return false;">
</div>
</div>
</form>
<p>&nbsp;</p>
</body>
</html>
