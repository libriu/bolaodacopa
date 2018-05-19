<!--#include virtual="/comuns/configuracoes.asp"--> 

<html>

<head>

<title><%=TituloPagina%> - Estat&iacute;stica</title>


<!--#include virtual="/comuns/menu.asp"--> 


<table class="Bolao" width="80%" border="0" cellspacing="2" cellpadding="2" align="center">

  <tr> 

    <th height="24">ESTAT&Iacute;STICAS DE APOSTAS | <%= day(DateAdd("h", FusoHorario, now)) & "/" & month(DateAdd("h",  FusoHorario, now)) & "/" & year(DateAdd("h",  FusoHorario, now)) & " - " & hour(DateAdd("h",  FusoHorario, now)) & ":" & minute(DateAdd("h",  FusoHorario, now)) & ":" & second(DateAdd("h",  FusoHorario, now)) %></th>

  </tr>

  <%





         Set conx = Server.CreateObject("ADODB.Connection")

         conx.Open ConnStrMySQL 





         set rs = Server.CreateObject("ADODB.Recordset")

         set rs2 = Server.CreateObject("ADODB.Recordset")

		         

		 sql = "select count(*) as qtde from Apostadores WHERE Ativo = 1"

         rs.Open sql, conx 



    	qtde_Apostadores = rs("qtde")

        rs.close 



	jogo_ant = 0



    sql = "select time1, placar_A, placar_B, r_placar_A, r_placar_B, time2, Jogos.cod_jogo, data_jogo, count(*) as qtde from Apostadores, Jogos, Resultados where" _

	  & "  cod_apostador = cod_aposta and" _

	  & "  Resultados.cod_jogo = Jogos.cod_jogo and" _

          & "  Apostadores.Ativo = 1" _

	  & "  group by Jogos.cod_jogo, time1, time2, placar_A, placar_B, r_placar_A, r_placar_B" _

	  & "  order by Jogos.cod_jogo desc, qtde desc"

' 	  & "  Resultados.jaOcorreu = true and" _

   

    rs.Open sql, conx 



    i = 1

 

   while not rs.eof



     if FormatoData = "Americano" then
       DatadoJogo = Mid(rs("data_jogo"),4,2) & "/" & left(rs("data_jogo"),2) & "/" & mid(rs("data_jogo"),7,4)
     else
       DatadoJogo = rs("data_jogo")
     end if

    

     if DateAdd("h", FusoHorario, now) >= cdate(DatadoJogo) then





    if rs("cod_jogo") <> jogo_ant then

	  if jogo_ant <> 0 then

	response.write "</table>"

	total = 0

		sql = "select count(*) as qtde, time1, time2 from Apostadores, Jogos, Resultados where" _

	     & " cod_apostador = cod_aposta and " _

	     & " Jogos.cod_jogo = Resultados.cod_jogo and " _

             & " Apostadores.Ativo = 1 and " _

	     & " Jogos.cod_jogo = " & jogo_ant & " and " _

			 & " placar_A > placar_B" _

			 & " group by time1, time2"

	    'set rs3 = conx.execute(sql)

            rs2.Open sql, conx 

			



%>	<table class="Bolao" width="40%" border="0" cellspacing="2" cellpadding="2" align="left">

	<tr class="LinhaPar">

	  <td widht="50%">TIPO DE APOSTA</td>

       <td widht="25%">QTDE APOSTAS</td>

	  <td widht="25%">% DE APOSTAS</td>

	</TR>

<%	if not(rs2.eof) then

	   total = total + cint(rs2("qtde"))

%>

	<tr class="LinhaImpar">

	  <td widht="50%"><%=rs2("time1")%> vencendo</td>

      <td widht="25%">&nbsp;<%=rs2("qtde")%> </td>

	  <td widht="25%">&nbsp;<%=formatnumber(cint(rs2("qtde"))/cint(qtde_Apostadores)*100,2)%></td>

	</TR>

