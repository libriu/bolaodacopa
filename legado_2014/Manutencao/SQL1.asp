<%  if Session("manut") = empty then
    response.write ("Usuário não autorizado!!!<br>")
    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")
  else
%>
<html>
<head>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title>Bolao da Copa do Mundo no Brasil 2014 - Inclusão de Apostadores</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">

<%="""" & request("comando") & """"%><br>
<%

    'Abrindo Conexão mySQL - Forma usada em 2010
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Database=bolaodacopa2013;uid=bolaodacopa;pwd=Brasil;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2013
         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=mysql.bolaodacopa.unositehospedagem.com.br;Database=bolaodacopa;uid=bolaodacopa;pwd=vasco97;option=3"
         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 

   Set Session("conx") = Conx
   
  
cLetra = UCase(Mid(trim(Request("comando")),1,1))

cLetra = UCase(Mid(trim(Request("comando")),1,1))

if cLetra = "S" then
   cComando = "Consulta"
   set rs = Server.CreateObject("ADODB.Recordset")
   sql = request("comando")
   rs.open sql, conx
elseif cLetra = "U" then
   cComando = "Atualização"
   Conx.execute(request("comando"))
elseif cLetra = "I" then
   cComando = "Inserção"
   Conx.execute(request("comando"))
elseif cLetra = "D" then
   cComando = "Deleção"   
   Conx.execute(request("comando"))
end if	 

if cLetra = "S" then%>
  <P>
  <TABLE BORDER = 1>
  <TR>
  <% For i=0 to RS.Fields.Count - 1 %>
      <TD><B><%=RS(i).name %> </B> </TD>
   <%Next%>
   </TR>
   <%Do while not RS.EOF %>
     <TR>
     <% For i=0 to RS.Fields.Count - 1 %>
	 <TD ALING =TOP ><%=RS(i) %> </TD>
     <% Next %></TR>
     <%RS.MoveNext
    Loop
RS.Close
set RS = Nothing
end if
conx.close 

set conx = Nothing%>

</TABLE>

<br><br>
<h3>Comando de <%=cComando%> efetuado com sucesso !!!</h3>

</body>
</html>
<%end if%>
