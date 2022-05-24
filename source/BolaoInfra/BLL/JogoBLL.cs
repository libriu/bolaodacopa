using BolaoInfra.Models;
using BolaoInfra.Repository;
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

        public List<Jogo> GetNext()
        {
            return _uow.JogoRepository.GetAll()
                .Include(game => game.PaisA)
                .Include(game => game.PaisB)
                .Where(j => j.DataHora > DateTime.Now && j.JaOcorreu == 0).ToList<Jogo>();
        }

        public List<Jogo> GetPrevious()
        {
            return _uow.JogoRepository.GetAll()
                .Include(game => game.PaisA)
                .Include(game => game.PaisB)
                .Where(j => j.DataHora <= DateTime.Now || j.JaOcorreu == 1)
                .ToList<Jogo>();
        }

        public void Insert(Jogo Jogo)
        {
            _uow.JogoRepository.Add(Jogo);
            _uow.Commit();
        }

        public void Insert(List<Jogo> Jogos)
        {
            foreach (Jogo Jogo in Jogos)
            {
                _uow.JogoRepository.Add(Jogo);
            }

            _uow.Commit();
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
