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
        public IEnumerable<Apostador> GetAll()
        {
            return _uow.ApostadorRepository.GetAll();
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
            _uow.ApostadorRepository.Update(apostador);
            _uow.Commit();
        }
        public Apostador GetById(int codigo)
        {
            return _uow.ApostadorRepository.GetById(c => c.CodApostador == codigo);
        }
        public Apostador Authenticate(string login, string senha)
        {
            var apostador = _uow.ApostadorRepository.Get(c => c.Login == login).FirstOrDefault();
            if (apostador == null) throw new BolaoException(1, "Login inválido");
            if (apostador.Ativo == 0) throw new BolaoException(2, "Usuário inativo");
            if (VerifyPassword(apostador.Senha, senha))
            {
                return apostador;
            }
            else
            {
                throw new BolaoException(3, "Senha incorreta");
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
                    throw new ArgumentOutOfRangeException(nameof(hashedPassword));
            }
        }
        public void Dispose()
        {
            _uow.Dispose();
            GC.SuppressFinalize(this);
        }
    }
}
