using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using BookingsModel;

namespace Bookings.Controllers
{
    public class BookingTimesController : Controller
    {
        private ModelBookings db = new ModelBookings();

        // GET: BookingTimes
        public ActionResult Index()
        {
            var bookingTimes = db.BookingTimes.Include(b => b.Booking);
            return View(bookingTimes.ToList());
        }

        // GET: BookingTimes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BookingTime bookingTime = db.BookingTimes.Find(id);
            if (bookingTime == null)
            {
                return HttpNotFound();
            }
            return View(bookingTime);
        }

        // GET: BookingTimes/Create
        public ActionResult Create()
        {
            ViewBag.BookingID = new SelectList(db.Bookings, "BookingID", "Notes");
            return View();
        }

        // POST: BookingTimes/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "BookingTimeID,BookingID,Date,TimeStart,Duration")] BookingTime bookingTime)
        {
            if (ModelState.IsValid)
            {
                db.BookingTimes.Add(bookingTime);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.BookingID = new SelectList(db.Bookings, "BookingID", "Notes", bookingTime.BookingID);
            return View(bookingTime);
        }

        // GET: BookingTimes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BookingTime bookingTime = db.BookingTimes.Find(id);
            if (bookingTime == null)
            {
                return HttpNotFound();
            }
            ViewBag.BookingID = new SelectList(db.Bookings, "BookingID", "Notes", bookingTime.BookingID);
            return View(bookingTime);
        }

        // POST: BookingTimes/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "BookingTimeID,BookingID,Date,TimeStart,Duration")] BookingTime bookingTime)
        {
            if (ModelState.IsValid)
            {
                db.Entry(bookingTime).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.BookingID = new SelectList(db.Bookings, "BookingID", "Notes", bookingTime.BookingID);
            return View(bookingTime);
        }

        // GET: BookingTimes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BookingTime bookingTime = db.BookingTimes.Find(id);
            if (bookingTime == null)
            {
                return HttpNotFound();
            }
            return View(bookingTime);
        }

        // POST: BookingTimes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            BookingTime bookingTime = db.BookingTimes.Find(id);
            db.BookingTimes.Remove(bookingTime);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
