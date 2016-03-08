using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BoletadeVentas.Data.ControlErrorTableAdapters;
namespace BoletadeVentas.Class
{
    public class LogReporte
    {
        private LOG_NVTableAdapter Log = new LOG_NVTableAdapter();

        public void RegistrarLog(NegocioLOG neg)
        {
            Log.Insert(neg.nv,
                neg.usuario,
                neg.accion,
                neg.descripcion);
        }
    }
}