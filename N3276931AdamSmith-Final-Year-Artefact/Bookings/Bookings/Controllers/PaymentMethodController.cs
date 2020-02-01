using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Bookings.Controllers
{
    public class PaymentMethodController : Controller
    {
        BookingsModel.ModelBookings db = new BookingsModel.ModelBookings();
        // GET: PaymentMethod
        public ActionResult Index()
        {
            var pay_ = db.PaymentMethods.ToList();
            return View(pay_);
        }

        // GET: PaymentMethod/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: PaymentMethod/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: PaymentMethod/Create
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

        // GET: PaymentMethod/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: PaymentMethod/Edit/5
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

        // GET: PaymentMethod/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: PaymentMethod/Delete/5
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
