using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace BoletadeVentas.Class
{
    public class Administracion
    {
        private string _Nombre;

        public string Nombre
        {
            get { return _Nombre; }
            set { _Nombre = value; }
        }
        private string _Permiso;

        public string Permiso
        {
            get { return _Permiso; }
            set { _Permiso = value; }
        }
        private int _Eliminado;

        public int Eliminado
        {
            get { return _Eliminado; }
            set { _Eliminado = value; }
        }

        private string _Clave;

        public string Clave
        {
            get { return _Clave; }
            set { _Clave = value; }
        }

        public DataTable Depas()
        {
            AdministracionDB db = new AdministracionDB();
            return db.ObtenerDepas();
        }

        public DataTable ObtenerDatos()
        {
            AdministracionDB db = new AdministracionDB();
            return db.Busqueda(this);
        }
        public DataTable Ingresar()
        {
            AdministracionDB db = new AdministracionDB();
            return db.AgregarUsuario(this);
        }
    }
}