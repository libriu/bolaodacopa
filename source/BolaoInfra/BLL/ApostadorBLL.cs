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
    public class ApostadorBLL : IDisposable
    {
        readonly UnitOfWork _uow;
        public ApostadorBLL(UnitOfWork uow)
        {
            _uow = uow;
        }
        public ApostadorBLL()
        {
            _uow = new UnitOfWork();
        }
        public List<Apostador> GetAll()
        {
            return _uow.ApostadorRepository.GetAll().ToList<Apostador>();
        }
        public void Insert(Apostador apostador)
        {
            apostador.Senha = new PasswordHasher<object?>().HashPassword(null, apostador.Senha);
            _uow.ApostadorRepository.Add(apostador);
            _uow.Commit();
        }
        public void Delete(Apostador apostador)
        {
            _uow.ApostadorRepository.Delete(apostador);
            _uow.Commit();
        }
        public void Update(Apostador apostador)
        {
            if (GetWithSameLogin(apostador).ToList().Count > 0)
            {
                throw BolaoException.LoginUtilizado;
            }
            _uow.ApostadorRepository.Update(apostador);
            _uow.Commit();
        }

        public void Update(List<Apostador> apostadores)
        {
            foreach (var apostador in apostadores)
            {
                _uow.ApostadorRepository.Update(apostador);
            }
            
            _uow.Commit();
        }
        public Apostador GetById(int codigo)
        {
            return _uow.ApostadorRepository.GetById(c => c.CodApostador == codigo);
        }
        public List<Apostador> GetInactive()
        {
            return _uow.ApostadorRepository.Get(c => c.Ativo == 0).ToList<Apostador>();
        }
        public List<Apostador> GetWithSameLogin(Apostador apostador)
        {
            return _uow.ApostadorRepository.Get(c => c.CodApostador != apostador.CodApostador && c.Login == apostador.Login).ToList<Apostador>(); ;
        }
        public Apostador Authenticate(string login, string senha)
        {
            var apostador = _uow.ApostadorRepository.Get(c => c.Login == login).FirstOrDefault();
            if (apostador == null) throw BolaoException.LoginInvalido;
            if (apostador.Ativo == 0) throw BolaoException.UsuarioInativo;
            if (VerifyPassword(apostador.Senha, senha))
            {
                return apostador;
            }
            else
            {
                throw BolaoException.SenhaIncorreta;
            }
        }

        private static bool VerifyPassword(string hashedPassword, string password)
        {
            var passwordVerificationResult = new PasswordHasher<object?>().VerifyHashedPassword(null, hashedPassword, password);
            switch (passwordVerificationResult)
            {
                case PasswordVerificationResult.Failed:
                    Console.WriteLine("Password incorrect.");
                    return false;

                case PasswordVerificationResult.Success:
                    Console.WriteLine("Password ok.");
                    return true;

                case PasswordVerificationResult.SuccessRehashNeeded:
                    Console.WriteLine("Password ok but should be rehashed and updated.");
                    return true;

                default:
                    throw BolaoException.HashSenhaInvalido;
            }
        }
        public void Dispose()
        {
            _uow.Dispose();
            GC.SuppressFinalize(this);
        }
    }
}
