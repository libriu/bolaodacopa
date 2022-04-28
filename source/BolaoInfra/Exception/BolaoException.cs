using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BolaoInfra.Exception
{
    public class BolaoException: ApplicationException
    {
        public int CodErro { get; set; }
        public string Mensagem { get; set; }

        public ApplicationException Ex { get; set; }

        public BolaoException()
        {

        }

        public BolaoException(int codErro, string mensagem)
        {
            CodErro = codErro;
            Mensagem = mensagem;
        }

        public BolaoException(int codErro, string mensagem, ApplicationException ex)
        {
            CodErro = codErro;
            Mensagem = mensagem;
            Ex = ex;
        }
    }
}
