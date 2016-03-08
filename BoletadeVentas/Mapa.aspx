<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Mapa.aspx.cs" Inherits="BoletadeVentas.Formulario_web14" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false">//se agrega asi</script> 
    <link href="Css/Base.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var lat = null;
        var lng = null;
        var latD = null;
        var lngD = null;
        var map = null;
        var geocoder = null;
        var marker = null;

        $(document).ready(function () { //esta con jquery, entonces cuando el documento este listo para funcionar
            //hara todo lo que esta dentro
            // se declaran los eventos click a los botones

            $("#btnUbicacionOrigen").click(function () { //aki estoy asignandole a que funcion llamara el evento click de los botones
                ObtenerCoordenadasOrigen(1);
                return false;
            });
            $("#btnUbicacionDestino").click(function () {
                ObtenerCoordenadasOrigen(2);
                return false;
            });
            $("#btnLlegar").click(function () { //le pongo click y la funcion que llamara, en este caso TrazarRuta();
                TrazarRuta();
                return false;


            });
            $("#btnLimpiar").click(function () {
                limpiar();
                return false;
            });
            //LA funcion Iniciar Carga el mapa, lo dibuja por primera vez en un div, y la otra funcion 
            //obtenercoordenadasOrigen, son para setear el lugar por defecto que nos mostrara, que en este caso es la empresa
            Iniciar();
            ObtenerCoordenadasOrigen(1);
        });

        function Iniciar() {
        //se crea un objeto geocorder para las coordenadas, este objeto trabaja con las coordenadas, todos estos son propios de API
            geocoder = new google.maps.Geocoder(); // aki empiezo a usar las variables que declare arriba


            //un objeto LatLng , con coordenadas al azar, es solo para mostrar el mapa
            //son coordenadas al azar para solo mostrar el mapa en un lugar, despues se seteara la ruta de la empresa con la otra
            //funcion
            var latLng = new google.maps.LatLng(37.0625, -95.677068);

            // Opciones de configuracion, estas opciones se le pasaran a la configuracion del mapa
            var myOptions = {
                center: latLng, //el mapa se centra a las coordenadas
                zoom: 15,//el zoom que tendra
                mapTypeId: google.maps.MapTypeId.ROADMAP // el tipo de mapa, te fijas hay dos tipos uno que es satelital y este el normal, igual se pueden cambiar en la pantalla
            };
            // se crea el map y se le pasa el id del div donde se alojara y las opciones que definimos
            //aki paso las opciones que defini antes y le paso tambien el div donde quedara el mapa
            map = new google.maps.Map(document.getElementById("map_canvas"), myOptions); // a fijate aki use la variable map
            //se declaran globales arriba porque al instanciarlas como aki se pueden usar en todas las funciones

            // Opciones para poner el punto de marca para el mapa
            //aki uso la variable marker que declare arriba, y es para poner el punto de marca el rojito xd
            marker = new google.maps.Marker({
                map: map,//el mapa creado anteriormente
                position: latLng,//donde se dibujara el punto, en este caso en las coordenadas especificadas
                draggable: true // que sea factible moverlo
            });




        }
        function ObtenerCoordenadasOrigen(opc) {
            // y esta es la otra funcion que nos dara las localizaciones al pulsar ubicacion origen y ubicacion destino
        //tiene un opc para determinar que boton lo llamo, para ver que direcciones tomar
            //opc nos dara las opciones de ruta, porque este metodo sera llamado por el boton ubicacion origen  y ubicacion destino
            //entonces si es llamado por ubicacion origen, le pasamos un 1 y si es llamado por ubicacion destino le pasamos un 2
        //se toman las variables separadas por comas, en este formato CALLE,COMUNA,CIUDAD,PAIS
            if (opc == 1) { //la opcion 1 es para la Ubicacion origen, por ende tomo los valores de los input que le corresponden a
            //ese boton
                var direccion = $("#ipUbicacionCalle").val() + ","
                            + $("#slComunaOrigen").val() + ","
                            + $("#ipUbicacionCiudad").val() + ",Chile";


            }
            else {//si no es 1 entonces la llamda es de ubicacion destino
                var direccion = $("#ipDestinoCalle").val() + ","
                            + $("#slComunaDestino").val() + ","
                            + $("#ipDestinoCiudad").val() + ",Chile";

            }
            // se hace la llamada al geocode, y le pasamos la direccion a la propiedad address, y llamamos a una funcion de resultado,
            //que recibe results como resultado y status como el estado para ver si ocurrio un error

            geocoder.geocode({ 'address': direccion }, function (results, status) {
            //results y status pueden ser cualkier nombre, pero son para determinar , los resultados y el estado, si es ok o un error

                if (status == google.maps.GeocoderStatus.OK) { //si el estado es ok significa que tenemos las coordenadas

                    map.setCenter(results[0].geometry.location); //se centra el mapa a las nuevas posiciones

                    marker.setPosition(results[0].geometry.location); // se pone el marcador en la posicion nueva

                    updatePosition(results[0].geometry.location); //se actualiza la posicion



                } else {

                    alert("No podemos encontrar la direcci&oacute;n, error: " + status); //si el estado no es ok, mostramos el mensaje y el error
                }
            });
        }
        // y esta es la funcion que llamara el boton Como LLegar
        function TrazarRuta() {

            $("#panel_ruta").show(); //mostramos este div que tendra los datos de la ruta
            //ese div tiene las opciones de ruta, despues veras que se oculta al presionar limpiar, por eso aki lo mostramos

            var directionsDisplay = new google.maps.DirectionsRenderer(); //este objeto proporciona lo necesario para la vsualizacion
            //me refiero a la visualizacion en el navegador
            var directionsService = new google.maps.DirectionsService(); //y este es para la llamada de las direcciones

            var origen = $("#ipUbicacionCalle").val() + "," //seteamos la direccion de origen
                            + $("#slComunaOrigen").val() + ","
                            + $("#ipUbicacionCiudad").val() + ",Chile";

            var destino = $("#ipDestinoCalle").val() + ","  //y la de destino
                            + $("#slComunaDestino").val() + ","
                            + $("#ipDestinoCiudad").val() + ",Chile";
            // las variables origen y destino tendran las direcciones

            var request = { // y nos creamos esta variable para las opciones
                origin: origen, //el origen
                destination: destino, //destino, origin y destination deben tener si o si esos nombres ya que son propiedades del API
                travelMode: google.maps.DirectionsTravelMode.DRIVING, //el modo de viaje Driving, conduciendo
                //existen mas modos de viaje, bicicleta, avion pero para el caso sera en auto xd

                provideRouteAlternatives: true // nos dara rutas alternativas, aver si queremos que salgan las rutas alternativas debemos ponerla en true
            };

            directionsService.route(request, function (response, status) { // y hacemos la llamda a directionservice, y tambien recibimos response como respuesta y status como el estado
                if (status == google.maps.DirectionsStatus.OK) { // si el status es OK
                    directionsDisplay.setMap(map); // se define donde se mostrara el mapa, aki vez vuelvo a usar la variable map, que ya esta definida como una variable MAP del api de google
                    directionsDisplay.setPanel($("#panel_ruta").get(0)); //el panel de las rutas, es un div donde cargaran las rutas
                    directionsDisplay.setDirections(response); // y se dibuja, y aqui dibujamos el mapa con la respuesta response que recibimos
                } else {
                    alert("No existen rutas entre ambos puntos");//si el status no fue OK mostramos este mensaje de error
                }
            });

        }
        function limpiar() {
            // y finalmente para el boton limpiar  lo que hacemos como te decia es ocultar el div panel_ruta
            // y volver a cargar el mapa desde el inicio

            $("#panel_ruta").hide();
            Iniciar();
            ObtenerCoordenadasOrigen(1);
            $("#ipDestinoCalle").val(""); // y tambien dejamos ubicacion destino en vacio

        }
    
    </script>
    <style type="text/css">
        .style3
        {
            width: 69%;
        }
        .style4
        {
            width: 128px;
        }
        .style6
        {
            width: 165px;
        }
        .style9
        {
            width: 243px;
            text-align: center;
        }
        .style10
        {
            text-align: center;
        }
        .style14
        {
            width: 165px;
            text-align: left;
        }
        .style15
        {
            width: 130px;
            text-align: left;
        }
        .style16
        {
            width: 243px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<br/>
<ul id="nav">
                    <li class="top">
                        <asp:LinkButton ID="LinkButtonInicio" runat="server" OnClick="btnInicio_Click" CssClass="top_link">Inicio</asp:LinkButton></li>
                    
                 
                    <li class="top"><a href="#nogo57" id="pinforme" class="top_link"><span>Preparar Informe</span></a></li>
                    <li class="top"><a href="#nogo57" id="AdmUsu" class="top_link"><span>Administrar Usuarios</span></a></li>
                    <li class="top"><a href="Despacho.aspx" id="CbForm" class="top_link"><span>Cambiar Formulario</span></a></li>
                    <li class="top"><a href="Mapa.aspx" id="Mapa" class="top_link"><span>Mapa</span></a></li>
                </ul>
                <br/>

    <table bgcolor="#666699" class="style3" align="center">
        <tr>
            <td class="style4">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Calle Origen"></asp:Label>
            </td>
            <td class="style16">
                <input id="ipUbicacionCalle" type="text" value="Maipo391" />
            </td>
            <td class="style15">
                <asp:Label ID="Label4" runat="server" Font-Bold="True" Text="Calle Destino (N°)"></asp:Label>
            </td>
            <td class="style6">
                <input id="ipDestinoCalle" type="text" />
            </td>
        </tr>
        <tr>
            <td class="style4">
                <asp:Label ID="Label2" runat="server" Font-Bold="True" Text="Ciudad Origen"></asp:Label>
            </td>
            <td class="style16">
                <input id="ipUbicacionCiudad" type="text" value="Santiago" />
            </td>
            <td class="style15">
                <asp:Label ID="Label5" runat="server" Font-Bold="True" Text="Ciudad Destino"></asp:Label>
            </td>
            <td class="style6">
                <input id="ipDestinoCiudad" type="text" value="Santiago" />
            </td>
        </tr>
        <tr>
            <td class="style4">
                <asp:Label ID="Label3" runat="server" Font-Bold="True" Text="Comuna Origen"></asp:Label>
            </td>
            <td class="style16">
                <select id="slComunaOrigen" name="D1">
                    <option value="Recoleta" selected="selected">Recoleta</option>
                    <option value="Santiago">Santiago</option>
                    <option value="Cerrillos">Cerrillos</option>
                    <option value="Cerro Navia">Cerro Navia</option>
                    <option value="Conchali">Conchali</option>
                    <option value="El Bosque">El Bosque</option>
                    <option value="Estacion Central">Estación Central</option>
                    <option value="Huechuraba">Huechuraba</option>
                    <option value="Independencia">Independencia</option>
                    <option value="La Cisterna">La Cisterna</option>
                    <option value="La Florida">La Florida</option>
                    <option value="La Granja">La Granja</option>
                    <option value="La Pintana">La Reina</option>
                    <option value="La Reina">La Reina</option>
                    <option value="Las Condes">Las Condes</option>
                    <option value="Lo Barnechea">Lo Barnechea</option>
                    <option value="Lo Espejo">Lo Espejo</option>
                    <option value="Lo Prado">Lo Prado</option>
                    <option value="Macul">Macul</option>
                    <option value="Maipu">Maipú</option>
                    <option value="Ñuñoa">Ñuñoa</option>
                    <option value="Pedro Aguirre Cerda">Pedro Aguirre Cerda</option>
                    <option value="Peñalolen">Peñalolen</option>
                    <option value="Providencia">Providencia</option>
                    <option value="Pudahuel">Pudahuel</option>
                    <option value="Quilicura">Quilicura</option>
                    <option value="Quinta Normal">Quinta Normal</option>
                    <option value="Recoleta">Renca</option>
                    <option value="San Joaquin">San Joaquín</option>
                    <option value="San Miguel">San Miguel</option>
                    <option value="San Ramon">San Ramon</option>
                    <option value="Vitacura">Vitacura</option>
                </select>
            </td>
            <td class="style15">
                <asp:Label ID="Label6" runat="server" Font-Bold="True" Text="Comuna Destino"></asp:Label>
            </td>
            <td class="style6">
                <select id="slComunaDestino" name="D2">
                    <option value="Recoleta" selected="selected">Recoleta</option>
                    <option value="Santiago">Santiago</option>
                    <option value="Cerrillos">Cerrillos</option>
                    <option value="Cerro Navia">Cerro Navia</option>
                    <option value="Conchali">Conchali</option>
                    <option value="El Bosque">El Bosque</option>
                    <option value="Estacion Central">Estación Central</option>
                    <option value="Huechuraba">Huechuraba</option>
                    <option value="Independencia">Independencia</option>
                    <option value="La Cisterna">La Cisterna</option>
                    <option value="La Florida">La Florida</option>
                    <option value="La Granja">La Granja</option>
                    <option value="La Pintana">La Reina</option>
                    <option value="La Reina">La Reina</option>
                    <option value="Las Condes">Las Condes</option>
                    <option value="Lo Barnechea">Lo Barnechea</option>
                    <option value="Lo Espejo">Lo Espejo</option>
                    <option value="Lo Prado">Lo Prado</option>
                    <option value="Macul">Macul</option>
                    <option value="Maipu">Maipú</option>
                    <option value="Ñuñoa">Ñuñoa</option>
                    <option value="Pedro Aguirre Cerda">Pedro Aguirre Cerda</option>
                    <option value="Peñalolen">Peñalolen</option>
                    <option value="Providencia">Providencia</option>
                    <option value="Pudahuel">Pudahuel</option>
                    <option value="Quilicura">Quilicura</option>
                    <option value="Quinta Normal">Quinta Normal</option>
                    <option value="Recoleta">Renca</option>
                    <option value="San Joaquin">San Joaquín</option>
                    <option value="San Miguel">San Miguel</option>
                    <option value="San Ramon">San Ramon</option>
                    <option value="Vitacura">Vitacura</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="style4">
                &nbsp;
            </td>
            <td class="style16">
                &nbsp;
            </td>
            <td class="style15">
                &nbsp;
            </td>
            <td class="style6">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="style10">
                <input id="btnUbicacionOrigen" type="button" value="Ubicación Origen" />
            </td>
            <td class="style9">
                <input id="btnLlegar" type="button" value="Como LLegar" />
            </td>
            <td class="style15">
                <input id="btnLimpiar" type="button" value="Limpiar" />
            </td>
            <td class="style14">
                <input id="btnUbicacionDestino" type="button" value="Ubicación Destino" />
            </td>
        </tr>
        <tr>
            <td class="style10" colspan="4">
                <input id="lat" type="hidden" /><input id="long" type="hidden" />
            </td>
        </tr>
        <tr>
            <td class="style10" colspan="4">
                <div id="map_canvas" style="width: auto; height: 300px;">
                </div>
            </td>
        </tr>
        <tr>
            <td class="style10" colspan="4">
                <div id="panel_ruta" style="width: auto; background-color: #FFFFFF; text-align: center;">
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
