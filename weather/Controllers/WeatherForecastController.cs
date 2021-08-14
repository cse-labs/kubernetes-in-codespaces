using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace weather.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class WeatherForecastController : ControllerBase
    {
        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        private readonly ILogger<WeatherForecastController> _logger;

        public WeatherForecastController(ILogger<WeatherForecastController> logger)
        {
            _logger = logger;
        }

        [HttpPost]
        [Dapr.Topic("pubsub", "new")]
        public async Task<ActionResult<WeatherForecast>> PostWeatherForecast(WeatherForecast model, [FromServices] Dapr.Client.DaprClient daprClient)
        {
            await daprClient.SaveStateAsync<WeatherForecast>("statestore", "weather", model);

            return model;
        }

        [HttpGet]
        public IEnumerable<WeatherForecast> Get([FromServices] Dapr.Client.DaprClient daprClient)
        {
            return new List<WeatherForecast> { daprClient.GetStateAsync<WeatherForecast>("statestore", "weather").Result };
        }
    }
}
