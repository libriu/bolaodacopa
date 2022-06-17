using BolaoInfra.Models;
using BolaoInfra.Repository;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BolaoInfra.BLL
{
    public class PaisBLL : IDisposable
    {
        readonly UnitOfWork _uow;
        public PaisBLL(UnitOfWork uow)
        {
            _uow = uow;
        }
        public PaisBLL()
        {
            _uow = new UnitOfWork();
        }
        public List<Pais> GetAll()
        {
            return _uow.PaisRepository.GetAll().ToList<Pais>();
        }
        public Pais GetById(int codigo)
        {
            return _uow.PaisRepository.GetById(c => c.CodPais == codigo);
        }

        public void Insert(Pais Pais)
        {
            _uow.PaisRepository.Add(Pais);
            _uow.Commit();
        }

        public void Insert(List<Pais> Paises)
        {
            foreach (Pais Pais in Paises)
            {
                _uow.PaisRepository.Add(Pais);
            }

            _uow.Commit();
        }
        public void Delete(Pais Pais)
        {
            _uow.PaisRepository.Delete(Pais);
            _uow.Commit();
        }
        public void Update(Pais Pais)
        {
            _uow.PaisRepository.Update(Pais);
            _uow.Commit();
        }

        public void Dispose()
        {
            _uow.Dispose();
            GC.SuppressFinalize(this);
        }
    }
}