<%	end if

        rs2.close 

		

		sql = "select count(*) as qtde, time1, time2 from Apostadores, Jogos, Resultados where" _

	     & " cod_apostador = cod_aposta and " _

	     & " Jogos.cod_jogo = Resultados.cod_jogo and " _

	     & " Apostadores.Ativo = 1 and " _

	     & " Jogos.cod_jogo = " & jogo_ant & " and " _

			 & " placar_A < placar_B" _

			 & " group by time1, time2"

            rs2.Open sql, conx 

			



	if not(rs2.eof) then

	   total = total + cint(rs2("qtde"))

%>

	<tr class="LinhaPar">

	  <td widht="50%"><%=rs2("time2")%> vencendo</td>

	   <td widht="25%">&nbsp;<%=rs2("qtde")%> </td>

      <td widht="25%">&nbsp;<%=formatnumber(cint(rs2("qtde"))/cint(qtde_Apostadores)*100,2)%></td>

	</TR>



<%	end if

        rs2.close

		

	sql = "select count(*) as qtde, time1, time2 from Apostadores, Jogos, Resultados where" _

	     & " cod_apostador = cod_aposta and " _

	     & " Jogos.cod_jogo = Resultados.cod_jogo and " _

             & "  Apostadores.Ativo = 1 and " _

	     & " Jogos.cod_jogo = " & jogo_ant & " and " _

			 & " placar_A = placar_B" _

			 & " group by time1, time2"

        rs2.Open sql, conx 

		

       if not(rs2.eof) then

	   total = total + cint(rs2("qtde"))

%>

	<tr class="LinhaImpar">

	  <td widht="60%">Empate</td>

      <td widht="25%">&nbsp;<%=rs2("qtde")%> </td>

	  <td widht="40%">&nbsp;<%=formatnumber(cint(rs2("qtde"))/cint(qtde_Apostadores)*100,2)%></td>

	</TR>

<%    end if

      if total <> cint(qtde_Apostadores) then

%>

	<tr class="LinhaPar">

	  <td widht="60%">Não Apostou</td>

      <td widht="25%">&nbsp;<%=cint(qtde_Apostadores) - total%> </td>

	  <td widht="40%">&nbsp;<%=formatnumber((cint(qtde_Apostadores) - total)/cint(qtde_Apostadores)*100,2)%></td>

	</TR>

<%    end if

      rs2.close 

	 

%>

      </table>

<%  end if %>

  <tr>

    <th height="24">RESULTADO DO JOGO <%=rs("cod_jogo")%>: <%=rs("time1") & " " & rs("r_placar_A") & " X " & rs("r_placar_B") & " " & rs("time2")%></th>

  </tr>

  <tr class="LinhaPar">

    <td >

      <table class="Bolao" width="60%" border="0" cellspacing="2" cellpadding="2" align="left">

	<tr class="LinhaPar">

	  <td widht="30%" >TIME A</td>

	  <td widht="20%">APOSTA</td>

	  <td widht="30%" >TIME B</td>

      <td widht="10%" >QTDE DE APOSTAS</td>

	  <td widht="10%" >% DE APOSTAS</td>

	</TR>

    </td>

  </TR>

  <% jogo_ant = rs("cod_jogo")

     i = 1

   end if



    if (i MOD 2) <> 0 then%>

  <tr class="LinhaImpar">

    <%	else%>

  <tr class="LinhaPar">

    <%	end if%>

    <td widht="30%" ><%=rs("time1")%></td>

    <td widht="20%"><a href='apostadoresPlacar.asp?codJogo=<%=rs("cod_Jogo")%>&p1=<%=rs("placar_A")%>&p2=<%=rs("placar_B")%>'><%=rs("placar_A")%>&nbsp;X&nbsp;<%=rs("placar_B")%></a> </td>

    <td widht="30%" ><%=rs("time2")%></td>

    <td widht="10%" ><%=rs("qtde")%></td>

    <td widht="10%" >&nbsp;<%=formatnumber(cint(rs("qtde"))/cint(qtde_Apostadores)*100,2)%></td>

  </tr>

  <%  i = i + 1



