<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Administrar.aspx.cs" Inherits="BoletadeVentas.Formulario_web15" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style4
        {
            width: 46%;
        }
        .style5
        {
            width: 112px;
        }
        .style6
        {
            width: 192px;
        }
        .style7
        {
            width: 137px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<br />
    <asp:Label ID="Label1" runat="server" Text="Agregar Usuario" Font-Bold="True" 
        Font-Size="Large" Font-Underline="True"></asp:Label>
    <br />
    <br />
    <table class="style4" 
        style="border: thin solid #000000; background-color: #CCFFFF">
        <tr>
            <td class="style5">
                &nbsp;</td>
            <td class="style6">
                &nbsp;</td>
            <td class="style7">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style5">
                <asp:Label ID="Label2" runat="server" Text="Usuario" Font-Bold="True"></asp:Label>
            </td>
            <td class="style6">
                <asp:TextBox ID="txtUsuario" runat="server"></asp:TextBox>
            </td>
            <td class="style7">
                <asp:CheckBox ID="chkBloqueado" runat="server" Text="Bloqueado" />
            </td>
        </tr>
        <tr>
            <td class="style5">
                <asp:Label ID="Label3" runat="server" Font-Bold="True" Text="Password"></asp:Label>
            </td>
            <td class="style6">
                <asp:TextBox ID="txtPass" runat="server"></asp:TextBox>
            </td>
            <td class="style7">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style5">
                <asp:Label ID="Label4" runat="server" Font-Bold="True" Text="Departamento"></asp:Label>
            </td>
            <td class="style6">
                <asp:DropDownList ID="ddlDep" runat="server">
                </asp:DropDownList>
            </td>
            <td class="style7">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style5">
                &nbsp;</td>
            <td class="style6">
                &nbsp;</td>
            <td class="style7">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style5">
                <asp:Button ID="btnAgregar" runat="server" onclick="btnAgregar_Click" 
                    Text="Agregar" />
            </td>
            <td class="style6">
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" 
                    onclick="btnBuscar_Click" />
            </td>
            <td class="style7">
                &nbsp;</td>
        </tr>
    </table>



    <asp:Label ID="lblEstado" runat="server" Font-Bold="True"></asp:Label>
    <br />
    <asp:Label ID="lblMensaje" runat="server" Font-Bold="True" ForeColor="#FF3300" 
        Text="Usuario no Existe"></asp:Label>



</asp:Content>