<%  if Session("manut") = empty then

    response.write ("Usuario nao autorizado!!!<br>")

    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")

  else

%>

<html>

<head>

<META HTTP-EQUIV="Expires" CONTENT="0">

<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">

<META HTTP-EQUIV="Pragma" CONTENT="no-cache">

<title>Bolao da Copa do Mundo - Emails</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">

</head>

<body bgcolor="#FFFFFF" text="#000000">

<!--#include virtual="/comuns/configuracoes.asp"--> 

<%


         Set conx = Server.CreateObject("ADODB.Connection")

         conx.Open ConnStrMySQL 





   set rs = Server.CreateObject("ADODB.Recordset")

		 

	sql = "Select distinct email from Apostadores where email <> '.' and email <> '' and ativo"	 

   rs.Open sql, conx

   while not RS.eof

     if rs("email") <> "" and rs("email") <> "." then

       response.write (rs("email") + ";<br>")

     end if

     rs.movenext

   wend

   rs.close

   conx.close

   set rs = nothing

   set conx = nothing

%>

</body>

</html>

<%end if%>

