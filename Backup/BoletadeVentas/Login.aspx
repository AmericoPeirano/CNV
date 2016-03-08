<%@ Page Title="Inicio de Sessión" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BoletadeVentas.Formulario_web1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
    .style2
    {
        text-align: center;
    }
    .style3
    {
        width: 73px;
    }
        .style5
        {
            text-align: center;
            height: 55px;
        }
        .style6
        {
            width: 820px;
            height: 18px;
        }
        .style7
        {
            width: 820px;
            height: 6px;
        }
        .style9
        {
            height: 36px;
        }
    .style10
    {
        width: 143px;
        height: 18px;
    }
    .style11
    {
        width: 143px;
        height: 13px;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
<br />


    <table style="width:220px; height: 233px; background-image: url('Imagenes/login.png');" align="center"  
    cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="2" style="text-align: center" class="style9">
            <br />
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Ingresar" 
                    ForeColor="White"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style7" colspan="2" align="center">
          
                <asp:Label ID="Label2" runat="server" Text="Usuario" Font-Italic="False" 
                    Font-Bold="True"></asp:Label>
            </td>
            </tr>
            <tr>
            <td class="style10"colspan="2" align="center">
        
                <asp:DropDownList ID="ddlUsers" runat="server">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="ddlUsers" ErrorMessage="*"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style6" colspan="2" align="center">
                <asp:Label ID="Label3" runat="server" Text="Password" Font-Italic="False" 
                    Font-Bold="True"></asp:Label>
            </td>
            </tr>
            <tr>
            <td class="style11" colspan="2" align="center">
              
                <asp:TextBox ID="txtPass" runat="server" TextMode="Password" Height="16px" 
                    Width="95px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtPass" ErrorMessage="*"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style5" colspan="2">
                <asp:ImageButton ID="Button1" runat="server" Text="Ingresar" 
                    onclick="Button1_Click" ImageUrl="~/Imagenes/botonIngresar.png" />
                <br />
                <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" 
                    style="text-align: center" Text="Contraseña Incorecta"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <br />
    
</asp:Content>
