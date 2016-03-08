<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExportLog.aspx.cs" Inherits="BoletadeVentas.ExportLog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Visible="False"></asp:Label>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:GL_GROUPConnectionString %>"             
            
            SelectCommand="SELECT [nv], [usuario], [fecha], [accion], [descripcion] FROM [LOG_NV] ORDER BY [id] DESC">
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableModelValidation="True">
            <Columns>
                <asp:BoundField DataField="nv" HeaderText="NotaVenta" SortExpression="nv" />
                <asp:BoundField DataField="usuario" HeaderText="Usuario" 
                    SortExpression="usuario" />
                <asp:BoundField DataField="fecha" HeaderText="fecha" SortExpression="fecha" />
                <asp:BoundField DataField="accion" HeaderText="Acción Realizada" 
                    SortExpression="accion" />
                <asp:BoundField DataField="descripcion" HeaderText="Descripción de la Acción" 
                    SortExpression="descripcion" />
            </Columns>
        </asp:GridView>
    <br />
    </div>
    </form>
</body>
</html>
