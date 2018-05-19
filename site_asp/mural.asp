<!--#include virtual="/comuns/configuracoes.asp"--> 

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

<title><%=TituloPagina%> - Mural de Mensagens</title>


<!--#include virtual="/comuns/menu.asp"--> 


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


  ' Fechar o objeto da conexÃ£o 


  conx.Close 


 


 ' Eliminar o objeto da conexÃ£o 


  Set conx = Nothing 











%>





<br>


<div align="center">


  <input type="submit" name="btnMensagem" value="Enviar Mensagem"  class="botao" onClick="Mensagens();return false;">&nbsp;&nbsp;


  <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


</div>


</body>


</html>


