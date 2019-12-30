using Microsoft.AspNetCore.Mvc;

namespace BoxOfficeInitiative.Controllers
{
    [Route("/")]
    public class HelloBoxOfficeController
    {
        [HttpGet]
        public ActionResult<string> helloWorld()
        {
            return "Hello, World!";
        }
    }
}
