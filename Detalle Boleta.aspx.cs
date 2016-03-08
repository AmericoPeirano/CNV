﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;
using System.Drawing;
using BoletadeVentas.Class;
namespace BoletadeVentas
{
    public partial class Formulario_web12 : System.Web.UI.Page
    {
        Negocio neg = new Negocio();
        private string imgEsup;
        private string imgEbod;
        private string imgFac;
        private string imgLab;
       

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.MaintainScrollPositionOnPostBack = true;

                if (!IsPostBack)
                {
                    switch (Convert.ToInt32(Session["PERMISO"].ToString()))
                    {
                        case 1:
                            ModSup.Visible = true;
                            ModBod.Visible = true;
                            ModFac.Visible = true;
                            ModLab.Visible = true;
                            pForzar.Visible = true;
                            break;
                        case 2:
                            ModSup.Visible = false;
                            ModBod.Visible = true;
                            ModFac.Visible = false;
                            ModLab.Visible = false;
                            break;
                        case 3:
                            ModSup.Visible = false;
                            ModBod.Visible = false;
                            ModFac.Visible = false;
                            ModLab.Visible = true;
                            break;
                        case 4:
                            ModSup.Visible = false;
                            ModBod.Visible = false;
                            ModFac.Visible = true;
                            ModLab.Visible = false;
                            break;
                        case 5:
                            Response.Redirect("Despacho.aspx",false);
                            break;
                    }
                    VerificarParcial();
                    OrganizarGrilla();
           

                }
            }
            catch (Exception ex) {
                RegistrarError(ex.ToString(), "Page_Load", "Pagina");
            }
           
            
        }

        private void OrganizarGrilla()
        {
            try
            {
             
                lblPermiso.Text =Session["DEPARTAMENTO"]+" - "+User.Identity.Name;
                ViewState["Filtro"] = 0;
           
                        DataTable dtGrid = new DataTable();
                        dtGrid.Columns.Add("Nota");
                        dtGrid.Columns.Add("tipo");
                        dtGrid.Columns.Add("Vendedor");
                        dtGrid.Columns.Add("Cliente");
                        dtGrid.Columns.Add("Fecha");
                        dtGrid.Columns.Add("FSuper");
                        dtGrid.Columns.Add("imagenEsup");
                        dtGrid.Columns.Add("FBode");
                        dtGrid.Columns.Add("imagenEbode");
                        dtGrid.Columns.Add("Flab");
                        dtGrid.Columns.Add("imagenElab");
                        dtGrid.Columns.Add("Ffac");
                        dtGrid.Columns.Add("imagenEfac");
                        DataTable dt = neg.TraerNotas();
                        if (dt.Rows.Count == 0)
                        {
                            return;
                        }
                        foreach (DataRow dr in dt.Rows)
                        {
                          
                            imgEbod = null;
                            imgEsup = null;
                            imgFac = null;
                            imgLab = null;
                            switch (Convert.ToInt32(dr["Sup_estado"]))
                            {
                                case 1:
                                    imgEsup = "~/Imagenes/Question.png";

                                    break;
                                case 2:
                                    switch (Convert.ToInt32(dr["Bod_estado"]))
                                    {
                                        case 1:
                                            imgEsup = "~/Imagenes/img_check.png";
                                            break;
                                        case 4:
                                            imgEsup = "~/Imagenes/icon-green-check.png";
                                            imgEbod = "~/Imagenes/lab.png";
                                            if (dr["Lab_estado"].ToString() == "6")
                                            {
                                                imgLab = "~/Imagenes/img_check.png";
                                            }
                                            break;
                                        case 5:
                                            imgEsup = "~/Imagenes/icon-green-check.png";
                                            imgEbod = "~/Imagenes/img_check.png";
                                            if (dr["Lab_estado"].ToString() == "3")
                                            {
                                                imgLab = "~/Imagenes/icon-green-check.png";
                                            }
                                            break;
                                        case 6:
                                            imgEbod = "~/Imagenes/icon-green-check.png";
                                            imgEsup = "~/Imagenes/icon-green-check.png";
                                            if (dr["Lab_estado"].ToString() == "3")
                                            {
                                                imgLab = "~/Imagenes/icon-green-check.png"; 
                                            }
                                            break;
                                    }
                                    if (dr["Fac_Estado"].ToString() != string.Empty)
                                    {
                                        switch (Convert.ToInt32(dr["Fac_Estado"]))
                                        {
                                            case 1:
                                                imgEbod = "~/Imagenes/fac.png";
                                                break;
                                            case 2:
                                                imgFac = "~/Imagenes/img_check.png";
                                                break;
                                            case 6:
                                                imgFac ="~/Imagenes/img_check.png";
                                                break;
                                        }
                                    }


                                    break;
                                case 4://si el estado es 4 entonces la imagen sera otra.
                                    imgEsup = "~/Imagenes/servicio.png";
                                   
                                    break;
                            }

                            dtGrid.Rows.Add(dr["Nota"].ToString(),
                                dr["tipoNota"].ToString(),
                                dr["Vendedor"].ToString(),
                                dr["Cliente"].ToString(),
                                ValidaFecha(dr[3].ToString()),
                                ValidaFecha(dr["Llegada"].ToString()),
                                imgEsup,
                                ValidaFecha(dr["Sup_fecha_Aprobacion"].ToString()),
                                imgEbod,
                                ValidaFecha(dr["Bod_fecha_laboratorio"].ToString()),
                                imgLab,
                                ValidaFecha(dr["Fac_fecha_pendiente"].ToString()),
                                imgFac);

                        }

                        gvNotas.DataSource = dtGrid;
                        gvNotas.DataBind();

            }
            catch (Exception ex) {
                RegistrarError(ex.ToString(),"OrganizarGrilla","gvNotas");      
            
            }
        }


         public string ValidaFecha(string fecha)
        {
            try
            {
                if (fecha == string.Empty)
                {
                    return fecha;
                }
                else
                {
                    return fecha.Substring(0, 10);
                }
            }catch(Exception ex){
                RegistrarError(ex.ToString(),"ValidaFecha","gvNotas");
                return ex.ToString();
            }
        }

         protected void gvNotas_RowDataBound(object sender, GridViewRowEventArgs e)
         {
             try
             {

                 if (e.Row.RowType == DataControlRowType.DataRow)
                 {
                     Label nota = (Label)e.Row.FindControl("lblNota");
                     e.Row.Attributes.Add("onclick", "javascript:Observaciones('" + nota.Text + "')");
                     ImageButton imgSup = (ImageButton)e.Row.FindControl("imagenEsup2");
                     ImageButton imgBod = (ImageButton)e.Row.FindControl("imagenEBod");
                     ImageButton imgALab = (ImageButton)e.Row.FindControl("imagenELab");
                     ImageButton imgAFac = (ImageButton)e.Row.FindControl("imagenEFac");
                     if (Convert.ToInt32(ViewState["Filtro"]) == 1)
                     {                                             
                         imgAFac.Enabled = false;
                         imgALab.Enabled = false;
                         imgSup.Enabled = false;
                         imgBod.Enabled = false;
                     }
                     else
                     {
                         switch (Convert.ToInt32(Session["PERMISO"].ToString()))
                         {
                             case 2:
                                 imgSup.Enabled = false;
                                 imgALab.Enabled = false;
                                 imgAFac.Enabled = false;
                                 break;
                             case 3:
                                 imgSup.Enabled = false;
                                 imgBod.Enabled = false;
                                 imgAFac.Enabled = false;
                                 break;
                             case 4:
                                 imgSup.Enabled = false;
                                 imgALab.Enabled = false;
                                 imgBod.Enabled = false;
                                 break;
                         }
                         if (imgSup.ImageUrl != "~/Imagenes/servicio.png")//aki se agrego 
                         {
                             ValidarEventosBodega(nota, imgBod, imgALab, imgSup);
                             ValidarEventosSupervisor(nota, imgSup);
                             ValidarEventosLaboratorio(nota, imgBod, imgALab);
                             ValidarEventosFactura(nota, imgAFac, imgBod);
                         }
                         else// si imagen es igual a la de servicio entonces deshabilito las imagenes.
                         {
                             imgAFac.Enabled = false;
                             imgALab.Enabled = false;
                             imgSup.Enabled = false;
                             imgBod.Enabled = false;
                         }
                     }
                 }
             }
             catch (Exception ex) {
                 RegistrarError(ex.ToString(), "gvNotas_RowDataBound", "gvNotas");
             }
            
         }

         private void ValidarEventosFactura(Label nota, 
             ImageButton imgAFac, 
             ImageButton imgBod)
         {
             try
             {
                 if (imgBod.ImageUrl == "~/Imagenes/fac.png")
                 {
                     imgAFac.Attributes.Add("onclick", "Recibir('" + nota.Text + "','3');return false");
                 }
                 else
                 {
                     imgAFac.Attributes.Add("onclick", "return false;");
                 }
             }
             catch (Exception ex) {
                 RegistrarError(ex.ToString(),"ValidarEventosFactura","gvNotas");
             }
         }

         private void ValidarEventosLaboratorio(Label nota, 
             ImageButton imgBod, 
             ImageButton imgALab)
         {
             try
             {
                 if (imgALab.ImageUrl == "~/Imagenes/img_check.png")
                 {
                     imgALab.Attributes.Add("onclick", "Recibir('" + nota.Text + "','4');return false");
                 }
                 else
                 {
                     if (imgBod.ImageUrl == "~/Imagenes/lab.png")
                     {
                         imgALab.Attributes.Add("onclick", "Recibir('" + nota.Text + "','2');return false");
                     }
                     else
                     {
                         imgALab.Attributes.Add("onclick", "return false;");
                     }
                 }
             }
             catch (Exception ex) {
                 RegistrarError(ex.ToString(),"ValidarEventosLaboratorio","gvNotas");
             
             }

         }

         private void ValidarEventosSupervisor(Label nota, ImageButton imgSup)
         {
             try
             {
                 if (imgSup.ImageUrl == "~/Imagenes/Question.png")
                 {
                     imgSup.Attributes.Add("onclick", "SupRecibido('" + nota.Text + "');return false");
                 }
                 else
                 {
                     imgSup.Attributes.Add("onclick", "return false;");
                 }
             }
             catch (Exception ex) {
                 RegistrarError(ex.ToString(), "ValidarEventosSupervisor","gvNotas");
             }
         }

         private void ValidarEventosBodega(Label nota, 
             ImageButton imgBod, 
             ImageButton imgALab,
             ImageButton imgASup)
         {
             try
             {
                 if (imgBod.ImageUrl == "~/Imagenes/img_check.png")
                 {
                     if (imgALab.ImageUrl == "~/Imagenes/icon-green-check.png")
                     {
                         imgBod.Attributes.Add("onclick", "Bod_EnvioFactura('" + nota.Text + "');return false");
                     }
                     else
                     {
                         imgBod.Attributes.Add("onclick", "Bod_Envio('" + nota.Text + "');return false");
                     }
                 }
                 else
                 {
                     if (imgASup.ImageUrl == "~/Imagenes/img_check.png")
                     {
                         imgBod.Attributes.Add("onclick", "Recibir('" + nota.Text + "','1');return false");
                     }
                     else
                     {
                         imgBod.Attributes.Add("onclick", "return false;");
                     }
                 }
             }
             catch (Exception ex) {
                 RegistrarError(ex.ToString(), "ValidarEventosBodega", "gvNotas");
             }
         }

         protected void gvNotas_PageIndexChanging(object sender, GridViewPageEventArgs e)
         {
             try
             {
                 gvNotas.PageIndex = e.NewPageIndex;
                 OrganizarGrilla();
             }
             catch (Exception ex) {
                 RegistrarError(ex.ToString(), "gvNotas_PageIndexChanging", "gvNotas");
             }
         }

         #region Filtros
         protected void sinFiltros_Click(object sender, EventArgs e)
         {
             try
             {
                 ViewState["Filtro"] = 0;
                 OrganizarGrilla();
             }
             catch (Exception ex)
             {
                 RegistrarError(ex.ToString(),"sinFiltros_Click","sinFiltros");
             }
         }

         protected void btnFiltrar_Click(object sender, EventArgs e)
        {

            try
            {
                DataTable dt = neg.FiltrarParciales();
                ViewState["Filtro"] = 0;
                GrillaFiltro(dt);
            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(), "btnFiltrar_Click", "btnFiltrar");
            }
        }
        protected void btnInicio_Click(object sender, EventArgs e)
        {
            try
            {
                ViewState["Filtro"] = 0;
                OrganizarGrilla();

            }
            catch(Exception ex)
            {
                RegistrarError(ex.ToString(), "btnInicio_Click", "btnInicio");
            }
        }
        protected void btnBodega_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = neg.FiltroOpc(2);
                ViewState["Filtro"] = 0;
                GrillaFiltro(dt);
            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(), "btnBodega_Click", "btnBodega");
            }
        }
        protected void btnLab_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = neg.FiltroOpc(3);
                ViewState["Filtro"] = 0;
                GrillaFiltro(dt);
            }
            catch(Exception ex)
            {
                RegistrarError(ex.ToString(), "btnLab_Click", "btnLab");
            }

        }
        protected void Listar_Eliminadas(object sender, EventArgs e)
        {
            try
            {
                Negocio neg = new Negocio();
                DataTable dt = neg.FiltroOpc(6);
                ViewState["Filtro"] = 1;
                GrillaFiltro(dt);
            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(),"Listar_Eliminadas","Fltro Eliminadas");
            }
        }
        protected void btnFactura_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = neg.FiltroOpc(4);
                ViewState["Filtro"] = 0;
                GrillaFiltro(dt);
            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(), "btnFactura_Click", "btnFactura");
            }
        }

        public void GrillaFiltro(DataTable dt)
        {
            try
            {
                DataTable dtGrid = new DataTable();
                dtGrid.Columns.Add("Nota");
                dtGrid.Columns.Add("tipo");
                dtGrid.Columns.Add("Vendedor");
                dtGrid.Columns.Add("Cliente");
                dtGrid.Columns.Add("Fecha");
                dtGrid.Columns.Add("FSuper");
                dtGrid.Columns.Add("imagenEsup");
                dtGrid.Columns.Add("FBode");
                dtGrid.Columns.Add("imagenEbode");
                dtGrid.Columns.Add("Flab");
                dtGrid.Columns.Add("imagenElab");
                dtGrid.Columns.Add("Ffac");
                dtGrid.Columns.Add("imagenEfac");


                foreach (DataRow dr in dt.Rows)
                {

                    string imgEbod = null;
                    string imgEsup = null;
                    string imgFac = null;
                    string imgLab = null;
                    switch (Convert.ToInt32(dr["Sup_estado"]))
                    {
                        case 1:
                            imgEsup = "~/Imagenes/Question.png";
                            break;
                        case 2:
                            switch (Convert.ToInt32(dr["Bod_estado"]))
                            {
                                case 1:
                                    imgEsup = "~/Imagenes/img_check.png";
                                    break;
                                case 4:
                                    imgEsup = "~/Imagenes/icon-green-check.png";
                                    imgEbod = "~/Imagenes/lab.png";
                                    if (dr["Lab_estado"].ToString() == "6")
                                    {
                                        imgLab = "~/Imagenes/img_check.png";
                                    }
                                    break;
                                case 5:
                                    imgEsup = "~/Imagenes/icon-green-check.png";
                                    imgEbod = "~/Imagenes/img_check.png";
                                    if (dr["Lab_estado"].ToString() == "3")
                                    {
                                        imgLab = "~/Imagenes/icon-green-check.png";
                                    }
                                    break;
                                case 6:
                                    imgEbod = "~/Imagenes/icon-green-check.png";
                                    imgEsup = "~/Imagenes/icon-green-check.png";
                                    if (dr["Lab_estado"].ToString() == "3")
                                    {
                                        imgLab = "~/Imagenes/icon-green-check.png";
                                    }
                                    break;
                            }
                            if (dr["Fac_Estado"].ToString() != string.Empty)
                            {
                                switch (Convert.ToInt32(dr["Fac_Estado"]))
                                {
                                    case 1:
                                        imgEbod = "~/Imagenes/fac.png";
                                        break;
                                    case 2:
                                        imgFac = "~/Imagenes/img_check.png";
                                        break;
                                    case 6:
                                        imgFac = "~/Imagenes/img_check.png";
                                        break;
                                }
                            }
                            break;
                    }

                    dtGrid.Rows.Add(dr["Nota"].ToString(),
                        dr["tipoNota"].ToString(),
                        dr["Vendedor"].ToString(),
                        dr["Cliente"].ToString(),
                        ValidaFecha(dr[3].ToString()),
                        ValidaFecha(dr["Llegada"].ToString()),
                        imgEsup,
                        ValidaFecha(dr["Sup_fecha_Aprobacion"].ToString()),
                        imgEbod,
                        ValidaFecha(dr["Bod_fecha_laboratorio"].ToString()),
                        imgLab,
                        ValidaFecha(dr["Fac_fecha_pendiente"].ToString()),
                        imgFac);
                }
                gvNotas.DataSource = dtGrid;
                gvNotas.DataBind();
            }
            catch (Exception ex) 
            {
                RegistrarError(ex.ToString(), "GrillaFiltro", "gvNotas");
            }
        }
            #endregion 
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

        private void RegistrarError(string excepcion,
            string metodo,
            string control)
        {
            NegocioError error = new NegocioError();
            error.Usuario = User.Identity.Name;
            error.Pagina = NombrePagina();
            error.Control = control;
            error.Error = excepcion;
            error.Metodo = metodo;
            error.RegistrarError();
        }

        protected void nventa_Click(object sender, EventArgs e)
        {
            try
            {
                neg.ActualizarNotas();
                OrganizarGrilla();
            }
            catch (Exception ex) 
            {
                RegistrarError(ex.ToString(), "nventa_Click", "nventa");
            }
        }

        protected void lbAux_Click(object sender, EventArgs e)
        {
            try
            {
                OrganizarGrilla();
            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(), "lbAux_Click", "lbAux");
            }
        }

        protected void CambiarForm_Click(object sender, EventArgs e)
        {
            try
            {
                neg.Documento_Actualizar();
                Response.Redirect("Despacho.aspx",false);
            }
            catch (Exception ex) 
            {
                RegistrarError(ex.ToString(), "CambiarForm_Click", "CambiarForm");
            }
        }

        private void VerificarParcial()
        {
            try
            {
                neg.VerificarParciales();

            }
            catch(Exception ex)
            {
                RegistrarError(ex.ToString(), "VerificarParcial", "Pagina");
            }

        }

        #region WebMethods LLamados con Ajax

        [WebMethod()]
        public static string TraerPreparadores()
        {
            try
            {
                Negocio neg = new Negocio();
                DataTable dt = neg.llenarPreparadores();
                string json = string.Empty;
                json = "[";
                foreach (DataRow dr in dt.Rows)
                {
                    json += "{";
                    json += "\"id\" : \"" + dr["NUMREG"].ToString() + "\",";
                    json += "\"nombre\":\"" + dr["Nombre"].ToString() + " " + dr["APELLIDO"].ToString() + "\"";
                    json += "},";
                }
                json = json.Substring(0, json.Length - 1);
                json += "]";
                return json;
            }
            catch (Exception ex)
            {

                Formulario_web12 fw = new Formulario_web12();
                fw.RegistrarError(ex.ToString(), "TraerPreparadores","SDesp");
                return "[]";
            }
        }

        [WebMethod()]
        public static string TraerComunas()
        {
            try
            {
                Negocio neg = new Negocio();
                DataTable dt = neg.Comunas();
                string json = string.Empty;
                json = "[";
                foreach (DataRow dr in dt.Rows)
                {
                    json += "{";
                    json += "\"idsector\": \"" + dr["sector"].ToString() + "\",";
                    json += "\"nombre\":\"" + dr["nombre"].ToString() + "\"";
                    json += "},";

                }
                json = json.Substring(0, json.Length - 1);
                json += "]";
                return json;
            }
            catch (Exception ex)
            {
                Formulario_web12 fw = new Formulario_web12();
                fw.RegistrarError(ex.ToString(), "TraerComunas", "SComunas");
                return "[]";
            }
        }

        [WebMethod()]
        public static bool AprobarSup(string NotaProceso,
            string comuna,
            string sector,
            string obs)
        {
            try
            {
                Negocio neg = new Negocio();
                neg.Nota = Convert.ToInt32(NotaProceso);
                neg.Sector = Convert.ToInt32(sector);
                neg.Obs = obs;
                neg.Comuna = comuna;
                neg.ActualizarSupE();

                return true;
            }
            catch (Exception ex)
            {
                Formulario_web12 fw = new Formulario_web12();
                fw.RegistrarError(ex.ToString(), "AprobarSup", "Pagina");
                return false;
            }

        }

        [WebMethod()]
        public static bool PorcesoNotaLab(string NotaProceso)
        {
            try
            {
                Negocio neg = new Negocio();
                neg.Nota = Convert.ToInt32(NotaProceso);
                neg.actualizaLabE();
                return true;
            }
            catch (Exception ex)
            {
                Formulario_web12 fw = new Formulario_web12();
                fw.RegistrarError(ex.ToString(), "PorcesoNotaLab", "Pagina");
                return false;
            }
        }
        [WebMethod()]
        public static bool RecibirNota(string NotaProceso, string opc)
        {
            try
            {
                Negocio neg = new Negocio();
                neg.Nota = Convert.ToInt32(NotaProceso);
                switch (Convert.ToInt32(opc))
                {
                    case 1:// Recibe Bodega
                        neg.actualizarBodE();
                        break;
                    case 2://recibe o Aprueba Lab
                        neg.actualizarLabRecibido();
                        break;
                    case 3://Recibe Factura
                        neg.FacturacionRecibe();
                        break;
                    case 4://Devolver de Laboratorio a Bodega
                        neg.RevisadoL();
                        break;
                }
                return true;
            }
            catch (Exception ex)
            {
                Formulario_web12 fw = new Formulario_web12();
                fw.RegistrarError(ex.ToString(), "RecibirNota", "gvNotas");
                return false;
            }
        }
        [WebMethod()]
        public static bool FacturarNota(string NotaProceso,
            string bc,
            string bm,
            string bg,
            string Prep,
            string obs)
        {
            try
            {
                Negocio neg = new Negocio();
                neg.Nota = Convert.ToInt32(NotaProceso);
                neg.Bultop = Convert.ToInt32(bc);
                neg.Bultosm = Convert.ToInt32(bm);
                neg.Bultosg = Convert.ToInt32(bg);
                neg.Obs = obs;
                neg.Preparador = Prep;
                neg.EnvioFacturacion();

                return true;
            }
            catch (Exception ex)
            {
                Formulario_web12 fw = new Formulario_web12();
                fw.RegistrarError(ex.ToString(), "FacturarNota", "Pagina");
                return false;
            }
        }

        [WebMethod()]
        public static string TraerAprobadas(string opc)
        {

            try
            {
                string json = string.Empty;
                Negocio neg = new Negocio();
                DataTable dt = neg.FiltroOpc(Convert.ToInt32(opc));
                json = "[";
                foreach (DataRow dr in dt.Rows)
                {
                    json += "{";
                    json += "\"nota\":\"" + dr["nota_venta"] + "\"";
                    json += "},";
                }
                json = json.Substring(0, json.Length - 1);
                json += "]";
                return json;
            }
            catch (Exception ex)
            {
                Formulario_web12 fw = new Formulario_web12();
                fw.RegistrarError(ex.ToString(), "TraerAprobadas", "Pagina");
                return "[]";
            }
        }
        [WebMethod()]
        public static bool Desaprobar(string opc, List<string> nota)
        {
            try
            {
                for (int i = 0; i < nota.Count; i++)
                {
                    Negocio neg = new Negocio();
                    neg.Nota = Convert.ToInt32(nota[i]);
                    neg.ModificarNota(Convert.ToInt32(opc));

                }
                return true;
            }
            catch (Exception ex)
            {
                Formulario_web12 fw = new Formulario_web12();
                fw.RegistrarError(ex.ToString(), "Desaprobar", "Pagina");
                return false;
            }
        }
        [WebMethod()]
        public static string Observaciones(string nota)
        {
            try
            {
                Negocio neg = new Negocio();
                neg.Nota = Convert.ToInt32(nota);
                return neg.TraerObs();
            }
            catch (Exception ex)
            {
                Formulario_web12 fw = new Formulario_web12();
                fw.RegistrarError(ex.ToString(), "Observaciones", "ipObsSup");
                return ex.ToString();
            }
        }
        #endregion

        protected void adm_usu_Click(object sender, EventArgs e)
        {
            Response.Redirect("Administrar.aspx",false);
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx",false);
        }

        protected void btnForzar_Click(object sender, EventArgs e)
        {
            try
            {
                if (String.IsNullOrEmpty(txtForzar.Text))
                {
                    return;
                }
                int res = 0;
                if (!int.TryParse(txtForzar.Text,out res))
                {
                    return;
                }

                neg.Nota = Convert.ToInt32(txtForzar.Text);
                neg.Forzar();
                OrganizarGrilla();

            }
            catch (Exception ex)
            {
                RegistrarError(ex.ToString(), "btnForzar_Click", "btnForzar");
            }
        }

    }
}