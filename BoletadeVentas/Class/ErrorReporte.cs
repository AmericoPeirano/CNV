using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BoletadeVentas.Data.ControlErrorTableAdapters;

namespace BoletadeVentas.Class
{
    public class ErrorReporte
    {
        private ERROR_LOGTableAdapter Error = new ERROR_LOGTableAdapter();

        public void RegistrarError(NegocioError neg)
        {
            Error.Insert(neg.Usuario,
                neg.Error,
                neg.Pagina,
                DateTime.Now,
                neg.Metodo,
                neg.Control);
        }
    }
}