<html>
<head>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title>Bolao da Copa do Mundo no Brasil 2014 - Inclusão de Apostadores</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%  if Session("manut") = empty then
    response.write ("Usuário não autorizado!!!<br>")
    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")
  else
%>
<%
    'Abrindo Conexão mySQL - Forma usada em 2010
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Database=bolaodacopa2013;uid=bolaodacopa;pwd=Brasil;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2013
         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=mysql.bolaodacopa.unositehospedagem.com.br;Database=bolaodacopa;uid=bolaodacopa;pwd=vasco97;option=3"
         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 

         set rs = Server.CreateObject("ADODB.Recordset")
         set rs2 = Server.CreateObject("ADODB.Recordset")        
         set rs3 = Server.CreateObject("ADODB.Recordset")
         set rs5 = Server.CreateObject("ADODB.Recordset")
     
	if request("btnIncluir") <> empty then
		sql = "SELECT cod_Apostador FROM Apostadores WHERE nome = '" & request("nome") & "'"
		rs.Open sql, conx 
                if not rs.eof then
		  Mensagem = "Apostador já existente. Utilize outro nome!"
		else
                  if request("nome") = "" or request("contato") = "" or request("email") = "" or request("controle_inclusao") = "" then
   		      Mensagem = "Todos os campos são obrigatório para inclusão!"
                  else
  		    sql = "SELECT MAX(Apostadores.cod_Apostador) as maxCodApostador FROM Apostadores"
		    rs2.Open sql, conx
		    codApostador = rs2("maxCodApostador") + 1
                    rs2.Close
		    sql =      "INSERT INTO Apostadores (cod_Apostador, nome, contato, Pago, email, senha_apostador,controle_inclusao, ativo)"
		    sql = sql & " 		    VALUES (" & codApostador & ", '" & request("nome") & "','" & request("contato") & "', 0, '" & request("email") & "','" & request("nome") & "','" & request("controle_inclusao") & "',1)"
		    conx.execute(sql)
		    sql = 	 "INSERT INTO Apostas (cod_Aposta, cod_Apostador,Total_Pontos, Total_Acertos)"
		    sql = sql & " 	  VALUES (" & codApostador & ", " & codApostador & ",0,0)"
		    conx.execute(sql)
		    Mensagem = "Apostador incluído com sucesso!"
                  end if
		end if
                rs.Close
         else
   	    if request("btnAtivar") <> empty then
		sql = "SELECT cod_Apostador FROM Apostadores WHERE nome = '" & request("nome1") & "'"
		rs.Open sql, conx 
                if rs.eof then
		  Mensagem = "Apostador não existe. Não tem como ativa-lo. Olhe a lista abaixo!"
		else
                  sql = "UPDATE Apostadores SET ATIVO = 1 , senha_apostador = '" & request("nome1") & "'"
                  if request("contato1") <> "" then
                    sql = sql & " , contato = '" & request("contato1") & "'"
                  end if
                  if request("email1")  <> "" then
                    sql = sql & " , email = '" & request("email1") & "'"
                  end if
                  if request("controle_inclusao1")  <> "" then
                    sql = sql & " , controle_inclusao = '" & request("controle_inclusao1") & "'"
                  end if
                  sql = sql & " WHERE nome = '" & request("nome1") & "'" 

		  conx.execute(sql)

		  Mensagem = "Apostador " & request("nome1") & " ativado com sucesso!"
		end if
                rs.Close

            end if
	 end if

   
%>

<html>
<head>
<title>Bolao da Copa do Mundo no Brasil 2014 - Administração</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<div class="mensagem">
  <% response.write Mensagem & "<BR>" %>
</div>
<BR>
<form name="formInclusao" method="post" action="administracao.asp">
  <table class="Bolao" width="80%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr>
      <th colspan="8" height="24">INCLUS&Atilde;O DE APOSTADORES
      </th>
    </tr>
    <tr>
      <th colspan="3" >NOME :
      </th>
      <th colspan="5" align="left">
	<input type="text" name="nome" size="30" maxlength="30">
      </th>
    </tr>
    <tr>
      <th colspan="3" >CONTATO :
      </th>
      <th colspan="5" align="left">
	<input type="text" name="contato" size="30" maxlength="30">
      </th>
    </tr>
    <tr>
      <th colspan="3" >E-MAIL :
      </th>
      <th colspan="5" align="left">
	<input type="text" name="email" size="50" maxlength="50">
      </th>
    </tr>
    <tr>
      <th colspan="3" >RESPONSAVEL CONTROLE FINANCEIRO :
      </th>
      <th colspan="5" align="left">
	<input type="text" name="controle_inclusao" size="50" maxlength="50">
      </th>
    </tr>
  </table><br>
  <div align="center">
    <input type="submit" name="btnIncluir" value="Incluir" class="botao">
  </div>

<HR>

  <table class="Bolao" width="80%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr>
      <th colspan="8" height="24">ATIVAÇÃO DE APOSTADORES 
      </th>
    </tr>
    <tr>
      <th colspan="3" >NOME :
      </th>
      <th colspan="5" align="left">
	<input type="text" name="nome1" size="30" maxlength="30">
      </th>
    </tr>
    <tr>
      <th colspan="3" >CONTATO :
      </th>
      <th colspan="5" align="left">
	<input type="text" name="contato1" size="30" maxlength="30">
      </th>
    </tr>
    <tr>
      <th colspan="3" >E-MAIL :
      </th>
      <th colspan="5" align="left">
	<input type="text" name="email1" size="50" maxlength="50">
      </th>
    </tr>
    <tr>
      <th colspan="3" >RESPONSAVEL CONTROLE FINANCEIRO :
      </th>
      <th colspan="5" align="left">
	<input type="text" name="controle_inclusao1" size="50" maxlength="50">
      </th>
    </tr>
  </table><br>
  <div align="center">
    <input type="submit" name="btnAtivar" value="Ativar" class="botao">
  </div>

</form>
<HR>

  <table class="Bolao" width="80%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr>
      <th colspan="8" height="24">LISTA DE APOSTADORES INATIVOS JÁ CADASTRADOS
      </th>
    </tr>
  </table><br>

<%		 
   sql = "Select * from Apostadores where not ativo order by nome"	

   rs3.Open sql, conx
   while not RS3.eof
     response.write ("Usuario: " & rs3("nome") & " - Contato: " & rs3("contato") & " - E-mail: " & rs3("email") & " - Controle Financeiro: " & rs3("controle_inclusao") & "<br>")
     rs3.movenext
   wend

   rs3.close

   end if
   Set rs = Nothing
   Set rs2 = Nothing
   Set rs3 = Nothing   
   Set rs5 = Nothing   

   conx.close
   Set conx = Nothing
%>
 </html>
