<!--#include virtual="/comuns/configuracoes.asp"--> 

  <script language="JavaScript">

  <!--

  function retornar() {

   window.location="../index.asp"

   }

  //-->

  </script>


<%
  if DateAdd("h", FusoHorario, now) >= DateAdd("d",-1,DataInicioCopaFormatado) then
    response.write ("Per&iacute;odo de Pr&eacute;-cadastrado j&aacute; ultrapassado!!!<br>")

    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")

  else


%>




<html>

<head>

<title><%=TituloPagina%> - Pr&eacute;-Cadastro</title>
  
<!--#include virtual="/comuns/menu.asp"--> 


<%

  Set conx = Server.CreateObject("ADODB.Connection")

  conx.Open ConnStrMySQL 

  set rs = Server.CreateObject("ADODB.Recordset")

  set rs2 = Server.CreateObject("ADODB.Recordset")        

  preencher = 0

	if request("btnIncluir") <> empty then

		sql = "SELECT cod_Apostador FROM Apostadores WHERE nome = '" & request("nome") & "'"

		rs.Open sql, conx 

    if not rs.eof then

		  Mensagem = "Apostador j&aacute; existente. Utilize outro nome!"
      preencher = 1
    
    else

      if request("nome") = "" or request("senha") = "" or request("senha2") = "" or request("contato") = "" or request("email") = "" or request("cidade") = "" then

        Mensagem = "Os campos Nome, Senha, Contato, E-mail e Cidade s&atilde;o obrigat&oacute;rios para inclus&atilde;o!"

        preencher = 1

      else

        if request("senha") <> request("senha2") then

          Mensagem = "Os campos de senha devem ser iguais!"
 
          preencher = 1

        else

  		    sql = "SELECT MAX(Apostadores.cod_Apostador) as maxCodApostador FROM Apostadores"

          rs2.Open sql, conx

	        codApostador = rs2("maxCodApostador") + 1

          rs2.Close

          nomeStr = TirarAcento(request("nome"))
          contatoStr = TirarAcento(request("contato"))
          emailStr = TirarAcento(request("email"))
          senhaStr = TirarAcento(request("senha"))
          cidadeStr = TirarAcento(request("cidade"))

	        sql =      "INSERT INTO Apostadores (cod_Apostador, nome, contato, Pago, email, Celular, senha_apostador, controle_inclusao, ativo, cidade)"

  	      sql = sql & " 		    VALUES (" & codApostador & ", '" & nomeStr & "','" & contatoStr & "', 0, '" & emailStr & "','" & request("Celular") & "','" & senhaStr & "',' ',0,'" & cidadeStr & "')"

	        conx.execute(sql)

  	      Mensagem = sql


	        sql = 	 "INSERT INTO Apostas (cod_Aposta, cod_Apostador,Total_Pontos, Total_Acertos)"

	        sql = sql & " 	  VALUES (" & codApostador & ", " & codApostador & ",0,0)"

	        conx.execute(sql)

  	      Mensagem = "Apostador inclu&iacute;do com sucesso! Agora envie o comprovante de pagamento para que seu cadastro seja ativado."
 
        end if
        
      end if

	  end if

    rs.Close

	end if

%>

<br>
<div class="mensagem">

  <% response.write Mensagem & "<BR>" %>

</div>

<BR>

<form name="formInclusao" method="post" action="precadastro.asp">

  <table class="Bolao" width="80%" border="0" cellspacing="2" cellpadding="2" align="center">

    <tr>

      <th colspan="8" height="24">PR&Eacute;-CADASTRO DE APOSTADORES

      </th>

    </tr>

    <tr>

      <th colspan="3" >NOME DO USU&Aacute;RIO (NOME QUE APARECER&Aacute; NO RANKING):

      </th>

      <th colspan="5" align="left">

<%      if preencher = 1 then %>

  	  <input type="text" name="nome" size="50" maxlength="30" value="<%=request("nome")%>">
<%      else %>
  	  <input type="text" name="nome" size="50" maxlength="30">
