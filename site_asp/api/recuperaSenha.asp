<!-- #include file ="jsonObject.class.asp" -->

<%
    Response.LCID = 1046 ' Brazilian LCID (use your locale code here).

    ' fun��o para converter array de bytes em string
    Function BytesToStr(bytes)
        Dim Stream
        Set Stream = Server.CreateObject("Adodb.Stream")
        With Stream
            .Type = 1 'adTypeBinary
            .Open
            .Write bytes
            .Position = 0
            .Type = 2 'adTypeText
            .Charset = "UTF-8"
            BytesToStr = .ReadText
            Stream.Close
        End With
        Set Stream = Nothing
    End Function





    ' realizando leitura do body da requisi��o post
    lngBytesCount = 0
    jsonString = ""

    If Request.TotalBytes > 0 Then
        lngBytesCount = Request.TotalBytes
        jsonString = BytesToStr(Request.BinaryRead(lngBytesCount))
    else
        jsonString = request("json")
    end if

    ' Response.Write jsonString & "<br>"

    ' Fazendo parse da string json para objeto json
    set JSON = New JSONobject
    set dadosRecSenhaObj = JSON.Parse(jsonString)

    dim nomeStr as string

    nomeStr = dadosRecSenhaObj.Value("arg0")

    ' Response.Write nomeStr & "<br>"

    'Abrindo Conexão mySQL - Forma usada em 2018

    ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=50.62.209.75;Database=bolaodacopa2018;uid=bolaodacopa;pwd=Brasil2018;option=3"

    Set conx = Server.CreateObject("ADODB.Connection")
    conx.Open ConnStrMySQL 

    sql = "select a.cod_Apostador, a.nome from Apostadores a where a.nome = '" & nomeStr & "'"

'    set rs_usuario = Server.CreateObject("ADODB.Recordset")
'    rs_usuario.Open sql, conx

' instantiate the class
''    set JSON = New JSONobject

''    JSON.LoadRecordset rs_usuario

      Response.Write sql
 ''   JSON.Write()

    ' Fechar e eliminar os objetos Recordsets 
''    rs_usuario.Close
''    Set rs_usuario = Nothing 
  
    ' Fechar e eliminar o objeto da conexÃ£o 
  
    conx.Close
    Set conx = Nothing   

%>