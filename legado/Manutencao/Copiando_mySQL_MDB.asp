<html>
<head>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title>Bolao da Copa das Confederações 2013 - Teste do MYSQL</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">
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


<%
   
  'Abrindo Conexão Access
 
    Set conx_MDB = Server.CreateObject("ADODB.Connection")
   	conx_MDB.Mode = 3      '3 = adModeReadWrite
	conx_MDB.Open "DBQ=" & Server.Mappath ("\db\bolao.mdb") & ";DRIVER={Microsoft Access Driver (*.mdb)}"
   
  
  'Abrindo Conexão mySQL
    
    'Abrindo Conexão mySQL - Forma usada em 2010
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Database=bolaodacopa2013;uid=bolaodacopa;pwd=Brasil;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2013
         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=mysql.bolaodacopa.unositehospedagem.com.br;Database=bolaodacopa;uid=bolaodacopa;pwd=vasco97;option=3"
         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 



' ********************************************************
'* Tratando tabela Apostas
' ********************************************************


  'Apagando a tabela 'Apostas' da base MDB
    
   conx_MDB.execute "DELETE * FROM Apostas" 


' Lendo todos os registros da Tabela 'Apostas' do mySQL

   sql = "SELECT * FROM Apostas"
   
    
   set rs = Server.CreateObject("ADODB.Recordset")
   rs.Open sql, conx_mySQL 
  
   i = 0

   while not rs.eof

   sql = 	 "INSERT INTO Apostas (cod_Aposta, cod_Apostador, Total_Pontos)"
   sql = sql & " 	  VALUES (" & rs("cod_Aposta") & ", " & rs("cod_Apostador") & ", " & rs("Total_Pontos") & ")"


  response.write SQL & " <BR>"

  conx_MDB.execute sql 
 

  i = i + 1 
  rs.MoveNext

  wend 
  
  rs.close
  response.write "<BR>" & i & " registro(s) foram migrados para a base MDB - Apostas <BR> <BR> " 




' ********************************************************
'* Tratando tabela Apostadores
' ********************************************************

   'Apagando a tabela 'Apostadores' da base MDB
    
   conx_MDB.execute "DELETE * FROM Apostadores" 


' Lendo todos os registros da Tabela Resultados do MySQL

   sql = "SELECT * FROM Apostadores"
   
     
   set rs = Server.CreateObject("ADODB.Recordset")
   rs.Open sql, conx_mySQL 
  
   i = 0

   while not rs.eof

   sql = 	 "INSERT INTO Apostadores (cod_Apostador, nome, contato, Pago, email, senha_apostador, cod_acesso,controle_inclusao)"
   sql = sql & " 	  VALUES (" & rs("cod_Apostador") & ", '" & rs("nome") &  "', '" & rs("contato") & "', " & rs("Pago") & ", '" & rs("email") & "', '" & rs("senha_apostador") & "',' ','" & rs("controle_inclusao") & "')"


   response.write SQL & " <BR>"

   conx_MDB.execute sql 
 

  i = i + 1 
  rs.MoveNext

  wend 
  
  rs.close
  response.write "<BR>" & i & " registro(s) foram migrados para a base MDB - Apostadores" 




' ********************************************************
'* Tratando tabela Jogos
' ********************************************************

   'Apagando a tabela 'Jogos' da base MDB
    
   conx_MDB.execute "DELETE FROM Jogos" 


' Lendo todos os registros da Tabela Jogos do mySQL

   sql = "SELECT * FROM Jogos"
   
   'Set rs = conx_MDB.execute(sql)
   
   set rs = Server.CreateObject("ADODB.Recordset")
   rs.Open sql, conx_mySQL 
  
   i = 0

   while not rs.eof

   sql = 	 "INSERT INTO Jogos (cod_Aposta, cod_Jogo, placar_A, placar_B, Pontos)"
   sql = sql & " 	  VALUES (" & rs("cod_Aposta") & "," & rs("cod_Jogo") &  ", " & rs("placar_A") & ", " & rs("placar_B") & "," & rs("Pontos") & ")"


   response.write SQL & " <BR>"

   conx_MDB.execute sql 
 

  i = i + 1 
  rs.MoveNext

  wend 
  
  rs.close
  response.write "<BR>" & i & " registro(s) foram migrados para a base MDB - Jogos  <BR> <BR>" 


