using BolaoInfra.Models;
using BolaoInfra.Repository;
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
        public IEnumerable<Jogo> GetAll()
        {
            return _uow.JogoRepository.GetAll();
        }
        public Jogo GetById(int codigo)
        {
            return _uow.JogoRepository.GetById(c => c.CodJogo == codigo);
        }

        public IEnumerable<Jogo> GetNotRegistered()
        {
            return _uow.JogoRepository.Get(j => j.DataHora <= DateTime.Now && j.JaOcorreu == 1);
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
