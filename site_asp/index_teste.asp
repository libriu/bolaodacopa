<!--#include virtual="/comuns/configuracoes.asp"--> 


	
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

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<script language="JavaScript">

<!--

  $.get("<%=LinkAPIMP%>", function(resultado){});
  
//-->

</script>


<html>

<head>

  <title><%=TituloPagina%></title>


<!--#include virtual="/comuns/menu.asp"--> 


<br>

<table width="80%" align="center">

<tr> 

<td width="80%" aling="center"><center><img src="Imagens/Ranking_Principal.jpg"></center></td>

</table>



<br>



<table class="Bolao" width="80%" border="0" cellspacing="2" cellpadding="2" align="center">

  <tr>

    <th colspan="9" height="24">TABELA DE JOGOS | <%= day(DateAdd("h", FusoHorario, now)) & "/" & month(DateAdd("h",  FusoHorario, now)) & "/" & year(DateAdd("h",  FusoHorario, now)) & " - " & hour(DateAdd("h",  FusoHorario, now)) & ":" & minute(DateAdd("h",  FusoHorario, now)) & ":" & second(DateAdd("h",  FusoHorario, now)) %></th>

  </tr>

  <tr>

    <th colspan="9" height="24">PRIMEIRA FASE</th>

  </tr>



 <%


 set rs = Server.CreateObject("ADODB.Recordset")

         Set conx = Server.CreateObject("ADODB.Connection")

        conx.Open ConnStrMySQL 
  

        sql =	       "   SELECT jogo.ja_ocorreu, jogo.grupo, jogo.data_hora, jogo.cod_jogo, Pais_time1.nome as nome_time1, Pais_time2.nome as nome_time2, " 
        sql = sql & " Pais_time1.arquivo as arquivo_time1, Pais_time2.arquivo as arquivo_time2, jogo.r_placar_A, jogo.r_placar_B"
        sql = sql & " FROM Jogo, Pais as Pais_time1, Pais as Pais_time2"
        sql = sql & " WHERE Jogo.cod_paisA = Pais_time1.cod_pais"
        sql = sql & " and Jogo.cod_paisB = Pais_time2.cod_pais"
        sql = sql & " ORDER BY Jogo.cod_Jogo"
      
        set rs = Server.CreateObject("ADODB.Recordset")
      
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



    DatadoJogo = Retira_data(rs("data_hora"))
    DatadoJogoExibicao = Retira_data_exibicao(DatadoJogo)
    HoradoJogo = Retira_hora(rs("data_hora"))

    if DateAdd("h", FusoHorario, now) >= cdate(DatadoJogo) then

%>

      <td><a href='apostas.asp?cod=<%=rs("cod_Jogo")%>'><%=rs("cod_Jogo")%>.</a></td>

<%   else%>

      <td><%=rs("cod_Jogo")%>.</td>

<%

    end if


%>

   

    <td><%=DatadoJogoExibicao%></td>

    <td><%=HoradoJogo%></td>

    <td><%=rs("grupo")%></td>

<%  if rs("nome_time1") = "BRASIL" then

%>    <td widht="60%" class="Brasil">BRASIL</td>

<%  elseif rs("nome_time1") = "A definir" then%>

      <td widht="60%" class="vazio"><%=Server.HTMLEncode(rs("nome_time1"))%></td>

<%  else%>

      <td widht="60%" ><%=Server.HTMLEncode(rs("nome_time1"))%></td>

<%  end if%>

    <td>

<%  if rs("nome_time1") <> "A definir" then


%>

	<img src="Imagens/<%=rs("arquivo_time1")%>" width="21" height="15"></td>

<%    

    end if

%>    </td>

<%   if rs("ja_Ocorreu") then%>

      <td><%=rs("r_placar_A")%>&nbsp;X&nbsp;<%=rs("r_placar_B")%> </td>

<%   else%>

      <td>&nbsp;&nbsp;X&nbsp;&nbsp;</td>

<%

    end if

%>

<td>

<%

    if rs("nome_time2") <> "A definir" then

 %>

	<img src="Imagens/<%=rs("arquivo_time2")%>" width="21" height="15"></td>

<%    

    end if%>

     </td>

<%  if rs("nome_time2") = "BRASIL" then

%>    <td widht="60%" class="Brasil">BRASIL</td>

<%  elseif rs("nome_time2") = "A definir" then%>

      <td widht="60%" class="vazio"><%=Server.HTMLEncode(rs("nome_time2"))%></td>

