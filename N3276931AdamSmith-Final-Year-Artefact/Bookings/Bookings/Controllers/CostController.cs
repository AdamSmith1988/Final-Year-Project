using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Bookings.Controllers
{
    public class CostController : Controller
    {
        BookingsModel.ModelBookings db = new BookingsModel.ModelBookings();
        // GET: Cost
        public ActionResult Index(int id)
        {
            var type = db.Costs.ToList();
            return View(type);
        }

        // GET: Cost/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Cost/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Cost/Create
        [HttpPost]
        public ActionResult Create(BookingsModel.Cost cost_)
        {
            try
            {
                if (ModelState.IsValid) //if model state is active/.
                    db.Costs.Add(cost_);
                db.SaveChanges();
                return RedirectToAction("Index"); //retur nto index
            }
            catch
            {
                return View(cost_);
            }
        }

        // GET: Cost/Edit/5
        public ActionResult Edit(int id)
        {
            if (id == 0) //if ID is equal to null.
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest); 
            }
            BookingsModel.Cost cost_ = db.Costs.Find(id); 
            if (cost_ == null) // if its not hthere
            {
                return HttpNotFound();//throw error
            }
            return View(cost_);
        }

        // POST: Cost/Edit/5
        [HttpPost]
        public ActionResult Edit(BookingsModel.Cost cost_)
        {
            try
            {
                if (ModelState.IsValid)
                   
                db.Entry(cost_).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View(cost_);
            }
        }

        // GET: Cost/Delete/5
        public ActionResult Delete(int? id)
        {
            BookingsModel.Cost cost_ = db.Costs.Find(id);
            if (cost_ == null) // if its not hthere
            {
                return HttpNotFound();//throw error
            }

            return View(cost_);//oftherwise through the view.
        }

        // POST: Cost/Delete/5
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
