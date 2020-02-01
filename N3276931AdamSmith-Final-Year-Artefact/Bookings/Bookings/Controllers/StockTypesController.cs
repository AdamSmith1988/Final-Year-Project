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
    public class StockTypesController : Controller
    {
        private ModelBookings db = new ModelBookings();

        // GET: StockTypes
        public ActionResult Index()
        {
            return View(db.StockTypes.ToList());
        }

        // GET: StockTypes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StockType stockType = db.StockTypes.Find(id);
            if (stockType == null)
            {
                return HttpNotFound();
            }
            return View(stockType);
        }

        // GET: StockTypes/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: StockTypes/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "StockTypeID,StockTypeName")] StockType stockType)
        {
            if (ModelState.IsValid)
            {
                db.StockTypes.Add(stockType);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(stockType);
        }

        // GET: StockTypes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StockType stockType = db.StockTypes.Find(id);
            if (stockType == null)
            {
                return HttpNotFound();
            }
            return View(stockType);
        }

        // POST: StockTypes/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "StockTypeID,StockTypeName")] StockType stockType)
        {
            if (ModelState.IsValid)
            {
                db.Entry(stockType).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(stockType);
        }

        // GET: StockTypes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StockType stockType = db.StockTypes.Find(id);
            if (stockType == null)
            {
                return HttpNotFound();
            }
            return View(stockType);
        }

        // POST: StockTypes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            StockType stockType = db.StockTypes.Find(id);
            db.StockTypes.Remove(stockType);
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
