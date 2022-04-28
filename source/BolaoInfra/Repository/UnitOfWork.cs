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
        IRepository<Aposta> ApostaRepository { get; }
        IRepository<Grupo> GrupoRepository { get; }
        IRepository<Jogo> JogoRepository { get; }
        IRepository<Mensagem> MensagemRepository { get; }
        IRepository<Pais> PaisRepository { get; }
        IRepository<Ranking> RankingRepository { get; }
        void Commit();
    }

    public class UnitOfWork : IUnitOfWork, IDisposable
    {
        public BolaoContext _context;
        private Repository<Apostador> _apostadorRepository;
        private Repository<Aposta> _apostaRepository;
        private Repository<Grupo> _grupoRepository;
        private Repository<Jogo> _jogoRepository;
        private Repository<Mensagem> _mensagemRepository;
        private Repository<Pais> _paisRepository;
        private Repository<Ranking> _rankingRepository;
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
                return _apostadorRepository ??= new Repository<Apostador>(_context);
            }
        }
        public IRepository<Aposta> ApostaRepository
        {
            get
            {
                return _apostaRepository ??= new Repository<Aposta>(_context);
            }
        }
        public IRepository<Jogo> JogoRepository
        {
            get
            {
                return _jogoRepository ??= new Repository<Jogo>(_context);
            }
        }
        public IRepository<Grupo> GrupoRepository
        {
            get
            {
                return _grupoRepository ??= new Repository<Grupo>(_context);
            }
        }
        public IRepository<Mensagem> MensagemRepository
        {
            get
            {
                return _mensagemRepository ??= new Repository<Mensagem>(_context);
            }
        }
        public IRepository<Pais> PaisRepository
        {
            get
            {
                return _paisRepository ??= new Repository<Pais>(_context);
            }
        }
        public IRepository<Ranking> RankingRepository
        {
            get
            {
                return _rankingRepository ??= new Repository<Ranking>(_context);
            }
        }
        public void Commit()
        {
            _context.SaveChanges();
        }
        public void Dispose()
        {
            _context.Dispose();
            GC.SuppressFinalize(this);
        }
    }
}
