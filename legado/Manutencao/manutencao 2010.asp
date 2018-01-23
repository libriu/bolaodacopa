<html>
<head>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title>Bolao da Copa das Confederações 2013 - Inclusão de Apostadores</title>
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
		 set rs6 = Server.CreateObject("ADODB.Recordset")
		 
     
	if request("btnIncluir") <> empty then
		sql = "SELECT cod_Apostador FROM Apostadores WHERE nome = '" & request("nome") & "'"
		rs.Open sql, conx 
        if not rs.eof then
		  Mensagem = "Apostador já existente. Utilize outro nome!"
		else
		  sql = "SELECT MAX(Apostadores.cod_Apostador) as maxCodApostador FROM Apostadores"
		  rs2.Open sql, conx
		  codApostador = rs2("maxCodApostador") + 1
          rs2.Close
		  sql =      "INSERT INTO Apostadores (cod_Apostador, nome, contato, Pago, email, senha_apostador,controle_inclusao)"
		  sql = sql & " 		    VALUES (" & codApostador & ", '" & request("nome") & "','" & request("contato") & "', 0, '" & request("email") & "','" & request("senha") & "','" & request("controle_inclusao") & "')"
		  conx.execute(sql)
		  sql = 	 "INSERT INTO Apostas (cod_Aposta, cod_Apostador,Total_Pontos)"
		  sql = sql & " 	  VALUES (" & codApostador & ", " & codApostador & ",0)"
		  conx.execute(sql)
		'Incluindo uma nova aposta
		   codInsercao = codApostador
		   for i = 1 to 20
		   if request("placar_A_" & i) <> empty and request("placar_B_" & i) <> empty then
		     if ISNUMERIC(request("placar_A_" & i)) and ISNUMERIC(request("placar_B_" & i)) then
			sql = "SELECT * FROM Jogos"
			sql = sql & " WHERE cod_Aposta = " & codApostador
			sql = sql & " AND cod_Jogo = " & i
			rs5.Open sql, conx
			if rs5.eof then
			  sql = 	  "INSERT INTO Jogos (cod_Aposta, cod_Jogo, placar_A, placar_B,pontos)"
			  sql = sql & " 	  VALUES (" & codInsercao & ", " & i & ", " & request("placar_A_" & i) & ", " & request("placar_B_" & i) & ",0)"
			  conx.execute(sql)
			end if
            rs5.Close
		    end if
		    end if
		 next
		  Mensagem = "Apostador incluído com sucesso!"
		end if
        rs.Close
	 else
		 if request("btnResultado") <> empty then

                                               on error resume next

		    'Incluindo um novo resultado
			 sql = "SELECT cod_Jogo FROM Resultados WHERE cod_Jogo = " & request("cmbJogos") & " and Resultados.jaOcorreu = false"





			 rs.Open sql, conx

			 if  not rs.eof then


				 conx.execute("set autocommit = 0")
				 conx.execute("start transaction")

			     sql =	 "UPDATE Resultados SET r_Placar_A = " & request("resultA") & ", r_Placar_B = " & request("resultB") & ", jaOcorreu = 1 WHERE cod_Jogo = " & request("cmbJogos")
				 conx.execute(sql)


				 Recalcula_Ranking request("cmbJogos")


                                                                                      if err then
              		                                                Mensagem = "Não foi possível incluir os placares. DEU ERRO!!!!!!!!!"
   				     conx.execute("rollback")
                                                                                      else
   				     conx.execute("commit")
  		                                                Mensagem = "Resultado registrado com sucesso!"
                                                                                      end if
                                                                  else
		         Mensagem = "Jogo não existe ou resultado já incluído anteriormente!"
			 end if
			 rs.Close
		 else
		   if request("btnTimes") <> empty then
		    'Definindo os jogos do Mata-mata
			 sql = "SELECT cod_Jogo FROM Resultados WHERE cod_Jogo = " & request("cmbJogos")
			 rs.Open sql, conx
             if  not rs.eof then
			     sql =	 "UPDATE Resultados SET time1 = '" & request("Time_A") & "', time2 = '" & request("Time_B") & "' WHERE cod_Jogo = " & request("cmbJogos")
			     conx.execute(sql)
			     Mensagem = "Times atualizados com sucesso!"
			 end if
             rs.Close
		    else
			Mensagem = ""
		    end if
		 end if
	 
	 
	 end if

   function recalcula_Ranking( codJogo )
			
			set rs7 = Server.CreateObject("ADODB.Recordset") 
			sql =	    "SELECT DISTINCT Jogos.cod_Aposta, Resultados.cod_Jogo, Jogos.placar_A, Jogos.placar_B, Resultados.r_placar_A, Resultados.r_placar_B, Jogos.Pontos"
			sql = sql & "		FROM Apostas, Jogos, Resultados"
			sql = sql & "	       WHERE Resultados.cod_Jogo = Jogos.cod_Jogo and Jogos.cod_Jogo = " & codJogo

			rs7.Open sql, conx

			while not rs7.eof
				if rs7("placar_A") = rs7("r_placar_A") and rs7("placar_B") = rs7("r_placar_B") then 'Placar Certo
					pontuacao = 10
				else if rs7("placar_A") > rs7("placar_B") and rs7("r_placar_A") > rs7("r_placar_B") then 'Acertou que Time A Venceria
						if rs7("placar_A") = rs7("r_placar_A") then 'Acertou Escore do Vencedor
							pontuacao = 5
						else if rs7("placar_B") = rs7("r_placar_B") then 'Acertou Escore do Perdedor
								pontuacao = 4
							 else
								pontuacao = 3 'Acertou somente quem iria vencer.
							 end if
						end if

					else if rs7("placar_A") < rs7("placar_B") and rs7("r_placar_A") < rs7("r_placar_B") then 'Acertou que Time B Venceria
							if rs7("placar_A") = rs7("r_placar_A") then 'Acertou Escore do Perdedor
								pontuacao = 4
							else if rs7("placar_B") = rs7("r_placar_B") then 'Acertou Escore do Vencedor
									pontuacao = 5
								 else
									pontuacao = 3 'Acertou somente quem iria vencer.
								 end if
							end if

						else if rs7("placar_A") = rs7("placar_B") and rs7("r_placar_A") = rs7("r_placar_B") then 'Acertou que daria empate
								pontuacao = 4  'Ex.: APostou 3 X 3 e deu 2 X 2
							 else if rs7("placar_A") = rs7("r_placar_B") and rs7("placar_B") = rs7("r_placar_A") then 'Placar Invertido.
									pontuacao = 1  'Ex.: APostou 3 X 2 e deu 2 X 3
							      else
								    pontuacao = 0
								  end if
							 end if
						end if
					end if
			    end if

				sql = "UPDATE Jogos SET Pontos = " & pontuacao & " WHERE cod_Aposta = " & rs7("cod_Aposta") & " and cod_Jogo = " & rs7("cod_jogo")
				conx.execute(sql)
				sql = "UPDATE Apostas SET Total_Pontos = Total_Pontos + " & pontuacao & " WHERE cod_Aposta = " & rs7("cod_Aposta")
				conx.execute(sql)
				rs7.MoveNext

			wend
            rs7.Close
			Set rs7 = Nothing
	end function

   
   
