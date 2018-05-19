<%  if Session("manut") = empty then


    response.write ("Usuario não autorizado!!!<br>")


    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")


  else


%>


<html>


<head>


<META HTTP-EQUIV="Expires" CONTENT="0">


<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">


<META HTTP-EQUIV="Pragma" CONTENT="no-cache">


<title>Bolao da Copa do Mundo</title>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">


</head>


<body bgcolor="#FFFFFF" text="#000000">





<%="""" & request("comando") & """"%><br>


<!--#include virtual="/comuns/configuracoes.asp"--> 


<%

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


   cComando = "Atualizacao"


   Conx.execute(request("comando"))


elseif cLetra = "I" then


   cComando = "Insercao"


   Conx.execute(request("comando"))


elseif cLetra = "D" then


   cComando = "Delecao"   


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


