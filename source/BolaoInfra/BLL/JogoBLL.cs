using BolaoInfra.Models;
using BolaoInfra.Repository;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BolaoInfra.BLL
{
    public class JogoBLL : IDisposable
    {
        readonly UnitOfWork _uow;
        public JogoBLL(UnitOfWork uow)
        {
            _uow = uow;
        }
        public JogoBLL()
        {
            _uow = new UnitOfWork();
        }
        public List<Jogo> GetAll()
        {
            return _uow.JogoRepository.GetAll().ToList<Jogo>();
        }
        public Jogo GetById(int codigo)
        {
            return _uow.JogoRepository.GetById(c => c.CodJogo == codigo);
        }

        public Jogo GetLastWithBetAllowed()
        {
            return _uow.JogoRepository.Get(j => j.DataHora.Date <= DateTime.Today).OrderByDescending(j => j.DataHora).FirstOrDefault<Jogo>();
        }

        public List<Jogo> GetNext(int codApostador, bool onlyAllowed)
        {
           
            if (!onlyAllowed)
            {
                // Caso esteja vendo os jogos do próprio usuário logado, traz as apostas dele
                return _uow.JogoRepository.GetAll()
                    .Include(game => game.PaisA)
                    .Include(game => game.PaisB)
                    .Where(j => j.JaOcorreu == 0)
                    .Select(g => new
                    {
                        g,
                        Apostas = g.Apostas.Where(a => a.CodApostador == codApostador)
                    })
                    .AsEnumerable()
                    .Select(x => x.g)
                    .OrderBy(x => x.DataHora).ThenBy(x => x.Grupo)
                    .ToList<Jogo>();
            }

            // Caso esteja vendo os jogos de outro usuário, só traz as apostas até o dia de hoje (dia fechado), não traz as futuras
            var lista1 = _uow.JogoRepository.GetAll()
                .Include(game => game.PaisA)
                .Include(game => game.PaisB)
                .Where(j => j.DataHora.Date <= DateTime.Today.AddDays(1) && j.JaOcorreu == 0)
                .Select(g => new
                {
                    g,
                    Apostas = g.Apostas.Where(a => a.CodApostador == codApostador)
                })
                .AsEnumerable()
                .Select(x => x.g)
                .ToList<Jogo>();
            var lista2 = _uow.JogoRepository.GetAll()
                .Include(game => game.PaisA)
                .Include(game => game.PaisB)
                .Where(j => j.DataHora.Date > DateTime.Today && j.JaOcorreu == 0)
                .ToList<Jogo>();

            return lista1.Concat(lista2).OrderBy(x => x.DataHora).ThenBy(x => x.Grupo).ToList<Jogo>(); ;

        }

        public List<Jogo> GetPrevious(int codApostador)
        {
            // Traz as apostas, mesmo que seja de outro usuário, pois são jogos passados
            return _uow.JogoRepository.GetAll()
                .Include(game => game.PaisA)
                .Include(game => game.PaisB)
                .Where(j => j.JaOcorreu == 1)
                .Select(g => new
                {
                    g,
                    Apostas = g.Apostas.Where(a => a.CodApostador == codApostador)
                })
                .AsEnumerable()
                .Select(x => x.g)
                .OrderByDescending(x => x.DataHora).ThenBy(x => x.Grupo)
                .ToList<Jogo>();

        }

        public void Insert(Jogo Jogo)
        {
            _uow.JogoRepository.Add(Jogo);
            _uow.Commit();
        }

        public void Insert(List<Jogo> Jogos)
        {
            _uow.BeginTransaction();
            try
            {
                foreach (Jogo Jogo in Jogos)
                {
                    _uow.JogoRepository.Add(Jogo);
                }

                _uow.CommitTransaction();
            }
            catch (System.Exception)
            {
                _uow.RollbackTransaction();
                throw;
            }
        }

        public void Delete(Jogo Jogo)
        {
            _uow.JogoRepository.Delete(Jogo);
            _uow.Commit();
        }
        public void Update(Jogo Jogo)
        {
            _uow.JogoRepository.Update(Jogo);
            _uow.Commit();
        }

        public void Dispose()
        {
            _uow.Dispose();
            GC.SuppressFinalize(this);
        }
    }
}
