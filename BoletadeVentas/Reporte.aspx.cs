using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BoletadeVentas.Class;

namespace BoletadeVentas
{
    public partial class Formulario_web16 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) CargarReporte();
        }

        protected void CargarReporte()
        {
            NegocioReporte report = new NegocioReporte();
            var data =
                new Microsoft.
                    Reporting.
                    WebForms.
                    ReportDataSource("dsBodega",
                    report.prueba());
            ReportViewer1.LocalReport.ReportPath = "ReporteBodega.rdlc";

            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(data);
            ReportViewer1.LocalReport.Refresh();
        }
    }
}