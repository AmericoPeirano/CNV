using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data.Sql;


namespace BoletadeVentas
{
    public partial class Acusete : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnClicLab_Click(object sender, EventArgs e)
        {
            int cant =0;
            SqlConnection cone = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["GL_GROUPConnectionString"].ToString());
            SqlCommand command = new SqlCommand("Update notv_control set Lab_Estado=3,Bod_estado=5 where Lab_Estado=1 and Sup_Estado<>3", cone);
            cone.Open();
                 SqlDataReader reader = command.ExecuteReader();
                 while (reader.Read())
                 {
                    cant++;
                 }
                 //if (cant>0)
                 //{
                 //    lbl1.text = "";
                 //}

                 cone.Close();
                 Response.Redirect("Detalle Boleta.aspx", false);
        }

        protected void btnClickFac_Click(object sender, EventArgs e)
        {
            int cant = 0;
            SqlConnection cone = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["GL_GROUPConnectionString"].ToString());
            SqlCommand command = new SqlCommand("Update notv_control set Fac_Estado=6 where Fac_Estado=1 and Sup_Estado<>3", cone);
            cone.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                cant++;
            }
            //if (cant>0)
            //{
            //    lbl1.text = "";
            //}

            cone.Close();
            Response.Redirect("Detalle Boleta.aspx", false);
        }

        protected void btnClickBod_Click(object sender, EventArgs e)
        {
            int cant = 0;
            SqlConnection cone = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["GL_GROUPConnectionString"].ToString());
            SqlCommand command = new SqlCommand("Update notv_control set Bod_Estado=2 where Bod_Estado=1 and Sup_Estado<>3", cone);
            cone.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                cant++;
            }
            //if (cant>0)
            //{
            //    lbl1.text = "";
            //}

            cone.Close();
            Response.Redirect("Detalle Boleta.aspx", false);
        }

        protected void btnClickDes_Click(object sender, EventArgs e)
        {
            int cant = 0;
            SqlConnection cone = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["GL_GROUPConnectionString"].ToString());
            SqlCommand command = new SqlCommand("Update notv_control set Checked='OK' where Des_Estado=1 and  Numero_factura_o_Guia is not null and Numero_factura_o_Guia is not null and Sup_Estado<>3 and Checked is null", cone);
            cone.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                cant++;
            }
            //if (cant>0)
            //{
            //    lbl1.text = "";
            //}

            cone.Close();
            Response.Redirect("Detalle Boleta.aspx", false);
        }

        protected void btnClickSup_Click(object sender, EventArgs e)
        {
            int cant = 0;
            SqlConnection cone = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["GL_GROUPConnectionString"].ToString());
            SqlCommand command = new SqlCommand("Update notv_control set Sup_Estado=2,Bod_Estado=1 where Sup_Estado=1 and Sup_Estado<>3", cone);
            cone.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                cant++;
            }
            //if (cant>0)
            //{
            //    lbl1.text = "";
            //}

            cone.Close();
            Response.Redirect("Detalle Boleta.aspx", false);
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Despacho.aspx", false);
        }

        //protected void lblDet_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("Detalle Boleta.aspx", false);
        //}
        //protected void lblDes_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("Despacho.aspx", false);
        //}
    }
}