end if



    rs.MoveNext

  wend 

  rs.close

%>

</table>

<%	   total = 0

		sql = "select count(*) as qtde, time1, time2 from Apostadores, Jogos, Resultados where" _

	     & " cod_apostador = cod_aposta and " _

	     & " Jogos.cod_jogo = Resultados.cod_jogo and " _

             & " Apostadores.Ativo = 1 and " _

	     & " Jogos.cod_jogo = " & jogo_ant & " and " _

			 & " placar_A > placar_B" _

			 & " group by time1, time2"

            rs2.Open sql, conx 

			

%>	<table class="Bolao" width="40%" border="0" cellspacing="2" cellpadding="2" align="left">

	<tr class="LinhaPar">

	  <td widht="50%">TIPO DE APOSTA</td>

       <td widht="25%">QTDE APOSTAS</td>

	  <td widht="25%">% DE APOSTAS</td>

	</TR>

<%	if not(rs2.eof) then

	   total = total + cint(rs2("qtde"))

%>

	<tr class="LinhaImpar">

	  <td widht="60%"><%=rs2("time1")%> vencendo</td>

      <td widht="25%">&nbsp;<%=rs2("qtde")%> </td>

	  <td widht="40%">&nbsp;<%=formatnumber(cint(rs2("qtde"))/cint(qtde_Apostadores)*100,2)%></td>

	</TR>

<%	end if

        rs2.close 

		



		sql = "select count(*) as qtde, time1, time2 from Apostadores, Jogos, Resultados where" _

	     & " cod_apostador = cod_aposta and " _

	     & " Jogos.cod_jogo = Resultados.cod_jogo and " _

             & "  Apostadores.Ativo = 1 and " _

	     & " Jogos.cod_jogo = " & jogo_ant & " and " _

			 & " placar_A < placar_B" _

			 & " group by time1, time2"



            rs2.Open sql, conx 

			



	if not(rs2.eof) then

	   total = total + cint(rs2("qtde"))

%>

	<tr class="LinhaPar">

	  <td widht="60%"><%=rs2("time2")%> vencendo</td>

      <td widht="25%">&nbsp;<%=rs2("qtde")%> </td>

	  <td widht="40%">&nbsp;<%=formatnumber(cint(rs2("qtde"))/cint(qtde_Apostadores)*100,2)%></td>

	</TR>



<%	end if

        rs2.close 

		

		sql = "select count(*) as qtde, time1, time2 from Apostadores, Jogos, Resultados where" _

	     & " cod_apostador = cod_aposta and " _

	     & " Jogos.cod_jogo = Resultados.cod_jogo and " _

             & " Apostadores.Ativo = 1 and " _

	     & " Jogos.cod_jogo = " & jogo_ant & " and " _

			 & " placar_A = placar_B" _

			 & " group by time1, time2"

            rs2.Open sql, conx 

			



       if not(rs2.eof) then

	   total = total + cint(rs2("qtde"))

%>

	<tr class="LinhaImpar">

	  <td widht="60%">Empate</td>

      <td widht="25%">&nbsp;<%=rs2("qtde")%> </td>

	  <td widht="40%">&nbsp;<%=formatnumber(cint(rs2("qtde"))/cint(qtde_Apostadores)*100,2)%></td>

	</TR>

<%    end if

       

	 



       if cint(total) <> cint(qtde_Apostadores) then

%>

	<tr class="LinhaPar">

	  <td widht="60%">Não Apostou</td>

      <td widht="25%">&nbsp;<%=cint(qtde_Apostadores) - total%> </td>

	  <td widht="40%">&nbsp;<%=formatnumber((cint(qtde_Apostadores) - total)/cint(qtde_Apostadores)*100,2)%></td>

	</TR>

<%     end if

       rs2.close

conx.close



set rs = nothing

set rs2 = nothing

set conx = nothing

%>

      </table>

</table>

<div align="center"><br>

  <br>

  <a href="index.asp">P&aacute;gina Principal</a> </div>

<p>&nbsp;</p>

</body>

</html>

