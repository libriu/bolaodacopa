<!-- #include file ="jsonObject.class.asp" -->

<%
    FusoHorario = 4
    FormatoData = "Americano"
    TituloPagina = "Bolão da Copa do Mundo 2018"
    Response.LCID = 1046 ' Brazilian LCID (use your locale code here).

    'Abrindo Conexão mySQL - Forma usada em 2018

    ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=50.62.209.75;Database=bolaodacopa2018;uid=bolaodacopa;pwd=Brasil2018;option=3"

    Set conx = Server.CreateObject("ADODB.Connection")
    conx.Open ConnStrMySQL 

    sql = "Select DATE_FORMAT(curdate(), ""%d\/%m\/%Y"") dataAtual"

    set rs_usuario = Server.CreateObject("ADODB.Recordset")
    rs_usuario.Open sql, conx

    ' instantiate the class
    set JSON = New JSONobject

    JSON.LoadRecordset rs_usuario

    ' Response.Write rs_usuario("dataAtual")
    JSON.Write()

    ' Fechar e eliminar os objetos Recordsets 
    rs_usuario.Close
    Set rs_usuario = Nothing 
  
    ' Fechar e eliminar o objeto da conexÃ£o 
  
    conx.Close
    Set conx = Nothing   

%>