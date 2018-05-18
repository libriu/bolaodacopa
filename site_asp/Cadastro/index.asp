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


  dim mensagem
  mensagem = "No primeiro acesso você deve alterar sua senha!!!"
  if request("btnLogin") <> empty then

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
<title><%=TituloPagina%></title>
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

<td width="15%" aling="lef"><center><a href="/app"><img src="../Imagens/app.jpg"></a></center></td>

<%   else %>


<td width="15%" aling="lef"><center>&nbsp;<a href="precadastro.asp"><img src="../Imagens/preinscricao.gif" width="100" height="45"></a><br></center>
<center>&nbsp;<a href="http://bolaodacopa2018.online/app"><img src="../Imagens/app.jpg"></a></center>
</td>


<% end if %>

<td width="15%" aling="lef"><center><img src="../Imagens/logo_copa.jpg" width="80" height="80"></center></td>
<td width="40%" aling="center"><center><img src="../Imagens/logo.jpg" width="328" height="80"></center></td>
<td width="15%" aling="right"><center>&nbsp;<a href="../index.asp"><img src="../Imagens/Ranking_Principal_link.jpg"></a><br></center>
<center>&nbsp;<a href="../rankingacertos.asp"><img src="../Imagens/Ranking_Acertos_link.jpg"></a><br></center>
<center>&nbsp;<a href="../rankingGrupos.asp"><img src="../Imagens/Ranking_Grupos_link.jpg"></a></center></td>
<td width="15%" aling="right"><center>&nbsp;<a href="../cadastro"><img src="../Imagens/aposta.gif"></a><br></center>
<center>&nbsp;<a href="../regras.asp"><img src="../Imagens/regras.jpg"></a><br></center>
<center>&nbsp;<a href="../estatistica.asp"><img src="../Imagens/estatisticas.jpg"></a></center></td>
</tr>
</table>


<br>
<div class="mensagem"><%=mensagem%>
</div>
<br>
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
