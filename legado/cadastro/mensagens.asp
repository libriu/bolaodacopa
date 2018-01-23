<% 

 if Session("usuario") = empty then
    response.write ("Usuário não autorizado!!!<br>")
    response.write ("<A href=""../index.asp"">Clique aqui para retornar</a>")
  else
    'Abrindo Conexão mySQL - Forma usada em 2010
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Database=bolaodacopa2013;uid=bolaodacopa;pwd=Brasil;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2013
         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=mysql.bolaodacopa.unositehospedagem.com.br;Database=bolaodacopa;uid=bolaodacopa;pwd=vasco97;option=3"
         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 

	
    sql = "Select * from Apostadores where nome = '" & session("usuario") & "'"

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
	      sql = sql & " VALUES (" & codInsercao & ", " & codMensagem & ",'" &  day(now()) & "/" & month(now()) & "/" & year(now()) & "', '" & time()
                           sql = sql & "', '" & request("mensagem") & "')"


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
<title>Bolao da Copa do Mundo no Brasil 2014</title>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta http-equiv="Content-Type" content="text/xhtml; charset=UTF-8" />


<link rel="stylesheet" href="../Comuns/styles.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">


<table width="80%" align="center">
<tr> 
<td width="20%" aling="lef"><center><img src="../Imagens/logo_copa.jpg" width="80" height="80"></center></td>
<td width="60%" aling="center"><center><img src="../Imagens/logo.jpg" width="328" height="80"></center></td>
<td width="20%" aling="right"><center>&nbsp;</center></td>
</tr>
</table>



<div class="mensagem">
  <% response.write Mensagem & "<BR>" %>
</div>
<BR>



<form name="formInclusao" method="post" action="mensagens.asp">
  <table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">
    <tr>
      <th colspan="2" height="24">ENVIO DE MENSAGENS | <%= day(now()) & "/" & month(now()) & "/" & year(now()) & " - " & time() %>
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
  
  ' Fechar o objeto da conexão 
  conx.Close 
 
 ' Eliminar o objeto da conexão 
  Set conx = Nothing 

 end if%>

</html>
