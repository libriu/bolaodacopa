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

 if Session("usuario") = empty then
    response.write ("Usuário não autorizado!!!<br>")
    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")
  else
         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 

	
	sql = "Select * from Apostadores where nome = '" & session("usuario") & "'"


    set rs_usuario = Server.CreateObject("ADODB.Recordset")

    rs_usuario.Open sql, conx 

	if request("btnIncluir") <> empty then
		'Incluindo uma nova aposta
		   codInsercao = rs_usuario("cod_Apostador")
		   for i = 1 to 64
		   if request("placar_A_" & i) <> empty and request("placar_B_" & i) <> empty then
		     if ISNUMERIC(request("placar_A_" & i)) and ISNUMERIC(request("placar_B_" & i)) then
			sql = "SELECT * FROM Jogos"
			sql = sql & " WHERE cod_Aposta = " & rs_usuario("cod_Apostador")
			sql = sql & " AND cod_Jogo = " & i
			 'set rs5 = conx.execute(sql)
			 set rs5 = Server.CreateObject("ADODB.Recordset")
             rs5.Open sql, conx 

			if rs5.eof then
			  sql = 	  "INSERT INTO Jogos (cod_Aposta, cod_Jogo, placar_A, placar_B,Pontos)"
			  sql = sql & " 	  VALUES (" & codInsercao & ", " & i & ", " & request("placar_A_" & i) & ", " & request("placar_B_" & i) & ",0)"
			  conx.execute(sql)
            else
			  sql = 	  "UPDATE Jogos SET placar_A = " & request("placar_A_" & i) & " , placar_B = " & request("placar_B_" & i) & " WHERE cod_Aposta = " & codInsercao & " and cod_Jogo = " & i
			  conx.execute(sql)
			end if
            rs5.Close
		      end if
		    end if
		 next

		 Mensagem = "Apostas atualizadas com sucesso!"

	end if

%>
<script language="JavaScript">
<!--
function retornar() {
 window.location="index.asp"
 }
//-->
</script>
<html>
<head>
<title><%=TituloPagina%> - Inclusão de Placares</title>
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
<div class="mensagem">
  <% response.write Mensagem & "<BR>" %>
</div>
<BR>
<form name="formInclusao" method="post" action="cadastro.asp">
  <table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr>
      <th colspan="7" height="24">INCLUS&Atilde;O E ALTERAÇÃO DE APOSTAS | <%= day(DateAdd("h", FusoHorario, now)) & "/" & month(DateAdd("h",  FusoHorario, now)) & "/" & year(DateAdd("h",  FusoHorario, now)) & " - " & hour(DateAdd("h",  FusoHorario, now)) & ":" & minute(DateAdd("h",  FusoHorario, now)) & ":" & second(DateAdd("h",  FusoHorario, now)) %>
      </th>
    </tr>
    <tr>
      <th colspan="2" >NOME :
      </th>
      <th colspan="5" align="left"><%=rs_usuario("nome")%>
      </th>
    </tr>
    <tr>
      <th colspan="2" >CONTATO :
      </th>
      <th colspan="5" align="left"> <%=rs_usuario("contato")%>
      </th>
    </tr>

  <tr>
    <th colspan="9" height="24">PRIMEIRA FASE</th>
  </tr>


<%
   sql =	       "   SELECT * FROM Resultados"
       sql = sql & " ORDER BY Resultados.cod_Jogo"
   'set rs = conx.execute(sql)
   
    set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conx 

  i = 1

  while not rs.eof
%>

   <% if rs("cod_Jogo") = 49 then%>
  <tr><th colspan="9" height="24">OITAVAS DE FINAIS</th>  </tr>
  <%  end if%>

  <% if rs("cod_Jogo") = 57 then%>
  <tr><th colspan="9" height="24">QUARTAS DE FINAIS</th>  </tr>
  <%  end if%>

  <% if rs("cod_Jogo") = 61 then%>
  <tr><th colspan="9" height="24">SEMI-FINAIS</th>  </tr>
  <%  end if%>

  <% if rs("cod_Jogo") = 63 then%>
  <tr><th colspan="9" height="24">DISPUTA DO TERCEIRO LUGAR</th>  </tr>
  <%  end if%>

  <% if rs("cod_Jogo") = 64 then%>
  <tr><th colspan="9" height="24"> GRANDE FINAL</th>  </tr>
  <%  end if%>

<%
    if (i MOD 2) <> 0 then%>
      <tr class="LinhaImpar">
<%  else%>
    <tr class="LinhaPar">
