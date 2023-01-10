using Quartz;
using Quartz.Core;
using Quartz.Impl;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WorkerRole.Jobs.Example;
using WorkerRole.Services.Config;

namespace WorkerRole.Utils
{
    public class Scheduler
    {
        private Scheduler() { }

        public static IScheduler _instance;

        private static readonly object _lock = new object();

        public static IScheduler GetInstance()
        {
            if (_instance == null)
            {
                lock (_lock)
                {
                    if( _instance == null )
                    {
                        Initialize();

                        InitializeScheduler();

                        Console.WriteLine($"Servico Iniciado; Ambiente: {ConfigurationManager.AppSettings["Environment"]}");//LOG DE INICIO
                        ScheduleJobs();

                        _instance.Start();
                    }
                }
            }
            return _instance;
        }

        private static void ScheduleJobs()
        {
            //Aqui vão os serviços
            Schedule<ExampleJob>("Example");
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

                _instance.AddJob(job, true);

                for (var triggerNumber = 0; triggerNumber < ServicesConfig.Instance.Service(service).Triggers.Count; triggerNumber++)
                {
                    var trigger = TriggerBuilder.Create()
                                                .ForJob(job)
                    .WithIdentity($"{monitorTrigger}.{triggerNumber + 1:000}", group)
                                                .StartNow()
                                                .WithCronSchedule(ServicesConfig.Instance.Service(service).Triggers[triggerNumber])
                                                .Build();

                    _instance.ScheduleJob(trigger);
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
            var baseDirectory = AppDomain.CurrentDomain.BaseDirectory;

            if (!string.IsNullOrWhiteSpace(baseDirectory))
            {
                ServicesConfig.Instance.Initialize(Path.Combine(baseDirectory, "ServicesConfig.xml"));
            }
        }

        private static async void InitializeScheduler()
        {
            var properties = new NameValueCollection
            {
                ["quartz.scheduler.instanceName"] = "Quartz",
                ["quartz.threadPool.type"] = "Quartz.Simpl.SimpleThreadPool, Quartz",
                ["quartz.threadPool.threadCount"] = "5",
                ["quartz.threadPool.threadPriority"] = "1",
                ["quartz.jobStore.misfireThreshold"] = "60000",
                ["quartz.jobStore.type"] = "Quartz.Simpl.RAMJobStore, Quartz"
            };

            ISchedulerFactory schedulerFactory = new StdSchedulerFactory(properties);
            _instance = await schedulerFactory.GetScheduler();
        }
    }
}
