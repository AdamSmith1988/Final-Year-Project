using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Bookings.Controllers
{
    
    public class EquipmentTypeController : Controller
    {
        BookingsModel.ModelBookings db = new BookingsModel.ModelBookings();
        // GET: EquipmentType
        public ActionResult Index()
        {
            var type = db.EquiptmentTypes.ToList();
            return View(type);
        }

        // GET: EquipmentType/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Industry/Create
        public ActionResult Create()
        {
            return View();
        }

        // GET: EquipmentType/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(BookingsModel.EquiptmentType type_)
        {
            try
            {
                if (ModelState.IsValid) //if model state is active/.
                db.EquiptmentTypes.Add(type_);
                db.SaveChanges();
                return RedirectToAction("Index"); //retur nto index
            }
            catch
            {
                return View(type_);
            }
        }

        // GET: EquipmentType/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: EquipmentType/Edit/5
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

        // GET: EquipmentType/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: EquipmentType/Delete/5
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
