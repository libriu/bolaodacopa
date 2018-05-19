<!--#include virtual="/comuns/configuracoes.asp"--> 


<% 



 if Session("usuario") = empty then

    response.write ("Usu&aacute;rio n&atilde;o autorizado!!!<br>")

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



	   Mensagem = "Nome de grupo j&aacute; existente. Utilize outro nome!"



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



	   sql = sql & " VALUES (" & codGrupo & ", '" & TirarAcento(request("nome_novo_grupo")) & "'," & rs_usuario("cod_Apostador") & ")"



	   conx.execute(sql)



	   Mensagem = "Grupo inclu&iacute;do com sucesso!"



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



            Mensagem = "Voc&ecirc; n&atilde;o tem grupo cadastrados. Crie um novo grupo para poder atualizar!"



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



               Mensagem = "Voc&ecirc; n&atilde;o tem grupo cadastrados. Crie um novo grupo para poder atualizar!"



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

<!--#include virtual="/comuns/menu.asp"--> 


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

  <th colspan="3" height="24" width="37%">Selecione o Grupo a ser Exclu&iacute;do:</th>





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

  

  ' Fechar o objeto da conex&atilde;o 

  conx.Close 

 

 ' Eliminar o objeto da conex&atilde;o 

  Set conx = Nothing 



 end if%>

</html>

