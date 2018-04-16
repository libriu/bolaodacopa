 <%

   FusoHorario = 4
   FormatoData = "Americano"
   TituloPagina = "Bolão da Copa do Mundo 2018"


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

 if Session("manut") = empty then
    response.write ("Usuário não autorizado!!!<br>")
    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")
 else 

    Set conx = Server.CreateObject("ADODB.Connection")
    conx.Open ConnStrMySQL 

	
    sql = "Select * from Apostadores where nome = '" & session("usuario") & "'"

    set rs_usuario = Server.CreateObject("ADODB.Recordset")

    rs_usuario.Open sql, conx 


    if request("btnIncluir") <> empty then
 
       todo_check = split(request("check"),",")

       qtde = 0

       if rs_usuario("acesso_gestao_total") = 0 then

          usuario_responsavel = rs_usuario("nome")

       else


          sql = "Select * from Apostadores where cod_Apostador = " & request("cmbAtualizar")

          set rs2 = Server.CreateObject("ADODB.Recordset")

          rs2.Open sql, conx 

          usuario_responsavel = rs2("nome")

          rs2.Close 
          Set rs2 = Nothing


       end if

       for contador = lbound(todo_check) to ubound(todo_check)

'
          sql = "UPDATE Apostadores set Ativo = 1, controle_inclusao = '" & usuario_responsavel & "' WHERE cod_Apostador = " & todo_check(contador)
          conx.execute(sql)

         qtde = qtde + 1

       next 

       Mensagem = qtde & " apostador(es) ativado(s) com sucesso sob a responsabilidade de " & usuario_responsavel 

    end if


%>


<html>
<head>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title><%=TituloPagina%> - Inclusão de Apostadores</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">


<div class="mensagem">
  <% response.write Mensagem & "<BR>" %>
</div>
<BR>

<form name="formInclusao" method="post" action="administracao_new.asp">
  <table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr>
      <th colspan="7" height="24">ATIVACAO DE APOSTADORES | <%= day(DateAdd("h", FusoHorario, now)) & "/" & month(DateAdd("h",  FusoHorario, now)) & "/" & year(DateAdd("h",  FusoHorario, now)) & " - " & hour(DateAdd("h",  FusoHorario, now)) & ":" & minute(DateAdd("h",  FusoHorario, now)) & ":" & second(DateAdd("h",  FusoHorario, now)) %>
      </th>
    </tr>
    <tr>
      <th colspan="2" >USUÁRIO LOGADO :
      </th>
      <th colspan="5" align="left"><%=rs_usuario("nome")%>
      </th>
    </tr>
    <tr>
      <th colspan="2" >USUÁRIO RESPONSÁVEL PELO FINANCEIRO:
      </th>

      <th colspan="5" align="left">


<% 
  
  if rs_usuario("acesso_gestao_total") = 0 then

%>

    <%=rs_usuario("nome")%>

<%

  else 

%>

    <select name="cmbAtualizar">


<%

  sql = "Select * from Apostadores where acesso_ativacao = 1 order by nome"

  set rs1 = Server.CreateObject("ADODB.Recordset")

  rs1.Open sql, conx 

  While not rs1.EOF

 %>
     <option value="<%= rs1("cod_Apostador")%>"><%= rs1("nome")%></option>

<% rs1.MoveNext

  wend
 

  rs1.Close 
  Set rs1 = Nothing

%> 

  </select>


<%

  end if

%>


      </th>

    </tr>


  </table>

<br>
<br>




<table width="50%" border="0" cellspacing="2" cellpadding="2" align="center" class="Bolao">
  <tr>
    <th colspan="70">APOSTADORES PRE-CADASTRADOS - SELECIONE OS QUE DEVEM SER ATIVADOS SOB RESPONSABILIDADE DO USUÁRIO ACIMA</th>
  </tr>
  <tr>
    <td class="Titulo" width="10%">Selecione</td>
    <td class="Titulo" width="20%">Nome</td>
    <td class="Titulo" width="20%">Contato</td>
   </tr>
  <%
     intLinha = 0

     sql =		 "   SELECT * FROM Apostadores"
	 sql = sql & "	  WHERE Apostadores.Ativo = 0"
	 sql = sql & " ORDER BY Apostadores.nome"


     set rs = Server.CreateObject("ADODB.Recordset")

     rs.Open sql, conx 

     while not rs.eof
		
                intLinha = intLinha + 1  
                
	if intLinha mod 2 = 0 then
%>			<tr class="LinhaPar">
<%	else %>
			<tr class="LinhaImpar">
<%	end if %>

		<td width="10%"> <input type="checkbox" name="check" value="<%=rs("cod_Apostador")%>"> </td>

       <td  width="20%"><%= rs("nome") %></td>
       <td  width="20%"><%= rs("Contato") %></td>
<%
       rs.MoveNext
    wend
%>
</table>


<%
  
  ' Fechar os objetos Recordsets 
  rs.Close
  rs_usuario.Close
   
  ' Eliminar os objetos Recordsets 
  Set rs = Nothing 
  Set rs_usuario = Nothing 
  ' Fechar o objeto da conexÃ£o 
  conx.Close 
 
 ' Eliminar o objeto da conexÃ£o 
  Set conx = Nothing 

%>

<br>
  <div align="center">
    <input type="submit" name="btnIncluir" value="Atualizar" class="botao">&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">
  </div>
<p>&nbsp;</p>


</form>

</body>
</html>
<%
	
end if

%>
