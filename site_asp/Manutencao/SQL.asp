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


<title>Bolao da Copa do Mundo</title>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">


</head>


<body bgcolor="#FFFFFF" text="#000000">


<form name="formInclusao" method="post" action="SQL1.asp">


    <table bgcolor=silver cellpadding="5" cellspacing="0" bordercolor="black" border="1">


    <tr>


      <td>SQL:&nbsp;<textarea cols="50" rows="5" name="comando" ></textarea></td>


    </tr>


    </table>





    <br><br>


	<input type="submit" value="Executar" width="5" height="10">





  </form>





  Tabelas: Apostadores, Apostas, Jogos, Pais, Resultados


</body>


</html>


<%END IF%>


