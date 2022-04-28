using System;
using System.Collections.Generic;

namespace BolaoInfra.Models
{
    public partial class Aposta
    {
        public int CodApostador { get; set; }
        public int CodJogo { get; set; }
        public int PlacarA { get; set; }
        public int PlacarB { get; set; }
        public long? Pontos { get; set; }

        public virtual Apostador Apostador { get; set; }
        public virtual Jogo Jogo { get; set; }
    }
}
