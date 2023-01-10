using Microsoft.WindowsAzure.ServiceRuntime;
using Quartz;
using System;
using System.IO;
using System.Linq;
using System.Net;
using System.Web.Http;
using Owin;
using CrystalQuartz.Owin;
using Microsoft.Owin.Hosting;

namespace WorkerRole
{
    public class WorkerRole : RoleEntryPoint
    {
        //private readonly CancellationTokenSource cancellationTokenSource = new CancellationTokenSource();
        //private readonly ManualResetEvent runCompleteEvent = new ManualResetEvent(false);
        public static IScheduler _quartzScheduler;

        public override bool OnStart()
        {
            try
            {
                var startup = ConfigureAppBuilder();
#if DEBUG
                WebApp.Start("http://localhost:9000", startup);
#else
                WebApp.Start("http://+:9000", startup);
#endif

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        private static Action<IAppBuilder> ConfigureAppBuilder()
        {
            void Startup(IAppBuilder app)
            {
                //app.Use(CLASSE_MIDDLEWARE);
                app.UseCrystalQuartz(() => Utils.Scheduler.GetInstance()); //Painel do CrystalQuartz estará em {URL_BASE}/quartz

                var config = new HttpConfiguration();
                config.MapHttpAttributeRoutes();
                app.UseWebApi(config);

                var listener = (HttpListener)app.Properties["System.Net.HttpListener"];
                listener.AuthenticationSchemes = AuthenticationSchemes.Ntlm;
            }

            return Startup;
        }

        private static Stream GetConfig()
        {
            var resName = typeof(WorkerRole).Assembly.GetManifestResourceNames().FirstOrDefault(a => a.ToUpper().Contains("CONFIG.XML"));

            return typeof(WorkerRole).Assembly.GetManifestResourceStream(resName);
        }

        private static void Initialize()
        {
            //Conexao com db e outras coisas úteis
        }
    }
}
