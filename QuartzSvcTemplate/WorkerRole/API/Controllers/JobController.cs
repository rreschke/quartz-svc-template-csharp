using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Quartz;
using System.Web.Http;
using System.Web.Http.Description;
using System.Web.Http.Results;

namespace WorkerRole.API.Controllers
{
    [RoutePrefix("api/jobs")]
    public class JobController : ApiController
    {
        [Route("")]
        [ResponseType(typeof(List<IJobDetail>))]
        [HttpGet]
        public IHttpActionResult Get()
        {
            try
            {
                return Ok(Models.Job.GetJobs());
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [Route("{jobGroup}/{jobName}/last-run-time")]
        [ResponseType(typeof(long))]
        [HttpGet]
        public IHttpActionResult GetLastRunTime(string jobGroup, string jobName)
        {
            try
            {
                return Ok(Models.Job.GetLastRunTime(jobGroup, jobName));
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [Route("{jobGroup}/{jobName}/run-now")]
        [ResponseType(typeof(long))]
        [HttpGet]
        public IHttpActionResult Get(string jobGroup, string jobName) 
        {
            try
            {
                return Ok(Models.Job.TriggerJob(jobGroup, jobName));
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [Route("{jobGroup}/{jobName}/{dtRef:datetime}/run-now")]
        [ResponseType(typeof(long))]
        [HttpGet]
        public IHttpActionResult Get(string jobGroup, string jobName, DateTime dtRef)
        {
            try
            {
                var map = new JobDataMap(new Dictionary<string, DateTime> { { "DT_REFERENCE", dtRef} });

                return Ok(Models.Job.TriggerJob(jobGroup, jobName, map));
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        protected override BadRequestErrorMessageResult BadRequest(string message)
        {
            //LOG BLABLABLA
            return new BadRequestErrorMessageResult(message, this);
        }
    }
}
