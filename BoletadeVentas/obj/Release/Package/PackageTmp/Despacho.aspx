<%@ Page Title="Listas Despacho" EnableEventValidation="false" Language="C#" MasterPageFile="~/MasterPage.Master"
    AutoEventWireup="true" CodeBehind="Despacho.aspx.cs" Inherits="BoletadeVentas.Formulario_web13"  MaintainScrollPositionOnPostback="true"%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script src="Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
  <link href="Css/start/jquery-ui-1.10.3.custom.css" rel="stylesheet" />
    <link href="Css/start/jquery-ui-1.10.3.custom.min.css" rel="stylesheet"
        type="text/css" />
    <script src="Scripts/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="Scripts/jquery.ui.widget.js"
        type="text/javascript"></script>
    <script src="Scripts/jquery.ui.button.js"
        type="text/javascript"></script>
    <script src="Scripts/jquery.ui.draggable.js"
        type="text/javascript"></script>
    <script src="Scripts/jquery.ui.mouse.js"
        type="text/javascript"></script>
    <script src="Scripts/jquery.ui.position.js"
        type="text/javascript"></script>
    <script src="Scripts/jquery.ui.resizable.js"
        type="text/javascript"></script>
    <script src="Scripts/jquery.ui.dialog.js"
        type="text/javascript"></script>
    <script src="Scripts/Exp_Regulares.js" type="text/javascript"></script>
    <style type="text/css">
        .style3
        {
            width: 30%;
        }
        .style4
        {
            width: 440px;
        }
        .style5
        {
            text-align: left;
            width: 384px;
        }
        .style7
        {
            width: 440px;
            height: 23px;
        }
        .style11
        {
            width: 384px;
        }
        .style12
        {
            width: 1877px;
        }
        .style13
        {
            width: 117px;
        }
        .style14
        {
            width: 475px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <script type="text/javascript">
        var nota = null;
        var fecha = null;
        var conductor = null;
        var despachador = null;
        var sectorComuna = null;

        $(document).ready(function () {
            Actualizar();
            $("#aux").hide();
            $("#dialog").dialog({
                autoOpen: false,
                height: 400,
                width: 450,
                modal: true,
                buttons: {
                    "Confirmar": function () {
                        var aux1 = '<%=FechaDespacho.ClientID%>';
                        var aux2 = '<%=ddl_Conductores.ClientID%>';
                        fecha = document.getElementById(aux1).value;
                        conductor = document.getElementById(aux2).value;
                        if (fecha == "" || conductor == "") {
                            alert('Complete Todos los Campos Para Continuar');
                            return false;
                        }
                        $.ajax({
                            type: 'POST',
                            url: 'Despacho.aspx/AsignarConductor',
                            data: "{'Nota':'" + nota + "', 'fecha' : '" + fecha + "','conductor' : '" + conductor + "'}",
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            success: function (msg) {
                                var objBoton = '<%=btnAux.ClientID%>';
                                var boton = document.getElementById(objBoton);
                                boton.click();
                            }


                        });

                        $(this).dialog("close");

                    },
                    Cancel: function () {
                        $(this).dialog("close");
                    }

                }
            });

            $("#ConfirmarNota").dialog({
                autoOpen: false,
                height: 200,
                width: 500,
                modal: true,
                buttons: {
                    "Recibe Cliente": function () {

                        if (despachador == null) {
                            return false;
                        }
                   
                        $.ajax({
                            type: 'POST',
                            url: 'Despacho.aspx/RecibeCliente',
                            data: "{'Nota' : '" + nota + "'}",
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            success: function (msg) {
                                if (msg.d) {
                                    var objBoton = '<%=btnAux.ClientID%>';
                                    var boton = document.getElementById(objBoton);
                                    boton.click();
                                }
                            }

                        });


                    },
                    "Reprogramar": function () {
                        $.ajax({
                            type: 'POST',
                            url: 'Despacho.aspx/ReprogramarNota',
                            data: "{'Nota' : '" + nota + "'}",
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            success: function (msg) {
                                var objBoton = '<%=btnAux.ClientID%>';
                                var boton = document.getElementById(objBoton);
                                boton.click();
                            }


                        });

                        $(this).dialog("close");

                    },
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }

            });

            $("#DespachadorDialog").dialog({
                autoOpen: false,
                height: 200,
                width: 350,
                modal: true,
                buttons: {
                    "Asignar": function () {

                        var aux = '<%=ddl_Desp.ClientID%>';
                        despachador = document.getElementById(aux).value;
                        if (despachador == "") {

                            alert('Debe Seleccionar un Despachador');
                            return false;
                        }
                        if (sectorComuna == "Oficina,Oficina") {
                            SectorOficina();
                        }
                        else {
                            Recibircliente();

                        }
                    }
                }
            });
            $("#simbologia").dialog({
                autoOpen: false,
                height: 250,
                width: 320,
                modal: true,
                buttons: {
                    "Atras": function () {
                        $(this).dialog("close");
                    }
                }

            });
        });

        function SectorOficina() {
            $.ajax({
                type: 'POST',
                url: 'Despacho.aspx/AsignarDespachador',
                data: "{'nota':'" + nota + "','despachador' : '"+despachador+"','opc':'2'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {
                    if (msg.d) {
                        alert('Operación completada con exito');
                        var objBoton = '<%=btnAux.ClientID%>';
                        var boton = document.getElementById(objBoton);
                        boton.click();
                        $(this).dialog("close");

                    } else {

                        alert('Ocurrio un error');
                        $(this).dialog("close");
                    }

                }
                 
            });
           

        }

        function Recibircliente() {
            $.ajax({
                type: 'POST',
                url: 'Despacho.aspx/AsignarDespachador',
                data: "{'nota':'" + nota + "','despachador' : '" + despachador + "','opc' : '1'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {
                    if (msg.d) {
                        var objBoton = '<%=btnAux.ClientID%>';
                        var boton = document.getElementById(objBoton);
                        boton.click();
                    } else {
                        alert("No se pudo asignar ese despachador");
                    }
                }


            });

            $(this).dialog("close");
        }

        function ErrorDespachador() {

            alert('Seleccione un Despachador');
        }
        function validarFecha(sender, args) {

            if (sender._selectedDate < new Date()) {
                alert('La Fecha No puede ser menor a la actual');
                sender._selectedDate = new Date();
                sender._textbox.set_Value(sender._selectedDate.format(sender._format));
            }



        }
        function AbrirFormFecha(notaProceso,sector) {
            if (sector != "Oficina,Oficina") {
                $("#auxCalendario").show();
            } else {
                var txt = '<%=FechaDespacho.ClientID%>';
                var fecha = new Date();
                document.getElementById(txt).value = fecha.getDate() + "/" + ("0" + (fecha.getMonth() + 1)).slice(-2)+ "/" + fecha.getFullYear();
                $("#auxCalendario").hide();
            }
            $("#dialog").dialog("open");
            nota = notaProceso;
        }
        function AbrirConfirmar(notaProceso, sector,desp) {
            nota = notaProceso;
            despachador = desp;
            if (sector != "Oficina,Oficina" || despachador!=null) {
                $("#ConfirmarNota").dialog("open");
            }
            else {
                sectorComuna = sector;
                $("#DespachadorDialog").dialog("open");
            }
        }
        function simbologia() {
            $("#simbologia").dialog("open");
        }
        function abrirDespacho(notaProceso, sector) {
            sectorComuna = sector;
            nota = notaProceso;
            $("#DespachadorDialog").dialog("open");
        }
        function Reprogramar(notaProceso) {

            nota = notaProceso;
            despachador = null;
            sectorComuna = null;
            $("#ConfirmarNota").dialog("open");
        }
        function AsignarFechaOficina(notaProceso) {

            $.ajax({

                type: 'POST',
                url: 'Despacho.aspx/AsignarFechaOficina',
                data: "{'nota' : '" + notaProceso + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {
                    if (msg.d) {
                        var objBoton = '<%=btnAux.ClientID%>';
                        var boton = document.getElementById(objBoton);
                        boton.click();
                    } else {
                        alert('Ocurrio un Error');
                    }
                }
            });
        }

        function Actualizar() {
            setInterval(function () {

                var btn = "<%=auxiliarBoton.ClientID%>";
                var boton = document.getElementById(btn);
                boton.click();
            }, 30000);

        }
    </script>
    <br />
   
   
       <table width="100%">
       <tr>
       <td class="style13"><asp:Label ID="lbldep" runat="server" Text="Departamento : " 
               Font-Bold="True"></asp:Label></td>
       <td align="left"><asp:Label ID="lblPermiso" runat="server" Font-Bold="True" 
               ForeColor="#FF3300" ></asp:Label></td>
       <td class="style14" align="right"><asp:Label ID="Label5" runat="server" 
               Text="Cerra Session" Font-Bold="True"></asp:Label></td>
       <td>
           <asp:ImageButton ID="imgBCerrar" runat="server" 
               ImageUrl="~/Imagenes/cerrar.png" onclick="imgBCerrar_Click" />
           </td>
       </tr>
       <tr>
       <td colspan="4" style="height:40px">
        <ul id="nav">
                    <li class="top">
                        <asp:LinkButton ID="LinkButtonInicio" runat="server" OnClick="btnInicio_Click" CssClass="top_link">Inicio</asp:LinkButton></li>
                    <li class="top"><asp:LinkButton ID="cambio" runat="server" CssClass="top_link" 
                            onclick="cambio_Click" Width="160px">Cambiar Formulario</asp:LinkButton></li>
                    <li class="top"><a href="Mapa.aspx" id="Mapa" class="top_link"><span>Consultar Mapa</span></a></li>
                    <li class="top"><asp:LinkButton ID="LinkButton5" Width="120px" runat="server" CssClass="top_link" 
                          OnClientClick="simbologia();return false">Simbología</asp:LinkButton></li>
                    <li class="top"><asp:LinkButton ID="lbInforme" runat="server" CssClass="top_link" 
                            onclick="lbInforme_Click">Revisar Informe Notas</asp:LinkButton></li>
                </ul>
       </td>
       </tr>
       </table>
       <div id="dialog" title="Ingrese Datos de Despacho">
        <table align="center" 
            
               
               style="background-color: #CCFF99; border-style: solid; border-width: thin; width: 300px;">
            <tr>
                <td style="text-align: center" class="style4" colspan="2">
                    <asp:CalendarExtender ID="CalendarExtender1" runat="server" PopupButtonID="imgCalendario"
                        TargetControlID="FechaDespacho" Format="dd/MM/yyyy" OnClientDateSelectionChanged="validarFecha">
                    </asp:CalendarExtender>
                    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
                    </asp:ToolkitScriptManager>
                </td>
            </tr>
            <tr>
                <td class="style12">
                    <asp:Label ID="lblDateD" runat="server" Text="Ingrese Fecha del Despacho" 
                        Font-Bold="True" Font-Size="Small"></asp:Label>
                </td>
                <td class="style11">
                    <asp:TextBox ID="FechaDespacho" runat="server" onKeyPress = "javascript:return false;" 
                    onPaste = "javascript:return false;" Width="100px" Font-Size="X-Small" 
                        Enabled="False"></asp:TextBox>
                    <div id="auxCalendario"><asp:Image ID="imgCalendario" runat="server" ImageUrl="~/Imagenes/Calendario.png"
                        CssClass="Calendario" /></div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="FechaDespacho" ErrorMessage="****" 
                        ValidationGroup="Conductores"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="style12">
                    <asp:Label ID="Label2" runat="server" 
                        Text="Seleccione un Conductor para el Despacho" Font-Bold="True" 
                        style="text-align: left" Font-Size="Small"></asp:Label>
                </td>
                <td class="style5">
                    <asp:DropDownList runat="server" ID="ddl_Conductores" Width="109px" 
                        Font-Size="X-Small">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="ddl_Conductores" ErrorMessage="****" 
                        ValidationGroup="Conductores"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="text-align: center" class="style7" colspan="2">
                    </td>
            </tr>
            </table>
        </div>
        <div id="ConfirmarNota">
        <asp:Label ID="Label1" runat="server" Text="¿Que operación desea Realizar?" 
                BackColor="White" Font-Bold="True"></asp:Label>
        </div>
        <div id="DespachadorDialog" title="Seleccionar Despachador">
        <asp:DropDownList ID="ddl_Desp" runat="server" Font-Size="X-Small"></asp:DropDownList>
        </div>
    
  
    <br />
    <asp:Button ID="auxiliarBoton" runat="server" Text="aux" 
        onclick="auxiliarBoton_Click" />
    <div id ="aux">
        
    <asp:LinkButton ID="btnAux" runat="server" onclick="btnAux_Click">LinkButton</asp:LinkButton>
    </div>
    <br />
 
    <asp:GridView ID="gvDespacho" runat="server" AutoGenerateColumns="False" CellPadding="4"
        EnableModelValidation="True" ForeColor="#333333" 
        Style="text-align: center" OnRowDataBound="gvDespacho_RowDataBound"
        OnRowCommand="gvDespacho_RowCommand" AllowSorting="True" 
        onsorting="gvDespacho_Sorting">
        <AlternatingRowStyle BackColor="#99CCFF" />
        <EditRowStyle BackColor="#0099CC" />
        <FooterStyle BackColor="#336699" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#001F3E" Font-Bold="True" ForeColor="White" 
            Font-Size="Small" />
        <PagerStyle BackColor="#001F3E" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="White" Font-Bold="True" Font-Size="8" Height="5px" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <Columns>
            <asp:TemplateField HeaderText="Nota" SortExpression="Nota">
                <EditItemTemplate>
                    <asp:TextBox ID="txtNota" runat="server" Text='<%# Bind("nota") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblNota" runat="server" Text='<%# Bind("nota") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Cliente">
                <EditItemTemplate>
                    <asp:TextBox ID="txtCliente" runat="server" Text='<%# Bind("cliente") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblCliente" runat="server" Text='<%# Bind("cliente") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Sector" SortExpression="Sector">
                <EditItemTemplate>
                    <asp:TextBox ID="txtComunaSector" runat="server" Text='<%# Bind("sector") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblcomunaSector" runat="server" Text='<%# Bind("sector") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Vendedor">
                <EditItemTemplate>
                    <asp:TextBox ID="txtVendedor" runat="server" Text='<%# Bind("vendedor") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblVendedor" runat="server" Text='<%# Bind("vendedor") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="#B Ch">
                <EditItemTemplate>
                    <asp:TextBox ID="txtBc" runat="server" Text='<%# Bind("bp") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblBc" runat="server" Text='<%# Bind("bp") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="#B M">
                <EditItemTemplate>
                    <asp:TextBox ID="txtBm" runat="server" Text='<%# Bind("bm") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblBm" runat="server" Text='<%# Bind("bm") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="#B G">
                <EditItemTemplate>
                    <asp:TextBox ID="txtBg" runat="server" Text='<%# Bind("bg") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblBg" runat="server" Text='<%# Bind("bg") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Docto">
                <EditItemTemplate>
                    <asp:TextBox ID="txtDocto" runat="server" Text='<%# Bind("docto") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblDocto" runat="server" Text='<%# Bind("docto") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Rec">
                <ItemTemplate>
                    <asp:ImageButton ImageUrl='<%#Bind("ok") %>' runat="server" ID="imgReci" 
                CommandArgument='<%# Bind("nota") %>' CommandName="Okcommand" ></asp:ImageButton >
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="F Desp">

                <ItemTemplate>
                    <asp:LinkButton runat="server" Text='<%# Bind("fdesp") %>' ID="lbFecha"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Conductor">
                <EditItemTemplate>
                    <asp:TextBox ID="txtConductor" runat="server" Text='<%# Bind("conductor") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblConductor" runat="server" Text='<%# Bind("conductor") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Estado">
                <ItemTemplate>
                    <asp:ImageButton runat="server" ID="imgBEstado" ImageUrl='<%#Eval("estado") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Depachador">
            <ItemTemplate>
            <asp:Label ID="lblDespa" runat="server" Text='<%#Bind("despachador")%>'></asp:Label>
            </ItemTemplate>        
            </asp:TemplateField>
            
        </Columns>
    </asp:GridView>
    <br />
    <div id="simbologia" title="Significado de Símbolos">
   <table>
   <tr>
    <td><asp:Image ID="Image6" runat="server" ImageUrl="~/Imagenes/T.png" Height="32px" Width="32px"/></td>
    <td><asp:Label ID="Label13" runat="server" Text="En Transito" Font-Size="Small"></asp:Label></td>
    </tr>
    <tr>
    <td><asp:Image ID="Image1" runat="server" ImageUrl="~/Imagenes/R.png" Height="32px" Width="32px"/></td>
    <td><asp:Label ID="Label3" runat="server" Text="Reprogramando" Font-Size="Small"></asp:Label></td>
    </tr>
    <tr>
    <td><asp:Image ID="Image2" runat="server" ImageUrl="~/Imagenes/office.png" Height="32px" Width="32px"/></td>
    <td><asp:Label ID="Label4" runat="server" Text="Despacho en Oficina" Font-Size="Small"></asp:Label></td>
    </tr>
   </table>
   </div>
</asp:Content>
