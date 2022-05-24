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
        public BolaoContext Context;
        private Repository<Apostador> _apostadorRepository;
        private Repository<Aposta> _apostaRepository;
        private Repository<Grupo> _grupoRepository;
        private Repository<Jogo> _jogoRepository;
        private Repository<Mensagem> _mensagemRepository;
        private Repository<Pais> _paisRepository;
        private Repository<Ranking> _rankingRepository;
        public UnitOfWork(BolaoContext context)
        {
            Context = context;
        }
        public UnitOfWork()
        {
            Context = new BolaoContext();
        }
        public IRepository<Apostador> ApostadorRepository
        {
            get
            {
                return _apostadorRepository ??= new Repository<Apostador>(Context);
            }
        }
        public IRepository<Aposta> ApostaRepository
        {
            get
            {
                return _apostaRepository ??= new Repository<Aposta>(Context);
            }
        }
        public IRepository<Jogo> JogoRepository
        {
            get
            {
                return _jogoRepository ??= new Repository<Jogo>(Context);
            }
        }
        public IRepository<Grupo> GrupoRepository
        {
            get
            {
                return _grupoRepository ??= new Repository<Grupo>(Context);
            }
        }
        public IRepository<Mensagem> MensagemRepository
        {
            get
            {
                return _mensagemRepository ??= new Repository<Mensagem>(Context);
            }
        }
        public IRepository<Pais> PaisRepository
        {
            get
            {
                return _paisRepository ??= new Repository<Pais>(Context);
            }
        }
        public IRepository<Ranking> RankingRepository
        {
            get
            {
                return _rankingRepository ??= new Repository<Ranking>(Context);
            }
        }
        public void Commit()
        {
            Context.SaveChanges();
        }
        public void Dispose()
        {
            Context.Dispose();
            GC.SuppressFinalize(this);
        }
    }
}
