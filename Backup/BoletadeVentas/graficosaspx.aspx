<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="graficosaspx.aspx.cs" Inherits="BoletadeVentas.graficosaspx" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<asp:Chart runat=server>

<Series><asp:Series Name="Series1">
</asp:Series></Series>

<ChartAreas><asp:ChartArea Name="ChartArea1">
</asp:ChartArea></ChartAreas>

</asp:Chart>
</asp:Content>