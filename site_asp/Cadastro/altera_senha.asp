<!--#include virtual="/comuns/configuracoes.asp"--> 
<%

  dim mensagem

  mensagem = ""

  preencher = 0

  if request("btnLogin") <> empty then

    if request("login") = "" then 

      mensagem = "Nome do apostador n&atilde;o foi informado!"
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

              mensagem = "A nova senha tem que ser igual a confirma&ccedil;&atilde;o da senha nova!"   
              preencher = 1
  
            else
  
              Set conx = Server.CreateObject("ADODB.Connection")

              conx.Open ConnStrMySQL 
	
       		  	sql = "SELECT * FROM Apostadores WHERE nome = '" & request("login") & "' and Apostadores.Ativo"  
  
        			set rs = Server.CreateObject("ADODB.Recordset")

		  	    	rs.Open sql, conx 
  
	  			    if rs.eof then

                mensagem = "Nome do Apostador inv&aacute;lido."
                preencher = 1

              else

                sql = "SELECT * FROM Apostadores WHERE nome = '" & request("login") & "' and senha_apostador = '" & request("senha_atual") & "';"

		            set rs1 = Server.CreateObject("ADODB.Recordset")

            		rs1.Open sql, conx 

                if rs1.eof then

                  mensagem = "Senha atual digitada n&atilde;o confere!"
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

<title><%=TituloPagina%> - Altera&ccedil;&atilde;o de Senha</title>

<!--#include virtual="/comuns/menu.asp"--> 

<br>

<div class="mensagem"><%=mensagem%>

</div>

<br>

<form name="formAlteraSenha" method="post" action="altera_senha.asp">

<table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">

  <tr>

    <th colspan="2" height="24">ALTERA&Ccedil;&Atilde;O DE SENHA | <%= day(DateAdd("h", FusoHorario, now)) & "/" & month(DateAdd("h",  FusoHorario, now)) & "/" & year(DateAdd("h",  FusoHorario, now)) & " - " & hour(DateAdd("h",  FusoHorario, now)) & ":" & minute(DateAdd("h",  FusoHorario, now)) & ":" & second(DateAdd("h",  FusoHorario, now)) %></th>

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

    <td><div align="left">&nbsp;Confirma&ccedil;&atilde;o da Nova Senha</div></td>

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

  <td><div align="left">&nbsp;Confirma&ccedil;&atilde;o da Nova Senha</div></td>

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

</body>

</html>

