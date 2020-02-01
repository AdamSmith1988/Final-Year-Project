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
    public class StaffRolesController : Controller
    {
        private ModelBookings db = new ModelBookings();

        // GET: StaffRoles
        public ActionResult Index()
        {
            return View(db.StaffRoles.ToList());
        }

        // GET: StaffRoles/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StaffRole staffRole = db.StaffRoles.Find(id);
            if (staffRole == null)
            {
                return HttpNotFound();
            }
            return View(staffRole);
        }

        // GET: StaffRoles/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: StaffRoles/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "StaffRoleID,RoleName")] StaffRole staffRole)
        {
            if (ModelState.IsValid)
            {
                db.StaffRoles.Add(staffRole);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(staffRole);
        }

        // GET: StaffRoles/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StaffRole staffRole = db.StaffRoles.Find(id);
            if (staffRole == null)
            {
                return HttpNotFound();
            }
            return View(staffRole);
        }

        // POST: StaffRoles/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "StaffRoleID,RoleName")] StaffRole staffRole)
        {
            if (ModelState.IsValid)
            {
                db.Entry(staffRole).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(staffRole);
        }

        // GET: StaffRoles/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StaffRole staffRole = db.StaffRoles.Find(id);
            if (staffRole == null)
            {
                return HttpNotFound();
            }
            return View(staffRole);
        }

        // POST: StaffRoles/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            StaffRole staffRole = db.StaffRoles.Find(id);
            db.StaffRoles.Remove(staffRole);
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
