using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using BolaoApi.Controllers;
using BolaoApi.Models;
using BolaoInfra.BLL;
using BolaoInfra.Models;
using System;
using System.Threading;
using System.Security.Claims;
using System.Linq;
using BolaoInfra.Exception;
using BolaoApi.Helpers;

namespace BolaoApi.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class UserController : BolaoController
    {

        public UserController()
        {
                        
        }

        [AllowAnonymous]
        [HttpPost("authenticate")]
        public IActionResult Authenticate([FromBody] AutentacacaoModel model)
        {
            var bll = new ApostadorBLL();
            Apostador user;
            try
            {
                user = bll.Authenticate(model.Login, model.Senha);
            }
            catch(BolaoException ex)
            {
                return BadRequest(new { message = ex.Mensagem });
            }
            return Ok(user.WithoutPassword());
        }

        [AllowAnonymous]
        [HttpPost("create")]
        public IActionResult Create([FromBody] Apostador model)
        {
            var bll = new ApostadorBLL();

            model.AcessoAtivacao = 0;
            model.AcessoGestaoTotal = 0;
            model.Ativo = 0;
            model.CodApostAtivador = null;

            bll.Insert(model);

            return Ok();
        }

        [HttpPost("activate")]
        public IActionResult Activate([FromBody] Apostador model)
        {
            if (UsuarioAutenticado.IsAcessoGestaoTotalOuAtivacao)
            {
                var bll = new ApostadorBLL();
                model = bll.GetById(model.CodApostador);
                model.Ativo = 1;
                model.CodApostAtivador = UsuarioAutenticado.CodApostador;

                bll.Update(model);

                return Ok();
            }

            return BadRequest(new { message = "Erro ao realizar ativação" });
        }

        [HttpGet]
        public IActionResult GetAll()
        {
            if (UsuarioAutenticado.IsAcessoGestaoTotal)
            {
                var bll = new ApostadorBLL();
                var apostadores = bll.GetAll();

                return Ok(apostadores.WithoutPasswords());
            }
            else
            {
                return BadRequest(new { message = "Acesso negado" });
            }
        }

    }
}