<%      end if %>

      </th>

    </tr>

    <tr>

      <th colspan="3" >SENHA:

      </th>

      <th colspan="5" align="left">

<%      if preencher = 1 then %>

  	  <input type="password" name="senha" size="50" maxlength="30" value="<%=request("senha")%>">
<%      else %>
  	  <input type="password" name="senha" size="50" maxlength="30">
<%      end if %>

      </th>

    </tr>

    <tr>

      <th colspan="3" >CONFIRMA&Ccedil;&Atilde;O DE SENHA:

      </th>

      <th colspan="5" align="left">

<%      if preencher = 1 then %>

  	  <input type="password" name="senha2" size="50" maxlength="30" value="<%=request("senha2")%>">
<%      else %>
  	  <input type="password" name="senha2" size="50" maxlength="30">
<%      end if %>

      </th>

    </tr>


    <tr>

      <th colspan="3" >CONTATO (QUEM O INDICOU OU GRUPO A QUE PERTENCE):

      </th>

      <th colspan="5" align="left">

<%      if preencher = 1  then %>

  	  <input type="text" name="contato" size="50" maxlength="30" value="<%=request("contato")%>">
<%      else %>
  	  <input type="text" name="contato" size="50" maxlength="30">
<%      end if %>

      </th>

    </tr>

    <tr>

      <th colspan="3" >E-MAIL :

      </th>

      <th colspan="5" align="left">

<%      if preencher = 1  then %>

  	  <input type="text" name="email" size="50" maxlength="50" value="<%=request("email")%>">
<%      else %>
  	  <input type="text" name="email" size="50" maxlength="50">
<%      end if %>

      </th>

    </tr>

    <tr>

      <th colspan="3" >CELULAR (DDD) XXXXX-XXXX:

      </th>

      <th colspan="5" align="left">

<%      if preencher = 1  then %>

  	  <input type="text" name="celular" size="50" maxlength="30" value="<%=request("celular")%>">
<%      else %>
  	  <input type="text" name="celular" size="50" maxlength="30">
<%      end if %>

      </th>

    </tr>

    <tr>

      <th colspan="3" >CIDADE ONDE RESIDE:

      </th>

      <th colspan="5" align="left">

<%      if preencher = 1  then %>

  	  <input type="text" name="cidade" size="50" maxlength="30" value="<%=request("cidade")%>">
<%      else %>
  	  <input type="text" name="cidade" size="50" maxlength="30">
<%      end if %>

      </th>

    </tr>

  </table><br>

  <div align="center">

    <input type="submit" name="btnIncluir" value="Incluir" class="botao">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

  <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

  </div><br>

<HR>


<table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">

  <tr>

    <th colspan="7" height="24">INFOMA&Ccedil;&Otilde;ES SOBRE O PR&Eacute;-CADASTRO</th>

  </tr>

  <TR>

    <td align="left">

      <div align="left">

        <p>O pr&eacute;-cadastro &eacute; fase essencial para que se efetive o cadastro no Bol&atilde;o On-line 2018. </p>

        <p>Ap&oacute;s realizar o seu pr&eacute;-cadastro, fa&ccedil;a a transf&ecirc;ncia para uma das contas dispon&iacute;veis (<a href="../imagens/ContasCorrentes.jpg">clique aqui para visualizar</a>) e envie o comprovante de transfer&ecirc;ncia por email (bolaodacopa2018.online@gmail.com), por whats app para os coordenadores (Andr&eacute; Muniz, Helson, Luis Angelo ou Piures) ou para o colaborador que o indicou.</p>
        <p>Ap&oacute;s a confirma&ccedil;&atilde;o do pagamento, o usu&aacute;rio ser&aacute; liberado, voc&ecirc; sendo comunicado por email preferencialmente. Por esta raz&atilde;o, o cadastro de email (assim como do celular) &eacute; fundamental.</p>

      </div>

    </td>

  </tr>

    

</table>

<br>

</form>

<HR>

<%
   Set rs = Nothing

   Set rs2 = Nothing

   conx.close

   Set conx = Nothing

%>

 </html>

<%

end if
%>