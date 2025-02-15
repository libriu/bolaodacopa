﻿using BolaoApi.Controllers;
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
        [HttpGet("getbyid")]
        public IActionResult GetById(int codJogo)
        {

            var bll = new JogoBLL();
            var jogo = bll.GetById(codJogo);

            return Ok(jogo);

        }

        [AllowAnonymous]
        [HttpGet("getwithbetallowed")]
        public IActionResult GetLastWithBetAllowed()
        {

            var bll = new JogoBLL();
            var jogo = bll.GetLastWithBetAllowed();

            return Ok(jogo);

        }

        //Método para usuário logado
        [HttpGet("nextwithbets")]
        public IActionResult GetNextWithBets(int codApostador)
        {

            var bll = new JogoBLL();
            var jogos = bll.GetNext(codApostador, UsuarioAutenticado.CodApostador != codApostador);

            return Ok(jogos);

        }

        //Método para usuário não logado
        [AllowAnonymous]
        [HttpGet("next")]
        public IActionResult GetNext(int codApostador)
        {

            var bll = new JogoBLL();
            var jogos = bll.GetNext(codApostador, true);

            return Ok(jogos);

        }

        //Método para usuário logado ou não
        [AllowAnonymous]
        [HttpGet("previous")]
        public IActionResult GetPrevious(int codApostador)
        {

            var bll = new JogoBLL();
            var jogos = bll.GetPrevious(codApostador);

            return Ok(jogos);

        }
    }
}
