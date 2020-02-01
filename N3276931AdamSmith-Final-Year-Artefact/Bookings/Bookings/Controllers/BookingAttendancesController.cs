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
    public class BookingAttendancesController : Controller
    {
        private ModelBookings db = new ModelBookings();

        // GET: BookingAttendances
        public ActionResult Index()
        {
            var bookingAttendances = db.BookingAttendances.Include(b => b.Booking).Include(b => b.Customer);
            return View(bookingAttendances.ToList());
        }

        // GET: BookingAttendances/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BookingAttendance bookingAttendance = db.BookingAttendances.Find(id);
            if (bookingAttendance == null)
            {
                return HttpNotFound();
            }
            return View(bookingAttendance);
        }

        // GET: BookingAttendances/Create
        public ActionResult Create()
        {
            ViewBag.BookingID = new SelectList(db.Bookings, "BookingID", "Notes");
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerId", "FirstName");
            return View();
        }

        // POST: BookingAttendances/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "AttendanceID,BookingID,CustomerID,Attended")] BookingAttendance bookingAttendance)
        {
            if (ModelState.IsValid)
            {
                db.BookingAttendances.Add(bookingAttendance);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.BookingID = new SelectList(db.Bookings, "BookingID", "Notes", bookingAttendance.BookingID);
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerId", "FirstName", bookingAttendance.CustomerID);
            return View(bookingAttendance);
        }

        // GET: BookingAttendances/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BookingAttendance bookingAttendance = db.BookingAttendances.Find(id);
            if (bookingAttendance == null)
            {
                return HttpNotFound();
            }
            ViewBag.BookingID = new SelectList(db.Bookings, "BookingID", "Notes", bookingAttendance.BookingID);
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerId", "FirstName", bookingAttendance.CustomerID);
            return View(bookingAttendance);
        }

        // POST: BookingAttendances/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "AttendanceID,BookingID,CustomerID,Attended")] BookingAttendance bookingAttendance)
        {
            if (ModelState.IsValid)
            {
                db.Entry(bookingAttendance).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.BookingID = new SelectList(db.Bookings, "BookingID", "Notes", bookingAttendance.BookingID);
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerId", "FirstName", bookingAttendance.CustomerID);
            return View(bookingAttendance);
        }

        // GET: BookingAttendances/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            BookingAttendance bookingAttendance = db.BookingAttendances.Find(id);
            if (bookingAttendance == null)
            {
                return HttpNotFound();
            }
            return View(bookingAttendance);
        }

        // POST: BookingAttendances/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            BookingAttendance bookingAttendance = db.BookingAttendances.Find(id);
            db.BookingAttendances.Remove(bookingAttendance);
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
