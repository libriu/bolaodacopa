using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BolaoInfra.Exception
{
    public class BolaoException: ApplicationException
    {
        public static BolaoException LoginInvalido { get { return new BolaoException("Login inválido"); } }
        public static BolaoException UsuarioInativo { get { return new BolaoException("Usuário inativo"); } }
        public static BolaoException SenhaIncorreta { get { return new BolaoException("Senha incorreta"); } }
        public static BolaoException HashSenhaInvalido { get { return new BolaoException("Erro ao verificar hash de senha"); } }
        public static BolaoException LoginUtilizado { get { return new BolaoException("Nome/Login já utilizado por outro usuário"); } }
        public static BolaoException JogoInvalido { get { return new BolaoException("Jogo inválido"); } }
        public static BolaoException JogoOcorrido { get { return new BolaoException("Não é possível fazer aposta em jogo já ocorrido"); } }
        public static BolaoException JogoDoDia { get { return new BolaoException("Não é possível fazer aposta em jogo do dia"); } }

        public static BolaoException RemocaoResponsavelGrupoNaoPermitido { get { return new BolaoException("Não é permitido remover o responsável pelo grupo"); } }

        public string Mensagem { get; set; }

        public ApplicationException Ex { get; set; }

        public BolaoException()
        {

        }

        public BolaoException(string mensagem)
        {
            Mensagem = mensagem;
        }

        public BolaoException(string mensagem, ApplicationException ex)
        {
            Mensagem = mensagem;
            Ex = ex;
        }
    }

}
