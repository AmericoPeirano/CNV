﻿<%@ Page Title="Lista de Notas de Venta" EnableEventValidation="false" Language="C#" MasterPageFile="~/MasterPage.Master"
    AutoEventWireup="true" CodeBehind="Detalle Boleta.aspx.cs" Inherits="BoletadeVentas.Formulario_web12" MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    
    <link href="Css/start/jquery-ui-1.10.3.custom.css" rel="stylesheet" />
    <link href="Css/start/jquery-ui-1.10.3.custom.min.css" rel="stylesheet"
        type="text/css" />
     
    <script src="Scripts/json_parse.js" type="text/javascript"></script>
 
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
        .style6
        {
            width: 118px;
            height: 48px;
        }
        .style7
        {
            height: 48px;
        }
        .style8
        {
            width: 100%;
        }
        .style9
        {
            height: 40px;
        }
        #Text1
        {
            height: 82px;
            width: 397px;
        }
        #inputObs
        {
            height: 34px;
            width: 167px;
        }
        #ipObs
        {
            height: 59px;
            width: 186px;
        }
        #ipObsSup
        {
            height: 50px;
            width: 291px;
        }
        #Button1
        {}
        .style30
        {
            width: 335px;
        }
        .style31
        {
            width: 70px;
        }
        .style33
        {
            width: 106px;
        }
        .style34
        {
            width: 291px;
            
        }
        .style35
        {
            height: 48px;
            width: 251px;
        }
    </style>
    <link href="Css/Base.css" rel="stylesheet" type="text/css" />
   

    <script type="text/javascript">
        var nota = null;
        var cantidad = 0;
        var option = null;

        function Observaciones(nota) {

            $.ajax({
                type: 'POST',
                url: 'Detalle Boleta.aspx/Observaciones',
                data: "{'nota':'" + nota + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {
                    $("#inputObs").val(msg.d);
                }
            });


        }

        function CargarNotas() {

            setInterval(function () {
                var objBoton = '<%=nventa.ClientID%>';
                var boton = document.getElementById(objBoton);
                boton.click();
             
            }, 300000);


        }

        function CheckedLab() {
     
            if ($("#cLaboratorio").is(":checked")) {

                $("#cFacturacion").removeAttr("checked");
             
            }

        }
        function CheckedFac() {

            if ($("#cFacturacion").is(":checked")) {
                $("#cLaboratorio").removeAttr("checked");

            }

        }
        function chkSi() {
            if ($("#ocSi").is(":checked")) {
                $("#ocNo").removeAttr("checked");
                $("#EX").prop('disabled', true);
              
            } else {
                $("#EX").prop('disabled', true);
               
            }
        }
        function chkNo() {
            if ($("#ocNo").is(":checked")) {
                $("#ocSi").removeAttr("checked");
                $("#EX").prop('disabled', false);

            } else {
                $("#EX").prop('disabled', true);
                
            }
        }
        function Bod_Envio(NotaProceso) {
            $("#Bod_Envio").empty();
            var str = '<table style="background-color: #CCFFFF; width: 337px;visibility:inherit;" align="center"><tr>';
            str += ' <td colspan="2" align="center" class="titulo">';
            str += '¿Donde desea proceder? ';
            str += '</td>';
            str += '</tr>';
            str += '  <tr>';
            str += ' <td colspan="2">&nbsp;</td>';
            str += '</tr>';
            str += '  <tr>';
            str += '<td class="texto">Laboratorio</td>';
            str += ' <td class="style25"> <input type="checkbox" id="cLaboratorio" onclick="CheckedLab()"/></td> </tr>';
            str += '<tr>  <td class="texto">Facturaci&oacute;n</td>';
            str += '<td class="style25"><input type="checkbox" id="cFacturacion" onclick="CheckedFac()" /></td>';
            str += ' </tr></table>';
            $("#Bod_Envio").append(str);
            nota = NotaProceso;
            $("#Bod_Envio").dialog("open");

        }
        function Exportar_Log() {
            $("#ExportarLogg").empty();      
            var str = '<table style="width:400px; background-color: #CCFFFF;visibility:inherit;">';
            str += '<tr><td>N° Nota de Venta</td></tr>';
            str += '<tr>';
            str += ' <td><input type="text" id="txtNVex" style="font-size: small" class=""/></td>';
            str += '</tr>';
            str += '</table>';            
            $("#ExportarLogg").append(str);        
            

        }
        function PrepararForm() { 
        
        var str=' <table style="width:550px; visibility:inherit; background-color: #CCFFFF;" >';
        str += '<tr>';
        str += '<td class="titulo" colspan="3">';
        str += 'Determine el tamaño y el numero de bultos';
        str += ' </td>';
        str += '</tr>';
        str += '<tr>';
        str += ' <td class="style24"><input type="checkbox" id="bp" value="cBP" onclick="Activar(bp)"/> </td>';
        str += '<td class="texto">Bultos Pequeños';
        str += '</td>';
        str += '<td><input type="text" id="ipBP" style="font-size: small" class="cBP" /></td>';
        str += ' </tr>';
        str += ' <tr>';
        str += '<td class="style24"><input type="checkbox" id="bm" onclick="Activar(bm)" value="cBM"/></td>';
        str += '<td class="texto">Bultos Medianos</td>';
        str += '<td><input type="text" id="ipBM" style="font-size: small" class="cBM"/></td>';
        str += ' </tr>';
        str += '<tr>';
        str += '  <td class="style24"><input type="checkbox" id="bg" onclick="Activar(bg)" value="cBG"/></td>';
        str += '   <td class="texto">Bultos Grandes</td>';
        str += ' <td><input type="text" id="ipBG" style="font-size: small" class="cBG"/></td>';
        str += '  </tr>';
        str += ' <tr>';
        str += '   <td class="texto">Seleccione un Preparador ';
        str += '</td>';
        str += ' <td colspan="2"><select id="SDesp" style="font-size: small"></select></td>';
        str += '   </tr>';
        str += '  <tr>';
        str += '  <td class="texto">Observaciones</td>';
        str += ' <td colspan="2"><input type="text" id="ipObs" style="font-size: small" /></td>';
        str += ' </tr>';
        str += '  </table>';
        $("#Fac_Envio").empty();
        $("#Fac_Envio").append(str);
        cargarPreparadores()       
        
        }


        function Bod_EnvioFactura(NotaProceso) {
            nota = NotaProceso;
            PrepararForm();
            $.ajax({
                type: 'POST',
                url: 'Detalle Boleta.aspx/Observaciones',
                data: "{'nota':'" + nota + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                    $("#ipObs").val(msg.d);
                }
            });

            $("#Fac_Envio").dialog("open");
        }

        function SupRecibido(notaProceso) {
         
            nota = notaProceso;      
            var str = '<table style="width:400px; background-color: #CCFFFF;visibility:inherit;">';
            str += '<tr> ';
            str += '<td class="texto" colspan=2 aling="center">Seleccione Comuna</td></tr>';
            str += ' <tr><td class="style28">&nbsp;</td>';
            str += ' <td> &nbsp;</td> </tr>';
            str += ' <tr><td class="texto">Comuna</td>';
            str += '  <td><select id="SComunas" name="D1" style="font-size: small">';
            str += '<option></option> </select></td> </tr>';
            str += ' <tr><td class="texto">¿O/C?&nbsp;</td>';
            str += ' <td>&nbsp;</td>  </tr>';
            str += ' <tr><td><input type="checkbox" id="ocSi" value="" onclick="chkSi()"/>Si';
            str += ' <input type="checkbox" id="ocNo" value="" onclick="chkNo()"/>No</td>';
            str += ' <td><select id="EX" disable="true" align="left" style="font-size: small"></select></td></br></tr>';
            str += '<tr><td class="texto">Observaciones</td>';
            str += '<td><input id="ipObsSup" type="text" style="font-size: small" /></td></tr>';
            str += ' </table>';
            $("#Sup_Reci").empty();
            $("#Sup_Reci").append(str);
            llenarComunas();
             

            $("#Sup_Reci").dialog("open");
        }

        function Recibir(notaProceso,opc) {
            $.ajax({
                type: 'POST',
                url: 'Detalle Boleta.aspx/RecibirNota',
                data: "{'NotaProceso': '" + notaProceso + "', 'opc' : '" + opc + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {
                    if (!msg.d) {
                        alert('Ocurrio un Error 2');
                    } else {
                        var objBoton = '<%=lbAux.ClientID%>';
                        var boton = document.getElementById(objBoton);
                        boton.click();
                    }
                }

            });
        }


      

        function cargarPreparadores() {

        $.ajax({
                type: 'POST',
                url: 'Detalle Boleta.aspx/TraerPreparadores',
                data: "{ }",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                    var json = json_parse(msg.d);
                    var str;
                    $.each(json, function (i, item) {
                        str += '<option value="' + item.id + '">' + item.nombre + '</option>';
                    });

                   $("#SDesp").html(str);
                  
                }
            });

        }
        function llenarComunas() {

            $.ajax({
                type: 'POST',
                url: 'Detalle Boleta.aspx/TraerComunas',
                data: "{ }",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {
                    var json = json_parse(msg.d);
                    var str;
                    var srt;
                    $.each(json, function (i, item) {
                        str += '<option value="' + item.idsector + '">' + item.nombre + '</option>';

                    });
                                       
                    srt += '<option></option><option>Cambio</option> <option>Contado</option> <option>Documentado</option> <option>E-mail</option> <option>Ejecutivo(Dcto.por llegar)</option> <option>Facturado</option> <option>Garantía</option> <option>Muestra</option> <option>Trans. Bancaria</option>';
                    $("#EX").html(srt);
                    $("#EX").prop('disabled', true);
                    $("#SComunas").html(str);
                }
            });
        }

        $(document).ready(function () {
            // cargarPreparadores();
            CargarNotas();
            // llenarComunas();
            $("#Daux").hide();
            $('.cBP').prop('disabled', true);
            $('.cBM').prop('disabled', true);
            $('.cBG').prop('disabled', true);
            $("#Bod_Envio").dialog({

                autoOpen: false,
                height: 300,
                width: 370,
                modal: true,
                buttons: {
                    "Confirmar": function () {
                        if (!$("#cLaboratorio").is(":checked") && !$("#cFacturacion").is(":checked")) {
                            alert('Debe Seleccionar un Departamento');
                            return false;
                        }
                        if ($("#cLaboratorio").is(":checked")) {

                            $.ajax({
                                type: 'POST',
                                url: 'Detalle Boleta.aspx/PorcesoNotaLab',
                                data: "{'NotaProceso' : '" + nota + "'}",
                                contentType: 'application/json; charset=utf-8',
                                dataType: 'json',
                                success: function (msg) {

                                    if (!msg.d) {
                                        alert('Ocurrio un Error 3');
                                    }
                                    var objBoton = '<%=lbAux.ClientID%>';
                                    var boton = document.getElementById(objBoton);
                                    boton.click();
                                }
                            });
                            $(this).dialog("close");
                        } else {

                            PrepararForm();

                            $("#Fac_Envio").dialog("open");
                            $("#Bod_Envio").dialog("close");
                        }

                    }
                }
            });
            $("#Fac_Envio").dialog({
                autoOpen: false,
                height: 400,
                width: 480,
                modal: true,
                buttons: {
                    "Continuar": function () {
                        var bc;
                        var bm;
                        var bg;
                        var preparador;
                        var obs;
                        if (!$("#bp").is(':checked') &&
                        !$('#bm').is(':checked') && !$("#bg").is(':checked')) {
                            alert('Debe Seleccionar un Tipo de Bulto y asignar su Cantidad');
                            return false;
                        }
                        if ($("#bp").is(':checked')) {
                            if ($(".cBP").val() == '') {
                                alert("Debe ingresar una cantidad de Bultos Pequeños");
                                return false;
                            }
                            bc = $(".cBP").val();
                            if (isNaN(bc)) {
                                alert('El valor ingresado para bultos pequeños es incorrecto');
                                return false;
                            }
                        }
                        else {
                            bc = 0;
                        }
                        if ($("#bm").is(':checked')) {
                            if ($(".cBM").val() == '') {
                                alert("Debe ingresar una cantidad de Bultos Medianos");
                                return false;
                            }
                            bm = $(".cBM").val();
                            if (isNaN(bm)) {
                                alert('El valor ingresado para bultos medianos es incorrecto');
                                return false;
                            }
                        }
                        else {
                            bm = 0;
                        }
                        if ($("#bg").is(':checked')) {
                            if ($(".cBG").val() == '') {
                                alert("Debe ingresar una cantidad de Bultos Grandes");
                                return false;
                            }
                            bg = $(".cBG").val();
                            if (isNaN(bg)) {
                                alert('El valor ingresado para bultos grandes es incorrecto');
                                return false;
                            }
                        }
                        else {
                            bg = 0;
                        }
                        obs = $("#ipObs").val();
                        preparador = $("#SDesp>option:selected").text();

                        var variables = "{'NotaProceso' : '" + nota + "', 'bc' : '" + bc + "',";
                        variables += "'bm' : '" + bm + "', 'bg' : '" + bg + "', 'Prep':'" + preparador + "', 'obs':'" + obs + "'}";

                        $.ajax({
                            type: 'POST',
                            url: 'Detalle Boleta.aspx/FacturarNota',
                            data: variables,
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            success: function (msg) {
                                if (!msg.d) {
                                    alert('Ocurrio un Error 4');
                                } else {
                                    var objBoton = '<%=lbAux.ClientID%>';
                                    var boton = document.getElementById(objBoton);
                                    boton.click();

                                    $("#Fac_Envio").dialog("close");
                                }
                            }
                        })

                    },
                    "Atras": function () {
                        $(this).dialog("close");
                    }

                }
            });

            $("#Sup_Reci").dialog({
                autoOpen: false,
                height: 350,
                width: 480,
                modal: true,
                buttons: {
                    "Confirmar": function () {
                        var sector = $("#SComunas").val();
                        var comuna = $("#SComunas>option:selected").text();
                        var occ;
                        var Exc = $("#EX>option:selected").text();
                        var obs = $("#ipObsSup").val();
                        if ($("#ocSi").is(':checked')) {
                            occ = "Si";
                            Exc = "";
                        }
                        if ($("#ocNo").is(':checked')) {
                            occ = "NO " + Exc;
                            $("#EX").enableSelection();
                        }
                        $.ajax({
                            type: 'POST',
                            url: 'Detalle Boleta.aspx/AprobarSup',
                            data: "{'NotaProceso' : '" + nota + "','comuna':'" + comuna + "','sector' : '" + sector + "', 'obs' : '" + obs + "', 'occ' : '" + occ + "'}",
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            success: function (msg) {
                                if (!msg.d) {
                                    alert('Ocurrio un Error 1');
                                }
                                var objBoton = '<%=lbAux.ClientID%>';
                                var boton = document.getElementById(objBoton);
                                boton.click();
                            }
                        });
                        $(this).dialog("close");
                    }
                }
            });
            $("#ModificarSup").dialog({
                autoOpen: false,
                height: 350,
                width: 480,
                modal: true,
                buttons: {
                    "Confirmar": function () {
                        var array = new Array();
                        var aux = 0;
                        for (var i = 0; i < cantidad; i++) {

                            if (!$("#chk" + i).is(':checked')) {

                                array[aux] = $("#chk" + i).val();
                                aux++;
                            }
                        }

                        if (array.length > 0) {

                            $.ajax({
                                type: 'POST',
                                url: 'Detalle Boleta.aspx/Desaprobar',
                                data: "{'opc' : '" + option + "','nota' : [" + array + "]}",
                                contentType: 'application/json; charset=utf-8',
                                dataType: 'json',
                                success: function (msg) {
                                    if (msg.d) {
                                        cantidad = 0;
                                        var objBoton = '<%=lbAux.ClientID%>';
                                        var boton = document.getElementById(objBoton);
                                        boton.click();
                                    }
                                }
                            });
                        }
                    }
                }
            });

            $("#simbologia").dialog({
                autoOpen: false,
                height: 450,
                width: 320,
                modal: true,
                buttons: {
                    "Atras": function () {
                        $(this).dialog("close");
                    }
                }

            });
            $("#ExportarLogg").dialog({
                autoOpen: false,
                height: 350,
                width: 420,
                modal: true,
                buttons: { "Atras": function () {
                    $(this).dialog("close");
                }
                }
            });
        });

        function simbologia() {
            $("#simbologia").dialog("open");
        }
        function abrirExport() {
            $("#ExportarLogg").dialog("open");
        }
    function TraerAprobadas(opc) {
        option = opc;
            $.ajax({
                type: 'POST',
                url: 'Detalle Boleta.aspx/TraerAprobadas',
                data: "{'opc':'" + opc + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {

                    var json = json_parse(msg.d);
                    var str = '<table align="center" width="250px" style="background-color: #CCFFFF;"><tr>';
                    str += '<td align="center">Notas</td>';
                    str += '<td align="center">Aprobada</td>';
                    str += '</tr>';
                    $.each(json, function (i, item) {
                        str += '<tr>';
                        str += '<td align="center"><asp:Label ID="lbls" runat="server" text="' + item.nota + '" Font-Size="Small"></asp:Label></td>';
                        str += '<td align="center"><input type="checkbox" checked id="chk' + i + '" value="' + item.nota + '"/></td>';
                        str += '</tr>';
                      
                        cantidad++;
                    });
              
                    str += '</table>';
                    $("#ModificarSup").html(str);
                    $("#ModificarSup").dialog("open");
                }

            });

        }
        function Activar(event) {
            var clase = $(event).val();
            if ($(event).is(':checked')) {

                $('.' + clase).prop('disabled', false);

            }
            else {
                $('.' + clase).prop('disabled', true);
                $('.' + clase).val('');
            }
        }
    
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>

    <table width="100%">