' ********************************************************
'* Tratando tabela Pais
' ********************************************************

   'Apagando a tabela 'Pais' da base MDB
    
   conx_MDB.execute "DELETE FROM Pais" 


' Lendo todos os registros da Tabela Resultados do mySQL

   sql = "SELECT * FROM Pais"
   
     
   set rs = Server.CreateObject("ADODB.Recordset")
   rs.Open sql, conx_mySQL 
  
   i = 0

   while not rs.eof

   sql = 	 "INSERT INTO Pais (Pais,Arquivo)"
   sql = sql & " 	  VALUES ('" & rs("Pais") & "','" & rs("Arquivo") &  "')"


   response.write SQL & " <BR>"

   conx_MDB.execute sql 
 

  i = i + 1 
  rs.MoveNext

  wend 
  
  rs.close
  response.write "<BR>" & i & " registro(s) foram migrados para a base MDB - Pais  <BR> <BR>" 



' ********************************************************
'* Tratando tabela Resultados
' ********************************************************

   'Apagando a tabela 'Resultados' da base MDB
    
   conx_MDB.execute "DELETE FROM Resultados" 


' Lendo todos os registros da Tabela Resultados do mySQL

   sql = "SELECT * FROM Resultados"
   
      
   set rs = Server.CreateObject("ADODB.Recordset")
   rs.Open sql, conx_mySQL
  
   i = 0

   while not rs.eof

   sql = 	 "INSERT INTO Resultados (cod_Jogo, r_placar_A, r_placar_B, jaOcorreu, time1, time2, data_jogo, Grupo, hora_jogo)"
   sql = sql & " 	  VALUES (" & rs("cod_Jogo") & ", " & rs("r_placar_A") & ", " & rs("r_placar_B") & ", " & rs("jaOcorreu") &  ", '" & rs("time1") & "', '" & rs("time2") & "', '" & rs("data_jogo") & "', '" & rs("Grupo") & "', '" & rs("hora_jogo") & "')"


   response.write SQL & " <BR>"

   conx_MDB.execute sql 
 

  i = i + 1 
  rs.MoveNext

  wend 
  
  rs.close
  response.write "<BR>" & i & " registro(s) foram migrados para a base MDB - Resultados" 


' ********************************************************
'* Tratando tabela Mensagens
' ********************************************************

   'Apagando a tabela 'Mensagens' da base MDB
    
   conx_MDB.execute "DELETE FROM Mensagens" 


' Lendo todos os registros da Tabela Mensagens do mySQL

   sql = "SELECT * FROM Mensagens"
   
     
   set rs = Server.CreateObject("ADODB.Recordset")
   rs.Open sql, conx_mySQL 
  
   i = 0

   while not rs.eof

   sql = 	 "INSERT INTO Mensagens (cod_apostador, data_msg, hora_msg, mensagem, cod_mensagem)"
   sql = sql & " 	  VALUES (" & rs("cod_apostador") & "','" & rs("data_msg") & "','" & rs("hora_msg") & "','" & rs("mensagem") & "'," & rs("cod_mensagem") &  ")"


   response.write SQL & " <BR>"

   conx_MDB.execute sql 
 

  i = i + 1 
  rs.MoveNext

  wend 
  
  rs.close
  response.write "<BR>" & i & " registro(s) foram migrados para a base MDB - Mensagens  <BR> <BR>" 


  conx_MDB.Close
  conx_MYSQL.Close
  Set rs = Nothing
  Set Conx_MDB = Nothing
  Set Conx_MYSQL = Nothing


 %>
  </body>
</html>
