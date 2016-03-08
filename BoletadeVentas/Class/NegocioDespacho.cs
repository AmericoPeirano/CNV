using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace BoletadeVentas.Class
{
    public class NegocioDespacho
    {
        #region parametros
        private DateTime _Fecha;

        public DateTime Fecha
        {
            get { return _Fecha; }
            set { _Fecha = value; }
        }
        private string _Conductor;

        public string Conductor
        {
            get { return _Conductor; }
            set { _Conductor = value; }
        }
        private int _Nota;

        public int Nota
        {
            get { return _Nota; }
            set { _Nota = value; }
        }
        private string _Despachador;

        public string Despachador
        {
            get { return _Despachador; }
            set { _Despachador = value; }
        }

        #endregion

        public DataTable TraerDespacho()
        {
            DatosDespacho des = new DatosDespacho();
            return des.TraerAlDespacho();
        }

        public DataTable Despachadores()
        {
            DatosDespacho des = new DatosDespacho();
            return des.Despachador();
        }

        public void Terminardespacho()
        {
            DatosDespacho des = new DatosDespacho();
            des.terminarDespacho(this);
        }

        public DataTable Conductores()
        {
            DatosDespacho des = new DatosDespacho();
           return des.traerConductores();
        }

        public void AsignarFechaConductor()
        {
            DatosDespacho des = new DatosDespacho();
            des.AsignarConductor(this);

        }

        public void ActualizarOk()
        {
            DatosDespacho des = new DatosDespacho();
            des.UpdateOk(this);
        }

        public void ReprogramarNota()
        {
            DatosDespacho des = new DatosDespacho();
            des.Reprogramar(this);
        }

        

        public void AsignarDespachador()
        {
            DatosDespacho des = new DatosDespacho();
            des.AgregarDespachador(this);
        }


        public void AsignaryTerminar()
        {
            DatosDespacho des = new DatosDespacho();
            des.AsignaryTerminarNota(this);
        }
    }
}