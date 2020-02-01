using Bookings.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Bookings.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Autherise(Bookings.Models.Staff staffModel)
        {
            using (BookingsModel.ModelBookings db = new BookingsModel.ModelBookings())
            {
                var userDetails = db.Staffs.Where(x => x.Username == staffModel.Username && 
                x.Password == staffModel.Password).FirstOrDefault();
                if (userDetails == null)
                {
                    staffModel.LoginErrorMessage = "Wrong Username or Password, please retry!";
                    return View("Index", staffModel);
                }
                else
                {
                    Session["StaffID"] = userDetails.StaffID;
                    return RedirectToAction("Index", "Dashboard");
                }
            }
        }
        public ActionResult LogOut()
        {
            Session.Abandon();
            return RedirectToAction("Index", "Login");
        }
    }
}