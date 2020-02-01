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
    public class CompanyReviewsController : Controller
    {
        private ModelBookings db = new ModelBookings();

        // GET: CompanyReviews
        public ActionResult Index()
        {
            var companyReviews = db.CompanyReviews.Include(c => c.Company).Include(c => c.Customer);
            return View(companyReviews.ToList());
        }

        // GET: CompanyReviews/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CompanyReview companyReview = db.CompanyReviews.Find(id);
            if (companyReview == null)
            {
                return HttpNotFound();
            }
            return View(companyReview);
        }

        // GET: CompanyReviews/Create
        public ActionResult Create()
        {
            ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName");
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerId", "FirstName");
            return View();
        }

        // POST: CompanyReviews/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "CompanyReviewsID,CompanyID,CustomerID,Rating,Comments")] CompanyReview companyReview)
        {
            if (ModelState.IsValid)
            {
                db.CompanyReviews.Add(companyReview);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName", companyReview.CompanyID);
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerId", "FirstName", companyReview.CustomerID);
            return View(companyReview);
        }

        // GET: CompanyReviews/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CompanyReview companyReview = db.CompanyReviews.Find(id);
            if (companyReview == null)
            {
                return HttpNotFound();
            }
            ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName", companyReview.CompanyID);
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerId", "FirstName", companyReview.CustomerID);
            return View(companyReview);
        }

        // POST: CompanyReviews/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "CompanyReviewsID,CompanyID,CustomerID,Rating,Comments")] CompanyReview companyReview)
        {
            if (ModelState.IsValid)
            {
                db.Entry(companyReview).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName", companyReview.CompanyID);
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerId", "FirstName", companyReview.CustomerID);
            return View(companyReview);
        }

        // GET: CompanyReviews/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CompanyReview companyReview = db.CompanyReviews.Find(id);
            if (companyReview == null)
            {
                return HttpNotFound();
            }
            return View(companyReview);
        }

        // POST: CompanyReviews/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            CompanyReview companyReview = db.CompanyReviews.Find(id);
            db.CompanyReviews.Remove(companyReview);
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
