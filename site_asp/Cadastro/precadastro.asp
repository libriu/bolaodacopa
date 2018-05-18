<%

   FusoHorario = 4
   FormatoData = "Americano"
   TituloPagina = "Bolão da Copa do Mundo 2018"
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

  <script language="JavaScript">
  <!--
  function retornar() {
   window.location="../index.asp"
   }
  //-->
  </script>

<%
  if DateAdd("h", FusoHorario, now) >= DateAdd("d",-1,DataInicioCopaFormatado) then
    response.write ("Período de Pre-cadastrado já ultrapassado!!!<br>")
    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")
  else


%>




<html>
<head>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title><%=TituloPagina%> - Pré-Cadastro</title>
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
		  Mensagem = "Apostador já existente. Utilize outro nome!"
                  preencher = 1
		else
                  if request("nome") = "" or request("contato") = "" or request("email") = "" or request("cidade") = "" then
   		      Mensagem = "Os campos Nome, Contato, E-mail e Cidade são obrigatório para inclusão!"
                      preencher = 1
                  else
  		    sql = "SELECT MAX(Apostadores.cod_Apostador) as maxCodApostador FROM Apostadores"
		    rs2.Open sql, conx
		    codApostador = rs2("maxCodApostador") + 1
                    rs2.Close
		    sql =      "INSERT INTO Apostadores (cod_Apostador, nome, contato, Pago, email, Celular, senha_apostador,controle_inclusao, ativo, cidade)"
		    sql = sql & " 		    VALUES (" & codApostador & ", '" & request("nome") & "','" & request("contato") & "', 0, '" & request("email") & "','" & request("Celular") & "','" & request("nome") & "',' ',0,'" & request("cidade") & "')"
		    conx.execute(sql)
		    sql = 	 "INSERT INTO Apostas (cod_Aposta, cod_Apostador,Total_Pontos, Total_Acertos)"
		    sql = sql & " 	  VALUES (" & codApostador & ", " & codApostador & ",0,0)"
		    conx.execute(sql)
		    Mensagem = "Apostador incluído com sucesso! Agora envie o comprovante de pagamento para que seu cadastro seja ativado."
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
      <th colspan="8" height="24">PRÉ-CADASTRO DE APOSTADORES
      </th>
    </tr>
    <tr>
      <th colspan="3" >NOME DO USUÁRIO:
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
    <th colspan="7" height="24">INFOMAÇÕES SOBRE O PRÉ-CADASTRO</th>
  </tr>
  <TR>
    <td align="left">
      <div align="left">
        <p>O pré-cadastro é fase essencial para que se efetive o cadastro no Bolão On-line 2018. </p>
        <p>Após realizar o seu pré-cadastro, envie o comprovante de transferência por email (bolaodacopa2018.online@gmail.com), por whats app para os coordenadores (Helson, Luis Angelo ou Piures) ou para o colaborador que o indicou.</p>
        <p>Após a confirmação do pagamento, o usuário será liberado, você sendo comunicado por email preferencialmente. Por esta razão, o cadastro de email (assim como do celular) é fundamental.</p>
        <p>Importante salientar que a senha inicial será o mesmo nome do usuário e deve ser alterado no primeiro acesso. </p>
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