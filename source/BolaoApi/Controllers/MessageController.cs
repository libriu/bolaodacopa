using BolaoInfra.BLL;
using BolaoInfra.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BolaoApi.Controllers
{
    public class MessageController : BolaoController
    {
        [AllowAnonymous]
        public IActionResult Index()
        {
            var bll = new MensagemBLL();
            var mensagens = bll.GetAll();

            return Ok(mensagens);
        }

        [HttpPost()]
        public IActionResult Insert(Mensagem mensagem)
        {

            var bll = new MensagemBLL();
            mensagem.CodApostador = UsuarioAutenticado.CodApostador;
            bll.Insert(mensagem);

            return Ok();
            
        }

    }
}
