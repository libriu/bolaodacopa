<!--#include virtual="/comuns/configuracoes.asp"--> 

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

<%  if Session("manut") = empty then

    response.write ("Usuario nao autorizado!!!<br>")

    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")

  else

%>



<%


         Set conx = Server.CreateObject("ADODB.Connection")

         conx.Open ConnStrMySQL 





         set rs = Server.CreateObject("ADODB.Recordset")

         set rs2 = Server.CreateObject("ADODB.Recordset")        

         set rs3 = Server.CreateObject("ADODB.Recordset")

         set rs5 = Server.CreateObject("ADODB.Recordset")

	 set rs6 = Server.CreateObject("ADODB.Recordset")

		 

     

	if request("btnIncluir") <> empty then

		sql = "SELECT cod_Apostador FROM Apostador WHERE login = '" & SafeSQL(request("nome")) & "'"

		rs.Open sql, conx 

        if not rs.eof then

		  Mensagem = "Apostador ja existente. Utilize outro nome!"

		else

		   sql = "SELECT cod_Apostador FROM Apostador WHERE login = '" & SafeSQL(TirarAcento(request("controle_inclusao"))) & "'"

		   rs3.Open sql, conx 

           if rs3.eof then

		      Mensagem = "Controlador da Inclusao inexistente"

			else

   		  		sql = "SELECT MAX(Apostador.cod_Apostador) as maxCodApostador FROM Apostador"

		  		rs2.Open sql, conx

		  		codApostador = rs2("maxCodApostador") + 1

          		rs2.Close

		  		sql =      "INSERT INTO Apostador (cod_Apostador, login, contato, email, senha, cod_apost_ativador ,Ativo,Celular,cidade)"

		  		sql = sql & " 		    VALUES (" & codApostador & ", '" & SafeSQL(TirarAcento(request("nome"))) & "','" & SafeSQL(TirarAcento(request("contato"))) & "', '" & SafeSQL(TirarAcento(request("email"))) & "','" & SafeSQL(TirarAcento(request("senha"))) & "'," & rs3("cod_Apostador") & ",1,'" & SafeSQL(request("celular")) & "','" & SafeSQL(TirarAcento(request("cidade"))) & "')"

			  	conx.execute(sql)

		  		sql = 	 "INSERT INTO Ranking (cod_Apostador,Total_Pontos, Total_Acertos)"

		  		sql = sql & " 	  VALUES (" & codApostador & ", 0,0)"

		  		conx.execute(sql)

		  		Mensagem = "Apostador incluido com sucesso!"

			end if

			rs3.close

		end if

                rs.Close

	 else

		 if request("btnResultado") <> empty then



'                    on error resume next



		    'Incluindo um novo resultado

			 sql = "SELECT cod_Jogo FROM Jogo WHERE cod_Jogo = " & SafeSQL(request("cmbJogos")) & " and ja_Ocorreu = 0"



			 rs.Open sql, conx



			 if  not rs.eof then



'				 conx.execute("set autocommit OFF")

'				 conx.execute("BEGIN transaction resultados")



			     sql = "UPDATE Jogo SET r_Placar_A = " & SafeSQL(request("resultA")) & ", r_Placar_B = " & SafeSQL(request("resultB")) & ", ja_Ocorreu = 1 WHERE cod_Jogo = " & SafeSQL(request("cmbJogos"))

				 conx.execute(sql)





				 Recalcula_Ranking request("cmbJogos")





                             if err then

              		         Mensagem = "Nao foi possivel incluir os placares. DEU ERRO!!!!!!!!!"

'   			         conx.execute("rollback transaction resultados")

                             else

 '  			         conx.execute("commit transaction resultados")

  		                 Mensagem = "Resultado registrado com sucesso!"

                             end if

                         else

		             Mensagem = "Jogo nao existe ou resultado ja incluido anteriormente!"

			 end if