<%  end if%>
    <td widht="10%"><%=rs("cod_Jogo")%>.</td>
    <td widht="10%"><%=rs("data_jogo")%></td>
<%  if rs("time1") = "BRASIL" then
%>    <td widht="60%" class="Brasil">BRASIL</td>
<%  elseif rs("time1") = "A definir" then%>
      <td widht="60%" class="vazio"><%=rs("time1")%></td>
<%  else%>
      <td widht="60%" ><%=rs("time1")%></td>
<%  end if%>
    <td widht="5%" >
<%  if rs("time1") <> "A definir" then
      sql = "SELECT * FROM Pais where Pais = '" & rs("time1") & "'"
      'set rs2 = conx.execute(sql)
      set rs2 = Server.CreateObject("ADODB.Recordset")
      rs2.Open sql, conx 


      if not rs2.eof then %>
	<img src="../Imagens/<%=rs2("Arquivo")%>" width="21" height="15"></td>
<%    end if
    end if
%>    </td>
<%  
'   if rs("time1") <> "A definir" AND rs("time2") <> "A definir" then
      sql =		  "   SELECT * FROM Jogos"
      sql = sql & " WHERE cod_Aposta = " & rs_usuario("cod_Apostador")
      sql = sql & " AND cod_Jogo = " & rs("cod_Jogo")
'      set rs4 = conx.execute(sql)
      set rs4 = Server.CreateObject("ADODB.Recordset")
      rs4.Open sql, conx 


       if FormatoData = "Americano" then
         DatadoJogo = Mid(rs("data_jogo"),4,2) & "/" & left(rs("data_jogo"),2) & "/" & mid(rs("data_jogo"),7,4)
       else
         DatadoJogo = rs("data_jogo")
       end if

    
       if DateAdd("h", FusoHorario, now) < cdate(DatadoJogo) then

        if rs4.eof then     %>
           <td widht="10%" >
           <input type="text" name="placar_A_<%=rs("cod_jogo")%>" maxlength="2" size="2">&nbsp;&nbsp;X&nbsp; 
           <input type="text" name="placar_B_<%=rs("cod_jogo")%>" maxlength="2" size="2">
           </td>
<%else %>
           <td widht="10%" >
           <input type="text" name="placar_A_<%=rs("cod_jogo")%>" maxlength="2" size="2" value="<%=rs4("placar_A")%>">&nbsp;&nbsp;X&nbsp; 
           <input type="text" name="placar_B_<%=rs("cod_jogo")%>" maxlength="2" size="2" value="<%=rs4("placar_B")%>">
           </td>
<%  end if  
      elseif not(rs4.eof) then%> 
	<td widht="10%" ><%=rs4("placar_A")%>&nbsp;&nbsp;&nbsp;&nbsp;X&nbsp;&nbsp;&nbsp;&nbsp;<%=rs4("placar_B")%> </td> 
<% else%>
      <td widht="10%" >&nbsp;&nbsp;X&nbsp;&nbsp;</td> 
<%    end if

%>
<td widht="5%" >
<%
    if rs("time2") <> "A definir" then
      sql = "SELECT * FROM Pais where Pais = '" & rs("time2") & "'"
      'set rs2 = conx.execute(sql)
	  set rs2 = Server.CreateObject("ADODB.Recordset")
      rs2.Open sql, conx 
      
	  if not rs2.eof then %>
	<img src="../Imagens/<%=rs2("Arquivo")%>" width="21" height="15"></td>
<%    end if
    end if%>
     </td>
<%  if rs("time2") = "BRASIL" then %>
    <td  widht="60%" class="Brasil">BRASIL</td>
<%  elseif rs("time2") = "A definir" then%>
      <td widht="60%" class="Vazio"><%=rs("time2")%></td>
<%  else%>
      <td widht="60%" ><%=rs("time2")%></td>
<%  end if%>
  </tr>
<%  i = i + 1
    rs.MoveNext
  wend %>
</table>
<br>
  <div align="center">
    <input type="submit" name="btnIncluir" value="Atualizar" class="botao">&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">
  </div>
<p>&nbsp;</p>
</form>
</body>
<% 
 ' Fechar os objetos Recordsets 
  rs.Close
  rs2.Close
  rs4.Close
  rs_usuario.Close
 
  ' Eliminar os objetos Recordsets 
  Set rs = Nothing 
  Set rs2 = Nothing
  Set rs4 = Nothing
  Set rs5 = Nothing
  Set rs_usuario = Nothing
  
  ' Fechar o objeto da conexão 
  conx.Close 
 
 ' Eliminar o objeto da conexão 
  Set conx = Nothing 

 end if%>
</html>
