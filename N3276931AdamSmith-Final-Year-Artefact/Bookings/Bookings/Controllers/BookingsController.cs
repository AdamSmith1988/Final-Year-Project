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
    public class BookingsController : Controller
    {
        private ModelBookings db = new ModelBookings();

        // GET: Bookings
        public ActionResult Index()//Get all the staff members from the company of the staff member logged in.
        {
            int staffID = (int)Session["StaffID"];
            var staffRecord = db.Staffs.FirstOrDefault(staff => staff.StaffID == staffID);
            var company = staffRecord.Company;
            var bookingsForCompany = company.Bookings;
            return View(bookingsForCompany);
        }

        // GET: Bookings/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Booking booking = db.Bookings.Find(id);
            if (booking == null)
            {
                return HttpNotFound();
            }
            return View(booking);
        }

        // GET: Bookings/Create
        public ActionResult Create()
        {
            ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName");
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerId", "FirstName");
            ViewBag.ServiceID = new SelectList(db.Services, "ServiceID", "ServiceName");
            return View();
        }

        // POST: Bookings/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "BookingID,ServiceID,StaffID,CompanyID,CustomerID,Notes,Active")] Booking booking)
        {
            if (ModelState.IsValid)
            {
                db.Bookings.Add(booking);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName", booking.CompanyID);
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerId", "FirstName", booking.CustomerID);
            ViewBag.ServiceID = new SelectList(db.Services, "ServiceID", "ServiceName", booking.ServiceID);
            return View(booking);
        }

        // GET: Bookings/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Booking booking = db.Bookings.Find(id);
            if (booking == null)
            {
                return HttpNotFound();
            }
            ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName", booking.CompanyID);
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerId", "FirstName", booking.CustomerID);
            ViewBag.ServiceID = new SelectList(db.Services, "ServiceID", "ServiceName", booking.ServiceID);
            return View(booking);
        }

        // POST: Bookings/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "BookingID,ServiceID,StaffID,CompanyID,CustomerID,Notes,Active")] Booking booking)
        {
            if (ModelState.IsValid)
            {
                db.Entry(booking).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName", booking.CompanyID);
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerId", "FirstName", booking.CustomerID);
            ViewBag.ServiceID = new SelectList(db.Services, "ServiceID", "ServiceName", booking.ServiceID);
            return View(booking);
        }

        // GET: Bookings/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Booking booking = db.Bookings.Find(id);
            if (booking == null)
            {
                return HttpNotFound();
            }
            return View(booking);
        }

        // POST: Bookings/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Booking booking = db.Bookings.Find(id);
            db.Bookings.Remove(booking);
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
