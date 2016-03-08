using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BoletadeVentas.Class
{
    public class NegocioError
    {
        private string _Usuario;
        private string _Pagina;
        private string _Error;
        private string _Metodo;
        private string _Control;

        public string Control
        {
            get { return _Control; }
            set { _Control = value; }
        }

        public string Metodo
        {
            get { return _Metodo; }
            set { _Metodo = value; }
        }

        public string Usuario
        {
            get { return _Usuario; }
            set { _Usuario = value; }
        }

        public string Error
        {
            get { return _Error; }
            set { _Error = value; }
        }
     
        public string Pagina
        {
            get { return _Pagina; }
            set { _Pagina = value; }
        }

        public void RegistrarError()
        {
            ErrorReporte error = new ErrorReporte();
            error.RegistrarError(this);
        }
    }
}