<%  else%>

      <td widht="60%" ><%=Server.HTMLEncode(rs("nome_time2"))%></td>

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



     sql = " SELECT cod_apostador, login, contato, total_pontos, "
	 sql = sql & "[1] AS P1, [2] AS P2, [3] AS P3, [4] AS P4, [5] AS P5, [6] AS P6, [7] AS P7, [8] AS P8, [9] AS P9, [10] AS p10, "
	 sql = sql & "[11] AS p11, [12] AS p12, [13] AS p13, [14] AS p14, [15] AS P15, [16] AS P16, [17] AS P17, [18] AS P18, [19] AS P19, [20] AS p20, "
	 sql = sql & "[21] AS p21, [22] AS p22, [23] AS p23, [24] AS p24, [25] AS P25, [26] AS P26, [27] AS P27, [28] AS P28, [29] AS P29, [30] AS p30, "
	 sql = sql & "[31] AS p31, [32] AS p32, [33] AS p33, [34] AS p34, [35] AS P35, [36] AS P36, [37] AS P37, [38] AS P38, [39] AS P39, [40] AS p40, "
 	 sql = sql & "[41] AS p41, [42] AS p42, [43] AS p43, [44] AS p44, [45] AS P45, [46] AS P46, [47] AS P47, [48] AS P48, [49] AS P49, [50] AS p50, "
	 sql = sql & "[51] AS p51, [52] AS p52, [53] AS p53, [54] AS p54, [55] AS P55, [56] AS P56, [57] AS P57, [58] AS P58, [59] AS P59, [60] AS P60, "
	 sql = sql & "[61] AS p61, [62] AS p62, [63] AS p63, [64] AS p64 "
	 sql = sql & "FROM (SELECT a.cod_apostador, a.login, a.contato, r.total_pontos, ap.cod_jogo, ap.pontos FROM Apostador a "
	 sql = sql & "INNER JOIN Ranking r ON a.cod_Apostador = r.cod_Apostador "
	 sql = sql & "LEFT JOIN Aposta ap ON a.cod_Apostador = ap.cod_Apostador "
	 sql = sql & "WHERE a.Ativo = 1) sq PIVOT (SUM(pontos) " 
 	 sql = sql & "FOR cod_jogo IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20]"
 	 sql = sql & ",[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31],[32],[33],[34],[35],[36],[37],[38],[39],[40],[41],[42],[43],[44]"
	 sql = sql & ",[45],[46],[47],[48],[49],[50],[51],[52],[53],[54],[55],[56],[57],[58],[59],[60],[61],[62],[63],[64]))P "
 	 sql = sql & "ORDER BY Total_Pontos DESC, login, cod_apostador"
 
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

    <td  width="16%"><a href='cartao.asp?cod=<%= rs("cod_Apostador")%>&nome=<%= rs("login") %>' ><%=Server.HTMLEncode(rs("login")) %></a>

      </td> <td  width="14%"><%= Server.HTMLEncode(rs("Contato")) %></td>

		<td  width="3%"><%= rs("Total_Pontos") %></td>
<%

          for i = 1 to 64

		  if intPosicao mod 2 = 0 then

%>			<td class="LinhaPar" width="3%">

<%		  else %>

			<td class="LinhaImpar" width="3%">

<%		  end if

   IF IsNull(RS("P"&i)) = True THEN
     response.write ("0")
   else
       response.write (rs("P"&i))
   end if
   
   %>

	  </td>

<% next %>

	</tr>

<%
	   rs.MoveNext

  wend

%>

</table>



<br>

<br>



<table class="Bolao" width="80%" border="0" cellspacing="2" cellpadding="2" align="center">

  <tr>

    <th colspan="9" height="24">MURAL DE MENSAGENS (&Uacute;LTIMAS 20 MENSAGENS)</th>

  </tr>

  <tr>

    <td class="Titulo" >Nome</td>

    <td class="Titulo" >Contato</td>

    <td class="Titulo" >Data</td>

    <td class="Titulo" >Hora</td>

    <td class="Titulo" >Mensagem</td>



<%



         sql =     "SELECT TOP 20 * FROM Mensagem, Apostador WHERE Apostador.cod_Apostador = Mensagem.cod_Apostador"

	  sql = sql & " ORDER BY Mensagem.cod_Mensagem DESC"



          set rs4 = Server.CreateObject("ADODB.Recordset")

	

          rs4.Open sql, conx 



  i = 1





  while not rs4.eof %>



<%  if (i MOD 2) <> 0 then%>

      <tr class="LinhaImpar">

<%  else%>

    <tr class="LinhaPar">

<%  end if


DatadaMsg = Retira_data(rs4("data_hora"))
DatadaMsg= Retira_data_exibicao (DatadaMsg)
HoradaMsg = Retira_hora(rs4("data_hora"))




%>



    <td><%=Server.HTMLEncode(rs4("login"))%></td>

    <td><%=Server.HTMLEncode(rs4("contato"))%></td>

    <td><%=DatadaMsg%></td>

    <td><%=HoradaMsg%></td>

    <td widht="60%"><%=Server.HTMLEncode(rs4("texto"))%></td>







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


  Set rs4 = Nothing

  ' Fechar o objeto da conexão 

  conx.Close 

 

 ' Eliminar o objeto da conexão 

  Set conx = Nothing 







%>



<p>&nbsp;</p>

</body>

</html>

	