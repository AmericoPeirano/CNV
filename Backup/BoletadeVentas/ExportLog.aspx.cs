using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BoletadeVentas
{
    public partial class ExportLog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Formulario_web12 fw = new Formulario_web12();
            string nn = fw.n;
            Label1.Text = nn;
            Response.ContentType = "application/vnd.ms-excel";
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Page.EnableViewState = false;
            Response.AddHeader("Content-Disposition", "attachment;filename=Log_CNV_" + DateTime.Now.ToShortDateString().ToString() + ".xls");

        }

        protected void laalalalalal(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}