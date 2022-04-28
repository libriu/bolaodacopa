using System.ComponentModel.DataAnnotations;

namespace BolaoApi.Models
{
    public class AutentacacaoModel
    {
        [Required]
        public string Login { get; set; }

        [Required]
        public string Senha { get; set; }
    }
}