<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Acusete.aspx.cs" Inherits="BoletadeVentas.Acusete" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <style type="text/css">
        .style4
        {
            width: 158px;
        }
        </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Button ID="btnVolver" runat="server" onclick="btnVolver_Click" 
    Text="Volver" />
    <asp:SqlDataSource ID="sqlAcusete" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GL_GROUPConnectionString %>" 
        
        
    SelectCommand="SELECT [nota_venta], CLIEN_DB.RAZSOC,RTRIM(PERSO_DB.NOMBRE)+' '+RTRIM(PERSO_DB.APELLIDO) as Vendedor 
FROM CLIEN_DB,NOTV_DB,NOTV_control,PERSO_DB
WHERE NOTV_DB.CODVEND=PERSO_DB.NUMREG and NOTV_DB.NRUTCLIE=CLIEN_DB.NREGUIST and NUMNOTA=nota_venta and 
nota_venta=nota_venta and NOTV_DB.NRUTCLIE= CLIEN_DB.NREGUIST and 
NOTV_DB.NUMNOTA = NOTV_control.nota_venta and nota_venta = nota_venta and
(([Fac_Estado] = 1) AND ([Numero_factura_o_Guia] IS NULL) AND ([Sup_Estado]<>3) ) ORDER BY [Id_Principal] DESC" 
    ProviderName="<%$ ConnectionStrings:GL_GROUPConnectionString.ProviderName %>">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="Fac_Estado" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    
    <table style="height: 39px; width: 205px">
    <tr><td><b>Pendienes de Facturacion&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>
        <asp:Button ID="btnClickFac" runat="server" Text="Limpiar Facturacion" 
            onclick="btnClickFac_Click" Font-Bold="True" /></td></tr>
    <tr>
    
    <td>
           <asp:GridView ID="GridView1" runat="server" 
        AutoGenerateColumns="False" EnableModelValidation="True" Font-Bold="False" 
        style="font-family: Tahoma; font-size: small" Width="680px" 
            DataSourceID="sqlAcusete">
            <Columns>
                <asp:BoundField DataField="nota_venta" HeaderText="nota_venta" 
                    SortExpression="nota_venta" />
                <asp:BoundField DataField="RAZSOC" HeaderText="Cliente" 
                    SortExpression="RAZSOC" />
                <asp:BoundField DataField="Vendedor" HeaderText="Vendedor" 
                    SortExpression="Vendedor" ReadOnly="True" />
            </Columns>
    </asp:GridView>
    </td>
    <td>
        
        </td>
    </tr>
    </table>
    <br />
    <br />
     <asp:SqlDataSource ID="sqlAcusete2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GL_GROUPConnectionString %>" 
        
        SelectCommand="SELECT [nota_venta],CLIEN_DB.RAZSOC,RTRIM(PERSO_DB.NOMBRE)+' '+RTRIM(PERSO_DB.APELLIDO) as Vendedor 
