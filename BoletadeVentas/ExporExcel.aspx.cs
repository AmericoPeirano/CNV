using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Drawing;
namespace BoletadeVentas
{
    public partial class ExporExcel : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            //*****
            Response.ContentType = "application/vnd.ms-excel";
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Page.EnableViewState = false;
            DateTime dt = DateTime.Now;
            Response.AddHeader("Content-Disposition", "attachment;filename=CNV_"+ DateTime.Now.ToShortDateString() +"__" +DateTime.Now.ToShortTimeString()+ ".xls");
            //****
         
        }
        protected void SYSGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //Color xColor = new Color();

                #region sup_estado
                //pendientes
                if(e.Row.Cells[2].Text == "1")
                {
                    e.Row.Cells[2].BackColor = Color.Red;
                    e.Row.Cells[2].ForeColor = Color.Red;
                }
                //listos
                if (e.Row.Cells[2].Text == "3" || e.Row.Cells[2].Text == "2" || e.Row.Cells[2].Text == "4")
                {
                    e.Row.Cells[2].BackColor = Color.Green;
                    e.Row.Cells[2].ForeColor = Color.Green;
                }
                #endregion

                #region bod_estado
                if (e.Row.Cells[5].Text == " ")
                {
                    e.Row.Cells[5].BackColor = Color.White;
                    e.Row.Cells[5].ForeColor = Color.White;
                }
                // pendientes
                if (e.Row.Cells[5].Text == "1" )
                 {
                    e.Row.Cells[5].BackColor = Color.Red;
                    e.Row.Cells[5].ForeColor = Color.Red;
                 }
                if (e.Row.Cells[5].Text == "5" || e.Row.Cells[5].Text == "4")
                {
                    e.Row.Cells[5].BackColor = Color.Yellow;
                    e.Row.Cells[5].ForeColor = Color.Yellow;
                }

                if (e.Row.Cells[5].Text == "6" )
                {
                    e.Row.Cells[5].BackColor = Color.Green;
                    e.Row.Cells[5].ForeColor = Color.Green;
                }

                #endregion 

                #region lab_estado
                if (e.Row.Cells[11].Text == " ")
                {
                    e.Row.Cells[11].BackColor = Color.White;
                    e.Row.Cells[11].ForeColor = Color.White;
                }
                if (e.Row.Cells[11].Text == "1")
                {
                    e.Row.Cells[11].BackColor = Color.Red;
                    e.Row.Cells[11].ForeColor = Color.Red;
                }
                if (e.Row.Cells[11].Text == "6")
                {
                    e.Row.Cells[11].BackColor = Color.Yellow;
                    e.Row.Cells[11].ForeColor = Color.Yellow;
                }
                if (e.Row.Cells[11].Text == "3")
                {
                    e.Row.Cells[11].BackColor = Color.Green;
                    e.Row.Cells[11].ForeColor = Color.Green;
                }
                #endregion

                #region fac_estado
                if (e.Row.Cells[15].Text == " ")
                {
                    e.Row.Cells[15].ForeColor = Color.White;

                }
                if (e.Row.Cells[15].Text == "1" || e.Row.Cells[15].Text == " ")
                {
                    e.Row.Cells[15].BackColor = Color.Red;
                    e.Row.Cells[15].ForeColor = Color.Red;
                }
                if (e.Row.Cells[15].Text == "6" && (e.Row.Cells[29].Text == " " || e.Row.Cells[30].Text == " "))
                {
                    e.Row.Cells[15].BackColor = Color.Yellow;
                    e.Row.Cells[15].ForeColor = Color.Yellow;
                }
                    
                    if (e.Row.Cells[15].Text == "6" && (e.Row.Cells[29].Text != " " || e.Row.Cells[30].Text != " "))
                {
                    e.Row.Cells[15].BackColor = Color.Green;
                    e.Row.Cells[15].ForeColor = Color.Green;
                }
                              
                #endregion

                #region Des_estado
                    if (e.Row.Cells[19].Text == " ")
                    {
                        e.Row.Cells[19].BackColor = Color.White;
                        e.Row.Cells[19].ForeColor = Color.White;
                    }
                    
                    if (e.Row.Cells[19].Text == "1" && (e.Row.Cells[31].Text == " " && (e.Row.Cells[29].Text == " " || e.Row.Cells[30].Text == " ")))
                    {
                        e.Row.Cells[19].BackColor = Color.Red;
                        e.Row.Cells[19].ForeColor = Color.Red;
                    }

                    if (e.Row.Cells[19].Text == "1" && (e.Row.Cells[31].Text != " " && (e.Row.Cells[29].Text != " " || e.Row.Cells[30].Text != " ")))
                    {
                        e.Row.Cells[19].BackColor = Color.Yellow;
                        e.Row.Cells[19].ForeColor = Color.Yellow;

                    }
                    if (e.Row.Cells[19].Text == "3")
                    {
                        e.Row.Cells[19].BackColor = Color.Green;
                        e.Row.Cells[19].ForeColor = Color.Green;
                    }


                    #endregion

                #region comentada

                ////faltan
                //if (e.Row.Cells[2].Text == "1" || (e.Row.Cells[5].Text == "1" || e.Row.Cells[5].Text == " ") || (e.Row.Cells[11].Text == "1" || e.Row.Cells[11].Text == " ")||
                //    (e.Row.Cells[15].Text == "1" || e.Row.Cells[15].Text == " ") || ((e.Row.Cells[19].Text == "1" || e.Row.Cells[19].Text == " ") && e.Row.Cells[31].Text == " " && 
                //    (e.Row.Cells[29].Text == " " || e.Row.Cells[30].Text == " ")))
                //{
                //  xColor = Color.Red;
                //  e.Row.Cells[29].BackColor = Color.SkyBlue;
                //  e.Row.Cells[30].BackColor = Color.SkyBlue;
                //  e.Row.Cells[31].BackColor = Color.SkyBlue;

                //}
                ////listos
                //if (e.Row.Cells[2].Text == "2" || e.Row.Cells[2].Text == "3" || e.Row.Cells[2].Text == "4" ||
                //    e.Row.Cells[5].Text == "6" || e.Row.Cells[11].Text == "3" || (e.Row.Cells[15].Text == "6" && (e.Row.Cells[29].Text != " " || e.Row.Cells[30].Text != " ")) ||
                //    e.Row.Cells[19].Text == "3"|| (e.Row.Cells[19].Text == "1" && e.Row.Cells[31].Text != " " && (e.Row.Cells[29].Text != " " || e.Row.Cells[30].Text != " ")))
                    
                //{
                //  xColor = Color.Green;
                //  e.Row.Cells[29].BackColor = Color.White;
                //  e.Row.Cells[30].BackColor = Color.White;
                //  e.Row.Cells[31].BackColor = Color.White;
                //}

                ////intermedios
                //if (e.Row.Cells[5].Text == "2" || e.Row.Cells[5].Text == "4" || e.Row.Cells[11].Text == "6" )
                //{
                //    xColor = Color.Yellow;
                //}


              
                //e.Row.Cells[2].BackColor = xColor;
                ////e.Row.Cells[2].ForeColor = xColor;
                //e.Row.Cells[5].BackColor = xColor;
                ////e.Row.Cells[5].ForeColor = xColor;
                //e.Row.Cells[11].BackColor = xColor;
                ////e.Row.Cells[11].ForeColor = xColor;
                //e.Row.Cells[15].BackColor = xColor;
                ////e.Row.Cells[15].ForeColor = xColor;
                //e.Row.Cells[19].BackColor = xColor;
                //e.Row.Cells[19].ForeColor = xColor;
                
                //5,11,15,19,[29,30(fac)], 31(ok),
