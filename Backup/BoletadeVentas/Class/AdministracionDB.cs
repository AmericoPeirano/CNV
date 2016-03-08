using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using BoletadeVentas.Data.AdministracionTableAdapters;

namespace BoletadeVentas.Class
{
    public class AdministracionDB
    {
        private NOTV_DepartamentosTableAdapter depa = new NOTV_DepartamentosTableAdapter();
        private NOTV_AreaLoginTableAdapter perfil = new NOTV_AreaLoginTableAdapter();
        private Agregar_UsuarioTableAdapter ingresar = new Agregar_UsuarioTableAdapter();

        public DataTable ObtenerDepas()
        {
            return depa.GetData();
        }

        public DataTable Busqueda(Administracion adm)
        {
            return perfil.GetDatos(adm.Nombre);
        }

        public DataTable AgregarUsuario(Administracion adm)
        {
            return ingresar.GetData(adm.Nombre,adm.Permiso,adm.Clave,adm.Eliminado);
        }
    }
}