using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;

namespace BoletadeVentas
{
    public partial class Formulario_web1 : System.Web.UI.Page
    {
        Class.Negocio neg = new Class.Negocio();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    lblMensaje.Visible = false;
                    DataTable dt = neg.UsuariosValidos();
                    foreach (DataRow dr in dt.Rows)
                    {
                        ddlUsers.Items.Add(dr[0].ToString());
                    }
                }
                catch (Exception ex) 
                {
                    RegistrarError(ex.ToString(), "Page_Load", "pagina");
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                neg.Usuario = ddlUsers.SelectedItem.ToString();
                neg.Pass = txtPass.Text;
                DataTable dt = neg.ValidaUsuario();
                                                 
                if (dt.Rows.Count==0)              
                {
                    lblMensaje.Visible = true;     
                    return;
                }

                Session["Origen"] = "Login";
                Session["PERMISO"] = dt.Rows[0]["Id"].ToString();
                                                                      
                Session["DEPARTAMENTO"] = dt.Rows[0]["nombre"].ToString();
                FormsAuthentication.RedirectFromLoginPage(ddlUsers.SelectedItem.ToString(),true);

            }
            catch (Exception ex) 
            {

                RegistrarError(ex.ToString(), "Button1_Click", "Button1");
            }
        }

        private void RegistrarError(string excepcion,
           string metodo,
           string control)
        {
            Class.NegocioError error = new Class.NegocioError();
            error.Usuario = User.Identity.Name;
            error.Pagina = NombrePagina();
            error.Control = control;
            error.Error = excepcion;
            error.Metodo = metodo;
            error.RegistrarError();
        }

        private string NombrePagina()
        {
            try
            {
                string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
                String result = arrResult[arrResult.GetUpperBound(0)];
                arrResult = result.Split('?');
                return arrResult[arrResult.GetLowerBound(0)];
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }
    }
}