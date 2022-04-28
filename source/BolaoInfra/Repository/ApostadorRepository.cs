using BolaoInfra.Context;
using BolaoInfra.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

namespace BolaoInfra.Repository
{
    public interface IApostadorRepository : IRepository<Apostador>
    {
        Apostador GetApostadorPorLogin(string login);
    }
    internal class ApostadorRepository : IRepository<Apostador>, IApostadorRepository
    {
        BolaoContext _context;
        public ApostadorRepository(BolaoContext context)
        {
            _context = context;
        }
        public void Add(Apostador entity)
        {
            _context.Apostadores.Add(entity);
        }
        public void Delete(Apostador entity)
        {
            _context.Apostadores.Remove(entity);
        }
        public IEnumerable<Apostador> GetAll()
        {
            return _context.Apostadores.ToList();
        }
        public void Update(Apostador entity)
        {
            _context.Apostadores.Update(entity);
        }
        public IEnumerable<Apostador> Get(Expression<Func<Apostador, bool>> predicate)
        {
            return _context.Apostadores.Where(predicate);
        }
        public Apostador GetById(Expression<Func<Apostador, bool>> predicate)
        {
            return _context.Apostadores.FirstOrDefault(predicate);
        }
        public Apostador GetApostadorPorLogin(string login)
        {
            return _context.Apostadores.FirstOrDefault(c => c.Login == login);
        }
    }
}
