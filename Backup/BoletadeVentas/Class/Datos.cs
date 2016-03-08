using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using BoletadeVentas.Data.AdministracionTableAdapters;
using BoletadeVentas.Data.Notas_ControlTableAdapters;

namespace BoletadeVentas.Class
{
    public class Datos
    {

        private NOTV_AreaLoginTableAdapter Loginadapter = new NOTV_AreaLoginTableAdapter();
        private Traer_NotasTableAdapter TraerNadapter = new Traer_NotasTableAdapter();
        private EstadoTableAdapter Eadapter = new EstadoTableAdapter();
        private NOTV_controlTableAdapter ControlAdapter = new NOTV_controlTableAdapter();
        private PERSO_DBTableAdapter Persoadapter = new PERSO_DBTableAdapter();
        private Notas_ParcialesTableAdapter Parciales = new Notas_ParcialesTableAdapter();
        private Traer_FiltroTableAdapter Filtro = new Traer_FiltroTableAdapter();
        private QueriesTableAdapter Actualizar = new QueriesTableAdapter();
        private NOTV_ComunasTableAdapter Comunas = new NOTV_ComunasTableAdapter();
        //***********************Login*******************************//
        public DataTable TraerUsuarios()
        {
            return Loginadapter.GetValidos();
        }

        public DataTable ValidarLogeo(Negocio neg)
        {
            return Loginadapter.ValidarLogin(neg.Usuario,neg.Pass);
        }


        //****************************Llena Grilla*******************//

        public DataTable RetornarNotas()
        {
            return TraerNadapter.GetData();
        }


        //**********************sector Supervisor*****************//
        public DataTable RestornarEstado(Negocio neg)
        {
            return Eadapter.GetEstado(neg.Nota);
        }

        public void EstadoSup(Negocio neg)
        {
            Eadapter.UpdateSupEstado(neg.Comuna, neg.Obs, neg.OC, neg.Nota, neg.Sector);
        }

        //*****************sector Bodega y Laboratorio***************//

        public void EstadoBod(Negocio neg)
        {
            Eadapter.UpdateBodEstado(neg.Nota);
        }

        public void EstadoEnvioLab(Negocio neg)
        {
            Eadapter.UpdateLabEnvio(neg.Nota);
        }

        public void EstadoReciLab(Negocio neg)
        {
            Eadapter.UpdateLabReci(neg.Nota);
        }

        

        public void Labrevisado(Negocio neg)
        {
            Eadapter.UpdateLabRevisado(neg.Nota);
        }

        //*****************************sector Factura********************//

        public void FacEnvio(Negocio neg)
        {
            Eadapter.UpdateFacEnvio(neg.Bultop,neg.Bultosm,
                neg.Bultosg,neg.Preparador,neg.Obs,neg.Nota);
        }

       

        public void FacRecibido(Negocio neg)
        {
            Eadapter.UpdatefacRecivido(neg.Nota);
        }

        //*********************************Traer Observaciones************//

        public DataTable NotaObs(Negocio neg)
        {
            return ControlAdapter.GetUno(neg.Nota);
        }

        //*****************traer Preparadores***********************//
        public DataTable Getpreparadores()
        {
            return Persoadapter.GetPreparadores();
        }

        //*********************traer Parciales *****************//

        public DataTable Traer_Parciales(){


            return Parciales.GetData();
        }
        //*******************Filtro con opcion**********//

        public DataTable traerFiltro(int opc)
        {
            return Filtro.GetData(opc);
        }

        public void ActualizarNotas()
        {
            Actualizar.Agregar_ActualizarNota();
        }

        //*********************TraerComunas******************//
        public DataTable ObtenerComunas()
        {
           return Comunas.GetData();
        }
        //*****************modificar nota****************//
        public void ModificarNota(int opc, Negocio neg)
        {
            Actualizar.Modificar_Nota(opc,neg.Nota);
        }
        //**************actualiza docu ***************//

        public void Docu()
        {
            Actualizar.Actualizar_Docu();
        }

        //************Revisar Parciales*******************//
        public void RevisarP()
        {
            Actualizar.Revisar_Parcial();
        }

        //*****************Forzar Ingreso ****************//
        public void ForzarNota(Negocio obj)
        {
            ControlAdapter.ForzarIngreso(obj.Nota);

        }

        //****************Anular Nota ********************//
        public void AnularNota(Negocio obj)
        {
            ControlAdapter.AnularNota(obj.Nota);
        }

        //****************Forzar Parcial******************//
        //public void ForzarParcial(Negocio obj)
        //{
        //    ControlAdapter.ForzarParcial(obj.Nota);
        //}

    }
}