%>

<html>
<head>
<title>Bolao da Copa das Confederações 2013 - Administração</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<div class="mensagem">
  <% response.write Mensagem & "<BR>" %>
</div>
<BR>
<form name="formInclusao" method="post" action="manutencao.asp">
  <table class="Bolao" width="80%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr>
      <th colspan="8" height="24">INCLUS&Atilde;O DE APOSTAS
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
      <th colspan="3" >SENHA :
      </th>
      <th colspan="5" align="left">
	<input type="text" name="senha" size="30" maxlength="30">
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
<%
   sql =	       "   SELECT * FROM Resultados"
       sql = sql & " ORDER BY Resultados.cod_Jogo"
   rs3.Open sql, conx

  i = 1

  while not rs3.eof

    if (i MOD 2) <> 0 then%>
      <tr class="LinhaImpar">
<%  else%>
    <tr class="LinhaPar">
<%  end if%>
    <td widht="10%"><%=rs3("cod_Jogo")%>.</td>
    <td widht="10%"><%=rs3("data_jogo")%></td>
<%  if rs3("time1") = "BRASIL" then
%>    <td widht="60%" class="Brasil">BRASIL</td>
<%  elseif rs3("time1") = "A definir" then%>
      <td widht="60%" class="vazio"><%=rs3("time1")%></td>
<%  else%>
      <td widht="60%" ><%=rs3("time1")%></td>
<%  end if%>
    <td widht="5%" >
<%  if rs3("time1") <> "A definir" then
      sql = "SELECT * FROM Pais where Pais = '" & rs3("time1") & "'"
      rs2.Open sql, conx
      if not rs2.eof then %>
	<img src="../Imagens/<%=rs2("Arquivo")%>" width="21" height="15"></td>
<%    end if
      rs2.Close
    end if
