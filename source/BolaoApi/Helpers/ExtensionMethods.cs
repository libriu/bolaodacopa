using System.Collections.Generic;
using System.Linq;
using BolaoInfra.Models;

namespace BolaoApi.Helpers
{
    public static class ExtensionMethods
    {
        public static IEnumerable<Apostador> WithoutPasswords(this IEnumerable<Apostador> apostadores) {
            return apostadores.Select(x => x.WithoutPassword());
        }

        public static Apostador WithoutPassword(this Apostador apostador) {
            apostador.Senha = null;
            return apostador;
        }
    }
}