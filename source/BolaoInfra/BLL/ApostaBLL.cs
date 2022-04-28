using BolaoInfra.Exception;
using BolaoInfra.Models;
using BolaoInfra.Repository;
using Microsoft.AspNetCore.Identity;
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
        public IEnumerable<Aposta> GetAll()
        {
            return _uow.ApostaRepository.GetAll();
        }

        public IEnumerable<Aposta> GetAllMy (int codApostador)
        {
            return _uow.ApostaRepository.Get(c => c.CodApostador == codApostador);
        }

        public IEnumerable<Aposta> GetNovasApostas()
        {
            List<Aposta> apostas = new();
            int diasAntecedencia = 3;
            var jogos = _uow.JogoRepository.Get(j => j.DataHora > DateTime.Now && j.DataHora <= DateTime.Now.AddDays(diasAntecedencia));
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

        public void Insert(List<Aposta> apostas)
        {
            foreach (Aposta aposta in apostas)
            {
                _uow.ApostaRepository.Add(aposta);
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
