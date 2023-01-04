using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace WorkerRole.Services.Config
{
    [Serializable]
    public class Service
    {
        [XmlAttribute("Enabled")]
        public bool Enabled { get; set; }

        [XmlAttribute("Name")]
        public string Name { get; set; }

        [XmlAttribute("Email")]
        public string Email { get; set; }

        [XmlArray("Triggers"), XmlArrayItem("Cron")]
        public List<string> Triggers { get; set; }
    }
}
