using System;
using System.Collections.Generic;

namespace BolaoInfra.Models
{
    public partial class Mensagem
    {
        public int CodMensagem { get; set; }
        public int CodApostador { get; set; }
        public DateTime DataHora { get; set; }
        public string Texto { get; set; }

        public virtual Apostador Apostador { get; set; }
    }
}
