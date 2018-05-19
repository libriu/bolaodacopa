<!--#include virtual="/comuns/configuracoes.asp"--> 

<html>

<head>

<title><%=TituloPagina%> - Regras</title>

<!--#include virtual="/comuns/menu.asp"--> 


<table class="Bolao" width="70%" border="0" cellspacing="2" cellpadding="2" align="center">

  <tr>

    <th colspan="7" height="24">REGRAS DO BOL&Atilde;O | <%= day(DateAdd("h", FusoHorario, now)) & "/" & month(DateAdd("h",  FusoHorario, now)) & "/" & year(DateAdd("h",  FusoHorario, now)) & " - " & hour(DateAdd("h",  FusoHorario, now)) & ":" & minute(DateAdd("h",  FusoHorario, now)) & ":" & second(DateAdd("h",  FusoHorario, now)) %></th>

  </tr>

  <TR>

    <td align="left">

      <div align="left">

        <p>O Bol&atilde;o On-line 2018 &eacute; composto por todos os jogos 

             da Copa do Mundo. </p>

        <p>O objetivo do bol&atilde;o &eacute; meramente promover uma brincadeira entre amigos, assim a arrecada&ccedil;&atilde;o, subtra&iacute;da apenas do custo da hospedagem de R$ 56,00, ser&aacute; distribu&iacute;da entre os vencedores.</p>

        <p>O valor da participa&ccedil;&atilde;o &eacute; de R$ 20,00.</p>

        <p>O participante receber&aacute; um nome de apostador e sua senha. Com

          estes dados ele poder&aacute; cadastrar suas apostas por meio

          do link existente na p&aacute;gina principal do bol&atilde;o.</p>

        <p>Os placares poder&atilde;o ser inclu&iacute;dos e alterados at&eacute; meia noite do dia anterior de cada jogo. Se o apostador n&atilde;o

          incluir o placar, ele n&atilde;o pontuar&aacute; nesta partida, mas concorrer&aacute; normalmente nas demais. </p>

        <p> Apenas no dia do jogo &eacute; que os placares apostados pelos participantes estar&atilde;o dispon&iacute;veis para consulta. </p>

	<p>O Bol&atilde;o ter&aacute; no m&iacute;nimo cinco ganhadores no ranking principal. Se houver empate entre apostadores ganhadores, eles dividir&atilde;o o pr&ecirc;mio das posi&ccedil;ões ocupadas de forma acumulada. Por exemplo, se duas pessoas empatarem em primeiro lugar, dividir&atilde;o o primeiro e segundo pr&ecirc;mios.

          <br><br>

	  Neste bol&atilde;o ter&aacute; uma novidade (pr&ecirc;mio extra): O apostador que tiver a maior quantidade de acertos de placares dos jogos receber&aacute; 5% do arrecadado*<br>

          <br>

    Em suma, assim ser&aacute; a divis&atilde;o da premia&ccedil;&atilde;o deste bol&atilde;o:

          <br><br>

          - 1º lugar                               : 50% do arrecadado* <br>

          - 2º lugar                               : 25% do arrecadado* <br>

          - 3º lugar                               : 10% do arrecadado* <br>

          - 4º lugar                               : 06% do arrecadado* <br>

          - 5º lugar                               : 04% do arrecadado* <br>

          - Maior quantidade de acertos de placares: 5% do arrecadado <br><br>

	  * Para efeitos de premia&ccedil;&atilde;o, a arrecada&ccedil;&atilde;o ser&aacute; subtra&iacute;da do custo de hospedagem, conforme j&aacute; esclarecido acima.<br>	

        <p>  

      </div>

    </td>

  </tr>

    

</table>

<br>

<table width="70%" border="0" cellspacing="2" cellpadding="2" class="Bolao" align="center">

  <tr>

    <th colspan="2">PONTUA&Ccedil;&Atilde;O</th>

  </tr>

  <tr>

    <td colspan="2">

      <div align="left">        <p>O quadro de pontua&ccedil;&atilde;o de cada jogo &eacute; o seguinte, considerando para tal somente o placar do tempo normal de jogo, sem prorroga&ccedil;ões ou p&ecirc;naltis:</p>

</div>

    </td>

  </tr>

  <tr>

    <td>10 - </td>

    <td>

      <div align="left">Acertou o placar do jogo</div>

    </td>

  </tr>

  <tr>

    <td>5 - </td>

    <td>

      <div align="left">Errou o placar, mas acertou quem venceu o jogo e o escore do vencedor</div>

    </td>

  </tr>

  <tr>

    <td>4 - </td>

    <td>

      <div align="left">Errou o placar, mas acertou quem venceu o jogo e o escore do perdedor</div>

    </td>

  </tr>

  <tr>

    <td>4 - </td>

    <td>

      <div align="left">Acertou o empate, mas errou o placar</div>

    </td>

  </tr>

  <tr>

    <td>3 - </td>

    <td>

      <div align="left">Errou os placares do vencedor e do perdedor, mas acertou quem venceu</div>

    </td>

  </tr>

  <tr>

    <td> 1 - </td>

    <td>

      <div align="left">Acertou o placar invertido</div>

    </td>

  </tr>

</table>

<br>

<table width="70%" border="0" cellspacing="2" cellpadding="2" class="Bolao" align="center">

  <tr>

    <th colspan="2">ATEN&Ccedil;&Atilde;O: PONTUA&Ccedil;&Atilde;O PONDERADA PARA A SEGUNDA FASE EM DIANTE</th>

  </tr>

  <tr>

    <td><div align="left"> Multiplicada por 2 | Jogos 49 a 60 (OITAVAS E QUARTAS DE FINAIS)</div>

    </td>

  </tr>

  <tr>

    <td><div align="left"> Multiplicada por 3 | Jogos 61 a 63 (SEMI-FINAIS e DISPUTA DE 3º LUGAR)</div>

    </td>

  </tr>

  <tr>

    <td><div align="left"> Multiplicada por 4 | Jogo 64 (GRANDE FINAL DA COPA DO MUNDO)</div>

    </td>

  </tr>

</table>



<script language="JavaScript">

<!--

function retornar() {

 window.location="index.asp"

 }

//-->

</script>

<br>

<FORM>

<div align="center">

  <input type="submit" name="btnVoltar" value="Retornar" class="botao" onclick="retornar();return false;">

</div>

</FORM>



<br>

<p>&nbsp;</p>

</body>

</html>

