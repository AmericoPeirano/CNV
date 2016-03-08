using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BoletadeVentas.Class;
using System.Data;

namespace BoletadeVentas
{
    public partial class Formulario_web15 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    LlenarDepartamentos();
                    lblMensaje.Visible = false;
                }
            }
            catch (Exception ex)
            {
                string var = ex.Message;
            }

        }

        private void LlenarDepartamentos()
        {
            Administracion adm = new Administracion();
            DataTable dt = adm.Depas();
            ddlDep.Items.Add(string.Empty);
            foreach (DataRow dr in dt.Rows)
            {   
                ddlDep.Items.Add(dr["Nombre"].ToString());
            }
            
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtUsuario.Text == string.Empty ||
                    txtPass.Text == string.Empty ||
                    ddlDep.SelectedValue == string.Empty)
                {
                    return;
                }
                Administracion adm = new Administracion();
                adm.Clave = txtPass.Text;
                adm.Nombre = txtUsuario.Text;
                adm.Permiso = ddlDep.SelectedValue;
                if(chkBloqueado.Checked)
                {
                    adm.Eliminado = 1;
                }else{

                    adm.Eliminado = 0;
                }
             DataTable dt=adm.Ingresar();
             if (dt.Rows.Count > 0)
             {
                 lblEstado.Text = dt.Rows[0][0].ToString();
             }
                
            }
            catch (Exception ex) { string var = ex.Message; }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtUsuario.Text == string.Empty)
                {
                    return;
                }

                Administracion adm = new Administracion();
                adm.Nombre = txtUsuario.Text;
                DataTable dt = adm.ObtenerDatos();
                if (dt.Rows.Count == 0)
                {
                    lblMensaje.Visible = true;
                    return;
                }

                txtPass.Text = dt.Rows[0]["clave"].ToString();
                ddlDep.SelectedItem.Text = dt.Rows[0]["nombre"].ToString();
                if (dt.Rows[0]["Eliminado"].ToString() != "0")
                {
                    chkBloqueado.Checked = true;
                }

            }
            catch (Exception ex) { string var = ex.Message; }
        }
    }
}