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
 window.location="index.asp"
 }
function Mensagens() {
 window.location="/cadastro/index.asp"
 }
//-->
</script>
<html>
<head>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title><%=TituloPagina%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="Comuns/styles.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="80%" align="center">
<tr> 
<%
     if DateAdd("h", FusoHorario, now) >= DateAdd("d",-1,DataInicioCopaFormatado) then

%>

<td width="30%" aling="lef"><center><img src="Imagens/logo_copa.jpg" width="80" height="80"></center></td>

<%   else %>


<td width="15%" aling="lef"><center><a href="cadastro/precadastro.asp"><img src="Imagens/preinscricao.gif" width="80" height="50"></a></center></td>
<td width="15%" aling="lef"><center><img src="Imagens/logo_copa.jpg" width="80" height="80"></center></td>

<% end if %>


<td width="40%" aling="center"><center><img src="Imagens/logo.jpg" width="328" height="80"></center></td>
<td width="15%" aling="right"><center>&nbsp;<a href="index.asp"><img src="Imagens/Ranking_Principal_link.jpg"></a><br></center>
<center>&nbsp;<a href="rankingacertos.asp"><img src="Imagens/Ranking_Acertos_link.jpg"></a><br></center>
<center>&nbsp;<a href="rankingGrupos.asp"><img src="Imagens/Ranking_Grupos_link.jpg"></a></center></td>
<td width="15%" aling="right"><center>&nbsp;<a href="cadastro"><img src="Imagens/aposta.gif"></a><br></center>
<center>&nbsp;<a href="regras.asp"><img src="Imagens/regras.jpg"></a><br></center>
<center>&nbsp;<a href="estatistica.asp"><img src="Imagens/estatisticas.jpg"></a></center></td>
</tr>
</table>


<table class="Bolao" width="80%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <th colspan="9" height="24">MURAL DE MENSAGENS</th>
  </tr>
  <tr>
    <td class="Titulo" >Nome</td>
    <td class="Titulo" >Contato</td>
    <td class="Titulo" >Data</td>
    <td class="Titulo" >Hora</td>
    <td class="Titulo" >Mensagem</td>

<%

         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 


         sql =     "SELECT * FROM Mensagens, Apostadores WHERE Apostadores.cod_Apostador = Mensagens.cod_Apostador"
	  sql = sql & " ORDER BY Mensagens.cod_Mensagem DESC"

          set rs4 = Server.CreateObject("ADODB.Recordset")
	
          rs4.Open sql, conx 

  i = 1


  while not rs4.eof %>

<%  if (i MOD 2) <> 0 then%>
      <tr class="LinhaImpar">
<%  else%>
    <tr class="LinhaPar">
<%  end if%>

    <td><%=rs4("nome")%></td>
    <td><%=rs4("contato")%></td>
    <td><%=rs4("data_msg")%></td>
    <td><%=rs4("hora_msg")%></td>
    <td widht="60%"><%=rs4("mensagem")%></td>



</tr>

<% 

   rs4.MoveNext
  wend


%>
</TABLE>

<%
  
  ' Fechar os objetos Recordsets 
  rs4.Close
   
  ' Eliminar os objetos Recordsets 
  Set rs4 = Nothing
  ' Fechar o objeto da conexÃƒÂ£o 
  conx.Close 
 
 ' Eliminar o objeto da conexÃƒÂ£o 
  Set conx = Nothing 



%>

<br>
<div align="center">
  <input type="submit" name="btnMensagem" value="Enviar Mensagem"  class="botao" onClick="Mensagens();return false;">&nbsp;&nbsp;
  <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
</body>
</html>
