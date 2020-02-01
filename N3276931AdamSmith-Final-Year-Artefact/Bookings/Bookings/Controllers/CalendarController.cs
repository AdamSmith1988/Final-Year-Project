using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BookingsModel;
//using FullCalendar;

/// <summary>
///  A lot of code from this CalendarController class was taken from:
///  sourav mondal . (2017). CRUD operation on fullcalendar in ASP.NET MVC. Available: http://www.dotnetawesome.com/. Last accessed 16th Mar 2018.
/// </summary>

namespace Bookings.Controllers
{
    public class CalendarController : Controller
    {
        BookingsModel.ModelBookings db = new BookingsModel.ModelBookings();
        // GET: Calendar
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult GetEvents() {
            using (BookingsModel.ModelBookings db = new BookingsModel.ModelBookings()) {
                var events = db.Events.ToList();
                return new JsonResult { Data = events, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
            }
        }

        [HttpPost]
        public JsonResult SaveEvent(Events e)
        {
            var status = false;
            var r = db.Events.ToList();
            using (BookingsModel.ModelBookings db = new BookingsModel.ModelBookings())
            {
                if (e.EventID > 0)
                {
                    //Update event
                    var v = db.Events.Where(a => a.EventID == e.EventID).FirstOrDefault();
                    if (v != null)
                    {
                        v.Subject = e.Subject;
                        v.Start = e.Start;
                        v.End = e.End;
                        v.Description = e.Description;
                        v.IsFullDay = e.IsFullDay;
                        v.ThemeColor = e.ThemeColor;
                    }
                }
                else
                {
                    db.Events.Add(e);
                }
                db.SaveChanges();
                status = true;
            }
                return new JsonResult { Data = new { status = status } };
        }

        [HttpPost]
        public JsonResult DeleteEvent(int eventID)
        {
            var status = false;
            using (BookingsModel.ModelBookings db = new BookingsModel.ModelBookings())
            {
                var v = db.Events.Where(a => a.EventID == eventID).FirstOrDefault();
                if (v != null)
                {
                    db.Events.Remove(v);
                    db.SaveChanges();
                    status = true;
                }
            }
                return new JsonResult { Data = new { status = status } };
        }
    }
}