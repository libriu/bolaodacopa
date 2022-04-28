using System;
using System.Collections.Generic;

namespace BolaoInfra.Models
{
    public partial class Grupo
    {
        public Grupo()
        {
            Apostadores = new HashSet<Apostador>();
        }

        public int CodGrupo { get; set; }
        public string Nome { get; set; }
        public int CodApostResponsavel { get; set; }

        public virtual Apostador ApostadorResponsavel { get; set; }

        public virtual ICollection<Apostador> Apostadores { get; set; }
    }
}
