<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Informe_Departamentos.aspx.cs" Inherits="BoletadeVentas.Formulario_web17" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <br />
    <br />
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" InteractiveDeviceInfos="(Colección)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="829px">
        <LocalReport ReportPath="ReporteDepartamentos.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="dsDepa" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
        SelectMethod="Departamentos" TypeName="BoletadeVentas.Class.NegocioReporte">
    </asp:ObjectDataSource>
</asp:Content>
