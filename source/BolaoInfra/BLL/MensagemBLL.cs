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
    public class MensagemBLL : IDisposable
    {
        readonly UnitOfWork _uow;
        public MensagemBLL(UnitOfWork uow)
        {
            _uow = uow;
        }
        public MensagemBLL()
        {
            _uow = new UnitOfWork();
        }
        public List<Mensagem> GetAll()
        {
            return _uow.MensagemRepository.GetAll().OrderByDescending(m => m.DataHora).ToList<Mensagem>();
        }
        public Mensagem GetById(int codigo)
        {
            return _uow.MensagemRepository.GetById(c => c.CodMensagem == codigo);
        }

        public void Insert(Mensagem Mensagem)
        {
            _uow.MensagemRepository.Add(Mensagem);
            _uow.Commit();
        }

        public void Delete(Mensagem Mensagem)
        {
            _uow.MensagemRepository.Delete(Mensagem);
            _uow.Commit();
        }
        public void Update(Mensagem Mensagem)
        {
            _uow.MensagemRepository.Update(Mensagem);
            _uow.Commit();
        }

        public void Dispose()
        {
            _uow.Dispose();
            GC.SuppressFinalize(this);
        }
    }
}
