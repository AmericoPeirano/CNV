using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BoletadeVentas.Class
{
    public class NegocioLOG
    {
        private int _nv;
        private string _usuario;
        private string _accion;
        private string _descripcion;
        

        public int nv
        {
            get { return _nv; }
            set { _nv = value; }
        }

        public string usuario
        {
            get { return _usuario; }
            set { _usuario = value; }
        }

        public string accion
        {
            get { return _accion; }
            set { _accion = value; }
        }

        public string descripcion
        {
            get { return _descripcion; }
            set { _descripcion = value; }
        }


        public void RegistrarLog()
        {
            LogReporte log = new LogReporte();
            log.RegistrarLog(this);
        }
    }
}