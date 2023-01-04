using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WorkerRole.Jobs.Interface
{
    public interface IRunnable : IDisposable
    {
        bool Run();
        void NotifySuccess();
        void NotifyError();
        void NotifyError(string message);
    }
}
