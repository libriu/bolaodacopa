using System;
using System.Collections.Generic;

namespace BolaoInfra.Models
{
    public partial class Apostador
    {
        public Apostador()
        {
            Apostas = new HashSet<Aposta>();
            GruposResponsavel = new HashSet<Grupo>();
            ApostadoresAtivados = new HashSet<Apostador>();
            Mensagens = new HashSet<Mensagem>();
            Grupos = new HashSet<Grupo>();
        }

        public int CodApostador { get; set; }
        public string Login { get; set; }
        public string Contato { get; set; }
        public string Email { get; set; }
        public string Senha { get; set; }
        public int? CodApostAtivador { get; set; }
        public byte Ativo { get; set; }
        public string Celular { get; set; }
        public byte AcessoGestaoTotal { get; set; }
        public byte AcessoAtivacao { get; set; }
        public string Cidade { get; set; }

        public string IdPagamento { get; set; }

        public virtual Apostador ApostadorAtivador { get; set; }
        public virtual Ranking Ranking { get; set; }
        public virtual ICollection<Aposta> Apostas { get; set; }
        public virtual ICollection<Grupo> GruposResponsavel { get; set; }
        public virtual ICollection<Mensagem> Mensagens { get; set; }

        public virtual ICollection<Apostador> ApostadoresAtivados { get; set; }

        public virtual ICollection<Grupo> Grupos { get; set; }
    }
}
