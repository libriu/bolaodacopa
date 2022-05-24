using BolaoApi.Controllers;
using BolaoInfra.BLL;
using BolaoInfra.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Security.Claims;

namespace BolaoApi.Controllers
{

    public class BetController : BolaoController
    {

        [HttpGet]
        public IActionResult Index()
        {
            var bll = new ApostaBLL();
            var apostas = bll.GetNovasApostas();

            return Ok(apostas);
        }

        [HttpGet("all")]
        public IActionResult GetAll()
        {
            if (UsuarioAutenticado.IsAcessoGestaoTotal)
            {
                var bll = new ApostaBLL();
                var apostas = bll.GetAll();

                return Ok(apostas);
            }
            else
            {
                return BadRequest(new { message = "Acesso negado" });
            }
        }

        [HttpGet("my")]
        public IActionResult GetAllMy()
        {

            var bll = new ApostaBLL();
            var apostas = bll.GetAllMy(UsuarioAutenticado.CodApostador);

            return Ok(apostas);

        }

        [HttpPost()]
        public IActionResult Register(List<Aposta> apostas)
        {
            var bll = new ApostaBLL();

            bll.InsertOrUpdate(apostas, UsuarioAutenticado.CodApostador);

            return Ok();
        }
    }
}
