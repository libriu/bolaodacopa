using BolaoInfra.Exception;
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
    public class GrupoBLL : IDisposable
    {
        readonly UnitOfWork _uow;
        public GrupoBLL(UnitOfWork uow)
        {
            _uow = uow;
        }
        public GrupoBLL()
        {
            _uow = new UnitOfWork();
        }
        public List<Grupo> GetAllMy(int codApostResponsavel)
        {
            return _uow.GrupoRepository.Get(g => g.CodApostResponsavel == codApostResponsavel).ToList<Grupo>();
        }

        public Grupo GetById(int codigo)
        {
            return _uow.GrupoRepository.GetById(c => c.CodGrupo == codigo);
        }

        public void Insert(Grupo Grupo)
        {
            _uow.GrupoRepository.Add(Grupo);
            _uow.Commit();
        }

        public void Delete(Grupo Grupo)
        {
            _uow.GrupoRepository.Delete(Grupo);
            _uow.Commit();
        }
        public void Update(Grupo Grupo)
        {
            _uow.GrupoRepository.Update(Grupo);
            _uow.Commit();
        }

        public List<Apostador> GetMembers(int codGrupo)
        {
            Grupo grupo = _uow.GrupoRepository.GetById(c => c.CodGrupo == codGrupo);
            return grupo.Apostadores.ToList<Apostador>();
        }

        public void InsertMember(Grupo grupo, Apostador apostador)
        {
            grupo.Apostadores.Add(apostador);
            _uow.Commit();
        }

        public void InsertMember(int codGrupo, Apostador apostador)
        {
            Grupo grupo = GetById(codGrupo);
            InsertMember(grupo, apostador);
        }

        public void InsertMember(int codGrupo, int codApostador)
        {
            Grupo grupo = GetById(codGrupo);
            Apostador apostador = new ApostadorBLL().GetById(codApostador);
            InsertMember(grupo, apostador);
        }


        public void DeleteMember(Grupo grupo, Apostador apostador)
        {
            if (grupo.CodApostResponsavel == apostador.CodApostador)
            {
                throw BolaoException.RemocaoResponsavelGrupoNaoPermitido;
            }
            grupo.Apostadores.Remove(apostador);
            _uow.Commit();
        }
        public void DeleteMember(int codGrupo, Apostador apostador)
        {
            Grupo grupo = GetById(codGrupo);
            DeleteMember(grupo, apostador);
        }

        public void DeleteMember(int codGrupo, int codApostador)
        {
            Grupo grupo = GetById(codGrupo);
            Apostador apostador = new ApostadorBLL().GetById(codApostador);
            DeleteMember(grupo, apostador);
        }

        public void Dispose()
        {
            _uow.Dispose();
            GC.SuppressFinalize(this);
        }
    }
}
