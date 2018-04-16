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



<% 

 if Session("usuario") = empty then
    response.write ("Usuário não autorizado!!!<br>")
    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")
  else
         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 

	
    sql = "Select * from Apostadores where nome = '" & session("usuario") & "'"

    set rs_usuario = Server.CreateObject("ADODB.Recordset")

    rs_usuario.Open sql, conx 

    if request("btnIncluir") <> empty then

      if request("nome_novo_grupo") = empty then

	  Mensagem = "Preencha um nome para o grupo se quiser incluir novo grupo!"

      else

        sql = "SELECT cod_grupo FROM Grupos WHERE nome_grupo = '" & request("nome_novo_grupo") & "'"

        set rs2 = Server.CreateObject("ADODB.Recordset")

	rs2.Open sql, conx 

        if not rs2.eof then

	   Mensagem = "Nome de grupo já existente. Utilize outro nome!"

	else

 	   sql = "SELECT MAX(Grupos.cod_grupo) as maxCodGrupo FROM Grupos"

           set rs3 = Server.CreateObject("ADODB.Recordset")

 	   rs3.Open sql, conx

           codGrupo = 1

           if IsNumeric(rs3("maxCodGrupo")) then

  	      codGrupo = rs3("maxCodGrupo") + 1

           end if

           rs2.Close

	   sql =      "INSERT INTO Grupos (cod_grupo, nome_grupo, cod_responsavel)"

	   sql = sql & " VALUES (" & codGrupo & ", '" & request("nome_novo_grupo") & "'," & rs_usuario("cod_Apostador") & ")"

	   conx.execute(sql)

	   Mensagem = "Grupo incluído com sucesso!"

           session("grupo") = codGrupo

%>

<script language="JavaScript">
<!--
 window.location="Detalhe_Grupos.asp"
//-->
</script>

<%

        end if

      end if


    else
      
      if request("btnAtualizar") <> empty then

         if request("cmbAtualizar") <> empty then

           session("grupo") = request("cmbAtualizar")

%>

<script language="JavaScript">
<!--
 window.location="Detalhe_Grupos.asp"
//-->
</script>

<%

         else

            Mensagem = "Você não tem grupo cadastrados. Crie um novo grupo para poder atualizar!"

         end if

      else

         if request("btnExcluir") <> empty then

            if request("cmbExcluir") <> empty then

  	      sql =      "DELETE FROM Det_Grupos"
              sql = sql & "	  WHERE cod_grupo = " & request("cmbExcluir") 
	      conx.execute(sql)

  	      sql =      "DELETE FROM Grupos"
              sql = sql & "	  WHERE cod_grupo = " & request("cmbExcluir") 
	      conx.execute(sql)

            else

               Mensagem = "Você não tem grupo cadastrados. Crie um novo grupo para poder atualizar!"

            end if

         end if

      end if

    end if


%>
<script language="JavaScript">
<!--
function retornar() {
 window.location="index.asp"
 }
//-->
</script>
<html>
<head>
<title><%=TituloPagina%> - Gerenciamento de Grupos</title>
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

<td width="30%" aling="lef"><center><img src="../imagens/logo_copa.jpg" width="80" height="80"></center></td>

<%   else %>


<td width="15%" aling="lef"><center><a href="precadastro.asp"><img src="../imagens/preinscricao.gif" width="80" height="50"></a></center></td>
<td width="15%" aling="lef"><center><img src="../imagens/logo_copa.jpg" width="80" height="80"></center></td>

<% end if %>


<td width="40%" aling="center"><center><img src="../imagens/logo.jpg" width="328" height="80"></center></td>
<td width="15%" aling="right"><center>&nbsp;<a href="../index.asp"><img src="../imagens/Ranking_Principal_link.jpg"></a><br></center>
<center>&nbsp;<a href="../rankingacertos.asp"><img src="../imagens/Ranking_Acertos_link.jpg"></a><br></center>
<center>&nbsp;<a href="../rankingGrupos.asp"><img src="../imagens/Ranking_Grupos_link.jpg"></a></center></td>
<td width="15%" aling="right"><center>&nbsp;<a href="../cadastro"><img src="../imagens/aposta.gif"></a><br></center>
<center>&nbsp;<a href="../regras.asp"><img src="../imagens/regras.jpg"></a><br></center>
<center>&nbsp;<a href="../estatistica.asp"><img src="../imagens/estatisticas.jpg"></a></center></td>
</tr>
</table>


