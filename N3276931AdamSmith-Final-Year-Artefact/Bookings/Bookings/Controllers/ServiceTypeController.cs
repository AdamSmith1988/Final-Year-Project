using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BookingsModel;

namespace Bookings.Controllers
{
    public class ServiceTypeController : Controller
    {
        BookingsModel.ModelBookings db = new BookingsModel.ModelBookings();
        // GET: ServiceType
        public ActionResult Index()
        {
            var type = db.ServiceTypes.ToList();
            return View(type);
        }

        // GET: ServiceType/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: ServiceType/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: ServiceType/Create
        [HttpPost]
        public ActionResult Create(BookingsModel.ServiceType type_)
        {
            try
            {
                if (ModelState.IsValid) //if model state is active/.
                    db.ServiceTypes.Add(type_);
                db.SaveChanges();
                return RedirectToAction("Index"); //retur nto index
            }
            catch
            {
                return View(type_);
            }
        }

        // GET: ServiceType/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: ServiceType/Edit/5
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

        // GET: ServiceType/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: ServiceType/Delete/5
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
