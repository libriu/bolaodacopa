using BolaoInfra.Exception;
using BolaoInfra.Models;
using BolaoInfra.Repository;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BolaoInfra.BLL
{
    public class ApostaBLL : IDisposable
    {
        readonly UnitOfWork _uow;
        public ApostaBLL(UnitOfWork uow)
        {
            _uow = uow;
        }
        public ApostaBLL()
        {
            _uow = new UnitOfWork();
        }
        public List<Aposta> GetAll()
        {
            return _uow.ApostaRepository.GetAll().ToList<Aposta>();
        }

        public List<Aposta> GetAllMy (int codApostador)
        {
            return _uow.ApostaRepository.Get(c => c.CodApostador == codApostador).ToList<Aposta>();
        }

        //public List<Aposta> GetWithGames(int codApostador)
        //{
        //    return _uow.ApostaRepository.Get(c => c.CodApostador == codApostador)
        //        .Include(aposta => aposta.Jogo)
        //        .ThenInclude<Aposta, Jogo>()
        //        .Where(j => j.DataHora > DateTime.Now && j.JaOcorreu == 0).ToList<Jogo>();
        //}

        public Aposta GetByGame(int codApostador, int codJogo)
        {
            return _uow.ApostaRepository.Get(c => c.CodApostador == codApostador 
                                             && c.CodJogo == codJogo).FirstOrDefault<Aposta>();
        }

        public static IEnumerable<Aposta> GetNovasApostas(int codApostador)
        {
            List<Aposta> apostas = new();
            //int diasAntecedencia = 3;
            //var jogos = _uow.JogoRepository.Get(j => j.DataHora > DateTime.Now && j.DataHora <= DateTime.Now.AddDays(diasAntecedencia)).AsEnumerable<Jogo>();
            JogoBLL jogoBLL = new();
            var jogos = jogoBLL.GetNext(codApostador, false);
            foreach (Jogo j in jogos)
            {
                Aposta a = new();
                a.CodJogo = j.CodJogo;
                a.Jogo = j;
                apostas.Add(a);
            }
            return apostas;
        }
        public void Insert(Aposta aposta)
        {
            _uow.ApostaRepository.Add(aposta);
            _uow.Commit();
        }

        public void InsertOrUpdate(Aposta aposta, int codApostador)
        {
            JogoBLL jogoBLL = new();
            var apostasFeitas = GetAllMy(codApostador);

            var jogo = jogoBLL.GetById(aposta.CodJogo);
            if (jogo == null)
            {
                throw BolaoException.JogoInvalido;
            }
            if (jogo.DataHora < DateTime.Now || jogo.JaOcorreu == 1)
            {
                throw BolaoException.JogoOcorrido;
            }
            aposta.CodApostador = codApostador;
            aposta.Pontos = 0;

            if (apostasFeitas.Any(a => a.CodJogo == aposta.CodJogo))
            {
                Update(aposta);
            }
            else
            {
                Insert(aposta);
            }

            _uow.Commit();
        }

        public void InsertOrUpdate(List<Aposta> apostas, int codApostador)
        {
            JogoBLL jogoBLL = new();
            var apostasFeitas = GetAllMy(codApostador);
            foreach (Aposta aposta in apostas)
            {
                var jogo = jogoBLL.GetById(aposta.CodJogo);
                if (jogo == null)
                {
                    throw BolaoException.JogoInvalido;
                }
                if (jogo.DataHora < DateTime.Now || jogo.JaOcorreu == 1)
                {
                    throw BolaoException.JogoOcorrido;
                }
                aposta.CodApostador = codApostador;
                aposta.Pontos = 0;

                if (apostasFeitas.Any(a => a.CodJogo == aposta.CodJogo))
                {
                    Update(aposta);
                }
                else
                {
                    Insert(aposta);
                }
            }
            
            _uow.Commit();
        }
        public void Delete(Aposta aposta)
        {
            _uow.ApostaRepository.Delete(aposta);
            _uow.Commit();
        }
        public void Update(Aposta aposta)
        {
            _uow.ApostaRepository.Update(aposta);
            _uow.Commit();
        }

        public void Dispose()
        {
            _uow.Dispose();
            GC.SuppressFinalize(this);
        }
    }
}