<br>
<div class="mensagem">
  <% response.write Mensagem & "<BR>" %>
</div>
<BR>
<form name="formInclusao" method="post" action="Gerenciar_Grupos.asp">
  <table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr>
      <th colspan="7" height="24">GERENCIAMENTO DE GRUPOS | <%= day(DateAdd("h", FusoHorario, now)) & "/" & month(DateAdd("h",  FusoHorario, now)) & "/" & year(DateAdd("h",  FusoHorario, now)) & " - " & hour(DateAdd("h",  FusoHorario, now)) & ":" & minute(DateAdd("h",  FusoHorario, now)) & ":" & second(DateAdd("h",  FusoHorario, now)) %>
      </th>
    </tr>
    <tr>
      <th colspan="2" >NOME :
      </th>
      <th colspan="5" align="left"><%=rs_usuario("nome")%>
      </th>
    </tr>
    <tr>
      <th colspan="2" >CONTATO :
      </th>
      <th colspan="5" align="left"> <%=rs_usuario("contato")%>
      </th>
    </tr>

  </table>

<br>
<br>


  <table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <th colspan="9" height="24">ATUALIZAR SEUS GRUPOS</th>
  </tr>

  <tr class="LinhaImpar">
  <th colspan="3" height="24" width="37%">Selecione o Grupo a Atualizar:</th>


  <th colspan="3" width="47%">

  <select name="cmbAtualizar">


<%

  sql = "Select * from Grupos where cod_responsavel = " & rs_usuario("cod_Apostador") 

  set rs1 = Server.CreateObject("ADODB.Recordset")

  rs1.Open sql, conx 

  While not rs1.EOF

 %>
     <option value="<%= rs1("cod_grupo")%>"><%= rs1("nome_grupo")%></option>

<% rs1.MoveNext

  wend
 

  rs1.Close 
  Set rs1 = Nothing

%> 

  </select>


  </th width="16%">

  <th colspan="3"><input type="submit" name="btnAtualizar" value="Atualizar Grupo" class="botao"></th>
  </tr>

</table>



<br>
<br>


  <table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <th colspan="9" height="24">EXCLUIR SEUS GRUPOS</th>
  </tr>

  <tr class="LinhaImpar">
  <th colspan="3" height="24" width="37%">Selecione o Grupo a ser Excluído:</th>


  <th colspan="3" width="47%">

  <select name="cmbExcluir">


<%

  sql = "Select * from Grupos where cod_responsavel = " & rs_usuario("cod_Apostador") 

  set rs1 = Server.CreateObject("ADODB.Recordset")

  rs1.Open sql, conx 

  While not rs1.EOF

 %>
     <option value="<%= rs1("cod_grupo")%>"><%= rs1("nome_grupo")%></option>

<% rs1.MoveNext

  wend
 

  rs1.Close 
  Set rs1 = Nothing

%> 

  </select>


  </th width="16%">

  <th colspan="3"><input type="submit" name="btnExcluir" value="Excluir Grupo" class="botao"></th>
  </tr>

</table>


<br>
<br>


  <table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <th colspan="9" height="24">CRIAR NOVO GRUPO</th>
  </tr>

  <tr class="LinhaImpar">
  <th colspan="3" height="24" width="37%">Digite o Nome do Grupo a Ser Criado:</th>


  <th colspan="3" width="47%"><input type="text" name="nome_novo_grupo" maxlength="50" size="50"> </th>


  <th colspan="3" width="16%"><input type="submit" name="btnIncluir" value="Incluir Grupo" class="botao"></th>
  </tr>

</table>


<br>
  <div align="center">
    <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">
  </div>
<p>&nbsp;</p>
</form>
</body>
<% 
 ' Fechar os objetos Recordsets 
'  rs5.Close
  rs_usuario.Close
 
  ' Eliminar os objetos Recordsets 
'  Set rs5 = Nothing
  Set rs_usuario = Nothing
  
  ' Fechar o objeto da conexão 
  conx.Close 
 
 ' Eliminar o objeto da conexão 
  Set conx = Nothing 

 end if%>
</html>
