using Microsoft.AspNetCore.Mvc;
using MercadoPago.Config;
using MercadoPago.Client.Common;
using MercadoPago.Client.Payment;
using MercadoPago.Resource.Payment;
using Microsoft.AspNetCore.Authorization;
using System.Threading.Tasks;
using BolaoApi.Models;
using System.Collections.Generic;
using BolaoInfra.BLL;
using BolaoInfra.Models;
using System.Net.Http;
using System;
using System.Net.Http.Headers;
using System.Text.RegularExpressions;
using Newtonsoft.Json.Linq;

namespace BolaoApi.Controllers
{
    public class MercadoPagoController : BolaoController
    {
        static HttpClient client = new HttpClient();

        private const string accessToken = "APP_USR-8392580964738331-101907-a646c1149030d3625cbf63b1532319f2-45998451";

        [AllowAnonymous]
        public async Task<IActionResult> Index()
        {
            ApostadorBLL bll = new();
            var apostadores = bll.GetInactive();
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);

            foreach (Apostador apostador in apostadores)
            {
                if (!string.IsNullOrEmpty(apostador.IdPagamento))
                {
                   
                    //client.BaseAddress = new Uri("https://api.mercadopago.com/");
                    
                    //client.DefaultRequestHeaders.Accept.Clear();
                    //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    HttpResponseMessage response = await client.GetAsync("https://api.mercadopago.com/v1/payments/" + apostador.IdPagamento.ToString());
                    response.EnsureSuccessStatusCode();

                    // return URI of the created resource.
                    var str = await response.Content.ReadAsStringAsync();

                    JObject json = JObject.Parse(str);

                    if (json.ContainsKey("status") && json["status"].ToString() == "approved")
                    {
                        apostador.Ativo = 1;
                        bll.Update(apostador);
                    }

                }
            }
            return Ok();
        }

        [AllowAnonymous]
        [HttpPost("create")]
        public async Task<JsonResult> CreateAsync(PayerData payerData) //, string IdentificationType, string IdentificationNumber)
        {
            MercadoPagoConfig.AccessToken = accessToken;
            DateTime expire = new(2022,11,19,23,59,59, DateTimeKind.Local);

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
                DateOfExpiration = expire
            };

            var client = new PaymentClient();
            Payment payment = await client.CreateAsync(request);
            var result = new Dictionary<string, string>();
            result.Add("Id", payment.Id.ToString());
            result.Add("QrCodeBase64", payment.PointOfInteraction.TransactionData.QrCodeBase64);
            result.Add("QrCode", payment.PointOfInteraction.TransactionData.QrCode);
            result.Add("TicketUrl", payment.PointOfInteraction.TransactionData.TicketUrl);
            return Json(result);
        }
    }
}
