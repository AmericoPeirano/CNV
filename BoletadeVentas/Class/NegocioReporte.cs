using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BoletadeVentas.Class
{
    public class NegocioReporte
    {
        private int _Nota;

        public int Nota
        {
            get { return _Nota; }
            set { _Nota = value; }
        }
        private string _Empleado;

        public string Empleado
        {
            get { return _Empleado; }  
            set { _Empleado = value; }
        }
        private string _Cliente;

        public string Cliente
        {
            get { return _Cliente; }
            set { _Cliente = value; }
        }
        private string _FechaRecibido;

        public string FechaRecibido
        {
            get { return _FechaRecibido; }
            set { _FechaRecibido = value; }
        }
        private string _FechaEntrega;

        public string FechaEntrega
        {
            get { return _FechaEntrega; }
            set { _FechaEntrega = value; }
        }
        private string _Obs;

        public string Obs
        {
            get { return _Obs; }
            set { _Obs = value; }
        }

        private TimeSpan _TiempoSupervision;

        public TimeSpan TiempoSupervision
        {
            get { return _TiempoSupervision; }
            set { _TiempoSupervision = value; }
        }
        private TimeSpan _TiempoBodega;

        public TimeSpan TiempoBodega
        {
            get { return _TiempoBodega; }
            set { _TiempoBodega = value; }
        }
        private TimeSpan _TiempoLaboratorio;

        public TimeSpan TiempoLaboratorio
        {
            get { return _TiempoLaboratorio; }
            set { _TiempoLaboratorio = value; }
        }
        private TimeSpan _TiempoFacturacion;

        public TimeSpan TiempoFacturacion
        {
            get { return _TiempoFacturacion; }
            set { _TiempoFacturacion = value; }
        }
        private TimeSpan _TiempoDespacho;

        public TimeSpan TiempoDespacho
        {
            get { return _TiempoDespacho; }
            set { _TiempoDespacho = value; }
        }

        public IQueryable<NegocioReporte> prueba()
        {
            ReporteDB db = new ReporteDB();
            return db.GetDatos();
        }

        public IQueryable<NegocioReporte> Departamentos()
        {
            ReporteDB db = new ReporteDB();
            return db.ReportePorDepartamentos(this);
        }
    }
}