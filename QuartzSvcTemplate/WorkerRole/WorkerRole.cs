using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Diagnostics;
using Microsoft.WindowsAzure.ServiceRuntime;
using Quartz.Core;
using Quartz.Impl;
using Quartz;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using WorkerRole.Services.Config;
using WorkerRole.Jobs.Example;
using WorkerRole.Jobs.Interface;
using WorkerRole.Jobs.Abstract;

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
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public static IScheduler Instance
        {
            get
            {
                if (_quartzScheduler == null)
                {
                    Initialize();
                    InitializeScheduler();
                    Console.WriteLine($"Servico Iniciado; Ambiente: {ConfigurationManager.AppSettings["Environment"]}");//LOG DE INICIO

                    Schedule<ExampleJob>("Example");

                    _quartzScheduler.Start();

                    return _quartzScheduler;
                }
                else
                    return _quartzScheduler;
            }

        }

        private static void Schedule<T>(string service) where T : IJob
        {
            Schedule<T>(service, service);
        }

        private static void Schedule<T>(string service, string group) where T : IJob
        {
            try
            {

                if (string.IsNullOrWhiteSpace(service))
                {
                    throw new ArgumentNullException(nameof(service));
                }

                if (!ServicesConfig.Instance.Service(service).Enabled)
                {
                    return;
                }

                var monitorJob = service + ".Job";
                var monitorTrigger = service + ".Trigger";
                group += ".Group";

                var job = JobBuilder.Create<T>()
                                    .StoreDurably(true)
                                    .WithIdentity(monitorJob, group)
                                    .Build();
                job.JobDataMap.Put("email", ServicesConfig.Instance.Service(service).Email);

                _quartzScheduler.AddJob(job, true);

                for (var triggerNumber = 0; triggerNumber < ServicesConfig.Instance.Service(service).Triggers.Count; triggerNumber++)
                {
                    var trigger = TriggerBuilder.Create()
                                                .ForJob(job)
                    .WithIdentity($"{monitorTrigger}.{triggerNumber + 1:000}", group)
                                                .StartNow()
                                                .WithCronSchedule(ServicesConfig.Instance.Service(service).Triggers[triggerNumber])
                                                .Build();

                    _quartzScheduler.ScheduleJob(trigger);
                }

                //LOG JOB AGENDADO

            }
            catch (SchedulerException ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        private static void Initialize()
        {
            //CONEXAO DB ETC ETC

            var baseDirectory = Directory.GetParent(System.IO.Directory.GetCurrentDirectory()).Parent.Parent.FullName + @"\WorkerRole\approot";

            if (!string.IsNullOrWhiteSpace(baseDirectory))
            {
                ServicesConfig.Instance.Initialize(Path.Combine(baseDirectory, "ServicesConfig.xml"));
            }

            //LOG BLABLABLA
        }

        private static async void InitializeScheduler()
        {
            var properties = new NameValueCollection
            {
                ["quartz.scheduler.instanceName"] = "svcCotacoesB3",
                ["quartz.threadPool.type"] = "Quartz.Simpl.SimpleThreadPool, Quartz",
                ["quartz.threadPool.threadCount"] = "5",
                ["quartz.threadPool.threadPriority"] = "1",
                ["quartz.jobStore.misfireThreshold"] = "60000",
                ["quartz.jobStore.type"] = "Quartz.Simpl.RAMJobStore, Quartz"
            };

            ISchedulerFactory schedulerFactory = new StdSchedulerFactory(properties);
            _quartzScheduler = await schedulerFactory.GetScheduler();
        }

        private static Stream GetConfig()
        {
            var resName = typeof(WorkerRole).Assembly.GetManifestResourceNames().FirstOrDefault(a => a.ToUpper().Contains("CONFIG.XML"));

            return typeof(WorkerRole).Assembly.GetManifestResourceStream(resName);
        }
    }
}
