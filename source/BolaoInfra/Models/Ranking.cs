using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace BolaoInfra.Models
{
    public partial class Ranking
    {
        public int CodApostador { get; set; }
        public long TotalPontos { get; set; }
        public long TotalAcertos { get; set; }

        [NotMapped] 
        public int Posicao { get; set; }

        public virtual Apostador Apostador { get; set; }
    }
}
