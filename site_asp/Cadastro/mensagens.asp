<!--#include virtual="/comuns/configuracoes.asp"--> 



<% 





 if Session("usuario") = empty then


    response.write ("Usu&aacute;rio n&atilde;o autorizado!!!<br>")


    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")


  else


         Set conx = Server.CreateObject("ADODB.Connection")


         conx.Open ConnStrMySQL 





	


    sql = "Select * from Apostadores where nome = '" & SafeSQL(session("usuario")) & "'"





    set rs_usuario = Server.CreateObject("ADODB.Recordset")





    rs_usuario.Open sql, conx 





   if request("btnIncluir") <> empty then


	'Incluindo uma nova mensagem


	   codInsercao = rs_usuario("cod_Apostador")


	   if request("mensagem") = empty then


                           Mensagem = "Preencha a mensagem a ser enviada!"


                        else


                           set rs = Server.CreateObject("ADODB.Recordset")


	      sql = "SELECT MAX(cod_mensagem) as maxCodMensagem FROM Mensagens"


                            rs.Open sql, conx


              if rs("maxCodMensagem") > 0 then


  	         codMensagem = rs("maxCodMensagem") + 1


              else


                 codMensagem = 1


              end if


              rs.Close








	      sql = 	  "INSERT INTO Mensagens (cod_Apostador, cod_Mensagem, data_msg, hora_msg, mensagem)"


	      sql = sql & " VALUES (" & SafeSQL(codInsercao) & ", " & SafeSQL(codMensagem) & ",'" &  day(DateAdd("h", FusoHorario, now)) & "/" & month(DateAdd("h",  FusoHorario, now)) & "/" & year(DateAdd("h",  FusoHorario, now)) & "', '" & hour(DateAdd("h",  FusoHorario, now)) & ":" & minute(DateAdd("h",  FusoHorario, now)) & ":" & second(DateAdd("h",  FusoHorario, now))

                           sql = sql & "', '" & SafeSQL(TirarAcento(request("mensagem"))) & "')"








	      conx.execute(sql)


      	      Mensagem = "Mensagem postada com sucesso!"


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


<title><%=TituloPagina%> - Envio de Mensagens</title>

<!--#include virtual="/comuns/menu.asp"--> 


<br>

<div class="mensagem">


  <% response.write Mensagem & "<BR>" %>


</div>


<BR>


<form name="formInclusao" method="post" action="mensagens.asp">


  <table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">


    <tr>


      <th colspan="2" height="24">ENVIO DE MENSAGENS | <%= day(DateAdd("h", FusoHorario, now)) & "/" & month(DateAdd("h",  FusoHorario, now)) & "/" & year(DateAdd("h",  FusoHorario, now)) & " - " & hour(DateAdd("h",  FusoHorario, now)) & ":" & minute(DateAdd("h",  FusoHorario, now)) & ":" & second(DateAdd("h",  FusoHorario, now)) %>


      </th>


    </tr>


    <tr>


      <th colspan="1" widht="20%" aling="right">NOME :


      </th>


      <th colspan="1" widht="80%" align="left"><%=rs_usuario("nome")%>


      </th>


    </tr>


    <tr>


      <th colspan="1" widht="20%" aling="right">CONTATO :


      </th>


      <th colspan="1" widht="80%" align="left"> <%=rs_usuario("contato")%>


      </th>


    </tr>





  <tr>


    <th colspan="2" height="24">MENSAGEM A SER ENVIADA:</th>


  </tr>





  <tr class="LinhaImpar">


  <td widht="100%" colspan="2" >


         <textarea cols="100" rows="10" name="mensagem" ></textarea>


  </td>


  </tr>


</table>


<br>


  <div align="center">


    <input type="submit" name="btnIncluir" value="Enviar Mensagem" class="botao">&nbsp;&nbsp;&nbsp;&nbsp;


    <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">


  </div>


<p>&nbsp;</p>


</form>


</body>


<% 


 ' Fechar os objetos Recordsets 


  rs_usuario.Close


 


  ' Eliminar os objetos Recordsets 


  Set rs_usuario = Nothing


  


  ' Fechar o objeto da conex&atilde;o 


  conx.Close 


 


 ' Eliminar o objeto da conex&atilde;o 


  Set conx = Nothing 





 end if%>





</html>


