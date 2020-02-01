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
    public class CompanyOpeningHoursController : Controller
    {
        private ModelBookings db = new ModelBookings();

        // GET: CompanyOpeningHours
        public ActionResult Index()
        {
            var companyOpeningHours = db.CompanyOpeningHours.Include(c => c.Company);
            return View(companyOpeningHours.ToList());
        }

        // GET: CompanyOpeningHours/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CompanyOpeningHour companyOpeningHour = db.CompanyOpeningHours.Find(id);
            if (companyOpeningHour == null)
            {
                return HttpNotFound();
            }
            return View(companyOpeningHour);
        }

        // GET: CompanyOpeningHours/Create
        public ActionResult Create()
        {
            ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName");
            return View();
        }

        // POST: CompanyOpeningHours/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "OpeningTimeID,CompanyID,DayOfWeek,OpeningTime,ClosingTime,NotesIfClosed")] CompanyOpeningHour companyOpeningHour)
        {
            if (ModelState.IsValid)
            {
                db.CompanyOpeningHours.Add(companyOpeningHour);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName", companyOpeningHour.CompanyID);
            return View(companyOpeningHour);
        }

        // GET: CompanyOpeningHours/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CompanyOpeningHour companyOpeningHour = db.CompanyOpeningHours.Find(id);
            if (companyOpeningHour == null)
            {
                return HttpNotFound();
            }
            ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName", companyOpeningHour.CompanyID);
            return View(companyOpeningHour);
        }

        // POST: CompanyOpeningHours/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "OpeningTimeID,CompanyID,DayOfWeek,OpeningTime,ClosingTime,NotesIfClosed")] CompanyOpeningHour companyOpeningHour)
        {
            if (ModelState.IsValid)
            {
                db.Entry(companyOpeningHour).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName", companyOpeningHour.CompanyID);
            return View(companyOpeningHour);
        }

        // GET: CompanyOpeningHours/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CompanyOpeningHour companyOpeningHour = db.CompanyOpeningHours.Find(id);
            if (companyOpeningHour == null)
            {
                return HttpNotFound();
            }
            return View(companyOpeningHour);
        }

        // POST: CompanyOpeningHours/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            CompanyOpeningHour companyOpeningHour = db.CompanyOpeningHours.Find(id);
            db.CompanyOpeningHours.Remove(companyOpeningHour);
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
