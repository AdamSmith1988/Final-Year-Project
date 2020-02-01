using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Bookings.Controllers
{
    public class ServiceController : Controller

    {
        BookingsModel.ModelBookings db = new BookingsModel.ModelBookings();

        public ActionResult Index()
        {
            var service_ = db.Services.AsParallel();
            return View(service_);
        }


        // GET: Service/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Service/Create
        [HttpPost]
        public ActionResult Create(BookingsModel.Service service_)
        {
            try
            {
                if (ModelState.IsValid) //if model state is active/.
                    
                db.Services.Add(service_); //create the bu in the database
                db.SaveChanges(); //save the changes. 
                return RedirectToAction("Index"); //retur nto index
            }
            catch
            {
                return View(service_);
            }
        }

        // GET: Service/Edit/5
        public ActionResult Edit(int id)  { 

        if (id == 0) //if ID is equal to null.
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest); 
    }
    BookingsModel.Service service_ = db.Services.Find(id);
            if (service_ == null) 
            {
                return HttpNotFound();
}

            return View(service_);
        }

        // POST: Service/Edit/5
        [HttpPost]
        public ActionResult Edit(BookingsModel.Service service_)
        {
            try
            {
                if (ModelState.IsValid)
                    db.Entry(service_).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View(service_);
            }
        }

        // GET: Service/Delete/5
        public ActionResult Delete(int? id)
        {
            BookingsModel.Service service_ = db.Services.Find(id);
            if (service_ == null) // if its not hthere
            {
                return HttpNotFound();//throw error
            }

            return View(service_);//oftherwise through the view.
        }

        // POST: Service/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            if (id == 0)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest); // displays error message is not existant
            }
            try
            {
                BookingsModel.Service service_ = db.Services.Find(id);
                db.Entry(service_).State = System.Data.Entity.EntityState.Modified;
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
