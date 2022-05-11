using System.ComponentModel.DataAnnotations;

namespace BolaoApi.Models
{
    public class AutentacacaoModel
    {
        [Required]
        public string login { get; set; }

        [Required]
        public string senha { get; set; }
    }
}