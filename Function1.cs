using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System.Net.Http;
using System.Reflection.Metadata;
using Newtonsoft.Json.Linq;
using System.Net.Http.Headers;

namespace SNRecieverWebHook
{
    public static class Function1
    {

        [FunctionName("SN-ServiceBus-WebHook")]
        public static void Run(
    [ServiceBusTrigger("queue1", Connection = "connection")]
    string myQueueItem,
    Int32 deliveryCount,
    DateTime enqueuedTimeUtc,
    string messageId,
    ILogger log)
        {
            // myQueueItem is the message recieved from ServiceBus
            HttpClient client = new HttpClient();
            var json = JsonConvert.SerializeObject(myQueueItem, Formatting.Indented);
            var stringContent = new StringContent(json);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            log.LogInformation("Queue", stringContent);
            //Send it to your servicenow URL.
            var response = client.PostAsync("https://servicenowdev.nttmsc.my/api/ntt12/kafkaevents", stringContent);
        }
    }
}
