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
    public class EquiptmentNeededsController : Controller
    {
        private ModelBookings db = new ModelBookings();

        // GET: EquiptmentNeededs
        public ActionResult Index()
        {
            var equiptmentNeededs = db.EquiptmentNeededs.Include(e => e.Equiptment).Include(e => e.Service);
            return View(equiptmentNeededs.ToList());
        }

        // GET: EquiptmentNeededs/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EquiptmentNeeded equiptmentNeeded = db.EquiptmentNeededs.Find(id);
            if (equiptmentNeeded == null)
            {
                return HttpNotFound();
            }
            return View(equiptmentNeeded);
        }

        // GET: EquiptmentNeededs/Create
        public ActionResult Create()
        {
            ViewBag.EquiptmentID = new SelectList(db.Equiptments, "EquiptmentID", "EquiptmentName");
            ViewBag.ServiceID = new SelectList(db.Services, "ServiceID", "ServiceName");
            return View();
        }

        // POST: EquiptmentNeededs/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "EquiptmentNeededID,ServiceID,EquiptmentID,Quantity")] EquiptmentNeeded equiptmentNeeded)
        {
            if (ModelState.IsValid)
            {
                db.EquiptmentNeededs.Add(equiptmentNeeded);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.EquiptmentID = new SelectList(db.Equiptments, "EquiptmentID", "EquiptmentName", equiptmentNeeded.EquiptmentID);
            ViewBag.ServiceID = new SelectList(db.Services, "ServiceID", "ServiceName", equiptmentNeeded.ServiceID);
            return View(equiptmentNeeded);
        }

        // GET: EquiptmentNeededs/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EquiptmentNeeded equiptmentNeeded = db.EquiptmentNeededs.Find(id);
            if (equiptmentNeeded == null)
            {
                return HttpNotFound();
            }
            ViewBag.EquiptmentID = new SelectList(db.Equiptments, "EquiptmentID", "EquiptmentName", equiptmentNeeded.EquiptmentID);
            ViewBag.ServiceID = new SelectList(db.Services, "ServiceID", "ServiceName", equiptmentNeeded.ServiceID);
            return View(equiptmentNeeded);
        }

        // POST: EquiptmentNeededs/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "EquiptmentNeededID,ServiceID,EquiptmentID,Quantity")] EquiptmentNeeded equiptmentNeeded)
        {
            if (ModelState.IsValid)
            {
                db.Entry(equiptmentNeeded).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.EquiptmentID = new SelectList(db.Equiptments, "EquiptmentID", "EquiptmentName", equiptmentNeeded.EquiptmentID);
            ViewBag.ServiceID = new SelectList(db.Services, "ServiceID", "ServiceName", equiptmentNeeded.ServiceID);
            return View(equiptmentNeeded);
        }

        // GET: EquiptmentNeededs/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EquiptmentNeeded equiptmentNeeded = db.EquiptmentNeededs.Find(id);
            if (equiptmentNeeded == null)
            {
                return HttpNotFound();
            }
            return View(equiptmentNeeded);
        }

        // POST: EquiptmentNeededs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            EquiptmentNeeded equiptmentNeeded = db.EquiptmentNeededs.Find(id);
            db.EquiptmentNeededs.Remove(equiptmentNeeded);
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
