using BolaoApi.Models;
using Microsoft.AspNetCore.Mvc;
using System.Linq;
using System.Security.Claims;

namespace BolaoApi.Controllers
{
    public class BolaoController : Controller
    {
        protected UsuarioAutenticado UsuarioAutenticado { 
            get {
                UsuarioAutenticado usuarioAutenticado = null;
                ClaimsPrincipal currentPrincipal = User;
                if (currentPrincipal != null)
                {
                    var claims = currentPrincipal.Claims;
                    usuarioAutenticado = new();
                    usuarioAutenticado.CodApostador = int.Parse(claims.Where(c => c.Type == "CodApostador").FirstOrDefault().Value);
                    usuarioAutenticado.Login = currentPrincipal.Identity.Name;
                    usuarioAutenticado.IsAcessoGestaoTotal = claims.Where(c => c.Type == "AcessoGestaoTotal").FirstOrDefault().Value.Equals("1");
                    usuarioAutenticado.IsAcessoAtivacao = claims.Where(c => c.Type == "AcessoAtivacao").FirstOrDefault().Value.Equals("1");
                    //usuarioAutenticado.IsAcessoGestaoTotal = currentPrincipal.IsInRole("AcessoGestaoTotal");
                    //usuarioAutenticado.IsAcessoAtivacao = currentPrincipal.IsInRole("AcessoAtivacao");
                }
                return usuarioAutenticado;
            } 
        }
        
        public BolaoController()
        {
        }

    }
}
