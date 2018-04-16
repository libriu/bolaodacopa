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


'    response.write DateAdd("h", FusoHorario, now)
'    response.write DataInicioCopaFormatado

  if DateAdd("h", FusoHorario, now) >= cdate(DataInicioCopaFormatado) then
    response.write ("Período ativiação de cadastrado já ultrapassado!!!<br>")
    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")
  else




  dim mensagem
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
      if rs("acesso_gestao_total") = 0 and rs("acesso_ativacao") = 0 then
        rs.close
        set rs = nothing
        conx.close
        Set conx = Nothing
        mensagem = "Usuário sem acesso a este módulo."
      else
       session("manut") = "Sou mais Brasil 2018"
       session("usuario") = request("login")
       rs.close
       set rs = nothing
       conx.close
       Set conx = Nothing 



     %>

<script language="JavaScript">
<!--
 window.location="administracao.asp"
//-->
</script>


<%  

      end if
    end if
  end if

%>

  <script language="JavaScript">
  <!--
  function retornar() {
   window.location="../index.asp"
   }
  //-->
  </script>


<html>
<head>
<title><%=TituloPagina%> - Administração de Apostadores</title>
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


<br><br>
<div class="mensagem"><%=mensagem%>
</div>
<form name="formCadastro" method="post" action="index.asp">
<table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <th colspan="2" height="24">LOGIN PARA ATIVAÇÃO DE APOSTADORES - ACESSO RESTRITO A USUÁRIO COM PODER DE GESTÃO</th>
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
  <input type="submit" name="btnLogin" value="Ativar Usuário" class="botao">&nbsp;&nbsp;
  <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
</form>
<p>&nbsp;</p>
</body>
</html>
<% end if %>