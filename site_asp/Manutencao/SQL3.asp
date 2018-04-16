<%  if Session("manut") = empty then
    response.write ("Usuário não autorizado!!!<br>")
    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")
  else
%>
<html>
<head>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title>Bolao da Copa do Mundo no Brasil 2014 - Emails sem apostas</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%
  if request("aposta") <> empty then

    'Abrindo Conexão mySQL - Forma usada em 2010
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Database=bolaodacopa2013;uid=bolaodacopa;pwd=Brasil;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2013
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=mysql.bolaodacopa.unositehospedagem.com.br;Database=bolaodacopa;uid=bolaodacopa;pwd=vasco97;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2018
         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=50.62.209.75;Database=bolaodacopa2018;uid=bolaodacopa;pwd=Brasil2018;option=3"

         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 


   set rs = Server.CreateObject("ADODB.Recordset")
   set rs2 = Server.CreateObject("ADODB.Recordset")
   
   sql = "SELECT * from Apostadores WHERE Ativo = 1"
   rs.Open sql, conx
   i = 0
   while not rs.eof
     sql = "select * from Jogos where cod_aposta = " & rs("cod_apostador") & " and cod_jogo = " & request("aposta")
     rs2.Open sql, conx
     if rs2.eof then
       i = i + 1
       response.write (i & ". " & rs("nome") & " - " & rs("contato") & "<br>")
     end if
	 rs2.Close
     rs.movenext
   wend
   rs.close
   sql = "SELECT * from Apostadores WHERE Ativo = 1"
   rs.Open sql, conx
   while not rs.eof
     sql = "select * from Jogos where cod_aposta = " & rs("cod_apostador") & " and cod_jogo = " & request("aposta")
     rs2.Open sql, conx
     if rs2.eof then
       response.write (rs("email") + ";<br>")
     end if
	 rs2.Close
     rs.movenext
   wend
   rs.Close
   conx.close
  else
%>
<form name="formInclusao" method="post" action="SQL3.asp">
    <table bgcolor=silver cellpadding="5" cellspacing="0" bordercolor="black" border="1">
    <tr>
      <td>Indique o número do jogo para o qual deseja verificar quem não apostou:&nbsp;<input type="text" name="aposta" ></textarea></td>
    </tr>
    </table>

    <br><br>
        <input type="submit" value="Executar" width="5" height="10">

  </form>
<%  end if%>
  </body>
</html>
<%end if%>