<tr>
<td class="style33">
    <asp:Label ID="Label2" runat="server" Font-Bold="True" Text="Departamento : "></asp:Label>
    </td>
    <td class="style34" align="left">
    <asp:Label ID="lblPermiso" runat="server" Font-Bold="True" ForeColor="#FF3300" Style="text-align: left"></asp:Label>
    </td>
    <td align="right" class="style30">
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
            Text="Exportar a Excel" BackColor="#0099FF" BorderColor="Black" 
            ForeColor="Black" />
    &nbsp;<asp:Label ID="Label14" runat="server" Font-Bold="True" 
        style="text-align: right" Text="Cerrar Session"></asp:Label>
        </td>
        <td class="style31">
    <asp:ImageButton ID="ImageButton1" runat="server" 
        ImageUrl="~/Imagenes/cerrar.png" onclick="ImageButton1_Click" />
        </td>
        </tr>
        </table>
    <table class="style8">
        <tr>
            <td class="style9">
                <ul id="nav">
                    <li class="top">
                        <asp:LinkButton ID="LinkButton1" runat="server" OnClick="btnInicio_Click" CssClass="top_link">Inicio</asp:LinkButton></li>
                    <li class="top"><a href="#nogo2" id="filtros" class="top_link"><span class="down">Filtros</span></a>
                        <ul class="sub">
                            <li>
                                <asp:LinkButton ID="LinkButton6" runat="server" OnClick="btnSuperv_Click" Font-Size="Medium" ForeColor="White">Supervisor</asp:LinkButton></li>
                                <li><asp:LinkButton ID="LinkButton8" runat="server" Font-Size="Medium" ForeColor="White" OnClick="btnSuperAp_Click">Sup.Aprobadas</asp:LinkButton></li>
                            <li>
                                <asp:LinkButton ID="LinkButton4" runat="server" OnClick="btnLab_Click" Font-Size="Medium" ForeColor="White">Laboratorio</asp:LinkButton></li>
                            <li>
                                <asp:LinkButton ID="LinkButton3" runat="server" OnClick="btnFactura_Click" Font-Size="Medium" ForeColor="White">Facturación</asp:LinkButton></li>
                            <li>
                                <asp:LinkButton ID="LinkButton2" runat="server" OnClick="btnBodega_Click" Font-Size="Medium" ForeColor="White">Bodega</asp:LinkButton></li>
                            <li>
                                <asp:LinkButton runat="server" OnClick="btnFiltrar_Click" Font-Size="Medium" ForeColor="White">Parcial</asp:LinkButton></li>
                                <li><asp:LinkButton runat="server" Font-Size="Medium" ForeColor="White" OnClick="Listar_Eliminadas">Eliminadas</asp:LinkButton></li>
                                <li><asp:LinkButton ID="LinkButton7" runat="server" Font-Size="Medium" ForeColor="White" OnClick="btnST_Click">Serv. Tecnico</asp:LinkButton></li>
                            <li><asp:LinkButton runat="server" Font-Size="Medium" ForeColor="White" OnClick="sinFiltros_Click">Sin Filtros</asp:LinkButton> </li>

                        </ul>
                    </li>
                    <li class="top"><asp:LinkButton ID="nventa" Width="100px" runat="server" CssClass="top_link" 
                            onclick="nventa_Click">Actualizar</asp:LinkButton></li>
                       <li class="top">
                        <a href="#nogo2" id="A2" class="top_link"><span class="down">Informes</span></a>
                        <ul class="sub">                        
                    <li>
                          <a href="Reporte.aspx" ID="pinforme" >Preparar Informe</a></li>
                    <li>
                          <asp:LinkButton ID="rlog" runat="server" CssClass="top_link" OnClientClick="abrirExport();return false">Reporte Log</asp:LinkButton></li>
                    </ul>
                    </li>
                    <li class="top"><asp:LinkButton Width="170px" ID="adm_usu" runat="server" CssClass="top_link" 
                            onclick="adm_usu_Click">Administrar Usuarios</asp:LinkButton></li>
                    <li class="top"><asp:LinkButton ID="CambiarForm" runat="server" CssClass="top_link" 
                            onclick="CambiarForm_Click">Cambiar Formulario</asp:LinkButton></li>
                    <li class="top"><a href="Mapa.aspx" id="Mapa" class="top_link"><span>Mapa</span></a></li>
                    <li class="top"><asp:LinkButton ID="LinkButton5" runat="server" CssClass="top_link" 
                          OnClientClick="simbologia();return false">Simbología</asp:LinkButton></li>
                           <li class="top">
                        <a href="#nogo2" id="A1" class="top_link"><span class="down">Modificar</span></a>
                        <ul class="sub">
                            <li>
                                <asp:LinkButton ID="ModAprob" runat="server" OnClientClick="TraerAprobadas(1);return false" Font-Size="Medium" ForeColor="White">Mod.Aprob</asp:LinkButton></li>
                            <li>
                                <asp:LinkButton ID="ModBode" runat="server" OnClientClick="TraerAprobadas(5);return false" Font-Size="Medium" ForeColor="White">Mod.Bod</asp:LinkButton></li>
                            <li>
                                <asp:LinkButton ID="ModLabo" runat="server" OnClientClick="TraerAprobadas(3);return false" Font-Size="Medium" ForeColor="White">Mod.Lab</asp:LinkButton></li>
                            <li>
                                <asp:LinkButton ID="ModFact" runat="server" OnClientClick="TraerAprobadas(4);return false" Font-Size="Medium" ForeColor="White">Mod.Fac</asp:LinkButton></li>
                           </ul>
                    </li>
                    
                    <asp:ImageButton ID="ImageButton2" runat="server" 
        ImageUrl="~/Imagenes/cerrar.png" onclick="ImageButton1_Click" />
                </ul>
            </td>
        </tr>
    </table>
  <div id="Bod_Envio" title="Envio de Nota" >
      <%--<table style="background-color: #CCFFFF; width: 337px;visibility:inherit;" align="center"><tr>
  <td colspan="2" align="center">
      <asp:Label ID="Label4" runat="server" Font-Bold="True" 
          Text="¿Donde desea proceder?"></asp:Label>
      </td>
  </tr>
      <tr>
  <td colspan="2">&nbsp;</td>
  </tr>
      <tr>
  <td class="style26"><asp:Label runat="server" ID="lblLab" Text="Laboratorio" Font-Bold="True" 
          Font-Size="Small"></asp:Label></td>
  <td class="style25"> <input type="checkbox" id="cLaboratorio" onclick="CheckedLab()"/></td>
  </tr>
  <tr>
  <td class="style26"><asp:Label runat="server" ID="lblFac" Text="Facturación" Font-Bold="True" 
          Font-Size="Small"></asp:Label>         
          
          </td>
  <td class="style25"><input type="checkbox" id="cFacturacion" onclick="CheckedFac()" /></td>
  </tr>
  </table>--%>
  </div>
 
   <div id="Fac_Envio" title="Envio Facturación" >
       <%-- <table style="width:450px; visibility:inherit; background-color: #CCFFFF;" >
            <tr>
                <td class="style22" colspan="3">
                    <asp:Label ID="Label3" runat="server" 
                        Text="Determine el tamaño y el numero de bultos" Font-Bold="True"></asp:Label>
                    &nbsp;
                </td>
            </tr>
            <tr>
          <td class="style24"><input type="checkbox" id="bp" value="cBP" onclick="Activar(bp)"/> </td>
          <td class="style23"><asp:Label ID="lblBP" runat="server" Text="Bultos Pequeños" 
                  Font-Size="Small"></asp:Label></td>
          <td><input type="text" id="ipBP" style="font-size: small" class="cBP" /></td>
          </tr>
          <tr>
          <td class="style24"><input type="checkbox" id="bm" onclick="Activar(bm)" value="cBM"/></td>
          <td><asp:Label ID="lblBM" runat="server" Text="Bultos Medianos" Font-Size="Small"></asp:Label></td>
          <td><input type="text" id="ipBM" style="font-size: small" class="cBM"/></td>
          </tr>
          <tr>
          <td class="style24"><input type="checkbox" id="bg" onclick="Activar(bg)" value="cBG"/></td>
          <td><asp:Label ID="lblBG" runat="server" Text="Bultos Grandes" Font-Size="Small"></asp:Label></td>
          <td><input type="text" id="ipBG" style="font-size: small" class="cBG"/></td>
          </tr>
          <tr>
          <td><asp:Label ID="lblDespachador" Text="Seleccione un Preparador" runat="server" 
                  Font-Size="Small"></asp:Label></td>
          <td colspan="2"><select id="SDesp" style="font-size: small"></select></td>
          </tr>
          <tr>
          <td><asp:Label ID="labelObs" runat="server" Text="Observaciones" Font-Size="Small"></asp:Label></td>
          <td colspan="2"><input type="text" id="ipObs" style="font-size: small" /></td>
          </tr>
        </table>--%>
          