%>    </td>
<%  if rs3("time1") <> "A definir" AND rs3("time2") <> "A definir" AND now() < cdate(mid(rs3("data_jogo"),4,3) & left(rs3("data_jogo"),3) & right(rs3("data_jogo"),4)) then %>
<td widht="10%" >
<input type="text" name="placar_A_<%=rs3("cod_jogo")%>" maxlength="2" size="2">&nbsp;&nbsp;X&nbsp;
<input type="text" name="placar_B_<%=rs3("cod_jogo")%>" maxlength="2" size="2">
</td>
<%  else%>
      <td widht="10%" >&nbsp;&nbsp;X&nbsp;&nbsp;</td>
<%
    end if
%>
<td widht="5%" >
<%
    if rs3("time2") <> "A definir" then
      sql = "SELECT * FROM Pais where Pais = '" & rs3("time2") & "'"
      rs2.Open sql, conx
      if not rs2.eof then %>
	<img src="../Imagens/<%=rs2("Arquivo")%>" width="21" height="15"></td>
<%    end if
      rs2.Close
    end if%>
     </td>
<%  if rs3("time2") = "BRASIL" then %>
    <td  widht="60%" class="Brasil">BRASIL</td>
<%  elseif rs3("time2") = "A definir" then%>
      <td widht="60%" class="Vazio"><%=rs3("time2")%></td>
<%  else%>
      <td widht="60%" ><%=rs3("time2")%></td>
<%  end if%>
  </tr>
<%  i = i + 1
    rs3.MoveNext
  wend 
  Rs3.Close
%>
  </table><br>
  <div align="center">
    <input type="submit" name="btnIncluir" value="Incluir" class="botao">
  </div>

</form>
<HR>
<div align="center">
  <form name="formResultado" method="post" action="manutencao.asp">
    <table width="40%" border="0" cellspacing="2" cellpadding="2" class="Bolao" align="center">
      <tr>
	<th colspan="2">INCLUS&Atilde;O DE RESULTADOS</th>
      </tr>
      <tr>
	<td>Selecione o Jogo</td>
	<td>
	  <div align="left">
	    <select name="cmbJogos">
	       
               <%
                    sql = "SELECT cod_Jogo FROM Resultados WHERE jaOcorreu = False ORDER BY Resultados.cod_Jogo"
		            rs6.Open sql, conx 
                    While not rs6.EOF
 %>
                        
                    <option value="<%= rs6("cod_jogo")%>">Jogo <%= rs6("cod_jogo")%></option>
	     	    <% rs6.MoveNext
                    wend
					rs6.Close %> 
	    </select>
	  </div>
	</td>
      </tr>
      <tr>
	<td>&nbsp;</td>
	<td> </td>
      </tr>
      <tr>
	<td>Placar Time A
	  <input type="text" name="resultA" size="2" maxlength="2">
	</td>
	<td>
	  <input type="text" name="resultB" size="2" maxlength="2">
	  Placar Time B </td>
      </tr>
    </table>
    <br>
    <input type="submit" name="btnResultado" value="OK" class="botao">
    <br>
  </form>
  <br>
</div>
<HR>
<div align="center">
<form name="formTimes" method="post" action="manutencao.asp">
    <table width="40%" border="0" cellspacing="2" cellpadding="2" class="Bolao" align="center">
      <tr>
	<th colspan="2">INCLUS&Atilde;O DE TIMES</th>
      </tr>
      <tr>
	<td>Selecione o Jogo</td>
	<td>
	  <div align="left">
	    <select name="cmbJogos">
	      <option value="13">Jogo 13</option>
	      <option value="14">Jogo 14</option>
	      <option value="15">Jogo 15</option>
	      <option value="16">Jogo 16</option>
	    </select>
	  </div>
	</td>
      </tr>
      <tr>
	<td>&nbsp;</td>
	<td> </td>
      </tr>
      <tr>
	<td>Time A:
	  <input type="text" name="Time_A" size="20" maxlength="20">
	</td>
      </tr>
      <tr>
	<td>Time B: <input type="text" name="Time_B" size="20" maxlength="20"> </td>
      </tr>
    </table>
    <br>
    <input type="submit" name="btnTimes" value="OK" class="botao">
    <br>
  </form>
<p>&nbsp;</p>
<a href="SQL.asp">Executar SQL</a> </div>
</body>

<%  
   end if
   Set rs = Nothing
   Set rs2 = Nothing
   Set rs3 = Nothing   
   Set rs5 = Nothing 
   Set rs6 = Nothing  

   conx.close
   Set conx = Nothing
%>
 </html>
