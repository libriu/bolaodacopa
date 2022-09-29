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
    public class RankingBLL : IDisposable
    {
        readonly UnitOfWork _uow;
        public RankingBLL(UnitOfWork uow)
        {
            _uow = uow;
        }
        public RankingBLL()
        {
            _uow = new UnitOfWork();
        }
        public List<Ranking> GetAll()
        {
            int empate = 0;
            var r = _uow.RankingRepository.GetAll().Include(ranking => ranking.Apostador)
                .OrderByDescending(c => c.TotalPontos)
                .ThenBy(c => c.TotalAcertos)
                .ThenBy(c => c.Apostador.Login).ToList<Ranking>();
            if (r != null && r.Count > 0)
            {
                r[0].Posicao = 1;
                r[0].Apostador.Senha = null;
            }
            for (int i=1; i< r.Count; i++)
            {
                if (r[i].TotalPontos == r[i-1].TotalPontos && r[i].TotalAcertos == r[i - 1].TotalAcertos)
                {
                    r[i].Posicao = r[i - 1].Posicao;
                    r[i].Apostador.Senha = null;
                    empate++;
                }
                else
                {
                    r[i].Posicao = r[i - 1].Posicao + 1 + empate;
                    r[i].Apostador.Senha = null;
                    empate = 0;
                }
            }
            return r;
        }

        public Ranking GetByApostador(int codApostador)
        {
            return GetAll().First<Ranking>(c => c.CodApostador == codApostador);
        }

        public void Insert(Ranking Ranking)
        {
            _uow.RankingRepository.Add(Ranking);
            _uow.Commit();
        }

        public void Insert(List<Ranking> Rankings)
        {
            _uow.BeginTransaction();
            try
            {
                foreach (Ranking Ranking in Rankings)
                {
                    _uow.RankingRepository.Add(Ranking);
                }

                _uow.CommitTransaction();
            }
            catch (System.Exception)
            {
                _uow.RollbackTransaction();
                throw;
            }
        }

        public void Delete(Ranking Ranking)
        {
            _uow.RankingRepository.Delete(Ranking);
            _uow.Commit();
        }
        public void Update(Ranking Ranking)
        {
            _uow.RankingRepository.Update(Ranking);
            _uow.Commit();
        }

        public void Dispose()
        {
            _uow.Dispose();
            GC.SuppressFinalize(this);
        }
    }
}
