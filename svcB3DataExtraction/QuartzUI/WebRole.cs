using CrystalQuartz.Owin;
using Microsoft.Owin.Hosting;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Diagnostics;
using Microsoft.WindowsAzure.ServiceRuntime;
using Owin;
using Quartz;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.EnterpriseServices;
using System.IO;
using System.Linq;
using System.Net;
using System.Web.Http;

namespace QuartzUI
{
    public class WebRole : RoleEntryPoint
    {
        public static IScheduler _quartzScheduler;

        public override bool OnStart()
        {
            IScheduler scheduler = WorkerRole.WorkerRole.Instance;

            try
            {   
                var startup = ConfigureAppBuilder(scheduler);
#if DEBUG
                WebApp.Start("http://localhost:9000/QuartzSvcExample", startup);
#else
                WebApp.Start("http://+:9000/QuartzSvcExample", startup);
#endif

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }

        }

        public override void OnStop()
        {
        }

        private static Action<IAppBuilder> ConfigureAppBuilder(IScheduler scheduler)
        {
            void Startup(IAppBuilder app)
            {
                //app.Use(CLASSE_MIDDLEWARE);
                app.UseCrystalQuartz(() => scheduler);

                var config = new HttpConfiguration();
                config.MapHttpAttributeRoutes();
                app.UseWebApi(config);

                var listener = (HttpListener)app.Properties["System.Net.HttpListener"];
                listener.AuthenticationSchemes = AuthenticationSchemes.Ntlm;
            }

            return Startup;
        }
    }
}
