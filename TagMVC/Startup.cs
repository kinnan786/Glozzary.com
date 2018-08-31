using Microsoft.Owin;
using Owin;
using TagMVC;

[assembly: OwinStartup(typeof(Startup))]
namespace TagMVC
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
