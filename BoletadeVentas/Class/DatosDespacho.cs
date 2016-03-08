using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using BoletadeVentas.Data.Notas_ControlTableAdapters;
using BoletadeVentas.Data.PersonalTableAdapters;

namespace BoletadeVentas.Class
{
    public class DatosDespacho
    {
        private Notas_DespachoTableAdapter Despacho = new Notas_DespachoTableAdapter();
        private TrabajadoresTableAdapter perso = new TrabajadoresTableAdapter();
        private NOTV_controlTableAdapter control = new NOTV_controlTableAdapter();
        private QueriesTableAdapter terminar = new QueriesTableAdapter();

        public DataTable TraerAlDespacho()
        {
            return Despacho.GetData();
        }

        public DataTable Despachador()
        {
            return perso.GetPersonal();
        }

        public void terminarDespacho(NegocioDespacho neg)
        {
            terminar.TerminarDespacho(neg.Nota);

        }
        public DataTable traerConductores()
        {
            return perso.GetConductores();
        }

        public void AsignarConductor(NegocioDespacho neg)
        {
            control.UpdateConductorFecha(neg.Fecha,neg.Conductor,neg.Nota);
        }


        public void UpdateOk(NegocioDespacho neg)
        {
            control.UpdateOk(neg.Nota);
        }

        public void Reprogramar(NegocioDespacho neg)
        {
            control.Reprogramar(neg.Nota);
        }

        public void AgregarDespachador(NegocioDespacho neg)
        {
            control.AsignarDespachador(neg.Despachador,neg.Nota);
        }

        public void AsignaryTerminarNota(NegocioDespacho neg)
        {
            int valor = control.AsignayTermina(neg.Despachador,neg.Nota);
        }
    }
}