FROM CLIEN_DB,NOTV_DB,NOTV_control,PERSO_DB
WHERE NOTV_DB.CODVEND=PERSO_DB.NUMREG and NOTV_DB.NRUTCLIE=CLIEN_DB.NREGUIST and NUMNOTA=nota_venta and 
nota_venta=nota_venta and NOTV_DB.NRUTCLIE= CLIEN_DB.NREGUIST and 
NOTV_DB.NUMNOTA = NOTV_control.nota_venta and nota_venta = nota_venta and
(([Bod_Estado] = 1) AND ([Sup_Estado]<>3)) ORDER BY [Id_Principal] DESC" 
    ProviderName="<%$ ConnectionStrings:GL_GROUPConnectionString.ProviderName %>">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="Bod_Estado" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <table style="height: 39px; width: 205px">
    <tr><td><b>Pendientes de Bodega&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>
        <asp:Button ID="btnClickBod" runat="server" Text="Limpiar Bodega" 
            onclick="btnClickBod_Click" Font-Bold="True" /> </td></tr>
    <tr>
   
    <td>
    <asp:GridView ID="GridView2" runat="server" 
        AutoGenerateColumns="False" EnableModelValidation="True" Font-Bold="False" 
        style="font-family: Tahoma; font-size: small" Width="680px" 
            DataSourceID="sqlAcusete2">
            <Columns>
                <asp:BoundField DataField="nota_venta" HeaderText="nota_venta" 
                    SortExpression="nota_venta" />
                <asp:BoundField DataField="RAZSOC" HeaderText="Cliente" 
                    SortExpression="RAZSOC" />
                <asp:BoundField DataField="Vendedor" HeaderText="Vendedor" 
                    SortExpression="Vendedor" ReadOnly="True" />
            </Columns>
    </asp:GridView>
    </td>
    <td>
        
        </td>
    </tr>
    </table>
    <br />
    <br />
     <asp:SqlDataSource ID="sqlAcusete3" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GL_GROUPConnectionString %>" 
        
        SelectCommand="SELECT [nota_venta],CLIEN_DB.RAZSOC,RTRIM(PERSO_DB.NOMBRE)+' '+RTRIM(PERSO_DB.APELLIDO) as Vendedor 
FROM CLIEN_DB,NOTV_DB,NOTV_control,PERSO_DB
WHERE NOTV_DB.CODVEND=PERSO_DB.NUMREG and NOTV_DB.NRUTCLIE=CLIEN_DB.NREGUIST and NUMNOTA=nota_venta and 
nota_venta=nota_venta and NOTV_DB.NRUTCLIE= CLIEN_DB.NREGUIST and 
NOTV_DB.NUMNOTA = NOTV_control.nota_venta and nota_venta = nota_venta and
(([Des_Estado]  = 1) AND (Checked is null)  AND ([Sup_Estado]<>3) AND ([Numero_factura_o_Guia] IS NOT NULL)) ORDER BY [Id_Principal] DESC" 
    ProviderName="<%$ ConnectionStrings:GL_GROUPConnectionString.ProviderName %>">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="Des_Estado" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <table style="height: 39px; width: 205px">
    <tr> 
      <td class="style4"></td><td><b> Pendientes de Despacho</b>&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button 
            ID="Button1" runat="server" Text="Limpiar 
 Despacho" 
            onclick="btnClickDes_Click" Width="162px" Font-Bold="True" /></td><td>
            &nbsp;</td>
    </tr>
    <tr>
    <td></td>
    <td>
    <asp:GridView ID="GridView3" runat="server" 
        AutoGenerateColumns="False" EnableModelValidation="True" Font-Bold="False" 
        style="font-family: Tahoma; font-size: small" Width="680px" 
            DataSourceID="sqlAcusete3">
            <Columns>
                <asp:BoundField DataField="nota_venta" HeaderText="nota_venta" 
                    SortExpression="nota_venta" />
                <asp:BoundField DataField="RAZSOC" HeaderText="Cliente" 
                    SortExpression="RAZSOC" />
                <asp:BoundField DataField="Vendedor" HeaderText="Vendedor" 
                    SortExpression="Vendedor" ReadOnly="True" />
            </Columns>
    </asp:GridView>
    </td>
    <td>
        
        </td>
    </tr>
    </table>
    <br />
    <br />
     <asp:SqlDataSource ID="sqlAcusete4" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GL_GROUPConnectionString %>" 
        
        SelectCommand="SELECT [nota_venta],CLIEN_DB.RAZSOC,RTRIM(PERSO_DB.NOMBRE)+' '+RTRIM(PERSO_DB.APELLIDO) as Vendedor 
