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
        UnitOfWork _uow;
        public ApostadorBLL(UnitOfWork uow)
        {
            _uow = uow;
        }
        public ApostadorBLL()
        {
            _uow = new UnitOfWork();
        }
        public IEnumerable<Apostador> ListarApostadores()
        {
            return _uow.ApostadorRepository.GetAll();
        }
        public void Adicionar(Apostador apostador)
        {
            apostador.Senha = new PasswordHasher<object?>().HashPassword(null, apostador.Senha);
            _uow.ApostadorRepository.Add(apostador);
            _uow.Commit();
        }
        public void Excluir(Apostador apostador)
        {
            _uow.ApostadorRepository.Delete(apostador);
            _uow.Commit();
        }
        public void Alterar(Apostador apostador)
        {
            _uow.ApostadorRepository.Update(apostador);
            _uow.Commit();
        }
        public Apostador GetApostadorPorId(int codigo)
        {
            return _uow.ApostadorRepository.GetById(c => c.CodApostador == codigo);
        }
        public Apostador Autenticar(string login, string password)
        {
            var apostador = _uow.ApostadorRepository.Get(c => c.Login == login).FirstOrDefault();
            if (apostador == null) throw new ApplicationException("1");
            if (apostador.Ativo == 0) throw new ApplicationException("2");
            if (VerificarSenha(apostador.Senha, password)) return apostador;
            return null;
        }

        private bool VerificarSenha(string hashedPassword, string password)
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
                    throw new ArgumentOutOfRangeException();
            }
        }
        public void Dispose()
        {
            _uow.Dispose();
        }
    }
}
