<!--#include virtual="/comuns/configuracoes.asp"--> 

<html>

<head>

<title><%=TituloPagina%></title>

<!--#include virtual="/comuns/menu.asp"--> 

 <%

        



         Set conx = Server.CreateObject("ADODB.Connection")

         conx.Open ConnStrMySQL 

    

         sql =	      "   SELECT * FROM Det_Grupos, Apostadores, Apostas, Jogos, Resultados"

	 sql = sql & "	  WHERE Apostadores.cod_Apostador = Apostas.Cod_aposta"

         sql = sql & "	  AND   Det_Grupos.cod_Apostador  = Apostadores.cod_Apostador"

         sql = sql & "	  AND   Apostas.Cod_aposta  = Jogos.cod_Aposta"

         sql = sql & "	  AND   Jogos.cod_Jogo = Resultados.cod_Jogo" 

         sql = sql & "	  AND Jogos.Cod_Jogo = " & SafeSQL(request("codJogo"))

         sql = sql & "	  AND Det_Grupos.Cod_Grupo = " & SafeSQL(request("codGrupo"))

         sql = sql & "	  AND Apostadores.Ativo = 1"

	 sql = sql & " ORDER BY Apostas.Total_Pontos DESC, Apostadores.nome"



	 set rs = Server.CreateObject("ADODB.Recordset")

	 set rs2 = Server.CreateObject("ADODB.Recordset")

	

         rs.Open sql, conx 



%>

  



<table class="Bolao" width="80%" border="0" cellspacing="2" cellpadding="2" align="center">

  <tr>

    <th colspan="9" height="24">APOSTAS DO JOGO <%= rs("cod_Jogo") & " - " & rs("time1") & " x " & rs("time2") & " | " & rs("data_jogo") & " - " & left(rs("hora_jogo"),5) %></th>

  </tr>



<%



i = 1  



while not rs.eof %>



  

<%  if (i MOD 2) <> 0 then%>

      <tr class="LinhaImpar">

<%  else%>

    <tr class="LinhaPar">

<%  end if%>

    <td><%=rs("total_pontos")%></td>

    <td><%=rs("nome")%></td>

    <td><%=rs("contato")%></td>

    <td><%=rs("grupo")%></td>

<%  if rs("time1") = "BRASIL" then

%>    <td widht="60%" class="Brasil">BRASIL</td>

<%  elseif rs("time1") = "A definir" then%>

      <td widht="35%" class="vazio"><%=rs("time1")%></td>

<%  else%>

      <td widht="35%" ><%=rs("time1")%></td>

<%  end if%>

    <td>

<%  if rs("time1") <> "A definir" then



      sql = "SELECT * FROM Pais where Pais = '" & rs("time1") & "'"

      rs2.Open sql, conx 



      if not rs2.eof then %>

	<img src="Imagens/<%=rs2("Arquivo")%>" width="21" height="15"></td>

<%    end if

      rs2.Close

    end if

%>    </td>

<%   

     if FormatoData = "Americano" then
       DatadoJogo = Mid(rs("data_jogo"),4,2) & "/" & left(rs("data_jogo"),2) & "/" & mid(rs("data_jogo"),7,4)
     else
       DatadoJogo = rs("data_jogo")
     end if

    

     if DateAdd("h", FusoHorario, now) >= cdate(DatadoJogo) then


%>

      <td><%=rs("placar_A")%>&nbsp;X&nbsp;<%=rs("placar_B")%> </td>

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



<div align="center"><br>

  <br>

  <a href="index.asp">P&aacute;gina Principal</a> </div>

<p>&nbsp;</p>



<%

  

   ' Eliminar os objetos Recordsets 

  Set rs = Nothing 

  Set rs2 = Nothing

  

  ' Fechar o objeto da conexão 

  conx.Close 

 

 ' Eliminar o objeto da conexão 

  Set conx = Nothing 







%>



<p>&nbsp;</p>

</body>

</html>

