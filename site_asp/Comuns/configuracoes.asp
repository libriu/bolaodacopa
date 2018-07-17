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

         ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=50.62.209.75;Database=bolaodacopa2018;uid=bolaodacopa2018;pwd=Th*e20@%214bo##AX;option=3"



Function TirarAcento(Palavra)
  CAcento = "àáâãäèéêëìíîïòóôõöùúûüÀÁÂÃÄÈÉÊËÌÍÎÒÓÔÕÖÙÚÛÜçÇñÑ"
  SAcento = "aaaaaeeeeiiiiooooouuuuAAAAAEEEEIIIOOOOOUUUUcCnN"
  Texto = ""
  If Palavra <> "" then
    For X = 1 To Len(Palavra)
      Letra = Mid(Palavra,X,1)
      Pos_Acento = InStr(CAcento,Letra)
      If Pos_Acento > 0 Then Letra = mid(SAcento,Pos_Acento,1)
      Texto = Texto & Letra
    Next
    TirarAcento = Texto
  End If
End Function  

Function SafeSQL(sInput)
  TempString = sInput
  sBadChars=array("select", "drop", ";", "--", "insert", "delete", "xp_", "#", "%", "&", "'", "(", ")", ":", ";", "<", ">", "=", "[", "]", "?", "`", "|") 
  For iCounter = 0 to uBound(sBadChars)
    TempString = replace(TempString,sBadChars(iCounter),"")
  Next
  SafeSQL = TempString
End function

Function SafeSQLSenha(sInput)
  TempString = sInput
  sBadChars=array("select", "drop", "--", "insert", "delete", "xp_", "'") 
  For iCounter = 0 to uBound(sBadChars)
    TempString = replace(TempString,sBadChars(iCounter),"")
  Next
  SafeSQLSenha = TempString
End function


%>
