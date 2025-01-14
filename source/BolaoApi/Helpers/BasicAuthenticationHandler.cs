using System;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text;
using System.Text.Encodings.Web;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using BolaoInfra.BLL;
using BolaoInfra.Models;
using System.Threading;

namespace BolaoApi.Helpers
{
    public class BasicAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
    {
        //private readonly IUserService _userService;

        public BasicAuthenticationHandler(
            IOptionsMonitor<AuthenticationSchemeOptions> options,
            ILoggerFactory logger,
            UrlEncoder encoder,
            ISystemClock clock)//,
            //IUserService userService)
            : base(options, logger, encoder, clock)
        {
            //_userService = userService;
        }

        protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
        {
            // skip authentication if endpoint has [AllowAnonymous] attribute
            var endpoint = Context.GetEndpoint();
            if (endpoint?.Metadata?.GetMetadata<IAllowAnonymous>() != null)
                return AuthenticateResult.NoResult();

            if (!Request.Headers.ContainsKey("Authorization"))
                return AuthenticateResult.Fail("Missing Authorization Header");

            Apostador user;
            try
            {
                var authHeader = AuthenticationHeaderValue.Parse(Request.Headers["Authorization"]);
                var credentialBytes = Convert.FromBase64String(authHeader.Parameter);
                var credentials = Encoding.UTF8.GetString(credentialBytes).Split(new[] { ':' }, 2);
                var username = credentials[0];
                var password = credentials[1];
                var bll = new ApostadorBLL();
                user = bll.Authenticate(username, password);

            }
            catch
            {
                return AuthenticateResult.Fail("Invalid Authorization Header");
            }

            if (user == null)
                return AuthenticateResult.Fail("Invalid Username or Password");
            
            string role = "Apostador";
            if (user.AcessoAtivacao == 1) role = "AcessoAtivacao";
            if (user.AcessoGestaoTotal == 1) role = "AcessoGestaoTotal";

            var claims = new[] {
                new Claim("CodApostador", user.CodApostador.ToString()),
                new Claim(ClaimTypes.Name, user.Login),
                new Claim("Login", user.Login),
                new Claim("AcessoGestaoTotal", user.AcessoGestaoTotal.ToString()),
                new Claim("AcessoAtivacao", user.AcessoAtivacao.ToString()),
                new Claim(ClaimTypes.Role, role)
            };
            var identity = new ClaimsIdentity(claims, Scheme.Name);
            var principal = new ClaimsPrincipal(identity);
            var ticket = new AuthenticationTicket(principal, Scheme.Name);

            Context.User = principal;

            return AuthenticateResult.Success(ticket);
        }
    }
}