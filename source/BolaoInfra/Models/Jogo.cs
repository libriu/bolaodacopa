using System;
using System.Collections.Generic;

namespace BolaoInfra.Models
{
    public partial class Jogo
    {
        public int CodJogo { get; set; }
        public DateTime DataHora { get; set; }
        public string Grupo { get; set; }
        public byte JaOcorreu { get; set; }
        public int RPlacarA { get; set; }
        public int RPlacarB { get; set; }
        public int CodPaisA { get; set; }
        public int CodPaisB { get; set; }

        public bool IsBetVisibleToOthers { get
            {
                return DataHora.Date <= DateTime.Today;
            } 
        }

        public virtual Pais PaisA { get; set; }
        public virtual Pais PaisB { get; set; }
        public virtual ICollection<Aposta> Apostas { get; set; }
    }
}
