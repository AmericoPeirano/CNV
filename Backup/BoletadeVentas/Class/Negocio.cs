using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace BoletadeVentas.Class
{
    public class Negocio
    {

        //***********region declaracion de variables***************//

        #region Declaracion de Variables
        private string _usuario;

        public string Usuario
        {
            get { return _usuario; }
            set { _usuario = value; }
        }
        private string _pass;

        public string Pass
        {
            get { return _pass; }
            set { _pass = value; }
        }
        private int _estado;

        public int Estado
        {
            get { return _estado; }
            set { _estado = value; }
        }

        private int nota;

        public int Nota
        {
            get { return nota; }
            set { nota = value; }
        }

        private DateTime _fecha;

        public DateTime Fecha
        {
            get { return _fecha; }
            set { _fecha = value; }
        }

        private int _Bultop;

        public int Bultop
        {
            get { return _Bultop; }
            set { _Bultop = value; }
        }
        private int _Bultosm;

        public int Bultosm
        {
            get { return _Bultosm; }
            set { _Bultosm = value; }
        }
        private int _Bultosg;

        public int Bultosg
        {
            get { return _Bultosg; }
            set { _Bultosg = value; }
        }
        private string _obs;

        public string Obs
        {
            get { return _obs; }
            set { _obs = value; }
        }

        private string preparador;

        public string Preparador
        {
            get { return preparador; }
            set { preparador = value; }
        }

        private int sector;

        public int Sector
        {
            get { return sector; }
            set { sector = value; }
        }
        private string comuna;

        public string Comuna
        {
            get { return comuna; }
            set { comuna = value; }
        }
        private string oc;

        public string OC
        {
            get { return oc; }
            set { oc = value; }
        }

        #endregion
        Datos bd = new Datos();

        //*********************Sector Logeo*************//
        public DataTable UsuariosValidos()
        {
            DataTable dt = new DataTable();
            DataTable dtUsers = new DataTable();
            dt = bd.TraerUsuarios();
            dtUsers.Columns.Add("Usuarios");
            dtUsers.Rows.Add(string.Empty);
            foreach (DataRow dr in dt.Rows)
            {
                dtUsers.Rows.Add(dr["usuario"]);
            }
            return dtUsers;
        }



        public DataTable ValidaUsuario()
        {
            return bd.ValidarLogeo(this);
        }


        //*************Llenar Grilla***********//
        public DataTable TraerNotas()
        {
            return bd.RetornarNotas();
        }

        //*************sector Supervision***************//

        public DataTable EstadoNota()
        {
           return bd.RestornarEstado(this);
        }

        public void ActualizarSupE()
        {
            bd.EstadoSup(this);
        }

        //*************************** sector Bodega y Laboratorio**************//

        public void actualizarBodE()
        {
            bd.EstadoBod(this);
        }

        public void actualizaLabE()
        {
            bd.EstadoEnvioLab(this);
        }
        public void actualizarLabRecibido()
        {
            bd.EstadoReciLab(this);
        }

        
        public void RevisadoL()
        {
            bd.Labrevisado(this);
        }

        // *****************sector Facturacion**************//

        public void EnvioFacturacion()
        {
            bd.FacEnvio(this);
        }

        public void FacturacionRecibe()
        {
            bd.FacRecibido(this);
        }

        //****************sector Llenar Preparadores*****************//

        public DataTable llenarPreparadores()
        {
            return bd.Getpreparadores();
        }

        //************sector traer observaciones************//

        public string TraerObs()
        {
            DataTable dt = bd.NotaObs(this);
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0]["Observaciones"].ToString();
            }
            else
            {
                return "No existe este Registro";
            }
        }


        //********************LlenarGrillaDespacho****************//

        public DataTable FiltrarParciales()
        {
            return bd.Traer_Parciales();
        }
        //*******************Filtro con opcion**********//
        public DataTable FiltroOpc(int opc)
        {
            return bd.traerFiltro(opc);
        }
        //********************************Actualizar y eliminar notas************//
        public void ActualizarNotas()
        {
            bd.ActualizarNotas();
        }
        //****************************TraerComunas******************************//
        public DataTable Comunas()
        {
            return bd.ObtenerComunas();
        }
        //********************Modificar Nota**************************//
        public void ModificarNota(int opc)
        {
            bd.ModificarNota(opc, this);
        }
        //*********************Actualiza Docu **************//
        public void Documento_Actualizar()
        {
            bd.Docu();
        }

        //***************Verificar Parcial*****************//
        public void VerificarParciales()
        {
            bd.RevisarP();
        }

        //*********Forzar Ingreso********************//
        public void Forzar()
        {
            bd.ForzarNota(this);
        }

        //**********Anular Nota ******************//
        public void AnularNV()
        {
            bd.AnularNota(this);
        }

        //********* Forzar Parcial**************//

        //public void ForzarPar()
        //{
        //    bd.ForzarParcial(this);
        //}
    }
}