using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Services;
using System.Web.Security;
using System.Web.UI.WebControls;
using BoletadeVentas.Class;
using System.Data;

namespace BoletadeVentas
{
    public partial class Formulario_web13 : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Origen"] = "Despacho";
            try
            {

                if (!IsPostBack)
                {
                  
                    LlenarGrilla();
                    Llenarconductores();
                    LlenarDespachadores();
                    auxiliarBoton.Visible = false;
                    if (Session["PERMISO"].ToString() == "5" || Session["PERMISO"].ToString() == "4" || Session["PERMISO"].ToString() == "3" || Session["PERMISO"].ToString() == "2" || Session["PERMISO"].ToString() == "6")
                    {
                        
                        lbInforme.Enabled = false;
                        acusete.Enabled = false;
                    }


                }
            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(),
                     "Page_Load",
                     "Pagina");
            }
        }

        private void LlenarGrilla()
        {
            try
            {
                NegocioDespacho negd = new NegocioDespacho();
                lblPermiso.Text = Session["DEPARTAMENTO"] + " - " + User.Identity.Name;
                DataTable dt = negd.TraerDespacho();
                gvDespacho.DataSource = dt;
                gvDespacho.DataBind();
                ViewState["Source"] = dt;
            }
            catch (Exception ex)
            {

                RegistrarError(ex.ToString(),
                    "LlenarGrilla",
                    "gvDespacho");
            }
        }

        private void Llenarconductores()
        {
            try
            {
                NegocioDespacho negd = new NegocioDespacho();
                DataTable dtC = negd.Conductores();
                ddl_Conductores.Items.Clear();
                ddl_Conductores.Items.Add(string.Empty);
                foreach (DataRow dr in dtC.Rows)
                {
                    ddl_Conductores.Items.Add(dr["NOMBRE"].ToString() + ' ' + dr["APELLIDO"].ToString());
                }
            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(),
                    "Llenarconductores",
                    "ddl_Conductores");
            }
        }

        protected void gvDespacho_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                NegocioDespacho negd = new NegocioDespacho();


                if (e.Row.RowType == DataControlRowType.DataRow)
                {

                    ImageButton imgB = new ImageButton();
                    ImageButton imgBOK = new ImageButton();
                    Label lbldoc = new Label();
                    Label lblSector = new Label();
                    Label nota = new Label();
                    Label despachador = new Label();
                    LinkButton lb = new LinkButton();


                    nota = (Label)e.Row.FindControl("lblNota");
                    imgB = (ImageButton)e.Row.FindControl("imgBEstado");
                    imgBOK = (ImageButton)e.Row.FindControl("imgReci");
                    lb = (LinkButton)e.Row.FindControl("lbFecha");
                    lbldoc = (Label)e.Row.FindControl("lblDocto");
                    lblSector = (Label)e.Row.FindControl("lblcomunaSector");
                    despachador = (Label)e.Row.FindControl("lblDespa");


                    ValidarCeldas(e, imgB, imgBOK, lbldoc, lblSector, lb, nota, despachador);
                }
            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(),
                    "gvDespacho_RowDataBound",
                    "gvDespacho");

            }
        }

        private void ValidarCeldas(GridViewRowEventArgs e,
            ImageButton imgB,
            ImageButton imgBOK,
            Label lbldoc,
            Label lblSector,
            LinkButton lb,
            Label n,
            Label desp) // evento validar celdas al inicio
        {
            try
            {
                if (lblSector.Text == "Oficina,Oficina")
                {
                    lb.Text = "Oficina";
                    lb.Enabled = false;
                } // se agrego el primer if 

                if (String.IsNullOrEmpty(lb.Text) || lb.Text=="En Espera...")
                {
                    imgB.Attributes.Add("onclick", "return false;");
                }
                else
                {
                    if (String.IsNullOrEmpty(desp.Text) && Session["PERMISO"].ToString() != "6")
                    {
                        imgB.Attributes.Add("onclick","Reprogramar('"+n.Text+"');return false");
                    }
                    else if ( Session["PERMISO"].ToString() != "6")
                    {
                        imgB.Attributes.Add("onclick", "AbrirConfirmar('" + n.Text + "','" + lblSector.Text + "','" + desp.Text + "');return false");
                    }
                    else
                    {
                        imgB.Attributes.Add("onclick","return false;");
                    }
                }
                if (imgBOK.ImageUrl != "~/Imagenes/OK.png")
                {
                    lb.Visible = false;
                }
                else
                {
                    if (lblSector.Text != "Oficina,Oficina")
                    {
                        lb.Attributes.Add("onclick", "AbrirFormFecha('" + n.Text + "','" + lblSector.Text + "');return false");
                    }
                    else
                    {
                        lb.Attributes.Add("onclick","AsignarFechaOficina('"+n.Text+"');return false");
                    }
                }
                if (String.IsNullOrEmpty(lbldoc.Text))
                {
                    imgBOK.Enabled = false;
                }
   
               
                if (lblSector.Text == "Oficina,Oficina")
                {
                    imgB.ImageUrl = "~/Imagenes/office.png";

                }
                switch (Session["PERMISO"].ToString())
                {
                    case "1":
                        if (!String.IsNullOrEmpty(lb.Text) && lb.Text != "En Espera...")
                        {
                            imgB.Attributes.Remove("onclick");
                            if ((imgB.ImageUrl == "~/Imagenes/T.png" && String.IsNullOrEmpty(desp.Text))
                                || imgB.ImageUrl == "~/Imagenes/office.png")
                            {
                                imgB.Attributes.Add("onclick", "abrirDespacho('" + n.Text + "','" + lblSector.Text + "');return false");
                            }
                            else
                            {

                                imgB.Attributes.Add("onclick", "return false;");
                                if (String.IsNullOrEmpty(desp.Text))
                                {
                                    imgB.Attributes.Add("onclick", "Reprogramar('" + n.Text + "');return false");
                                }
                                else
                                {
                                    imgB.Attributes.Add("onclick", "AbrirConfirmar('" + n.Text + "','" + lblSector.Text + "','" + desp.Text + "');return false");
                                }
                            }

                        }
                        if (lblSector.Text == "Oficina,Oficina")
                        {
                            lb.Text = "Oficina";
                            lb.Enabled = false; //sobre el break se agrego del caso 1
                        }
                            break;
                       
                   
                    case "2":
                        lb.Attributes.Remove("onclick");
                        lb.Attributes.Add("onclick", "return false;");
                        imgB.Attributes.Remove("onclick");
                        if (!String.IsNullOrEmpty(lb.Text) && lb.Text != "En Espera...")
                        {
                            if (Session["PERMISO"].ToString() != "5" && Session["PERMISO"].ToString() != "6")
                            {
                                if ((imgB.ImageUrl == "~/Imagenes/T.png" && String.IsNullOrEmpty(desp.Text))
                                    || imgB.ImageUrl == "~/Imagenes/office.png")
                                {
                                    imgB.Attributes.Add("onclick", "abrirDespacho('" + n.Text + "','" + lblSector.Text + "');return false");
                                }
                                else
                                {
                                    imgB.Attributes.Add("onclick", "return false;");
                                }
                            }
                            else
                            {
                                imgB.Attributes.Add("onclick", "return false;");
                            }
                        }
                        else
                        {
                            imgB.Attributes.Add("onclick", "return false;");
                        }
                        if (lblSector.Text == "Oficina,Oficina")
                        {
                            lb.Text = "Oficina";
                            lb.Enabled = false;
                        }  // y sobre el break del caso 2 
                        imgBOK.Attributes.Remove("onclick");
                        imgBOK.Attributes.Add("onclick", "return false;");
                        imgB.Enabled = true;
                        imgBOK.Enabled = false;
                        lb.Enabled = false;
                        break;
                    case "3":
                        lb.Attributes.Remove("onclick");
                        lb.Attributes.Add("onclick", "return false;");
                        imgB.Attributes.Remove("onclick");
                        imgB.Attributes.Add("onclick", "return false;");
                        imgBOK.Attributes.Remove("onclick");
                        imgBOK.Attributes.Add("onclick", "return false;");
                        imgB.Enabled = false;
                        imgBOK.Enabled = false;
                        lb.Enabled = false;
                        break;
                    case "4":
                        lb.Attributes.Remove("onclick");
                        lb.Attributes.Add("onclick", "return false;");
                        imgB.Attributes.Remove("onclick");
                        imgB.Attributes.Add("onclick", "return false;");
                        imgBOK.Attributes.Remove("onclick");
                        imgBOK.Attributes.Add("onclick", "return false;");
                        imgB.Enabled = false;
                        imgBOK.Enabled = false;
                        lb.Enabled = false;
                        break;
                    case "5":
                        if(String.IsNullOrEmpty(desp.Text))
                        {
                        imgB.Attributes.Add("onclick", "return false;");
                        }
                            break;
                    case "6":
                        //lb.Attributes.Remove("onclick");
                        lb.Attributes.Add("onclick", "return false;");
                        //imgB.Attributes.Remove("onclick");
                        imgB.Attributes.Add("onclick", "return false;");
                       // imgBOK.Attributes.Remove("onclick");
                        imgBOK.Attributes.Add("onclick", "return false;");
                        imgB.Enabled = false;
                        imgBOK.Enabled = false;
                        lb.Enabled = false;
                        break;
                    //case "8":
                    //    lb.Attributes.Remove("onclick");
                    //    lb.Attributes.Add("onclick", "return false;");
                    //    imgB.Attributes.Remove("onclick");
                    //    if (!String.IsNullOrEmpty(lb.Text) && lb.Text != "En Espera...")
                    //    {
                    //        if (Session["PERMISO"].ToString() != "5" && Session["PERMISO"].ToString() != "6")
                    //        {
                    //            if ((imgB.ImageUrl == "~/Imagenes/T.png" && String.IsNullOrEmpty(desp.Text))
                    //                || imgB.ImageUrl == "~/Imagenes/office.png")
                    //            {
                    //                imgB.Attributes.Add("onclick", "abrirDespacho('" + n.Text + "','" + lblSector.Text + "');return false");
                    //            }
                    //            else
                    //            {
                    //                imgB.Attributes.Add("onclick", "return false;");
                    //            }
                    //        }
                    //        else
                    //        {
                    //            imgB.Attributes.Add("onclick", "return false;");
                    //        }
                    //    }
                    //    else
                    //    {
                    //        imgB.Attributes.Add("onclick", "return false;");
                    //    }
                    //    if (lblSector.Text == "Oficina,Oficina")
                    //    {
                    //        lb.Text = "Oficina";
                    //        lb.Enabled = false;
                    //    }  // y sobre el break del caso 2 
                    //    imgBOK.Attributes.Remove("onclick");
                    //    imgBOK.Attributes.Add("onclick", "return false;");
                    //    imgB.Enabled = true;
                    //    imgBOK.Enabled = false;
                    //    lb.Enabled = false;
                    //    break;
                  
                }
                e.Row.Cells[9].CssClass = "Calendario";
            }
            catch (Exception ex)
            {
                Formulario_web13 fw = new Formulario_web13();
                fw.RegistrarError(ex.ToString(),
                    "ValidarCeldas",
                    "gvDespacho");

            }
        }



        protected void gvDespacho_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                string c = e.CommandArgument.ToString();
                switch (e.CommandName.ToString())
                {

                    case "Okcommand":
                        NegocioDespacho negd = new NegocioDespacho();
                        negd.Nota = Convert.ToInt32(e.CommandArgument.ToString());
                        negd.ActualizarOk();
                        RegistrarLog(negd.Nota, "OK", "NV Recibida en area de despacho");
                        LlenarGrilla();
                        

                        break;

                }
            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(),
                    "gvDespacho_RowCommand",
                    "gvDespacho");
            }
        }
        protected void btnContin_Click(object sender, EventArgs e)
        {
            try
            {
                string fecha = FechaDespacho.Text;
                if (String.IsNullOrEmpty(fecha))
                {
                    fecha = DateTime.Now.ToString();
                }
                NegocioDespacho des = new NegocioDespacho();
                des.Conductor = ddl_Conductores.SelectedItem.Text;
                des.Nota = Convert.ToInt32(Session["nota"].ToString());
                des.Fecha = Convert.ToDateTime(fecha);
                des.AsignarFechaConductor();
                limpiar();
                LlenarGrilla();
            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(),
                    "btnContin_Click",
                    "btnContin");
            }

        }
        private void limpiar()
        {
            try
            {
                FechaDespacho.Text = string.Empty;
                Llenarconductores();
            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(),
                    "limpiar",
                    "Pagina");
            }
        }
        private void LlenarDespachadores()
        {
            try
            {
                NegocioDespacho negd = new NegocioDespacho();
                DataTable dt = negd.Despachadores();
                ddl_Desp.Items.Add(string.Empty);
                foreach (DataRow dr in dt.Rows)
                {
                    ddl_Desp.Items.Add(dr["NOMBRE"].ToString() + " " + dr["APELLIDO"].ToString());
                }
            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(), "LlenarDespachadores()","pagina");
            }
        }
        protected void gvDespacho_Sorting(object sender, GridViewSortEventArgs e)
        {
            try
            {

                DataTable dt = ViewState["Source"] as DataTable;
                DataView dv = new DataView(dt);
                object o = ViewState["Orden"];
                if (o == null)
                {
                    dv.Sort = e.SortExpression + " " + "ASC";
                    ViewState["Orden"] = "ASC";

                }
                else
                {
                    if (ViewState["Orden"].ToString() == "ASC")
                    {
                        dv.Sort = e.SortExpression + " " + "DESC";
                        ViewState["Orden"] = "DESC";

                    }
                    else
                    {
                        dv.Sort = e.SortExpression + " " + "ASC";
                        ViewState["Orden"] = "ASC";
                    }
                }

                gvDespacho.DataSource = dv;
                gvDespacho.DataBind();
            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(),
                    "gvDespacho_Sorting",
                    "gvDespacho");
            }
        }
        [WebMethod()]
        public static void AsignarConductor(string Nota, string fecha, string conductor)
        {
            Formulario_web13 fw = new Formulario_web13();
            int nvv = Convert.ToInt32(Nota);
            try
            {
                
                NegocioDespacho negd = new NegocioDespacho();
                negd.Conductor = conductor;
                negd.Nota = Convert.ToInt32(Nota);
                negd.Fecha = Convert.ToDateTime(fecha);
                negd.AsignarFechaConductor();
                fw.RegistrarLog(nvv, "Asignar", "Se asigna conductor");
            }
            catch(Exception ex)
            {
                
                fw.RegistrarError(ex.ToString(), "AsignarConductor","Pagina");
            }
        }
        [WebMethod()]
        public static bool RecibeCliente(string Nota)//termina despacho
        {
            Formulario_web13 fw = new Formulario_web13();
            int nvv = Convert.ToInt32(Nota);
            try
            {
                NegocioDespacho negd = new NegocioDespacho();
                negd.Nota = Convert.ToInt32(Nota);
                fw.RegistrarLog(nvv, "Terminar", "Se termina el Despacho");
                negd.Terminardespacho();
                
                return true;
            }
            catch (Exception ex) {
                
                fw.RegistrarError(ex.ToString(), "RecibeCliente", "Pagina");
                return false;
            }
        }
        [WebMethod()]
        public static void ReprogramarNota(string Nota)
        {
            Formulario_web13 fw = new Formulario_web13();
            int nvv = Convert.ToInt32(Nota);
            try
            {
                NegocioDespacho negd = new NegocioDespacho();
                negd.Nota = Convert.ToInt32(Nota);
                fw.RegistrarLog(nvv, "Reprograma", "Se Reprograma el despacho");
                negd.ReprogramarNota();
                
            }
            catch (Exception ex)
            {
                
                fw.RegistrarError(ex.ToString(), "ReprogramarNota","pagina");
            }
        }
        [WebMethod()]
        public static bool AsignarDespachador(string nota,string despachador,string opc)//termina despacho
        {
            Formulario_web13 fw = new Formulario_web13();
            int nvv = Convert.ToInt32(nota);
            try
            {
                NegocioDespacho negd = new NegocioDespacho();
                negd.Despachador = despachador;
                negd.Nota = Convert.ToInt32(nota);

                switch (opc)
                {
                    case "1":
                
                negd.AsignarDespachador();
                fw.RegistrarLog(nvv,"Asigna","Se Asigna Despachador");
                break;
                    case "2":
                negd.AsignaryTerminar();
                fw.RegistrarLog(nvv, "Asigna", "Se Asigna Despachador y se termina (Desp.Oficina)");
                break;
                }
                return true;
            }
            catch (Exception ex) {
                
                fw.RegistrarError(ex.ToString(), "AsignarDespachador", "pagina");
                return false;
            }
        }
        [WebMethod()]
        public static bool AsignarFechaOficina(string nota)
        {
            Formulario_web13 fw = new Formulario_web13();
            int nvv = Convert.ToInt32(nota);
            try
            {
                NegocioDespacho negd = new NegocioDespacho();
                negd.Nota = Convert.ToInt32(nota);
                negd.Fecha = DateTime.Now;
                negd.Conductor = null;
                negd.AsignarFechaConductor();
                fw.RegistrarLog(nvv,"Asigna","Se Asigna Fecha a Despacho en Oficina");
                return true;
            }
            catch (Exception ex) {
                
                fw.RegistrarError(ex.ToString(), "AsignarFechaOficina", "pagina");
                return false;
            }

        }
        protected void btnInicio_Click(object sender, EventArgs e)
        {
            Response.Redirect("Detalle Boleta.aspx",false);
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
        private void RegistrarError(string excepcion,   string metodo, string control)
        {
            NegocioError error = new NegocioError();
            error.Usuario = User.Identity.Name;
            error.Pagina = NombrePagina();
            error.Control = control;
            error.Error = excepcion;
            error.Metodo = metodo;
            error.RegistrarError();
        }
        private void RegistrarLog(int nv, string accion, string descripcion)
        {
            NegocioLOG log = new NegocioLOG();
            log.nv = nv;
            log.usuario = User.Identity.Name;
            log.accion = accion;
            log.descripcion = descripcion;
            log.RegistrarLog();
        }
        protected void btnAux_Click(object sender, EventArgs e)
        {
            LlenarGrilla();
        }
        protected void cambio_Click(object sender, EventArgs e)
        {
            Response.Redirect("Detalle Boleta.aspx",false);
        }
        protected void auxiliarBoton_Click(object sender, EventArgs e)
        {
            try
            {
                ActualizarTabla();
                LlenarGrilla();
            }
            catch(Exception ex){

                RegistrarError(ex.ToString(), "auxiliarBoton_Click", "auxiliarBoton");
            }
        }
        protected void ActualizarTabla()
        {
            try
            {
                Negocio neg = new Negocio();
                neg.Documento_Actualizar();
            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(), "ActualizarTabla", "pagina");
            }
        }
        protected void imgBCerrar_Click(object sender, ImageClickEventArgs e)
        {
            Session.Abandon();
            Response.Redirect("login.aspx",false);
            RegistrarLog(0,"LogOUT","Se finaliza session en despacho");
        }
        protected void lbInforme_Click(object sender, EventArgs e)
        {
            Response.Redirect("Informe_Departamentos.aspx", false);
        }              
        protected void acusete_Click(object sender, EventArgs e)
        {
            Response.Redirect("Acusete.aspx", false);
        }
        protected void gvDespacho_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}