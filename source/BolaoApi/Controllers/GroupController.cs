using BolaoInfra.BLL;
using BolaoInfra.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using BolaoApi.Helpers;

namespace BolaoApi.Controllers
{
    public class GroupController : BolaoController
    {
        [AllowAnonymous]
        public IActionResult Index()
        {
            var bll = new GrupoBLL();
            var grupos = bll.GetAll();

            return Ok(grupos);
        }

        [HttpGet("withme")]
        public IActionResult GetAllMy()
        {

            var bll = new GrupoBLL();
            var grupos = bll.GetByMember(UsuarioAutenticado.CodApostador);

            return Ok(grupos);

        }

        [AllowAnonymous]
        [HttpGet("members")]
        public IActionResult GetMembers(int codGrupo)
        {

            var bll = new GrupoBLL();
            var apostadores = bll.GetMembers(codGrupo);
            return Ok(apostadores.WithoutPasswords());

        }
    }
}
