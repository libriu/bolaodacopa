using BolaoInfra.Context;
using BolaoInfra.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace BolaoInfra.Repository
{
    public interface IPaisRepository : IRepository<Pais>
    {

    }
    internal class PaisRepository : IRepository<Pais>, IPaisRepository
    {
        BolaoContext _context;
        public PaisRepository(BolaoContext context)
        {
            _context = context;
        }
        public void Add(Pais entity)
        {
            _context.Paises.Add(entity);
        }
        public void Delete(Pais entity)
        {
            _context.Paises.Remove(entity);
        }
        public IEnumerable<Pais> GetAll()
        {
            return _context.Paises.ToList();
        }
        public void Update(Pais entity)
        {
            _context.Paises.Update(entity);
        }
        public IEnumerable<Pais> Get(Expression<Func<Pais, bool>> predicate)
        {
            return _context.Paises.Where(predicate);
        }
        public Pais GetById(Expression<Func<Pais, bool>> predicate)
        {
            return _context.Paises.FirstOrDefault(predicate);
        }

    }
}
