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
    public class StaffAccessesController : Controller
    {
        private ModelBookings db = new ModelBookings();

        // GET: StaffAccesses
        public ActionResult Index()
        {
            var staffAccesses = db.StaffAccesses.Include(s => s.StaffRole).Include(s => s.SystemAuthorization);
            return View(staffAccesses.ToList());
        }

        // GET: StaffAccesses/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StaffAccess staffAccess = db.StaffAccesses.Find(id);
            if (staffAccess == null)
            {
                return HttpNotFound();
            }
            return View(staffAccess);
        }

        // GET: StaffAccesses/Create
        public ActionResult Create()
        {
            ViewBag.StaffRoleID = new SelectList(db.StaffRoles, "StaffRoleID", "RoleName");
            ViewBag.SystemAuthorizationID = new SelectList(db.SystemAuthorizations, "SystemAuthorizationID", "Add_Edit_Del");
            return View();
        }

        // POST: StaffAccesses/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "StaffAccessID,SystemAuthorizationID,StaffRoleID,IsAccessible")] StaffAccess staffAccess)
        {
            if (ModelState.IsValid)
            {
                db.StaffAccesses.Add(staffAccess);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.StaffRoleID = new SelectList(db.StaffRoles, "StaffRoleID", "RoleName", staffAccess.StaffRoleID);
            ViewBag.SystemAuthorizationID = new SelectList(db.SystemAuthorizations, "SystemAuthorizationID", "Add_Edit_Del", staffAccess.SystemAuthorizationID);
            return View(staffAccess);
        }

        // GET: StaffAccesses/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StaffAccess staffAccess = db.StaffAccesses.Find(id);
            if (staffAccess == null)
            {
                return HttpNotFound();
            }
            ViewBag.StaffRoleID = new SelectList(db.StaffRoles, "StaffRoleID", "RoleName", staffAccess.StaffRoleID);
            ViewBag.SystemAuthorizationID = new SelectList(db.SystemAuthorizations, "SystemAuthorizationID", "Add_Edit_Del", staffAccess.SystemAuthorizationID);
            return View(staffAccess);
        }

        // POST: StaffAccesses/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "StaffAccessID,SystemAuthorizationID,StaffRoleID,IsAccessible")] StaffAccess staffAccess)
        {
            if (ModelState.IsValid)
            {
                db.Entry(staffAccess).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.StaffRoleID = new SelectList(db.StaffRoles, "StaffRoleID", "RoleName", staffAccess.StaffRoleID);
            ViewBag.SystemAuthorizationID = new SelectList(db.SystemAuthorizations, "SystemAuthorizationID", "Add_Edit_Del", staffAccess.SystemAuthorizationID);
            return View(staffAccess);
        }

        // GET: StaffAccesses/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StaffAccess staffAccess = db.StaffAccesses.Find(id);
            if (staffAccess == null)
            {
                return HttpNotFound();
            }
            return View(staffAccess);
        }

        // POST: StaffAccesses/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            StaffAccess staffAccess = db.StaffAccesses.Find(id);
            db.StaffAccesses.Remove(staffAccess);
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
