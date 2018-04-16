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
		  sql =      "INSERT INTO Apostadores (cod_Apostador, nome, contato, Pago, email, senha_apostador,controle_inclusao,Ativo)"
		  sql = sql & " 		    VALUES (" & codApostador & ", '" & request("nome") & "','" & request("contato") & "', 0, '" & request("email") & "','" & request("senha") & "','" & request("controle_inclusao") & "',1)"
		  conx.execute(sql)
		  sql = 	 "INSERT INTO Apostas (cod_Aposta, cod_Apostador,Total_Pontos, Total_Acertos)"
		  sql = sql & " 	  VALUES (" & codApostador & ", " & codApostador & ",0,0)"
		  conx.execute(sql)
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

			     sql = "UPDATE Resultados SET r_Placar_A = " & request("resultA") & ", r_Placar_B = " & request("resultB") & ", jaOcorreu = 1 WHERE cod_Jogo = " & request("cmbJogos")
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
				
				acertouPlacar = false ' Incluído em 2014 para controlar o ranking de maior acertador de placares corretos.

				if rs7("placar_A") = rs7("r_placar_A") and rs7("placar_B") = rs7("r_placar_B") then 'Placar Certo
					pontuacao = 10
					acertouPlacar = true
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
                              
                            'Atribuindo peso ponderado aos jogos das OITAVAS EM DIANTE | Incluído para a versão de 2013 e 2014

	                         if codJogo >= 49 AND codJogo <= 60 then 'Peso 2 para os Jogos das Oitavas e Quartas de Finais
                                   pontuacao = pontuacao * 2
			         else if codJogo >= 61 AND codJogo <= 63 then 'Peso 3 para os Jogos das Semi e Disputa de Terceiro Lugar 
		                    pontuacao = pontuacao * 3
				 else if codJogo = 64 then 'Peso 4 para o Jogo da Grande Final
		                    pontuacao = pontuacao * 4
				 end if
				 end if
                                 end if


				sql = "UPDATE Jogos SET Pontos = " & pontuacao & " WHERE cod_Aposta = " & rs7("cod_Aposta") & " and cod_Jogo = " & rs7("cod_jogo")
				conx.execute(sql)
				
				if acertouPlacar then 
					sql = "UPDATE Apostas SET Total_Pontos = Total_Pontos + " & pontuacao & ", Total_Acertos = Total_Acertos + 1 WHERE cod_Aposta = " & rs7("cod_Aposta")
				else
					sql = "UPDATE Apostas SET Total_Pontos = Total_Pontos + " & pontuacao & " WHERE cod_Aposta = " & rs7("cod_Aposta")
				end if
				
				conx.execute(sql)
				
				rs7.MoveNext

			wend
            rs7.Close
			Set rs7 = Nothing
	end function

   
   
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
	      <option value="49">Jogo 49</option>
	      <option value="50">Jogo 50</option>
	      <option value="51">Jogo 51</option>
	      <option value="52">Jogo 52</option>
	      <option value="53">Jogo 53</option>
	      <option value="54">Jogo 54</option>
	      <option value="55">Jogo 55</option>
	      <option value="56">Jogo 56</option>
	      <option value="57">Jogo 57</option>
	      <option value="58">Jogo 58</option>
	      <option value="59">Jogo 59</option>
	      <option value="60">Jogo 60</option>
	      <option value="61">Jogo 61</option>
	      <option value="62">Jogo 62</option>
	      <option value="63">Jogo 63</option>
	      <option value="64">Jogo 64</option>
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
		