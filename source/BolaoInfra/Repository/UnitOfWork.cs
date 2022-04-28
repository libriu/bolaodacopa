using BolaoInfra.Context;
using BolaoInfra.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BolaoInfra.Repository
{
    internal interface IUnitOfWork
    {
        IRepository<Apostador> ApostadorRepository { get; }
        void Commit();
    }

    public class UnitOfWork : IUnitOfWork, IDisposable
    {
        public BolaoContext _context;
        private Repository<Apostador> _apostadorRepository;
        public UnitOfWork(BolaoContext context)
        {
            _context = context;
        }
        public UnitOfWork()
        {
            _context = new BolaoContext();
        }
        public IRepository<Apostador> ApostadorRepository
        {
            get
            {
                return _apostadorRepository = _apostadorRepository ?? new Repository<Apostador>(_context);
            }
        }
        public void Commit()
        {
            _context.SaveChanges();
        }
        public void Dispose()
        {
            _context.Dispose();
        }
    }
}
