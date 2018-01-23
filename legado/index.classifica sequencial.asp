<script language="JavaScript">
<!--
function mural() {
 window.location="mural.asp"
 }
function mensagens() {
 window.location="/cadastro/index.asp"
 }
//-->
</script>

<html>
<head>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title>Bolao da Copa das Confederações 2013</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="Comuns/styles.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="80%" align="center">
<tr> 
<td width="20%" aling="lef"><center><img src="Imagens/logo_copa.jpg" width="80" height="80"></center></td>
<td width="60%" aling="center"><center><img src="Imagens/logo.jpg" width="328" height="80"></center></td>
<td width="20%" aling="right"><center>&nbsp;<a href="cadastro"><img src="Imagens/aposta.gif"></a><br></center>
<center>&nbsp;<a href="regras.asp"><img src="Imagens/regras.jpg"></a><br></center>
<center>&nbsp;<a href="estatistica.asp"><img src="Imagens/estatisticas.jpg"></a></center></td>
</tr>
</table>
<table class="Bolao" width="80%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <th colspan="9" height="24">TABELA DE JOGOS | <%= day(now()) & "/" & month(now()) & "/" & year(now()) & " - " & time() %></th>
  </tr>
  <tr>
    <th colspan="9" height="24">PRIMEIRA FASE</th>
  </tr>

 <%
        
    'Abrindo Conexão mySQL - Forma usada em 2010
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Database=bolaodacopa2013;uid=bolaodacopa;pwd=Brasil;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2013
         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=mysql.bolaodacopa.unositehospedagem.com.br;Database=bolaodacopa;uid=bolaodacopa;pwd=vasco97;option=3"
         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 


       
         sql =     "SELECT * FROM Resultados"
	  sql = sql & " ORDER BY Resultados.cod_Jogo"

	 set rs = Server.CreateObject("ADODB.Recordset")
	 set rs2 = Server.CreateObject("ADODB.Recordset")
	
     rs.Open sql, conx 



  i = 1

  while not rs.eof %>

  <% if rs("cod_Jogo") = 13 then%>
  <tr><th colspan="9" height="24">SEMI-FINAIS</th>  </tr>
  <%  end if%>

  <% if rs("cod_Jogo") = 15 then%>
  <tr><th colspan="9" height="24">DISPUTA DO TERCEIRO LUGAR</th>  </tr>
  <%  end if%>

  <% if rs("cod_Jogo") = 16 then%>
  <tr><th colspan="9" height="24">FINAL</th>  </tr>
  <%  end if%>
 

<%  if (i MOD 2) <> 0 then%>
      <tr class="LinhaImpar">
<%  else%>
    <tr class="LinhaPar">
<%  end if

    if now() >= cdate(mid(rs("data_jogo"),4,3) & left(rs("data_jogo"),3) & right(rs("data_jogo"),4)) then%>
      <td><a href='apostas.asp?cod=<%=rs("cod_Jogo")%>'><%=rs("cod_Jogo")%>.</a></td>
<%   else%>
      <td><%=rs("cod_Jogo")%>.</td>
<%
    end if
%>

    <td><%=rs("data_jogo")%></td>
    <td><%=left(rs("hora_jogo"),5)%></td>
    <td><%=rs("grupo")%></td>
<%  if rs("time1") = "BRASIL" then
%>    <td widht="60%" class="Brasil">BRASIL</td>
<%  elseif rs("time1") = "A definir" then%>
      <td widht="60%" class="vazio"><%=rs("time1")%></td>
<%  else%>
      <td widht="60%" ><%=rs("time1")%></td>
<%  end if%>
    <td>
<%  if rs("time1") <> "A definir" then

      sql = "SELECT * FROM Pais where Pais.Pais = '" & rs("time1") & "'"
      rs2.Open sql, conx 

      if not rs2.eof then 

%>
	<img src="Imagens/<%=rs2("Arquivo")%>" width="21" height="15"></td>
<%    end if
      rs2.Close
    end if
%>    </td>
<%   if rs("jaOcorreu") then%>
      <td><%=rs("r_placar_A")%>&nbsp;X&nbsp;<%=rs("r_placar_B")%> </td>
<%   else%>
      <td>&nbsp;&nbsp;X&nbsp;&nbsp;</td>
<%
    end if
%>
<td>
<%
    if rs("time2") <> "A definir" then
      sql = "SELECT * FROM Pais where Pais = '" & rs("time2") & "'"
      rs2.Open sql, conx 
      if not rs2.eof then %>
	<img src="Imagens/<%=rs2("Arquivo")%>" width="21" height="15"></td>
<%    end if
      rs2.Close
    end if%>
     </td>
<%  if rs("time2") = "BRASIL" then
%>    <td widht="60%" class="Brasil">BRASIL</td>
<%  elseif rs("time2") = "A definir" then%>
      <td widht="60%" class="vazio"><%=rs("time2")%></td>
<%  else%>
      <td widht="60%" ><%=rs("time2")%></td>
<%  end if%>
  </tr>
<%  i = i + 1
    rs.MoveNext
  wend 
  rs.Close
  %>
