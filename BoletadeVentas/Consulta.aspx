<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Consulta.aspx.cs" Inherits="BoletadeVentas.Formulario_web11" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style2
        {
            height: 23px;
            width: 525px;
        }
        .style3
        {
            width: 631px;
        }
        .style4
        {
            height: 23px;
            width: 631px;
        }
        .style5
        {
            width: 631px;
            height: 26px;
        }
        .style6
        {
            height: 26px;
            width: 525px;
        }
        .style7
        {
            width: 525px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width:42%; height: 71px;" align="center">
        <tr>
            <td class="style3">
                <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
                </asp:ToolkitScriptManager>
            </td>
            <td class="style7">
                &nbsp;</td>
            
        </tr>
        <tr>
            <td class="style4">
                <asp:Label ID="Label1" runat="server" Text="Numero Factura o Guia"></asp:Label>
            </td>
            <td class="style2">
                <asp:TextBox ID="txtNum" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style5">
                <asp:Label ID="Label2" runat="server" Text="Fecha Despacho"></asp:Label>
            </td>
            <td class="style6">
                <asp:TextBox ID="txtFecha" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="cc1" runat="server" TargetControlID="txtFecha">
            </asp:CalendarExtender>
                <asp:ImageButton ID="ibtn_cc" runat="server" 
                    ImageUrl="~/Imagenes/Calendario.png" />
                <asp:CalendarExtender ID="CCE" runat="server" PopupButtonID="ibtn_cc" TargetControlID="txtfecha">
            </asp:CalendarExtender>
            </td>
            
            
        </tr>
        <tr>
            <td class="style3">
                <asp:Label ID="Label3" runat="server" Text="Conductor del Despacho"></asp:Label>
            </td>
            <td class="style7">
                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style3">
                <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="style7">
                <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style3">
                &nbsp;</td>
            <td class="style7">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
