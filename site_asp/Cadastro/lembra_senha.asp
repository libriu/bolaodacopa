<!--#include virtual="/comuns/configuracoes.asp"--> 




<%


  dim mensagem


  mensagem = ""


  if request("btnLogin") <> empty then





    if request("login") = "" then 


       mensagem = "Favor informar o Nome do Apostador."


    else


       if request("lembrete") = "" then


          mensagem = "Favor informar o C&oacute;digo para Recupera&ccedil;&atilde;o de Senha."


       else


         Set conx = Server.CreateObject("ADODB.Connection")


         conx.Open ConnStrMySQL 





          


		  sql = "SELECT * FROM Apostadores WHERE nome = '" & SafeSQL(request("login")) & "';"


          


		  'set rs = conx.execute(sql)


          set rs = Server.CreateObject("ADODB.Recordset")


		  rs.Open sql, conx


		  


		  if rs.eof then


             mensagem = "Nome do Apostador inv&aacute;lido."


          else


             if rs("cod_acesso") <> request("lembrete") then


                mensagem = "Có&oacute;digo para recupera&ccedil;&atilde;o de senha n&atilde;o confere. Informe o Có&oacute;digo correto ou entre em contato com o administrador."


             else


                mensagem = "Sua senha &eacute;: " & rs("senha_apostador")


             end if


          end if 


          rs.close


          set rs = nothing   


          conx.close


		  set conx = nothing   


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


<title><%=TituloPagina%> - Solicita&ccedil;&atilde;o de Senha</title>


<!--#include virtual="/comuns/menu.asp"--> 

<br>

<div class="mensagem"><%=mensagem%>


</div>


<br>

<form name="formCadastro" method="post" action="lembra_senha.asp">


<table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">


  <tr>


    <th colspan="2" height="24">SOLICITA&Ccedil;&Atilde;O DE SENHA | <%= day(DateAdd("h", FusoHorario, now)) & "/" & month(DateAdd("h",  FusoHorario, now)) & "/" & year(DateAdd("h",  FusoHorario, now)) & " - " & hour(DateAdd("h",  FusoHorario, now)) & ":" & minute(DateAdd("h",  FusoHorario, now)) & ":" & second(DateAdd("h",  FusoHorario, now)) %></th>


  </tr>


  <tr>


    <td><div align="left">&nbsp;Nome do Apostador</div></td>


    <td><div align="left">&nbsp;<input type="text" name="login" size="50"></div></td>


  </tr>


  <tr>    


  <td><div align="left">&nbsp;Có&oacute;digo para recupera&ccedil;&atilde;o de Senha</div></td>


    <td><div align="left">&nbsp;<input type="text" name="lembrete" size="50"></div></td>


  </tr>


</table>


<br>


<div align="center">


  <input type="submit" name="btnLogin" value="Solicitar" class="botao">&nbsp;&nbsp;&nbsp;&nbsp;


  <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">


</div>


</form>


<p>&nbsp;</p>


<div align="center" class="texto">Se voc&eacute; esqueceu a sua senha, solicite por meio desta p&aacute;gina utilizando o có&oacute;digo para recupera&ccedil;&atilde;o de senha gerado pelo administrador.</div>


</body>


</html>


