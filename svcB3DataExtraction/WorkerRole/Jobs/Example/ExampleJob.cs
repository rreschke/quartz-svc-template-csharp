﻿using System.Configuration;
using WorkerRole.Jobs.Abstract;

namespace WorkerRole.Jobs.Example
{
    public class ExampleJob : BaseJob
    {
        public ExampleJob() : base("Example", typeof(ExampleJob).Namespace.ToString(), ConfigurationManager.AppSettings["EmailList"]) { }

        public override bool Run()
        {
            return true;
        }
    }
}