#endregion
            }
        }

        #region 
        //private void ExportToExcel()
        //{

        //    StringBuilder sb = new StringBuilder(); 
        //    StringWriter sw = new StringWriter(sb);
        //    HtmlTextWriter hw = new HtmlTextWriter(sw);
        //    gvExcel.AllowPaging = false;
        //    GetResult();
        //    Response.Clear();
        //    Response.Buffer = true;
        //    Response.AddHeader("content-disposition", "attachment;filename=CNV_" + DateTime.Now.ToShortDateString().ToString() + ".xls");
        //    Response.Charset = "";
        //    Response.ContentType = "application/vnd.ms-excel";
        //    //Change the Header Row back to white color
        //    gvExcel.HeaderRow.Style.Add("background-color", "#FFFFFF");

        //    //Apply style to Individual Cells
        //    for (int index = 0; index < gvExcel.Columns.Count; index++)
        //    {
        //        gvExcel.HeaderRow.Cells[index].Style.Add("background-color", "#5D7B9D");
        //    }

        //    for (int count = 0; count < gvExcel.Rows.Count; count++)
        //    {
        //        GridViewRow row = gvExcel.Rows[count];
        //        //Change Color back to white
        //        row.BackColor = System.Drawing.Color.White;
        //        //Apply text style to each Row
        //        row.Attributes.Add("class", "textmode");
        //        //Apply style to Individual Cells of Alternating Row
        //        if (count % 2 != 0)
        //        {
        //            for (int index = 0; index < gvExcel.Columns.Count; index++)
        //            {
        //                row.Cells[index].Style.Add("background-color", "#C2D69B");
        //            }
        //        }
        //    }
        //    gvExcel.RenderControl(hw);
        //    Response.Output.Write(sw.ToString());
        //    Response.Flush();
        //    Response.End();
        //}

        //public void   GetResult(GridView wControls)
        //{   
        //    DataSet dataset = new DataSet();
        //    SqlConnection conec = new SqlConnection(ConfigurationManager.ConnectionStrings["GL_GROUPConnectionString"].ToString());
            
        //        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
        //        cmd.Connection= conec;
        //        cmd.CommandText = "SELECT nota_venta,Fecha,Sup_Estado,Sup_fecha_Pendiente,"
        //    +"Sup_fecha_Aprobacion,Sup_fecha_Termino,Bod_Estado,Bod_fecha_Pendiente,Bod_fecha_Preparacion" 
        //    +",Bod_fecha_Terminado,Bod_fecha_Laboratorio,Preparador,Lab_Estado,Lab_fecha_pendiente,"
        //    +"Lab_fecha_PorRevisar,Lab_fecha_Revisado,Fac_Estado,Fac_fecha_Pendiente,Fac_fecha_Por_Facturar,"
        //    +"Fac_fecha_Facturado,Des_Estado,Des_fecha_Pendiente,Des_fecha_Por_Despachar,Des_fecha_Despacho"
        //    +",Sector,Tipo,Bultos_pequeños,Bultos_medianos,Bultos_grandes,Conductor,Numero_factura_o_Guia,"
        //    +"Numero_factura_o_Guia1,Checked,Despachador,Observaciones,Sektor,Disponible,TipoDoc "
        //    +"FROM NOTV_control WHERE (nota_venta > 26830) ORDER BY nota_venta DESC";
        //        conec.Open();
        //        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
        //        adapter.Fill(dataset);
        //        conec.Close();                    

        //    DataSet ds = dataset; // Updated
        //    if (ds != null)
        //    {
        //        if (ds.Tables[0].Rows.Count != 0)
        //        {
        //            gvExcel.DataSource = ds;
        //            gvExcel.DataBind();
        //        }
                
        //    }
        //}

        #endregion
    }
}