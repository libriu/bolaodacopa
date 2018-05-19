<!--#include virtual="/comuns/configuracoes.asp"--> 


<%





  dim mensagem

  mensagem = "No primeiro acesso voc&ecirc; deve alterar sua senha!!!"

  if request("btnLogin") <> empty then



         Set conx = Server.CreateObject("ADODB.Connection")

         conx.Open ConnStrMySQL 





    sql = "SELECT * FROM Apostadores WHERE nome = '" & request("login") & "' and senha_apostador = '" & Request("senha") & "' and Apostadores.Ativo"

   

    set rs = Server.CreateObject("ADODB.Recordset")

    rs.Open sql, conx 



    if rs.eof then

       rs.close

       set rs = nothing

	   conx.close

	   Set conx = Nothing

       mensagem = "Nome do Apostador ou senha inv&aacute;lido(a)."

    else

      session("usuario") = request("login")

      rs.close

      set rs = nothing

      conx.close

      Set conx = Nothing 



      if request("login") = request("senha") then





     %>



<script language="JavaScript">

<!--

 window.location="altera_senha.asp"

//-->

</script>

<%  





      else





     %>



<script language="JavaScript">

<!--

 window.location="Cadastro.asp"

//-->

</script>

<%  



      end if

    end if

  else



     if request("btnMensagem") <> empty then

 

         Set conx = Server.CreateObject("ADODB.Connection")

         conx.Open ConnStrMySQL 



     sql = "SELECT * FROM Apostadores WHERE nome = '" & request("login") & "' and senha_apostador = '" & Request("senha") & "' and Apostadores.Ativo"



     set rs = Server.CreateObject("ADODB.Recordset")

     rs.Open sql, conx 



     if rs.eof then

        rs.close

        set rs = nothing

 	   conx.close

 	   Set conx = Nothing

       mensagem = "Nome do Apostador ou senha inv&aacute;lido(a)."

     else

       session("usuario") = request("login")

       rs.close

       set rs = nothing

       conx.close

       Set conx = Nothing 









      if request("login") = request("senha") then





     %>



<script language="JavaScript">

<!--

 window.location="altera_senha.asp"

//-->

</script>

<%  





      else





     %>



<script language="JavaScript">

<!--

 window.location="Mensagens.asp"

//-->

</script>

<%  



      end if



    end if

    else



     if request("btnGerenciar") <> empty then

 

         Set conx = Server.CreateObject("ADODB.Connection")

         conx.Open ConnStrMySQL 



     sql = "SELECT * FROM Apostadores WHERE nome = '" & request("login") & "' and senha_apostador = '" & Request("senha") & "' and Apostadores.Ativo"



     set rs = Server.CreateObject("ADODB.Recordset")

     rs.Open sql, conx 



     if rs.eof then

        rs.close

        set rs = nothing

 	   conx.close

 	   Set conx = Nothing

       mensagem = "Nome do Apostador ou senha inv&aacute;lido(a)."

     else

       session("usuario") = request("login")

       rs.close

       set rs = nothing

       conx.close

       Set conx = Nothing 









      if request("login") = request("senha") then





     %>



<script language="JavaScript">

<!--

 window.location="altera_senha.asp"

//-->

</script>

<%  





      else





     %>



<script language="JavaScript">

<!--

 window.location="Gerenciar_Grupos.asp"

//-->

</script>

<%  



      end if



    end if



    else



      session.abandon



    end if

    end if

  end if %>





  <script language="JavaScript">

  <!--

  function retornar() {

   window.location="../index.asp"

   }

  function buscar_senha() {

   window.location="solicita_senha.asp"

   }

  function alterar_senha() {

   window.location="altera_senha.asp"

   }

  //-->

  </script>





<html>

<head>

<title><%=TituloPagina%></title>

<!--#include virtual="/comuns/menu.asp"--> 

<br>

<div class="mensagem"><%=mensagem%>

</div>

<br>

<form name="formCadastro" method="post" action="index.asp">

<table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">

  <tr>

    <th colspan="2" height="24">LOGIN PARA CADASTRAMENTO DE PLACARES E ENVIO DE MENSAGENS</th>

  </tr>

  <tr>

    <td><div align="left">&nbsp;Nome do Apostador</div></td>

    <td><div align="left">&nbsp;<input type="text" name="login" size="50"
    
      <% if request("login") <> "" then %>
         value = "<%=request("login")%>"
      <% end if%>   
    
    ></div></td>

  </tr>

  <tr align="left">

    <td><div align="left">&nbsp;Senha</div></td>

    <td><div align="left">&nbsp;<input type="password" name="senha" size="20"

      <% if request("senha") <> "" then %>
        value = "<%=request("senha")%>"
      <% end if%>   

    ></div></td>

  </tr>

</table>

<br>

<div align="center">

  <input type="submit" name="btnLogin" value="Atualizar Apostas" class="botao">&nbsp;&nbsp;

  <input type="submit" name="btnMensagem" value="Enviar Mensagem" class="botao">&nbsp;&nbsp;

  <input type="submit" name="btnGerenciar" value="Gerenciar Seus Grupos" class="botao">&nbsp;&nbsp;

  <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</div>

<div align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</div>

<div align="center">

  <input type="submit" name="btnLembrarSenha" value="Solicitar Senha" class="botao" onClick="buscar_senha();return false;">&nbsp;&nbsp;

  <input type="submit" name="btnAlterarSenha" value="Alterar Senha" class="botao" onClick="alterar_senha();return false;">

</div>

</div>

</form>

<p>&nbsp;</p>

</body>

</html>

