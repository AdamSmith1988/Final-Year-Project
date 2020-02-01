using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Bookings.Controllers
{
    public class EquipmentController : Controller
    {
        BookingsModel.ModelBookings db = new BookingsModel.ModelBookings();
        // GET: Equipment
        public ActionResult Index()
        {
            var equipment_ = db.Equiptments.ToList();
            return View(equipment_);
        }

        // GET: Equipment/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var equipment_ = db.Equiptments.Find(id); // Creating variable staff to find a staff member with a certain id (the one the user picks.)
            if (equipment_ == null) //if theres no such staff member
            {
                return HttpNotFound(); //send error message
            }
            return View(equipment_); //otherwise return the edited staff.


        }

        // GET: Equipment/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Equipment/Create
        [HttpPost]
        public ActionResult Create(BookingsModel.Equiptment equipment_)
        {
            try
            {
                if (ModelState.IsValid) //if model state is active/.
                db.Equiptments.Add(equipment_); //create the bu in the database
                db.SaveChanges(); //save the changes. 
                return RedirectToAction("Index"); //retur nto index
            }
            catch
            {
                return View(equipment_);
            }
        }

        // GET: Equipment/Edit/5
        public ActionResult Edit(int id)
        {

            if (id == 0) //if ID is equal to null.
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest); //reutnr with error
            }
            BookingsModel.Equiptment equipment_ = db.Equiptments.Find(id); //find the specified Staff.
            if (equipment_ == null) // if its not hthere
            {
                return HttpNotFound();//throw error
            }

            return View(equipment_);//oftherwise through the view.
        }

        // POST: Equipment/Edit/5
        [HttpPost]
        public ActionResult Edit(BookingsModel.Equiptment equipment_)
        {
            try
            {
                if (ModelState.IsValid)
                db.Entry(equipment_).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View(equipment_);
            }
        }

        // GET: Equipment/Delete/5
        public ActionResult Delete(int? id)
        {
            BookingsModel.Equiptment equipment_ = db.Equiptments.Find(id);
            if (equipment_ == null) // if its not hthere
        {
            return HttpNotFound();//throw error
    }

            return View(equipment_);//oftherwise through the view.
}

// POST: Equipment/Delete/5
[HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            if (id == 0)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest); // displays error message is not existant
            }
            try
            {
                BookingsModel.Equiptment equipment_ = db.Equiptments.Find(id);
                db.Entry(equipment_).State = System.Data.Entity.EntityState.Modified;
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
