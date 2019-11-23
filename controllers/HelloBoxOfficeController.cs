using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;

namespace boxofficeinitiative
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var host = Host.CreateDefaultBuilder()
                .ConfigureWebHostDefaults(webBuilder => {
                    webBuilder.Configure(app => {
                        app.UseHttpsRedirection()
                            .Run(async context => {
                                await context.Response.WriteAsync("Hello Box Office Initiative!");
                            });
                    });
                });
            host.Build().Run();
        }
    }
}