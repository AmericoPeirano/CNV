using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using BoletadeVentas.Data;

namespace BoletadeVentas.Class
{
    public class ReporteDB
    {
        
        
        public IQueryable<NegocioReporte> GetDatos()
        {
            var query = new ReporteDataContext();
            return query.NOTV_control.Join(query.NOTV_DB,
                nc => nc.nota_venta, nd => nd.NUMNOTA,

                (nc, nd) => new

                {
                    NOTV_control = nc,
                    NOTV_DB = nd  
                                
                }).Join(query.CLIEN_DB,
                     nd => nd.NOTV_DB.NRUTCLIE, 
                                                        
                     cl => cl.NREGUIST,
                     (nd, cl) => new { NOTV_DB = nd, CLIEN_DB = cl }).Where(
                     nd => nd.NOTV_DB.NOTV_control.Sup_Estado != 3 && 
                                                                             
                           nd.NOTV_DB.NOTV_control.Bod_Estado ==6 &&
                           nd.NOTV_DB.NOTV_control.Fac_Estado == 1
                           
                     ).Select        
                                   (n => new NegocioReporte()

                {
                    Nota = (int)n.NOTV_DB.NOTV_control.nota_venta, 

                    Cliente = n.CLIEN_DB.RAZSOC,
                    FechaRecibido =((DateTime)n.NOTV_DB.NOTV_control.Bod_fecha_Pendiente).ToShortDateString(),
                    FechaEntrega = ((DateTime)n.NOTV_DB.NOTV_control.Bod_fecha_Terminado).ToShortDateString(),
                    Obs = n.NOTV_DB.NOTV_control.Observaciones
                });
        }


        public IQueryable<NegocioReporte> ReportePorDepartamentos(NegocioReporte neg)
        { 
            
            var datos = new ReporteDataContext();

            return datos.NOTV_control.Where
                (nc => nc.Sup_Estado !=3 && nc.Fac_Estado!=null).Select(
                nc => new NegocioReporte()
                {
                    TiempoSupervision = ((DateTime)nc.Sup_fecha_Termino == null ? DateTime.Now : (DateTime)nc.Sup_fecha_Termino)
                    - ((DateTime)nc.Sup_fecha_Aprobacion == null ? DateTime.Now : (DateTime)nc.Sup_fecha_Aprobacion),
                    TiempoBodega = ((DateTime)nc.Bod_fecha_Terminado == null ? DateTime.Now : 
                    (DateTime)nc.Bod_fecha_Terminado) - ((DateTime)nc.Bod_fecha_Preparacion==null ? DateTime.Now :
                    (DateTime)nc.Bod_fecha_Preparacion),
                    TiempoFacturacion =((DateTime)nc.Fac_fecha_Facturado==null ? DateTime.Now
                    : (DateTime)nc.Fac_fecha_Facturado) - ((DateTime)nc.Fac_fecha_Por_Facturar==null ? DateTime.Now :
                    (DateTime)nc.Fac_fecha_Por_Facturar),
                    TiempoLaboratorio = ((DateTime)nc.Lab_fecha_Revisado==null ? DateTime.Now :
                    (DateTime)nc.Lab_fecha_Revisado) - ((DateTime)nc.Lab_fecha_PorRevisar==null ? DateTime.Now :
                    (DateTime)nc.Lab_fecha_PorRevisar),
                    TiempoDespacho = ((DateTime)nc.Des_fecha_Despacho == null ? DateTime.Now :
                    (DateTime)nc.Des_fecha_Despacho) - ((DateTime)nc.Des_fecha_Pendiente == null ? DateTime.Now :
                    (DateTime)nc.Des_fecha_Por_Despachar),                    
                    Nota =(int)nc.nota_venta

                }

            );
        }
    }
}