</div>
     

     <asp:UpdatePanel ID="upGrilla" runat="server" UpdateMode="Conditional">
     <Triggers>
     <asp:AsyncPostBackTrigger ControlID="nventa" />
     </Triggers>
     
     <ContentTemplate>
     
     
    
 
   <asp:LinkButton ID="lbAux" runat="server" onclick="lbAux_Click" style="display:none;">LinkButton</asp:LinkButton>

    
    <asp:Button ID="ModSup" runat="server" Text="Modificar Aprobación" 
        OnClientClick="TraerAprobadas(1);return false" BackColor="#1E5485" 
        Font-Bold="True" ForeColor="White"/>
    <asp:Button ID="ModBod" runat="server" Text="Modificar Bod" 
        OnClientClick="TraerAprobadas(5);return false" BackColor="#1E5485" 
        Font-Bold="True" ForeColor="White"/>
    <asp:Button ID="ModLab" runat="server" Text="Modificar Lab" 
        OnClientClick="TraerAprobadas(3);return false" BackColor="#1E5485" 
        Font-Bold="True" ForeColor="White" />
    <asp:Button ID="ModFac" runat="server" Text="Modificar Fac" 
        OnClientClick="TraerAprobadas(4);return false" BackColor="#1E5485" 
        Font-Bold="True" ForeColor="White"/>
    <br />

   
    <br />       
     <asp:GridView ID="gvNotas" runat="server" CellPadding="4" EnableModelValidation="True"
        ForeColor="#333333" Width="100%" AutoGenerateColumns="false" OnRowDataBound="gvNotas_RowDataBound"
        OnPageIndexChanging="gvNotas_PageIndexChanging" style="text-align: center">
        <AlternatingRowStyle BackColor="#99CCFF" />
        <EditRowStyle BackColor="#0099CC" />
        <FooterStyle BackColor="#336699" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#001F3E" Font-Bold="True" ForeColor="White" 
            Font-Size="Small" />
        <PagerStyle BackColor="#001F3E" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="White" Font-Bold="True" Font-Size="8" Height="5px" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <Columns>
            <asp:TemplateField HeaderText="Nota">
                <EditItemTemplate>
                    <asp:TextBox ID="txtNota" runat="server" Text='<%# Bind("Nota") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblNota" runat="server" Text='<%# Bind("Nota") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tipo">
                <ItemTemplate>
                    <asp:Image ImageUrl='<%#Eval("tipo")%>' runat="server" ID="tipoImg" />
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Vendedor">
                <EditItemTemplate>
                    <asp:TextBox ID="txtVendedor" runat="server" Text='<%# Bind("Vendedor") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblVendedor" runat="server" Text='<%# Bind("Vendedor") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Cliente">
                <EditItemTemplate>
                    <asp:TextBox ID="txtCliente" runat="server" Text='<%# Bind("Cliente") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblCliente" runat="server" Text='<%# Bind("Cliente") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Fecha">
                <EditItemTemplate>
                    <asp:TextBox ID="txtFecha" runat="server" Text='<%# Bind("Fecha") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblFecha" runat="server" Text='<%# Bind("Fecha") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="F Super">
                <EditItemTemplate>
                    <asp:TextBox ID="txtSuper" runat="server" Text='<%# Bind("FSuper") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblSuper" runat="server" Text='<%# Bind("FSuper") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="E Sup">
                <ItemTemplate>
                    <asp:ImageButton ID="imagenEsup2" AlternateText=" " ImageUrl='<%#Eval("imagenEsup")%>' runat="server"
                      />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="F Bode">
                <EditItemTemplate>
                    <asp:TextBox ID="txtFode" runat="server" Text='<%# Bind("Fbode") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblFbode" runat="server" Text='<%# Bind("Fbode") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="E Bod">
                <ItemTemplate>
                    <asp:ImageButton ID="imagenEBod" AlternateText=" " ImageUrl='<%#Eval("imagenEbode")%>' runat="server"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="F.Lab">
                <EditItemTemplate>
                    <asp:TextBox ID="txtFlab" runat="server" Text='<%# Bind("Flab") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblFlab" runat="server" Text='<%# Bind("Flab") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="E Lab">
                <ItemTemplate>
                    <asp:ImageButton ID="imagenELab" AlternateText=" " ImageUrl='<%#Eval("imagenElab")%>' runat="server"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="F Fac">
                <EditItemTemplate>
                    <asp:TextBox ID="txtFfac" runat="server" Text='<%# Bind("Ffac") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblFfac" runat="server" Text='<%# Bind("Ffac") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="E Fac">
                <ItemTemplate>
                    <asp:ImageButton ID="imagenEFac" AlternateText=" " ImageUrl='<%#Eval("imagenEFac")%>' runat="server"/>
                </ItemTemplate>
            </asp:TemplateField>
           <asp:TemplateField HeaderText="Observaciones">
                <EditItemTemplate>
                    <asp:TextBox ID="txtObse" runat="server" Text='<%# Bind("observaciones") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblObserv" runat="server" Text='<%# Bind("observaciones") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
     </ContentTemplate></asp:UpdatePanel>
 
    <table style="width: 80%;">
        <tr>
            <td class="style6">
                Observaciones</td>
            <td class="style35">
                <input id="inputObs" type="text" readonly="readonly" /><asp:Button ID="btnFiltrar" runat="server" OnClick="btnFiltrar_Click" Text="filtrar"
                    Visible="False" />
            </td>
            <td class="style7">
                <asp:Panel ID="pForzar" runat="server" Visible="False">
                    <asp:TextBox ID="txtForzar" runat="server"></asp:TextBox>
                    &nbsp;
                    <asp:Button ID="btnAnular" runat="server" onclick="btnAnular_Click" 
                        Text="Anular" />
                    &nbsp;<asp:Button ID="btnForzar" runat="server" onclick="btnForzar_Click" 
                        Text="Forzar Ingreso" />
                    &nbsp;
                </asp:Panel>
            </td>
        </tr>
    </table>
    <div id="Sup_Reci" title="Aprobación de Nota">
        <%--<table style="width:400px; background-color: #CCFFFF;visibility:inherit;">
        <tr>
            <td class="style27" colspan="2" align="center">
                <asp:Label ID="Label5" runat="server" Font-Bold="True" Text="Seleccione Comuna"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style28">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style28">
                <asp:Label ID="Label6" runat="server" Font-Size="Small" Text="Comuna"></asp:Label>
            </td>
            <td>
                <select id="SComunas" name="D1" style="font-size: small">
                    <option></option>
                </select></td>
        </tr>
        <tr>
            <td class="style28">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style28">
                <asp:Label ID="Label7" runat="server" Font-Size="Small" Text="Observaciones"></asp:Label>
            </td>
            <td>
                <input id="ipObsSup" type="text" style="font-size: small" /></td>
        </tr>
    </table>--%>
    </div>
    <br />
    <div id="ModificarSup" title="Modificación de Aprobación"></div>
    <div id="ExportarLogg" title="Exportar LOG">
    <table style="width:400px; background-color: #CCFFFF;visibility:inherit;">
         <tr><td>N° Nota de Venta</td></tr>
        <tr>
        <td>
        <asp:TextBox ID="txtNvExp" runat="server"></asp:TextBox></td>
         <td>&nbsp;&nbsp; <asp:Button ID="btnExpLog" runat="server" Text="Exportar" 
                 onclick="btnExpLog_Click" PostBackUrl="~/Detalle Boleta.aspx" /></td>
         </tr>
        </table>
    </div>
    <div id="simbologia" title="Significado de Símbolos">
    <table width="300px">
    <tr>
    <td><asp:Image runat="server" ImageUrl="~/Imagenes/img_check.png" Height="32px" Width="32px"/></td>
    <td><asp:Label runat="server" Text="Posesión de la nota de ventas" Font-Size="Small"></asp:Label></td>
    </tr>
    <tr>
    <td><asp:Image ID="Image1" runat="server" ImageUrl="~/Imagenes/Question.png" Height="32px" Width="32px"/></td>
    <td><asp:Label ID="Label8" runat="server" Text="En Espera de Aprobación" Font-Size="Small"></asp:Label></td>
    </tr>
    <tr>
    <td><asp:Image ID="Image2" runat="server" ImageUrl="Imagenes/icon-green-check.png" Height="32px" Width="32px"/></td>
    <td><asp:Label ID="Label9" runat="server" Text="Termino de Proceso" Font-Size="Small"></asp:Label></td>
    </tr>
    <tr>
    <td><asp:Image ID="Image3" runat="server" ImageUrl="~/Imagenes/lab.png" Height="32px" Width="32px"/></td>
    <td><asp:Label ID="Label10" runat="server" Text="Nota Enviada a Laboratorio" Font-Size="Small"></asp:Label></td>
    </tr>
     <tr>
    <td><asp:Image ID="Image4" runat="server" ImageUrl="~/Imagenes/fac.png" Height="32px" Width="32px"/></td>
    <td><asp:Label ID="Label11" runat="server" Text="Nota Enviada a Facturación" Font-Size="Small"></asp:Label></td>
    </tr>
     <tr>
    <td><asp:Image ID="Image5" runat="server" ImageUrl="~/Imagenes/parcial.png" Height="32px" Width="32px"/></td>
    <td><asp:Label ID="Label12" runat="server" Text="Nota Despacho Parcial" Font-Size="Small"></asp:Label></td>
    </tr>
        <%--  <tr>
    <td><asp:Image ID="Image6" runat="server" ImageUrl="~/Imagenes/total.png" Height="32px" Width="32px"/></td>
    <td><asp:Label ID="Label13" runat="server" Text="Nota Despacho Total" Font-Size="Small"></asp:Label></td>
    </tr>--%>
    <tr>
    <td><asp:Image ID="Image7" runat="server" ImageUrl="~/Imagenes/ST.png" Height="32px" Width="32px"/></td>
    <td><asp:Label ID="Label15" runat="server" Text="Servicio Tecnico" Font-Size="Small"></asp:Label></td>
    </tr>
    </table>
    </div>    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
     
    <%--     <asp:GridView ID="gvNotas" runat="server" CellPadding="4" EnableModelValidation="True"
        ForeColor="#333333" Width="100%" AutoGenerateColumns="false" OnRowDataBound="gvNotas_RowDataBound"
        OnPageIndexChanging="gvNotas_PageIndexChanging" style="text-align: center">
        <AlternatingRowStyle BackColor="#99CCFF" />
        <EditRowStyle BackColor="#0099CC" />
        <FooterStyle BackColor="#336699" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#001F3E" Font-Bold="True" ForeColor="White" 
            Font-Size="Small" />
        <PagerStyle BackColor="#001F3E" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="White" Font-Bold="True" Font-Size="8" Height="5px" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <Columns>
            <asp:TemplateField HeaderText="Nota">
                <EditItemTemplate>
                    <asp:TextBox ID="txtNota" runat="server" Text='<%# Bind("Nota") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblNota" runat="server" Text='<%# Bind("Nota") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tipo">
                <ItemTemplate>
                    <asp:Image ImageUrl='<%#Eval("tipo")%>' runat="server" ID="tipoImg" />
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Vendedor">
                <EditItemTemplate>
                    <asp:TextBox ID="txtVendedor" runat="server" Text='<%# Bind("Vendedor") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblVendedor" runat="server" Text='<%# Bind("Vendedor") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Cliente">
                <EditItemTemplate>
                    <asp:TextBox ID="txtCliente" runat="server" Text='<%# Bind("Cliente") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblCliente" runat="server" Text='<%# Bind("Cliente") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Fecha">
                <EditItemTemplate>
                    <asp:TextBox ID="txtFecha" runat="server" Text='<%# Bind("Fecha") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblFecha" runat="server" Text='<%# Bind("Fecha") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="F Super">
                <EditItemTemplate>
                    <asp:TextBox ID="txtSuper" runat="server" Text='<%# Bind("FSuper") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblSuper" runat="server" Text='<%# Bind("FSuper") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="E Sup">
                <ItemTemplate>
                    <asp:ImageButton ID="imagenEsup2" AlternateText=" " ImageUrl='<%#Eval("imagenEsup")%>' runat="server"
                      />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="F Bode">
                <EditItemTemplate>
                    <asp:TextBox ID="txtFode" runat="server" Text='<%# Bind("Fbode") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblFbode" runat="server" Text='<%# Bind("Fbode") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="E Bod">
                <ItemTemplate>
                    <asp:ImageButton ID="imagenEBod" AlternateText=" " ImageUrl='<%#Eval("imagenEbode")%>' runat="server"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="F.Lab">
                <EditItemTemplate>
                    <asp:TextBox ID="txtFlab" runat="server" Text='<%# Bind("Flab") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblFlab" runat="server" Text='<%# Bind("Flab") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="E Lab">
                <ItemTemplate>
                    <asp:ImageButton ID="imagenELab" AlternateText=" " ImageUrl='<%#Eval("imagenElab")%>' runat="server"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="F Fac">
                <EditItemTemplate>
                    <asp:TextBox ID="txtFfac" runat="server" Text='<%# Bind("Ffac") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblFfac" runat="server" Text='<%# Bind("Ffac") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="E Fac">
                <ItemTemplate>
                    <asp:ImageButton ID="imagenEFac" AlternateText=" " ImageUrl='<%#Eval("imagenEFac")%>' runat="server"/>
                </ItemTemplate>
            </asp:TemplateField>
           <asp:TemplateField HeaderText="Observaciones">
                <EditItemTemplate>
                    <asp:TextBox ID="txtObse" runat="server" Text='<%# Bind("observaciones") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblObserv" runat="server" Text='<%# Bind("observaciones") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>--%>

    </asp:Content>