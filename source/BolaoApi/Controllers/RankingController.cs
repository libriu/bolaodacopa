using BolaoInfra.BLL;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BolaoApi.Controllers
{
    public class RankingController : BolaoController
    {
        [AllowAnonymous]
        [HttpGet]
        public IActionResult Index()
        {
            var bll = new RankingBLL();
            var ranking = bll.GetAll();

            return Ok(ranking);
        }

        [HttpGet("my")]
        public IActionResult GetMyInfo()
        {
            var bll = new RankingBLL();
            var myRanking = bll.GetByApostador(UsuarioAutenticado.CodApostador);
            return Ok(myRanking);
        }

        [AllowAnonymous]
        [HttpGet("bybetter")]
        public IActionResult GetByBetter(int codApostador)
        {
            var bll = new RankingBLL();
            var ranking = bll.GetByApostador(codApostador);
            return Ok(ranking);
        }

        [AllowAnonymous]
        [HttpGet("bygroup")]
        public IActionResult GetByGroup(int codGrupo)
        {
            var bll = new RankingBLL();
            var ranking = bll.GetByGroup(codGrupo);

            return Ok(ranking);
        }
    }
}