FROM CLIEN_DB,NOTV_DB,NOTV_control,PERSO_DB
WHERE NOTV_DB.CODVEND=PERSO_DB.NUMREG and NOTV_DB.NRUTCLIE=CLIEN_DB.NREGUIST and NUMNOTA=nota_venta and 
nota_venta=nota_venta and NOTV_DB.NRUTCLIE= CLIEN_DB.NREGUIST and 
NOTV_DB.NUMNOTA = NOTV_control.nota_venta and nota_venta = nota_venta and
(([Sup_Estado]  = 1)  AND ([Sup_Estado]<>3)) ORDER BY [Id_Principal] DESC" 
    ProviderName="<%$ ConnectionStrings:GL_GROUPConnectionString.ProviderName %>">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="Sup_Estado" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <table style="height: 39px; width: 205px">
    <tr><td><b> Pendientes de Supervision&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b> 
        <asp:Button ID="btnClickSup" runat="server" Text="Limpiar Supervisor" 
            onclick="btnClickSup_Click" Visible="False" Font-Bold="True" /></td></tr>
    <tr>
   
    <td>
    <asp:GridView ID="GridView4" runat="server" 
        AutoGenerateColumns="False" EnableModelValidation="True" Font-Bold="False" 
        style="font-family: Tahoma; font-size: small" Width="680px" 
            DataSourceID="sqlAcusete4">
            <Columns>
                <asp:BoundField DataField="nota_venta" HeaderText="nota_venta" 
                    SortExpression="nota_venta" />
                <asp:BoundField DataField="RAZSOC" HeaderText="Cliente" 
                    SortExpression="RAZSOC" />
                <asp:BoundField DataField="Vendedor" HeaderText="Vendedor" 
                    SortExpression="Vendedor" ReadOnly="True" />
            </Columns>
    </asp:GridView>
    </td>
    <td>
        
        </td>
    </tr>
    </table>
    <br />
    <br />
     <asp:SqlDataSource ID="sqlAcusete5" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GL_GROUPConnectionString %>" 
        
        SelectCommand="SELECT [nota_venta],CLIEN_DB.RAZSOC,RTRIM(PERSO_DB.NOMBRE)+' '+RTRIM(PERSO_DB.APELLIDO) as Vendedor 
FROM CLIEN_DB,NOTV_DB,NOTV_control,PERSO_DB
WHERE NOTV_DB.CODVEND=PERSO_DB.NUMREG and NOTV_DB.NRUTCLIE=CLIEN_DB.NREGUIST and NUMNOTA=nota_venta and 
nota_venta=nota_venta and NOTV_DB.NRUTCLIE= CLIEN_DB.NREGUIST and 
NOTV_DB.NUMNOTA = NOTV_control.nota_venta and nota_venta = nota_venta and
(([Lab_Estado]  = 1)  AND ([Sup_Estado]<>3)) ORDER BY [Id_Principal] DESC" 
    ProviderName="<%$ ConnectionStrings:GL_GROUPConnectionString.ProviderName %>">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="Lab_Estado" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <table style="height: 39px; width: 205px">
     <tr><td><b>Pendientes de Laboratorio&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>
         <asp:Button ID="btnClicLab" runat="server" onclick="btnClicLab_Click" 
            Text="Limpiar Laboratorio " Font-Bold="True" /></td></tr>
    <tr>
    
    <td>
    <asp:GridView ID="GridView5" runat="server" 
        AutoGenerateColumns="False" EnableModelValidation="True" Font-Bold="False" 
        style="font-family: Tahoma; font-size: small" Width="680px" 
            DataSourceID="sqlAcusete5">
            <Columns>
                <asp:BoundField DataField="nota_venta" HeaderText="nota_venta" 
                    SortExpression="nota_venta" />
                <asp:BoundField DataField="RAZSOC" HeaderText="Cliente" 
                    SortExpression="RAZSOC" />
                <asp:BoundField DataField="Vendedor" HeaderText="Vendedor" 
                    SortExpression="Vendedor" ReadOnly="True" />
            </Columns>
    </asp:GridView>
    </td>
    <td>
       
        </td>
    </tr>
    </table>
    <br />
    <br />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
