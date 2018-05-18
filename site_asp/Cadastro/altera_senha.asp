<%


   FusoHorario = 4
   FormatoData = "Americano"
   TituloPagina = "Bol?o da Copa do Mundo 2018"
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

  dim mensagem

  mensagem = ""

  preencher = 0

  if request("btnLogin") <> empty then

    if request("login") = "" then 

      mensagem = "Nome do apostador n?o foi informado!"
      preencher = 1

    else

        if request("senha_atual") = "" then

           mensagem = "Favor preencher a senha atual!"   
           preencher = 1

        else

          if request("senha_nova") = "" then 

            mensagem = "Favor preencher a nova senha!"   
            preencher = 1

          else
            if request("senha_nova") <> request("senha_nova2")  then

              mensagem = "A nova senha tem que ser igual a confirma??o da senha nova!"   
              preencher = 1
  
            else
  
              Set conx = Server.CreateObject("ADODB.Connection")

              conx.Open ConnStrMySQL 
	
       		  	sql = "SELECT * FROM Apostadores WHERE nome = '" & request("login") & "' and Apostadores.Ativo"  
  
        			set rs = Server.CreateObject("ADODB.Recordset")

		  	    	rs.Open sql, conx 
  
	  			    if rs.eof then

                mensagem = "Nome do Apostador inv?lido."
                preencher = 1

              else

                sql = "SELECT * FROM Apostadores WHERE nome = '" & request("login") & "' and senha_apostador = '" & request("senha_atual") & "';"

		            set rs1 = Server.CreateObject("ADODB.Recordset")

            		rs1.Open sql, conx 

                if rs1.eof then

                  mensagem = "Senha atual digitada não confere!"
                  preencher = 1

                else  

                  sql = "UPDATE Apostadores SET Senha_apostador = '" & request("senha_nova") & "' WHERE nome = '" & request("login") & "'"

                  conx.execute(sql)

                  mensagem = "Senha alterada com sucesso!"

                end if

                rs1.close

                set rs1 = nothing
 
              end if

              rs.close

              set rs = nothing
  
              conx.close
  
              Set conx = Nothing
  
            end if

          end if

        end if

    end if

  end if %>

<script language="JavaScript">

<!--

function retornar() {

 window.location="index.asp"

 }

//-->

</script>

<html>

<head>

<title><%=TituloPagina%> - Altera??o de Senha</title>

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

<div class="mensagem"><%=mensagem%>

</div>

<br>

<form name="formAlteraSenha" method="post" action="altera_senha.asp">

<table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">

  <tr>

    <th colspan="2" height="24">ALTERA??O DE SENHA | <%= day(DateAdd("h", FusoHorario, now)) & "/" & month(DateAdd("h",  FusoHorario, now)) & "/" & year(DateAdd("h",  FusoHorario, now)) & " - " & hour(DateAdd("h",  FusoHorario, now)) & ":" & minute(DateAdd("h",  FusoHorario, now)) & ":" & second(DateAdd("h",  FusoHorario, now)) %></th>

  </tr>


  <%      if preencher = 1 then %>


  <tr>

    <td><div align="left">&nbsp;Nome do Apostador</div></td>

    <td><div align="left">&nbsp;<input type="text" name="login" size="50" value="<%=request("login")%>"></div></td>

  </tr>

  <tr>

    <td><div align="left">&nbsp;Senha Atual</div></td>

    <td><div align="left">&nbsp;<input type="password" name="senha_atual" size="20" value="<%=request("senha_atual")%>"></div></td>

  </tr>  

  <tr>

    <td><div align="left">&nbsp;Nova Senha</div></td>

    <td><div align="left">&nbsp;<input type="password" name="senha_nova" size="20" value="<%=request("senha_nova")%>"></div></td>

  </tr>

  <tr>

    <td><div align="left">&nbsp;Confirma??o da Nova Senha</div></td>

    <td><div align="left">&nbsp;<input type="password" name="senha_nova2" size="20" value="<%=request("senha_nova2")%>"></div></td>

  </tr>

<% else %>

<tr>

  <td><div align="left">&nbsp;Nome do Apostador</div></td>

  <td><div align="left">&nbsp;<input type="text" name="login" size="50" </div></td>

</tr>

<tr>

  <td><div align="left">&nbsp;Senha Atual</div></td>

  <td><div align="left">&nbsp;<input type="password" name="senha_atual" size="20" </div></td>

</tr>  

<tr>

  <td><div align="left">&nbsp;Nova Senha</div></td>

  <td><div align="left">&nbsp;<input type="password" name="senha_nova" size="20"> </div></td>

</tr>

<tr>

  <td><div align="left">&nbsp;Confirma??o da Nova Senha</div></td>

  <td><div align="left">&nbsp;<input type="password" name="senha_nova2" size="20"> </div></td>

</tr>


<% end if %>

</table>

<br>

<div align="center">





  <input type="submit" name="btnLogin" value="Alterar" class="botao">&nbsp;&nbsp;&nbsp;&nbsp;




  <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">

</div>

</form>

<p>&nbsp;</p>




<%      if preencher = 1 then %>



<div align="center" class="texto">Formul?rio para altera??o de senha</div>

<div align="center" class="texto">  </div>

<div align="center" class="mensagem">No primeiro acesso voc? precisa alterar sua senha</div>



<% end if %>



</body>

</html>

