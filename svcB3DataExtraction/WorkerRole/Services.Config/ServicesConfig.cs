using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace WorkerRole.Services.Config
{
    [Serializable]
    [XmlRoot(ElementName = "config")]
    public class ServicesConfig
    {
        private static ServicesConfig _servicesConfig;

        public static ServicesConfig Instance
        {
            get { return _servicesConfig = _servicesConfig ?? new ServicesConfig(); }
            set => _servicesConfig = value;
        }

        [XmlArray("Services"), XmlArrayItem("Service")]
        public List<Service> Services { get; set; }
    }

    public static class ServicesConfigExtensions
    {
        public static ServicesConfig Initialize(this ServicesConfig servicesConfig, string fileName)
        {
            var ser = new XmlSerializer(typeof(ServicesConfig));

            ServicesConfig.Instance = (ServicesConfig)ser.Deserialize(System.IO.File.OpenText(fileName));

            return ServicesConfig.Instance;
        }

        public static Service Service(this ServicesConfig servicesConfig, string serviceName)
        {
            return servicesConfig.Services.FirstOrDefault(s => string.Equals(s.Name, serviceName, StringComparison.CurrentCultureIgnoreCase));
        }
    }
}
