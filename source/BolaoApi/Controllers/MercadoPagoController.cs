using Microsoft.AspNetCore.Mvc;
using MercadoPago.Config;
using MercadoPago.Client.Common;
using MercadoPago.Client.Payment;
using MercadoPago.Resource.Payment;
using Microsoft.AspNetCore.Authorization;
using System.Threading.Tasks;
using BolaoApi.Models;
using System.Collections.Generic;

namespace BolaoApi.Controllers
{
    public class MercadoPagoController : BolaoController
    {
        public IActionResult Index()
        {
            return View();
        }

        [AllowAnonymous]
        [HttpPost("create")]
        public async Task<JsonResult> CreateAsync(PayerData payerData) //, string IdentificationType, string IdentificationNumber)
        {
            MercadoPagoConfig.AccessToken = "TEST-8392580964738331-101907-3e3b4cf18f144f9dd00e1aade688ed19-45998451";

            var request = new PaymentCreateRequest
            {
                TransactionAmount = 20,
                Description = "Inscrição do Bolão da Copa 2022",
                PaymentMethodId = "pix",
                Payer = new PaymentPayerRequest
                {
                    Email = payerData.Email,
                    FirstName = payerData.FirstName,
                    LastName = payerData.LastName,
                    //Identification = new IdentificationRequest
                    //{
                    //    Type = "CPF",
                    //    Number = "79502555520", // Verificar formato: 191191191-00
                    //},
                },
            };

            var client = new PaymentClient();
            Payment payment = await client.CreateAsync(request);
            var result = new Dictionary<string, string>();
            result.Add("QrCodeBase64", payment.PointOfInteraction.TransactionData.QrCodeBase64);
            result.Add("QrCode", payment.PointOfInteraction.TransactionData.QrCode);
            result.Add("TicketUrl", payment.PointOfInteraction.TransactionData.TicketUrl);
            return Json(result);
        }
    }
}
