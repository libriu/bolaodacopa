using BolaoApi.Controllers;
using BolaoInfra.BLL;
using BolaoInfra.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace BolaoApi.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class GameController : BolaoController
    {

        [HttpPost()]
        public IActionResult Insert(List<Jogo> jogos)
        {
            var bll = new JogoBLL();

            bll.Insert(jogos);

            return Ok();
        }

        [HttpPost("register")]
        public IActionResult RegisterResult(int codJogo, int placarA, int placarB)
        {
            var bll = new JogoBLL();
            var jogo = bll.GetById(codJogo);
            jogo.RPlacarA = placarA;
            jogo.RPlacarB = placarB;
            bll.Update(jogo);

            return Ok();
        }

        [HttpGet("all")]
        public IActionResult GetAll()
        {

            var bll = new JogoBLL();
            var jogos = bll.GetAll();

            return Ok(jogos);

        }

        [HttpGet("my")]
        public IActionResult GetNotRegistered()
        {

            var bll = new JogoBLL();
            var jogos = bll.GetNotRegistered();

            return Ok(jogos);

        }
    }
}
