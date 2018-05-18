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
    
    <td width="15%" aling="lef"><center><a href="/app"><img src="../Imagens/app.jpg"></a></center></td>
    
    
    <%   else %>
    
    
    <td width="15%" aling="lef"><center>&nbsp;<a href="precadastro.asp"><img src="../Imagens/preinscricao.gif" width="100" height="45"></a><br></center>
    <center>&nbsp;<a href="http://bolaodacopa2018.online/app"><img src="../Imagens/app.jpg"></a></center>
    
    </td>
    
    
    
    <% end if %>
    
    <td width="15%" aling="lef"><center><img src="../Imagens/logo_copa.jpg" width="80" height="80"></center></td>
    
    <td width="40%" aling="center"><center><img src="../Imagens/logo.jpg" width="328" height="80"></center></td>
    
    <td width="15%" aling="right"><center>&nbsp;<a href="../index.asp"><img src="../Imagens/Ranking_Principal_link.jpg"></a><br></center>
    
    <center>&nbsp;<a href="../rankingacertos.asp"><img src="../Imagens/Ranking_Acertos_link.jpg"></a><br></center>
    
    <center>&nbsp;<a href="../rankingGrupos.asp"><img src="../Imagens/Ranking_Grupos_link.jpg"></a></center></td>
    
    <td width="15%" aling="right"><center>&nbsp;<a href="../cadastro"><img src="../Imagens/aposta.gif"></a><br></center>
    
    <center>&nbsp;<a href="../regras.asp"><img src="../Imagens/regras.jpg"></a><br></center>
    
    <center>&nbsp;<a href="../estatistica.asp"><img src="../Imagens/estatisticas.jpg"></a></center></td>
    
    </tr>
    
    </table>
    