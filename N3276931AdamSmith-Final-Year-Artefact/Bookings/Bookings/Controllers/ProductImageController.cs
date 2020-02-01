using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Bookings.Controllers
{
    public class ProductImageController : Controller
    {
        BookingsModel.ModelBookings db = new BookingsModel.ModelBookings();
        // GET: ProductImage
        public ActionResult Index()
        {
            var img_ = db.ProductImages.ToList();
            return View(img_);
        }

        // GET: ProductImage/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: ProductImage/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: ProductImage/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: ProductImage/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: ProductImage/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: ProductImage/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: ProductImage/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
