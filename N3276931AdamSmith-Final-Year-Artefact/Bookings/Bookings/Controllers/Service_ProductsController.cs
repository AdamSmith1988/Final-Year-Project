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
    public class Service_ProductsController : Controller
    {
        private ModelBookings db = new ModelBookings();

        // GET: Service_Products
        public ActionResult Index()
        {
            var service_Products = db.Service_Products.Include(s => s.Service).Include(s => s.Stock);
            return View(service_Products.ToList());
        }

        // GET: Service_Products/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Service_Products service_Products = db.Service_Products.Find(id);
            if (service_Products == null)
            {
                return HttpNotFound();
            }
            return View(service_Products);
        }

        // GET: Service_Products/Create
        public ActionResult Create()
        {
            ViewBag.ServiceID = new SelectList(db.Services, "ServiceID", "ServiceName");
            ViewBag.StockID = new SelectList(db.Stocks, "StockID", "ProductName");
            return View();
        }

        // POST: Service_Products/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ServiceProductsID,ServiceID,StockID")] Service_Products service_Products)
        {
            if (ModelState.IsValid)
            {
                db.Service_Products.Add(service_Products);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.ServiceID = new SelectList(db.Services, "ServiceID", "ServiceName", service_Products.ServiceID);
            ViewBag.StockID = new SelectList(db.Stocks, "StockID", "ProductName", service_Products.StockID);
            return View(service_Products);
        }

        // GET: Service_Products/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Service_Products service_Products = db.Service_Products.Find(id);
            if (service_Products == null)
            {
                return HttpNotFound();
            }
            ViewBag.ServiceID = new SelectList(db.Services, "ServiceID", "ServiceName", service_Products.ServiceID);
            ViewBag.StockID = new SelectList(db.Stocks, "StockID", "ProductName", service_Products.StockID);
            return View(service_Products);
        }

        // POST: Service_Products/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ServiceProductsID,ServiceID,StockID")] Service_Products service_Products)
        {
            if (ModelState.IsValid)
            {
                db.Entry(service_Products).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ServiceID = new SelectList(db.Services, "ServiceID", "ServiceName", service_Products.ServiceID);
            ViewBag.StockID = new SelectList(db.Stocks, "StockID", "ProductName", service_Products.StockID);
            return View(service_Products);
        }

        // GET: Service_Products/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Service_Products service_Products = db.Service_Products.Find(id);
            if (service_Products == null)
            {
                return HttpNotFound();
            }
            return View(service_Products);
        }

        // POST: Service_Products/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Service_Products service_Products = db.Service_Products.Find(id);
            db.Service_Products.Remove(service_Products);
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