'			 conx.execute("set autocommit ON")

			 rs.Close

		 else

		   if request("btnTimes") <> empty then

		    'Definindo os jogos do Mata-mata

			 sql = "SELECT cod_Jogo FROM Jogo WHERE cod_Jogo = " & SafeSQL(request("cmbJogos"))

			 rs.Open sql, conx

             if  not rs.eof then

  			     sql = "SELECT * FROM Pais WHERE nome = '" & SafeSQL(TirarAcento(request("Time_A"))) & "'"

				 rs2.open sql, conx

				 sql = "SELECT * FROM Pais WHERE nome = '" & SafeSQL(TirarAcento(request("Time_B"))) & "'"

				 rs3.open sql, conx

				 if rs2.eof or rs3.eof then

		   		     Mensagem = "Times inexistentes!"

				 else

			         sql =	 "UPDATE Jogo SET cod_paisA = " & rs2("cod_pais") & ", cod_paisB = " & rs3("cod_pais") & " WHERE cod_Jogo = " & SafeSQL(request("cmbJogos"))

			         conx.execute(sql)

			         Mensagem = "Times atualizados com sucesso!"
					 
				end if

				rs2.Close

				rs3.Close

		  
		  
			 end if

             rs.Close

		    else

  				Mensagem = ""

		    end if

		 end if

	 end if


   function recalcula_Ranking( codJogo )

                            'Atribuindo peso ponderado aos jogos das OITAVAS EM DIANTE | Inclusdo para a versao de 2013 e 2014

				 peso = 1

	                         if codJogo >= 49 AND codJogo <= 60 then 'Peso 2 para os Jogos das Oitavas e Quartas de Finais

                                   peso = 2

			         else if codJogo >= 61 AND codJogo <= 63 then 'Peso 3 para os Jogos das Semi e Disputa de Terceiro Lugar 

		                    peso = 3

				 else if codJogo = 64 then 'Peso 4 para o Jogo da Grande Final

		                    peso = 4

				 end if

				 end if

                                 end if

			''--Placar Certo
			sql =	    "UPDATE Aposta SET pontos = 10 * " & peso & " FROM Aposta a INNER JOIN Jogo j ON a.cod_Jogo = j.cod_Jogo "
			sql = sql & "	WHERE a.placar_A = j.r_placar_A AND a.placar_B = j.r_placar_B "
			sql = sql & "	AND a.cod_Jogo = " & SafeSQL(codJogo)
			conx.execute(sql)

			''--Acertou que Time A Venceria e escore do vencedor
			sql =	    "UPDATE Aposta SET pontos = 5 * " & peso & " FROM Aposta a INNER JOIN Jogo j ON a.cod_Jogo = j.cod_Jogo "
			sql = sql & "	WHERE a.placar_A > a.placar_B AND j.r_placar_A > j.r_placar_B "
			sql = sql & "	AND a.placar_A = j.r_placar_A AND a.placar_B <> j.r_placar_B "
			sql = sql & "	AND a.cod_Jogo = " & SafeSQL(codJogo)
			conx.execute(sql)

			''--Acertou que Time A Venceria e escore do perdedor
			sql =	    "UPDATE Aposta SET pontos = 4 * " & peso & " FROM Aposta a INNER JOIN Jogo j ON a.cod_Jogo = j.cod_Jogo "
			sql = sql & "	WHERE a.placar_A > a.placar_B AND j.r_placar_A > j.r_placar_B "
			sql = sql & "	AND a.placar_A <> j.r_placar_A AND a.placar_B = j.r_placar_B "
			sql = sql & "	AND a.cod_Jogo = " & SafeSQL(codJogo)
			conx.execute(sql)

			''--Acertou que Time A Venceria, mas errou os escores dos dois
			sql =	    "UPDATE Aposta SET pontos = 3 * " & peso & " FROM Aposta a INNER JOIN Jogo j ON a.cod_Jogo = j.cod_Jogo "
			sql = sql & "	WHERE a.placar_A > a.placar_B AND j.r_placar_A > j.r_placar_B "
			sql = sql & "	AND a.placar_A <> j.r_placar_A AND a.placar_B <> j.r_placar_B "
			sql = sql & "	AND a.cod_Jogo = " & SafeSQL(codJogo)
			conx.execute(sql)

			''--Acertou que Time B Venceria e escore do perdedor
			sql =	    "UPDATE Aposta SET pontos = 4 * " & peso & " FROM Aposta a INNER JOIN Jogo j ON a.cod_Jogo = j.cod_Jogo "
			sql = sql & "	WHERE a.placar_A < a.placar_B AND j.r_placar_A < j.r_placar_B "
			sql = sql & "	AND a.placar_A = j.r_placar_A AND a.placar_B <> j.r_placar_B "
			sql = sql & "	AND a.cod_Jogo = " & SafeSQL(codJogo)
			conx.execute(sql)

			''--Acertou que Time B Venceria e escore do vencedor
			sql =	    "UPDATE Aposta SET pontos = 5 * " & peso & " FROM Aposta a INNER JOIN Jogo j ON a.cod_Jogo = j.cod_Jogo "
			sql = sql & "	WHERE a.placar_A < a.placar_B AND j.r_placar_A < j.r_placar_B "
			sql = sql & "	AND a.placar_A <> j.r_placar_A AND a.placar_B = j.r_placar_B "
			sql = sql & "	AND a.cod_Jogo = " & SafeSQL(codJogo)
			conx.execute(sql)

			''--Acertou que Time B Venceria, mas errou os escores dos dois
			sql =	    "UPDATE Aposta SET pontos = 3 * " & peso & " FROM Aposta a INNER JOIN Jogo j ON a.cod_Jogo = j.cod_Jogo "
			sql = sql & "	WHERE a.placar_A > a.placar_B AND j.r_placar_A > j.r_placar_B "
			sql = sql & "	AND a.placar_A <> j.r_placar_A AND a.placar_B <> j.r_placar_B "
			sql = sql & "	AND a.cod_Jogo = " & SafeSQL(codJogo)
			conx.execute(sql)

			''--Acertou que daria empate, mas errou o placar
			sql =	    "UPDATE Aposta SET pontos = 5 * " & peso & " FROM Aposta a INNER JOIN Jogo j ON a.cod_Jogo = j.cod_Jogo "
			sql = sql & "	WHERE a.placar_A = a.placar_B AND j.r_placar_A = j.r_placar_B "
			sql = sql & "	AND a.placar_A <> j.r_placar_A AND a.placar_B <> j.r_placar_B "
			sql = sql & "	AND a.cod_Jogo = " & SafeSQL(codJogo)
			conx.execute(sql)

			''--Placar Invertido
			sql =	    "UPDATE Aposta SET pontos = 1 * " & peso & " FROM Aposta a INNER JOIN Jogo j ON a.cod_Jogo = j.cod_Jogo "
			sql = sql & "	WHERE a.placar_A <> a.placar_B AND j.r_placar_A <> j.r_placar_B "
			sql = sql & "	AND a.placar_A = j.r_placar_B AND a.placar_B = j.r_placar_A "
			sql = sql & "	AND a.cod_Jogo = " & SafeSQL(codJogo)
			conx.execute(sql)

			''--ATualiza total de pontos do ranking
			sql =	    "UPDATE Ranking SET Total_Pontos = r.Total_Pontos + a.pontos "
			sql = sql & "	FROM Ranking r INNER JOIN Aposta a ON r.cod_apostador = a.cod_apostador "
			sql = sql & "	AND a.cod_Jogo = " & SafeSQL(codJogo)
			conx.execute(sql)

			''--atualiza total de acertos do ranking
			sql =	    "UPDATE Ranking SET Total_Acertos = r.Total_Acertos + 1  "
			sql = sql & "	FROM Ranking r INNER JOIN Aposta a ON r.cod_apostador = a.cod_apostador AND pontos = 10 "
			sql = sql & "	AND a.cod_Jogo = " & SafeSQL(codJogo)
			conx.execute(sql)

	end function



   

   

%>



<html>

<head>

<title>Bolao da Copa do Mundo</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">

</head>



<body bgcolor="#FFFFFF" text="#000000">

<div class="mensagem">

  <% response.write Mensagem & "<BR>" %>

</div>

<BR>



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

                    sql = "SELECT j.cod_Jogo, p1.nome paisA, p2.nome paisB FROM Jogo j INNER JOIN Pais p1 ON j.cod_paisA = p1.cod_pais INNER JOIN Pais p2 ON j.cod_paisB = p2.cod_pais WHERE ja_Ocorreu = 0 ORDER BY j.cod_Jogo"

		            rs6.Open sql, conx 

                    While not rs6.EOF

 %>

                        

                    <option value="<%= rs6("cod_jogo")%>">Jogo <%= rs6("cod_jogo")%> - <%= rs6("paisA")%> x <%= rs6("paisB")%></option>

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

<a href="SQL.asp">Executar SQL</a> 

<p>&nbsp;</p>

<a href="altera_usuario.asp">Altera dados cadastrais de Apostador</a> </div>

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
