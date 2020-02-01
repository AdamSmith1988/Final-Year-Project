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
    public class StockLevelsController : Controller
    {
        private ModelBookings db = new ModelBookings();

        // GET: StockLevels
        public ActionResult Index()
        {
            var stockLevels = db.StockLevels.Include(s => s.Stock);
            return View(stockLevels.ToList());
        }

        // GET: StockLevels/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StockLevel stockLevel = db.StockLevels.Find(id);
            if (stockLevel == null)
            {
                return HttpNotFound();
            }
            return View(stockLevel);
        }

        // GET: StockLevels/Create
        public ActionResult Create()
        {
            ViewBag.StockID = new SelectList(db.Stocks, "StockID", "ProductName");
            return View();
        }

        // POST: StockLevels/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ProductStockLevelID,StockID,ProductStockLevel")] StockLevel stockLevel)
        {
            if (ModelState.IsValid)
            {
                db.StockLevels.Add(stockLevel);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.StockID = new SelectList(db.Stocks, "StockID", "ProductName", stockLevel.StockID);
            return View(stockLevel);
        }

        // GET: StockLevels/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StockLevel stockLevel = db.StockLevels.Find(id);
            if (stockLevel == null)
            {
                return HttpNotFound();
            }
            ViewBag.StockID = new SelectList(db.Stocks, "StockID", "ProductName", stockLevel.StockID);
            return View(stockLevel);
        }

        // POST: StockLevels/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ProductStockLevelID,StockID,ProductStockLevel")] StockLevel stockLevel)
        {
            if (ModelState.IsValid)
            {
                db.Entry(stockLevel).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.StockID = new SelectList(db.Stocks, "StockID", "ProductName", stockLevel.StockID);
            return View(stockLevel);
        }

        // GET: StockLevels/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StockLevel stockLevel = db.StockLevels.Find(id);
            if (stockLevel == null)
            {
                return HttpNotFound();
            }
            return View(stockLevel);
        }

        // POST: StockLevels/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            StockLevel stockLevel = db.StockLevels.Find(id);
            db.StockLevels.Remove(stockLevel);
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
