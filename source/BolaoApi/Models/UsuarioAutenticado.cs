namespace BolaoApi.Models
{
    public class UsuarioAutenticado
    {
        public int CodApostador { get; set; }
        public string Login { get; set; }
        public bool IsAcessoGestaoTotal { get; set; }
        public bool IsAcessoAtivacao { get; set; }

        public bool IsAcessoGestaoTotalOuAtivacao
        {
            get
            {
                return IsAcessoGestaoTotal || IsAcessoAtivacao;
            }
        }

    }
}
