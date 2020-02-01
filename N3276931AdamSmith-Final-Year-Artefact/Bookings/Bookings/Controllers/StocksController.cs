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
    public class StocksController : Controller
    {
        private ModelBookings db = new ModelBookings();

        // GET: Stocks
        public ActionResult Index()
        {
            var stocks = db.Stocks.Include(s => s.ProductImage).Include(s => s.ProductSupplier).Include(s => s.StockType);
            return View(stocks.ToList());
        }

        // GET: Stocks/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Stock stock = db.Stocks.Find(id);
            if (stock == null)
            {
                return HttpNotFound();
            }
            return View(stock);
        }

        // GET: Stocks/Create
        public ActionResult Create()
        {
            ViewBag.ProductImageID = new SelectList(db.ProductImages, "ProductImageID", "ProductImageURL");
            ViewBag.SupplierID = new SelectList(db.ProductSuppliers, "SupplierID", "Name");
            ViewBag.ProductStockTypeID = new SelectList(db.StockTypes, "StockTypeID", "StockTypeName");
            return View();
        }

        // POST: Stocks/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "StockID,ProductImageID,SupplierID,ProductStockTypeID,ProductName")] Stock stock)
        {
            if (ModelState.IsValid)
            {
                db.Stocks.Add(stock);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ProductImageID = new SelectList(db.ProductImages, "ProductImageID", "ProductImageURL", stock.ProductImageID);
            ViewBag.SupplierID = new SelectList(db.ProductSuppliers, "SupplierID", "Name", stock.SupplierID);
            ViewBag.ProductStockTypeID = new SelectList(db.StockTypes, "StockTypeID", "StockTypeName", stock.ProductStockTypeID);
            return View(stock);
        }

        // GET: Stocks/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Stock stock = db.Stocks.Find(id);
            if (stock == null)
            {
                return HttpNotFound();
            }
            ViewBag.ProductImageID = new SelectList(db.ProductImages, "ProductImageID", "ProductImageURL", stock.ProductImageID);
            ViewBag.SupplierID = new SelectList(db.ProductSuppliers, "SupplierID", "Name", stock.SupplierID);
            ViewBag.ProductStockTypeID = new SelectList(db.StockTypes, "StockTypeID", "StockTypeName", stock.ProductStockTypeID);
            return View(stock);
        }

        // POST: Stocks/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "StockID,ProductImageID,SupplierID,ProductStockTypeID,ProductName")] Stock stock)
        {
            if (ModelState.IsValid)
            {
                db.Entry(stock).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ProductImageID = new SelectList(db.ProductImages, "ProductImageID", "ProductImageURL", stock.ProductImageID);
            ViewBag.SupplierID = new SelectList(db.ProductSuppliers, "SupplierID", "Name", stock.SupplierID);
            ViewBag.ProductStockTypeID = new SelectList(db.StockTypes, "StockTypeID", "StockTypeName", stock.ProductStockTypeID);
            return View(stock);
        }

        // GET: Stocks/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Stock stock = db.Stocks.Find(id);
            if (stock == null)
            {
                return HttpNotFound();
            }
            return View(stock);
        }

        // POST: Stocks/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Stock stock = db.Stocks.Find(id);
            db.Stocks.Remove(stock);
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
