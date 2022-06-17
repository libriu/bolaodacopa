using BolaoApi.Controllers;
using BolaoInfra.BLL;
using BolaoInfra.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace BolaoApi.Controllers
{
    public class GameController : BolaoController
    {

        [HttpPost()]
        public IActionResult Insert(List<Jogo> jogos)
        {
            if (UsuarioAutenticado.IsAcessoGestaoTotal)
            {
                var bll = new JogoBLL();

                bll.Insert(jogos);

                return Ok();
            }
            return BadRequest(new { message = "Erro ao inserir jogo" });
        }

        [HttpPost("register")]
        public IActionResult RegisterResult(int codJogo, int placarA, int placarB)
        {
            if (UsuarioAutenticado.IsAcessoGestaoTotal)
            {
                var bll = new JogoBLL();
                var jogo = bll.GetById(codJogo);
                jogo.RPlacarA = placarA;
                jogo.RPlacarB = placarB;
                bll.Update(jogo);

                return Ok();
            }
            return BadRequest(new { message = "Erro ao inserir resultado de jogo" });
        }

        [AllowAnonymous]
        [HttpGet("all")]
        public IActionResult GetAll()
        {

            var bll = new JogoBLL();
            var jogos = bll.GetAll();

            return Ok(jogos);

        }

        [AllowAnonymous]
        [HttpGet("next")]
        public IActionResult GetNext()
        {

            var bll = new JogoBLL();
            var jogos = bll.GetNext();

            return Ok(jogos);

        }

        [AllowAnonymous]
        [HttpGet("previous")]
        public IActionResult GetPrevious()
        {

            var bll = new JogoBLL();
            var jogos = bll.GetPrevious();

            return Ok(jogos);

        }
    }
}
