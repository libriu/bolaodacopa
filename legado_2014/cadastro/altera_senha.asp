<%
  dim mensagem
  mensagem = ""
  if request("btnLogin") <> empty then

     if request("login") = "" then 
        mensagem = "Nome do apostador não foi informado!"
     else
        if request("senha_atual") = "" then
           mensagem = "Favor preencher a senha atual!"   
        else
           if request("senha_nova") = "" then 
             mensagem = "Favor preencher a nova senha!"   
           else

    'Abrindo Conexão mySQL - Forma usada em 2010
'         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Database=bolaodacopa2013;uid=bolaodacopa;pwd=Brasil;option=3"


    'Abrindo Conexão mySQL - Forma usada em 2013
         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=mysql.bolaodacopa.unositehospedagem.com.br;Database=bolaodacopa;uid=bolaodacopa;pwd=vasco97;option=3"
         Set conx = Server.CreateObject("ADODB.Connection")
         conx.Open ConnStrMySQL 

			
     			sql = "SELECT * FROM Apostadores WHERE nome = '" & request("login") & "' and Apostadores.Ativo"  
  
				set rs = Server.CreateObject("ADODB.Recordset")
				rs.Open sql, conx 
				
             if rs.eof then
               mensagem = "Nome do Apostador inválido."
             else
                 sql = "SELECT * FROM Apostadores WHERE nome = '" & request("login") & "' and senha_apostador = '" & request("senha_atual") & "';"
		 set rs1 = Server.CreateObject("ADODB.Recordset")
 		 rs1.Open sql, conx 

                 if rs1.eof then
                   mensagem = "Senha atual digitada não confere!"
                else  
                  sql = "UPDATE Apostadores SET Senha_apostador = '" & request("senha_nova") & "' WHERE nome = '" & request("login") & "'"
                  conx.execute(sql)
                  mensagem = "Senha alterada com sucesso!"
                 
                end if
                rs1.close
                set rs1 = nothing

             end if
             rs.close
             set rs = nothing
             conx.close
             Set conx = Nothing
      end if

     end if
    end if
   end if %>
<script language="JavaScript">
<!--
function retornar() {
 window.location="index.asp"
 }
//-->
</script>
<html>
<head>
<title>Bolao da Copa do Mundo no Brasil 2014 - Alteração de Senha</title>
<META HTTP-EQUIV="Expires" CONTENT="0">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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


<div class="mensagem"><%=mensagem%>
</div>
<form name="formAlteraSenha" method="post" action="altera_senha.asp">
<table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <th colspan="2" height="24">ALTERAÇÃO DE SENHA | <%= day(now()) & "/" & month(now()) & "/" & year(now()) & " - " & time() %></th>
  </tr>


<%

if mensagem <> "Senha alterada com sucesso!" then

%>
  <tr>
    <td><div align="left">&nbsp;Nome do Apostador</div></td>
    <td><div align="left">&nbsp;<input type="text" name="login" size="50" value="<%=session("usuario")%>"></div></td>




  </tr>
  <tr>
    <td><div align="left">&nbsp;Senha Atual</div></td>
    <td><div align="left">&nbsp;<input type="password" name="senha_atual" size="20"></div></td>
  </tr>  
  <tr>
    <td><div align="left">&nbsp;Nova Senha</div></td>
    <td><div align="left">&nbsp;<input type="password" name="senha_nova" size="20"></div></td>
  </tr>

<% end if %>
</table>
<br>
<div align="center">

<%

if mensagem <> "Senha alterada com sucesso!" then

%>
  <input type="submit" name="btnLogin" value="Alterar" class="botao">&nbsp;&nbsp;&nbsp;&nbsp;

<% end if %>

  <input type="submit" name="btnVoltar" value="Retornar" class="botao" onClick="retornar();return false;">
</div>
</form>
<p>&nbsp;</p>


<%

if mensagem <> "Senha alterada com sucesso!" then

%>

<div align="center" class="texto">Formulário para alteração de senha</div>
<div align="center" class="texto">  </div>
<div align="center" class="mensagem">No primeiro acesso você precisa alterar sua senha</div>

<% end if %>

</body>
</html>