</table>
<br>
<table width="80%" border="0" cellspacing="2" cellpadding="2" align="center" class="Bolao">
  <tr>
    <th colspan="70">RANKING</th>
  </tr>
  <tr>
    <td class="Titulo" width="3%">&nbsp;</td>
    <td class="Titulo" width="14%">Nome</td>
    <td class="Titulo" width="12%">Contato</td>
    <td class="Titulo" width="3%">Total</td>
    <td class="Titulo" width="3%">01</td>
    <td class="Titulo" width="3%">02</td>
    <td class="Titulo" width="3%">03</td>
    <td class="Titulo" width="3%">04</td>
    <td class="Titulo" width="3%">05</td>
    <td class="Titulo" width="3%">06</td>
    <td class="Titulo" width="3%">07</td>
    <td class="Titulo" width="3%">08</td>
    <td class="Titulo" width="3%">09</td>
    <td class="Titulo" width="3%">10</td>
    <td class="Titulo" width="3%">11</td>
    <td class="Titulo" width="3%">12</td>
    <td class="Titulo" width="3%">13</td>
    <td class="Titulo" width="3%">14</td>
    <td class="Titulo" width="3%">15</td>
    <td class="Titulo" width="3%">16</td>
  </tr>
  <%
     intPosicao = 0

     sql =		 "   SELECT * FROM Apostadores, Apostas"
	 sql = sql & "	  WHERE Apostadores.cod_Apostador = Apostas.cod_Apostador"
	 sql = sql & " ORDER BY Apostas.Total_Pontos DESC, Apostadores.nome, Apostas.cod_Aposta "

'     sql =		 "   SELECT * FROM Apostadores, Apostas, Jogos, Resultados"
'	 sql = sql & "	  WHERE Apostadores.cod_Apostador = Apostas.cod_Apostador"
'	 sql = sql & "	    AND Jogos.cod_Aposta = Apostas.cod_Aposta"
'	 sql = sql & "	    AND Jogos.cod_Jogo = Resultados.cod_Jogo"
'	 sql = sql & " ORDER BY Apostas.Total_Pontos DESC, Apostadores.nome, Apostas.cod_Aposta, Jogos.cod_Jogo "
'	 set rs = conx.execute(sql)

     rs.Open sql, conx 

     while not rs.eof
		intPosicao = intPosicao + 1
		if intPosicao mod 2 = 0 then
%>			<tr class="LinhaPar">
<%	else %>
			<tr class="LinhaImpar">
<%	end if %>

		<td width="3%"><%= intPosicao %></td>

    <td  width="16%"><a href='cartao.asp?cod=<%= rs("cod_Aposta")%>&nome=<%= rs("nome") %>' ><%= rs("nome") %></a>
      </td> <td  width="14%"><%= rs("Contato") %></td>
		<td  width="3%"><%= rs("Total_Pontos") %></td>

<%
     sql =		 "   SELECT * FROM Jogos, Resultados"
	 sql = sql & "	  WHERE Jogos.cod_Aposta = " & rs("cod_Aposta")
	 sql = sql & "	    AND Jogos.cod_Jogo = Resultados.cod_Jogo"
	 sql = sql & " ORDER BY Jogos.cod_Jogo "
      
     rs2.Open sql, conx 


          for i = 1 to 16
		  if intPosicao mod 2 = 0 then
%>			<td class="LinhaPar" width="3%">
<%		  else %>
			<td class="LinhaImpar" width="3%">
<%		  end if %>
<% if rs2.eof then
     response.write ("0")
   elseif rs2("cod_Jogo") <> i then
       response.write ("0")
   else
       response.write (rs2("Pontos"))
	   rs2.MoveNext
   end if
   
   %>
	  </td>
<% next %>
	</tr>
<%
       rs2.Close
	   rs.MoveNext
  wend
%>
</table>

<br>
<br>

<table class="Bolao" width="80%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <th colspan="9" height="24">MURAL DE MENSAGENS (ÚLTIMAS 30 MENSAGENS)</th>
  </tr>
  <tr>
    <td class="Titulo" >Nome</td>
    <td class="Titulo" >Contato</td>
    <td class="Titulo" >Data</td>
    <td class="Titulo" >Hora</td>
    <td class="Titulo" >Mensagem</td>

<%

         sql =     "SELECT * FROM Mensagens, Apostadores WHERE Apostadores.cod_Apostador = Mensagens.cod_Apostador"
	  sql = sql & " ORDER BY Mensagens.cod_Mensagem DESC LIMIT 30"

          set rs4 = Server.CreateObject("ADODB.Recordset")
	
          rs4.Open sql, conx 

  i = 1


  while not rs4.eof %>

<%  if (i MOD 2) <> 0 then%>
      <tr class="LinhaImpar">
<%  else%>
    <tr class="LinhaPar">
<%  end if%>

    <td><%=rs4("nome")%></td>
    <td><%=rs4("contato")%></td>
    <td><%=rs4("data_msg")%></td>
    <td><%=rs4("hora_msg")%></td>
    <td widht="60%"><%=rs4("mensagem")%></td>



</tr>

<% 

   rs4.MoveNext
  wend


%>
</TABLE>
<br>
<div align="center">
  <input type="submit" name="btnEnviarMensagem" value="Enviar Mensagem"  class="botao" onClick="mensagens();return false;">&nbsp;&nbsp;
  <input type="submit" name="btnVerMuralr" value="Ver Todas Mensagens" class="botao" onClick="mural();return false;">
</div>



<%
  
  ' Fechar os objetos Recordsets 
  rs.Close
   
  ' Eliminar os objetos Recordsets 
  Set rs = Nothing 
  Set rs2 = Nothing
  Set rs3 = Nothing
  Set rs4 = Nothing
  ' Fechar o objeto da conexÃ£o 
  conx.Close 
 
 ' Eliminar o objeto da conexÃ£o 
  Set conx = Nothing 



%>

<p>&nbsp;</p>
</body>
</html>
