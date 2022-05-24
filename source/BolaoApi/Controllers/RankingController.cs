﻿using BolaoInfra.BLL;
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
    }
}
