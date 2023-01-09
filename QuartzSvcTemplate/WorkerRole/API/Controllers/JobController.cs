using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Quartz;
using System.Web.Http;
using System.Web.Http.Description;
using System.Web.Http.Results;
using System.Net.Http;
using System.Net;

namespace WorkerRole.API.Controllers
{
    [RoutePrefix("api/jobs")]
    public class JobController : ApiController
    {
        [Route("")]
        [ResponseType(typeof(List<IJobDetail>))]
        [HttpGet]
        public HttpResponseMessage Get()
        {
            try
            {
                return Ok(Models.Job.GetJobs());
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }

        [Route("{jobGroup}/{jobName}/last-run-time")]
        [ResponseType(typeof(long))]
        [HttpGet]
        public HttpResponseMessage GetLastRunTime(string jobGroup, string jobName)
        {
            try
            {
                return Ok(Models.Job.GetLastRunTime(jobGroup, jobName));
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }

        [Route("{jobGroup}/{jobName}/run-now")]
        [ResponseType(typeof(long))]
        [HttpGet]
        public HttpResponseMessage Get(string jobGroup, string jobName) 
        {
            try
            {
                return Ok(Models.Job.TriggerJob(jobGroup, jobName));
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }

        [Route("{jobGroup}/{jobName}/{dtRef:datetime}/run-now")]
        [ResponseType(typeof(long))]
        [HttpGet]
        public HttpResponseMessage Get(string jobGroup, string jobName, DateTime dtRef)
        {
            try
            {
                var map = new JobDataMap(new Dictionary<string, DateTime> { { "DT_REFERENCE", dtRef} });

                return Ok(Models.Job.TriggerJob(jobGroup, jobName, map));
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }

        private HttpResponseMessage Ok<T>(T response)
        {
            return Request.CreateResponse(HttpStatusCode.OK, response, Configuration.Formatters.JsonFormatter);
        }

        private HttpResponseMessage BadRequest(Exception ex)
        {
            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
        }
    }
}
