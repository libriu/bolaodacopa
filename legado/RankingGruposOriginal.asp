<script language="JavaScript">
<!--
function mural() {
 window.location="mural.asp"
 }
function retornar() {
 window.location="index.asp"
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
<title>Bolao da Copa do Mundo no Brasil 2014</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="Comuns/styles.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">

<form name="formGrupos" method="post" action="RankingGrupos.asp">

<%

    'Abrindo Conexão mySQL - Forma usada em 2010
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Database=bolaodacopa2013;uid=bolaodacopa;pwd=Brasil;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2013
         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=mysql.bolaodacopa.unositehospedagem.com.br;Database=bolaodacopa;uid=bolaodacopa;pwd=vasco97;option=3"
         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 

%>


<table width="80%" align="center">
<tr> 
<td width="30%" aling="lef"><center><img src="Imagens/logo_copa.jpg" width="80" height="80"></center></td>
<td width="40%" aling="center"><center><img src="Imagens/logo.jpg" width="328" height="80"></center></td>
<td width="15%" aling="right"><center>&nbsp;<a href="index.asp"><img src="Imagens/Ranking_Principal_link.jpg"></a><br></center>
<center>&nbsp;<a href="rankingacertos.asp"><img src="Imagens/Ranking_Acertos_link.jpg"></a><br></center>
<center>&nbsp;<a href="rankingGrupos.asp"><img src="Imagens/Ranking_Grupos_link.jpg"></a></center></td>
<td width="15%" aling="right"><center>&nbsp;<a href="cadastro"><img src="Imagens/aposta.gif"></a><br></center>
<center>&nbsp;<a href="regras.asp"><img src="Imagens/regras.jpg"></a><br></center>
<center>&nbsp;<a href="estatistica.asp"><img src="Imagens/estatisticas.jpg"></a></center></td>
</tr>
</table>

<br>
<table width="80%" align="center">
<tr> 
<td width="80%" aling="center"><center><img src="Imagens/Ranking_Grupos.jpg"></center></td>
</table>

<br>


  <table class="Bolao" width="80%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <th colspan="9" height="24">SELECIONAR O GRUPO A VISUALIZAR</th>
  </tr>

  <tr class="LinhaImpar">
  <th colspan="3" height="24" width="37%">Selecione o Grupo a Visualizar:</th>


  <th colspan="3" width="47%">

  <select name="cmbAtualizar">


<%

  sql = "Select * from Grupos order by nome_grupo"

  set rs1 = Server.CreateObject("ADODB.Recordset")

  rs1.Open sql, conx 

  While not rs1.EOF

    if request("btnAtualizar") <> empty then
   
       if cint(request("cmbAtualizar")) = cint(rs1("cod_grupo")) then
   
 %>
     <option selected value="<%= rs1("cod_grupo")%>"><%= rs1("nome_grupo")%></option>

<% 
       else

 %>
     <option value="<%= rs1("cod_grupo")%>"><%= rs1("nome_grupo")%></option>

<% 
       end if

    else

 %>
     <option value="<%= rs1("cod_grupo")%>"><%= rs1("nome_grupo")%></option>

<% 


    end if

  rs1.MoveNext

  wend
 

  rs1.Close 
  Set rs1 = Nothing

%> 

  </select>


  </th width="16%">

  <th colspan="3"><input type="submit" name="btnAtualizar" value="Visualizar Grupo" class="botao"></th>
  </tr>

</table>


<br>
<br>

<%
if request("btnAtualizar") <> empty then

%>


<table class="Bolao" width="80%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <th colspan="9" height="24">TABELA DE JOGOS | <%= day(now()) & "/" & month(now()) & "/" & year(now()) & " - " & time() %></th>
  </tr>
  <tr>
    <th colspan="9" height="24">PRIMEIRA FASE</th>
  </tr>

 <%
        
       
         sql =     "SELECT * FROM Resultados"
	  sql = sql & " ORDER BY Resultados.cod_Jogo"

	 set rs = Server.CreateObject("ADODB.Recordset")
	 set rs2 = Server.CreateObject("ADODB.Recordset")
	
     rs.Open sql, conx 



  i = 1

  while not rs.eof %>

  <% if rs("cod_Jogo") = 49 then%>
  <tr><th colspan="9" height="24">OITAVAS DE FINAL</th>  </tr>
  <%  end if%>

  <% if rs("cod_Jogo") = 57 then%>
  <tr><th colspan="9" height="24">QUARTAS DE FINAL</th>  </tr>
  <%  end if%>

  <% if rs("cod_Jogo") = 61 then%>
  <tr><th colspan="9" height="24">SEMI-FINAL</th>  </tr>
  <%  end if%>

  <% if rs("cod_Jogo") = 63 then%>
  <tr><th colspan="9" height="24">DISPUTA DO TERCEIRO LUGAR</th>  </tr>
  <%  end if%>

  <% if rs("cod_Jogo") = 64 then%>
  <tr><th colspan="9" height="24"> GRANDE FINAL</th>  </tr>
  <%  end if%>
 

<%  if (i MOD 2) <> 0 then%>
      <tr class="LinhaImpar">
<%  else%>
    <tr class="LinhaPar">
<%  end if

    
     if now() >= cdate(rs("data_jogo")) then%> 
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

<%
  sql = "Select * from Grupos, Apostadores "
  sql = sql & " where Grupos.cod_responsavel = Apostadores.cod_apostador and"
  sql = sql & "       Grupos.cod_grupo = " & request("cmbAtualizar")

  set rs3 = Server.CreateObject("ADODB.Recordset")

  rs3.Open sql, conx 

  nome_grupo = rs3("nome_grupo")
  nome_responsavel = rs3("nome")


%>

  <table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr>
      <th colspan="5" height="24">VISUALIZAÇÃO DE GRUPOS | GRUPO SELECIONADO
      </th>
    </tr>
    <tr>
      <th colspan="2" >NOME DO GRUPO:
      </th>
      <th colspan="3" align="left"><%=nome_grupo%>
      </th>
    </tr>
    <tr>
      <th colspan="2" >RESPONSÁVEL PELO GRUPO :
      </th>
      <th colspan="3" align="left"> <%=nome_responsavel%>
      </th>
    </tr>

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
    <td class="Titulo" width="3%">17</td>
    <td class="Titulo" width="3%">18</td>
    <td class="Titulo" width="3%">19</td>
    <td class="Titulo" width="3%">20</td>
    <td class="Titulo" width="3%">21</td>
    <td class="Titulo" width="3%">22</td>
    <td class="Titulo" width="3%">23</td>
    <td class="Titulo" width="3%">24</td>
    <td class="Titulo" width="3%">25</td>
    <td class="Titulo" width="3%">26</td>
    <td class="Titulo" width="3%">27</td>
    <td class="Titulo" width="3%">28</td>
    <td class="Titulo" width="3%">29</td>
    <td class="Titulo" width="3%">30</td>
    <td class="Titulo" width="3%">31</td>
    <td class="Titulo" width="3%">32</td>
    <td class="Titulo" width="3%">33</td>
    <td class="Titulo" width="3%">34</td>
    <td class="Titulo" width="3%">35</td>
    <td class="Titulo" width="3%">36</td>
    <td class="Titulo" width="3%">37</td>
    <td class="Titulo" width="3%">38</td>
    <td class="Titulo" width="3%">39</td>
    <td class="Titulo" width="3%">40</td>
    <td class="Titulo" width="3%">41</td>
    <td class="Titulo" width="3%">42</td>
    <td class="Titulo" width="3%">43</td>
    <td class="Titulo" width="3%">44</td>
    <td class="Titulo" width="3%">45</td>
    <td class="Titulo" width="3%">46</td>
    <td class="Titulo" width="3%">47</td>
    <td class="Titulo" width="3%">48</td>
    <td class="Titulo" width="3%">49</td>
    <td class="Titulo" width="3%">50</td>
    <td class="Titulo" width="3%">51</td>
    <td class="Titulo" width="3%">52</td>
    <td class="Titulo" width="3%">53</td>
    <td class="Titulo" width="3%">54</td>
    <td class="Titulo" width="3%">55</td>
    <td class="Titulo" width="3%">56</td>
    <td class="Titulo" width="3%">57</td>
    <td class="Titulo" width="3%">58</td>
    <td class="Titulo" width="3%">59</td>
    <td class="Titulo" width="3%">60</td>
    <td class="Titulo" width="3%">61</td>
    <td class="Titulo" width="3%">62</td>
    <td class="Titulo" width="3%">63</td>
    <td class="Titulo" width="3%">64</td>
   </tr>
  <%
     intLinha = 0
     intPosicao = 0
     intTotalPontosJogadorAcima = 0
     intGrupo = 0
   
     if request("cmbAtualizar") <> empty then 
        intGrupo = cint(request("cmbAtualizar"))
     end if

     sql =		 "   SELECT * FROM Apostadores, Apostas, Det_Grupos"
 	 sql = sql & "	  WHERE Apostadores.cod_Apostador = Apostas.cod_Apostador and Apostadores.Ativo"
 	 sql = sql & "	    and Apostadores.cod_Apostador = Det_Grupos.cod_Apostador"
 	 sql = sql & "	    and Det_Grupos.cod_Grupo = " & intGrupo
	 sql = sql & " ORDER BY Apostas.Total_Pontos DESC, Apostadores.nome, Apostas.cod_Aposta "

'     sql =		 "   SELECT * FROM Apostadores, Apostas, Jogos, Resultados"
'	 sql = sql & "	  WHERE Apostadores.cod_Apostador = Apostas.cod_Apostador"
'	 sql = sql & "	    AND Jogos.cod_Aposta = Apostas.cod_Aposta"
'	 sql = sql & "	    AND Jogos.cod_Jogo = Resultados.cod_Jogo"
'	 sql = sql & " ORDER BY Apostas.Total_Pontos DESC, Apostadores.nome, Apostas.cod_Aposta, Jogos.cod_Jogo "
'	 set rs = conx.execute(sql)

     rs.Open sql, conx 

     while not rs.eof
		
                intLinha = intLinha + 1  
                if cint(rs("Total_Pontos")) = 0 OR cint(rs("Total_Pontos")) <> intTotalPontosJogadorAcima then 
                   intPosicao = intLinha
                end if

                intTotalPontosJogadorAcima = cint(rs("Total_Pontos"))                
                
		if intLinha mod 2 = 0 then
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


          for i = 1 to 64
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

<%

  ' Fechar os objetos Recordsets 
  rs.Close


end if

%>

<br>
<br>

<div align="center">
  <input type="submit" name="btnVoltar" value="Retornar" class="botao" onclick="retornar();return false;">
</div>


<%
  

   
  ' Eliminar os objetos Recordsets 
  Set rs = Nothing 
  Set rs2 = Nothing
  Set rs3 = Nothing

  ' Fechar o objeto da conexÃ£o 
  conx.Close 
 
 ' Eliminar o objeto da conexÃ£o 
  Set conx = Nothing 



%>

<p>&nbsp;</p>

</FORM>
</body>
</html>
	