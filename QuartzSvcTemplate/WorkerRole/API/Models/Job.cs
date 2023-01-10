using System;
using System.Collections.Generic;
using System.Linq;
using CrystalQuartz.Core.Utils;
using Quartz;
using Quartz.Impl.Matchers;

namespace WorkerRole.API.Models
{
    public class Job
    {
        private static IScheduler _scheduler = Utils.Scheduler.GetInstance();

        public string Group { get; set; }

        public string Name { get; set; }

        public static IEnumerable<Job> GetJobs()
        {
            return _scheduler.GetJobKeys(GroupMatcher<JobKey>.AnyGroup()).Result
                             .Select(jobKey => _scheduler.GetJobDetail(jobKey).Result.Key)
                             .Select(key => new Job { Group = key.Group, Name = key.Name}); 
        }

        public static long GetLastRunTime(string jobGroup, string jobName)
        {
            var key = new JobKey(jobName, jobGroup);
            var prevFireTimeUTC = _scheduler.GetTriggersOfJob(key).Result.Max(t => t.GetPreviousFireTimeUtc());

            if(prevFireTimeUTC != null)
            {
                var dateTime = prevFireTimeUTC.ToDateTime();

                if(dateTime != null)
                {
                    return dateTime.Value.ToLocalTime().Ticks;
                }
            }
            return 0;
        }

        public static long TriggerJob(string jobGroup, string jobName, JobDataMap map = null)
        {
            var job = _scheduler.GetJobDetail(new JobKey(jobName, jobGroup)).Result;

            if(_scheduler.GetCurrentlyExecutingJobs().Result.Any(runningJob => Equals(runningJob.JobDetail, job)))
            {
                throw new InvalidOperationException("Job already running");
            }

            _scheduler.TriggerJob(job.Key, map);

            return DateTime.Now.Ticks;
        }
    }
}
