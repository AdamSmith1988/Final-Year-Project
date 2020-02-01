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
    public class SystemAuthorizationsController : Controller
    {
        private ModelBookings db = new ModelBookings();

        // GET: SystemAuthorizations
        public ActionResult Index()
        {
            return View(db.SystemAuthorizations.ToList());
        }

        // GET: SystemAuthorizations/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SystemAuthorization systemAuthorization = db.SystemAuthorizations.Find(id);
            if (systemAuthorization == null)
            {
                return HttpNotFound();
            }
            return View(systemAuthorization);
        }

        // GET: SystemAuthorizations/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: SystemAuthorizations/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "SystemAuthorizationID,Add_Edit_Del,AuthorzationName")] SystemAuthorization systemAuthorization)
        {
            if (ModelState.IsValid)
            {
                db.SystemAuthorizations.Add(systemAuthorization);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(systemAuthorization);
        }

        // GET: SystemAuthorizations/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SystemAuthorization systemAuthorization = db.SystemAuthorizations.Find(id);
            if (systemAuthorization == null)
            {
                return HttpNotFound();
            }
            return View(systemAuthorization);
        }

        // POST: SystemAuthorizations/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "SystemAuthorizationID,Add_Edit_Del,AuthorzationName")] SystemAuthorization systemAuthorization)
        {
            if (ModelState.IsValid)
            {
                db.Entry(systemAuthorization).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(systemAuthorization);
        }

        // GET: SystemAuthorizations/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SystemAuthorization systemAuthorization = db.SystemAuthorizations.Find(id);
            if (systemAuthorization == null)
            {
                return HttpNotFound();
            }
            return View(systemAuthorization);
        }

        // POST: SystemAuthorizations/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            SystemAuthorization systemAuthorization = db.SystemAuthorizations.Find(id);
            db.SystemAuthorizations.Remove(systemAuthorization);
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
