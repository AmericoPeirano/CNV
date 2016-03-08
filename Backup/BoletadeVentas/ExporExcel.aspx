<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExporExcel.aspx.cs" Inherits="BoletadeVentas.ExporExcel" EnableEventValidation="false"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
      <p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:GL_GROUPConnectionString %>"  
            SelectCommand="SELECT [nota_venta], [Fecha], [Sup_Estado], [Sup_fecha_Pendiente], [Sup_fecha_Aprobacion], [Sup_fecha_Termino], [Bod_Estado], [Bod_fecha_Pendiente], [Bod_fecha_Preparacion], [Bod_fecha_Terminado], [Bod_fecha_Laboratorio], [Preparador], [Lab_Estado], [Lab_fecha_pendiente], [Lab_fecha_PorRevisar], [Lab_fecha_Revisado], [Fac_Estado], [Fac_fecha_Pendiente], [Fac_fecha_Por_Facturar], [Fac_fecha_Facturado], [Des_Estado], [Des_fecha_Pendiente], [Des_fecha_Por_Despachar], [Des_fecha_Despacho], [Sector], [Tipo], [Bultos_pequeños], [Bultos_medianos], [Bultos_grandes], [Conductor], [Numero_factura_o_Guia], [Numero_factura_o_Guia1], [Checked], [Despachador], [Observaciones], [Sektor], [TipoDoc],[OC] FROM [NOTV_control] WHERE ([nota_venta] &gt; @nota_venta) ORDER BY [nota_venta] DESC">
            <SelectParameters>
                <asp:Parameter DefaultValue="26830" Name="nota_venta" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="gvExcel" runat="server" EnableModelValidation="True" 
            AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnRowDataBound="SYSGrid_RowDataBound">
            <Columns>
                <asp:BoundField HeaderText="Num NV" DataField="nota_venta" 
                    SortExpression="nota_venta" />
                <asp:BoundField HeaderText="Fecha" DataField="Fecha" SortExpression="Fecha" />
                <asp:BoundField HeaderText="Estado Supervisor" DataField="Sup_Estado" 
                    SortExpression="Sup_Estado" />
                <%--<asp:BoundField HeaderText="Sup_fecha antes del clic" 
                    DataField="Sup_fecha_Pendiente" SortExpression="Sup_fecha_Pendiente" />--%>
                <asp:BoundField HeaderText="Aprobacion de NV por Supervisor" 
                    DataField="Sup_fecha_Aprobacion" SortExpression="Sup_fecha_Aprobacion" />
                <asp:BoundField HeaderText="Termino de despacho" DataField="Sup_fecha_Termino" 
                    SortExpression="Sup_fecha_Termino" />
                <asp:BoundField HeaderText="Estado Bodega" DataField="Bod_Estado" 
                    SortExpression="Bod_Estado" />
                <asp:BoundField HeaderText="Antes que Reciba bodega" 
                    DataField="Bod_fecha_Pendiente" SortExpression="Bod_fecha_Pendiente" />
                <asp:BoundField HeaderText="Bodega Recibe NV (primer clic)" 
                    DataField="Bod_fecha_Preparacion" SortExpression="Bod_fecha_Preparacion" />
                <asp:BoundField HeaderText="Bodega Envia a factura" 
                    DataField="Bod_fecha_Terminado" SortExpression="Bod_fecha_Terminado" />
                <asp:BoundField HeaderText="Bodega Envia a Laboratorio" 
                    DataField="Bod_fecha_Laboratorio" SortExpression="Bod_fecha_Laboratorio" />
                <asp:BoundField HeaderText="Preparador" DataField="Preparador" 
                    SortExpression="Preparador" />
                <asp:BoundField HeaderText="Estado Laboratorio" DataField="Lab_Estado" 
                    SortExpression="Lab_Estado" />
                <asp:BoundField HeaderText="Antes que Reciba laboratorio" 
                    DataField="Lab_fecha_pendiente" SortExpression="Lab_fecha_pendiente" />
                <asp:BoundField HeaderText="Recibe Laboratorio" 
                    DataField="Lab_fecha_PorRevisar" SortExpression="Lab_fecha_PorRevisar" />
                <asp:BoundField HeaderText="Laboratorio ya Reviso" DataField="Lab_fecha_Revisado" 
                    SortExpression="Lab_fecha_Revisado" />
                <asp:BoundField HeaderText="Estado Facturacion" DataField="Fac_Estado" 
                    SortExpression="Fac_Estado" />
                <asp:BoundField HeaderText="Antes que facturacion Reciba" 
                    DataField="Fac_fecha_Pendiente" SortExpression="Fac_fecha_Pendiente" />
                <asp:BoundField HeaderText="Facturacion recibe" 
                    DataField="Fac_fecha_Por_Facturar" SortExpression="Fac_fecha_Por_Facturar" />
                <asp:BoundField HeaderText="Facturado" 
                    DataField="Fac_fecha_Facturado" SortExpression="Fac_fecha_Facturado" />
                <asp:BoundField HeaderText="Estado Despacho" DataField="Des_Estado" 
                    SortExpression="Des_Estado" />
                <asp:BoundField HeaderText="Des_fecha Pendiente" 
                    DataField="Des_fecha_Pendiente" SortExpression="Des_fecha_Pendiente" />
                <asp:BoundField HeaderText="Des_fecha Por Despachar" 
                    DataField="Des_fecha_Por_Despachar" SortExpression="Des_fecha_Por_Despachar" />
                <asp:BoundField HeaderText="Des_fecha de Despacho" DataField="Des_fecha_Despacho" 
                    SortExpression="Des_fecha_Despacho" />
                <asp:BoundField HeaderText="Comuna" DataField="Sector" 
                    SortExpression="Sector" />
                <asp:BoundField HeaderText="Tipo de Despacho" DataField="Tipo" SortExpression="Tipo" />
                <asp:BoundField HeaderText="Bultos Pequeños" DataField="Bultos_pequeños" 
                    SortExpression="Bultos_pequeños" />
                <asp:BoundField HeaderText="Bultos Medianos" DataField="Bultos_medianos" 
                    SortExpression="Bultos_medianos" />
                <asp:BoundField HeaderText="Bultos Grandes" DataField="Bultos_grandes" 
                    SortExpression="Bultos_grandes" />
                <asp:BoundField HeaderText="Conductor" DataField="Conductor" 
                    SortExpression="Conductor" />
                <asp:BoundField HeaderText="Documento" 
                    DataField="Numero_factura_o_Guia" SortExpression="Numero_factura_o_Guia" />
                <asp:BoundField HeaderText="Documento1" 
                    DataField="Numero_factura_o_Guia1" SortExpression="Numero_factura_o_Guia1" />
                <asp:BoundField HeaderText="Ok de Despacho" DataField="Checked" 
                    SortExpression="Checked" />
                <asp:BoundField HeaderText="Despachador" DataField="Despachador" 
                    SortExpression="Despachador" />
                <asp:BoundField HeaderText="Observaciones" DataField="Observaciones" 
                    SortExpression="Observaciones" />
                <asp:BoundField HeaderText="Sector" DataField="Sektor" 
                    SortExpression="Sektor" />
                <asp:BoundField DataField="TipoDoc" HeaderText="Tipo de Docu" 
                    SortExpression="TipoDoc" />
                    <asp:BoundField DataField="OC" HeaderText="O/C" 
                    SortExpression="OC" />
            </Columns>
        </asp:GridView>
        </p>
    </div>
    </form>
</body>
</html>
