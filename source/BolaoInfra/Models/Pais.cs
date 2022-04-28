using System;
using System.Collections.Generic;

namespace BolaoInfra.Models
{
    public partial class Pais
    {
        public Pais()
        {
            JogosA = new HashSet<Jogo>();
            JogosB = new HashSet<Jogo>();
        }

        public int CodPais { get; set; }
        public string Nome { get; set; }
        public string Arquivo { get; set; }

        public virtual ICollection<Jogo> JogosA { get; set; }
        public virtual ICollection<Jogo> JogosB { get; set; }
    }
}
