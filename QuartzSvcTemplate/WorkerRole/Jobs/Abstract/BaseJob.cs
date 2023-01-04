using Quartz;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Threading.Tasks;
using WorkerRole.Jobs.Interface;
using static Quartz.Logging.OperationName;

namespace WorkerRole.Jobs.Abstract
{
    public abstract class BaseJob : IRunnable, IJob
    {
        protected readonly List<Exception> _errors = new List<Exception>();
        protected readonly string _jobName;
        protected readonly string _processScope;
        public string _emailList;
        public DateTime _dtReference = DateTime.MinValue;

        public BaseJob(string jobName, string processScope, string emailList = "")
        {
            _jobName = jobName;
            _processScope = processScope;
            _emailList = emailList;
        }

        public void Dispose()
        {
            _errors.Clear();
        }

        public Task Execute(IJobExecutionContext context)
        {
            this._emailList = (string)context.MergedJobDataMap["emailList"];

            if (context.MergedJobDataMap.ContainsKey("DT_REFERENCE"))
            {
                this._dtReference = (DateTime)context.MergedJobDataMap["DT_REFERENCE"];
            }

            try
            {
                //log4net.Debug($"Running {context.JobDetail.Key.Name}");
                if (this.Run())
                    this.NotifySuccess();
                else
                    this.NotifyError();
            }
            catch (Exception ex)
            {
                //log4net.Appender.LogException(ex);
                this.NotifyError($"[ERRO] Quartz - Job: {context.JobDetail.Key.Name} Ambiente: {ConfigurationManager.AppSettings["Environment"]}");
            }

            return Task.CompletedTask;
        }

        public void NotifyError()
        {

        }

        public void NotifyError(string message)
        {

        }

        public void NotifySuccess()
        {

        }

        public abstract bool Run();
    }
}
