using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using BolaoApi.Helpers;
using BolaoApi.Models;
using BolaoInfra.BLL;
using BolaoInfra.Models;
using System;
using System.Threading;
using System.Security.Claims;
using System.Linq;

namespace BolaoApi.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {

        public UserController() 
        {
            
            
        }

        [AllowAnonymous]
        [HttpPost("authenticate")]
        public IActionResult Autenticar([FromBody] AutentacacaoModel model)
        {
            var bll = new ApostadorBLL();
            Apostador user = null;
            try
            {
                user = bll.Autenticar(model.Login, model.Senha);

                if (user == null)
                    return BadRequest(new { message = "Senha incorreta" });
            }
            catch(ApplicationException ex)
            {
                if (ex.Message == "1")
                {
                    return BadRequest(new { message = "Login inválido" });
                }
                if (ex.Message == "2")
                {
                    return BadRequest(new { message = "Usuário inativo" });
                }
                else throw ex;
            }
            return Ok(user);
        }

        [AllowAnonymous]
        [HttpPost("create")]
        public IActionResult Criar([FromBody] Apostador model)
        {
            var bll = new ApostadorBLL();

            model.AcessoAtivacao = 0;
            model.AcessoGestaoTotal = 0;
            model.Ativo = 0;
            model.CodApostAtivador = null;

            bll.Adicionar(model);

            return Ok();
        }

        [HttpPost("activate")]
        public IActionResult Ativar([FromBody] Apostador model)
        {
            ClaimsPrincipal currentPrincipal = User as ClaimsPrincipal;

            if (currentPrincipal.IsInRole("AcessoGestaoTotal") || currentPrincipal.IsInRole("AcessoAtivacao"))
            {
                var claims = currentPrincipal.Claims;

                var bll = new ApostadorBLL();
                model = bll.GetApostadorPorId(model.CodApostador);
                model.Ativo = 1;
                model.CodApostAtivador = int.Parse(claims.Where(c => c.Type == "CodApostador").FirstOrDefault().Value);

                bll.Alterar(model);

                return Ok();
            }

            return BadRequest(new { message = "Erro ao realizar ativação" });
        }

        [HttpGet]
        public IActionResult GetApostadores()
        {
            var bll = new ApostadorBLL();
            var apostadores = bll.ListarApostadores();

            return Ok(apostadores.WithoutPasswords());
        }

    }
}