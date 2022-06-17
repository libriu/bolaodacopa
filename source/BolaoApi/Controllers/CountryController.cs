using BolaoInfra.BLL;
using BolaoInfra.Exception;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BolaoApi.Controllers
{
    public class CountryController : BolaoController
    {
        public IActionResult Index()
        {
            return View();
        }

        [AllowAnonymous]
        [HttpGet("image")]
        public IActionResult GetFlagByImage(string fileName)
        {
            var image = System.IO.File.OpenRead(@"C:\inetpub\wwwroot\images\" + fileName);
            return File(image, "image/png");
        }

        [AllowAnonymous]
        [HttpGet("flag")]
        public IActionResult GetFlagByCountry(int codPais)
        {
            var bll = new PaisBLL();
            var pais = bll.GetById(codPais);
            var image = System.IO.File.OpenRead(@"C:\inetpub\wwwroot\images\" + pais.Arquivo);
            return File(image, "image/png");
        }

        [AllowAnonymous]
        [HttpGet()]
        public IActionResult GetCountry(int codPais)
        {
            try
            {
                var bll = new PaisBLL();
                var pais = bll.GetById(codPais);
                return Ok(pais);
            }
            catch (BolaoException ex)
            {
                return BadRequest(new { message = ex.Mensagem });
            }

        }
    }
}
