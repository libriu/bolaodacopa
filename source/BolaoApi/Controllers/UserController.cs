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
using System.Collections.Generic;

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
                user = bll.Authenticate(model.login, model.senha);
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
        public IActionResult Activate(List<Apostador> apostadores)
        {
            List<Apostador> lista = new();
            var bll = new ApostadorBLL();
            if (UsuarioAutenticado.IsAcessoGestaoTotalOuAtivacao)
            {
                foreach (Apostador a in apostadores)
                {
                    var model = bll.GetById(a.CodApostador);
                    model.Ativo = 1;
                    model.CodApostAtivador = UsuarioAutenticado.CodApostador;
                    lista.Add(model);
                }
                bll.Update(lista);
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

        [HttpGet("toactivate")]
        public IActionResult GetInactive()
        {
            if (UsuarioAutenticado.IsAcessoGestaoTotal)
            {
                var bll = new ApostadorBLL();
                var apostadores = bll.GetInactive();

                return Ok(apostadores.WithoutPasswords());
            }
            else
            {
                return BadRequest(new { message = "Acesso negado" });
            }
        }

    }
}