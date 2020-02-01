using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Bookings.Controllers
{
    public class ProductSuppliersController : Controller
    {
        BookingsModel.ModelBookings db = new BookingsModel.ModelBookings();
        // GET: ProductSuppliers
        public ActionResult Index()
        {
            var supplier_ = db.ProductSuppliers.ToList();
            return View(supplier_);
        }

        // GET: ProductSuppliers/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var supplier_ = db.ProductSuppliers.Find(id); // Creating variable staff to find a staff member with a certain id (the one the user picks.)
            if (supplier_ == null) //if theres no such staff member
            {
                return HttpNotFound(); //send error message
            }
            return View(supplier_);
        }

// GET: ProductSuppliers/Create
public ActionResult Create()
        {
            return View();
        }

        // POST: ProductSuppliers/Create
        [HttpPost]
        public ActionResult Create(BookingsModel.ProductSupplier supplier_)
        {
            try
            {
                if (ModelState.IsValid) //if model state is active/.
                db.ProductSuppliers.Add(supplier_); //create the bu in the database
                db.SaveChanges(); //save the changes. 
                return RedirectToAction("Index"); //retur nto index
            }
            catch
            {
                return View(supplier_);
            }
        }

        // GET: ProductSuppliers/Edit/5
        public ActionResult Edit(int id)
        {
            if (id == 0) //if ID is equal to null.
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest); //reutnr with error
            }
            BookingsModel.ProductSupplier supplier_ = db.ProductSuppliers.Find(id); //find the specified Staff.
            if (supplier_ == null) // if its not hthere
            {
                return HttpNotFound();//throw error
            }

            return View(supplier_);//oftherwise through the view.
        }

        // POST: ProductSuppliers/Edit/5
        [HttpPost]
        public ActionResult Edit(BookingsModel.ProductSupplier supplier_)
        {
            try
            {
                if (ModelState.IsValid)
                db.Entry(supplier_).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View(supplier_);
            }
        }

        // GET: ProductSuppliers/Delete/5
        public ActionResult Delete(int? id)
        {
            BookingsModel.ProductSupplier supplier_ = db.ProductSuppliers.Find(id);
            if (supplier_ == null) // if its not hthere
            {
                return HttpNotFound();//throw error
            }

            return View(supplier_);//oftherwise through the view.
        }

        // POST: ProductSuppliers/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            if (id == 0)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest); // displays error message is not existant
            }
            try
            {
                BookingsModel.ProductSupplier supplier_ = db.ProductSuppliers.Find(id);
                
                db.Entry(supplier_).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            catch
            {
                return View();
            }
        }
    }
}
