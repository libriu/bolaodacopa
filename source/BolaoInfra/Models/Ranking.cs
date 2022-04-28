using System;
using System.Collections.Generic;

namespace BolaoInfra.Models
{
    public partial class Ranking
    {
        public int CodApostador { get; set; }
        public long TotalPontos { get; set; }
        public long TotalAcertos { get; set; }

        public virtual Apostador Apostador { get; set; }
    }
}
