<!-- #include file ="jsonObject.class.asp" -->

<%
    Response.LCID = 1046 ' Brazilian LCID (use your locale code here).

    On Error Resume Next

    ConnStrMySQL  = "Driver={MySQL ODBC 3.51 Driver};Server=50.62.209.75;Database=bolaodacopa2018;uid=bolaodacopa;pwd=Brasil2018;option=3"
    Set conx = Server.CreateObject("ADODB.Connection")
    conx.Open ConnStrMySQL 

    sql = "select r.*,p1.Arquivo arq_time_1, p2.Arquivo arq_time_2 from Resultados r, Pais p1, Pais p2 where r.time1 = p1.Pais and r.time2 = p2.Pais"

    set resultSet = Server.CreateObject("ADODB.Recordset")
    
    resultSet.Open sql, conx

    ' instantiate the class
    set JSONarr = New JSONarray

    JSONarr.LoadRecordset resultSet
    
    set JSON = New JSONobject
    
    JSON.Add "data", JSONarr

    JSON.Write()

    ' Fechar e eliminar os objetos Recordsets 
    resultSet.Close
    Set resultSet = Nothing 
  
    ' Fechar e eliminar o objeto da conexÃ£o 
  
    conx.Close
    Set conx = Nothing   

%>