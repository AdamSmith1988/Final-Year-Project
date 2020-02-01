using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Bookings.Controllers
{
    public class IndustryController : Controller
    {
        BookingsModel.ModelBookings db = new BookingsModel.ModelBookings();
        // GET: Industry
        public ActionResult Index()
        {
            var ind_ = db.Industries.ToList();
            return View(ind_);
        }
        
        // GET: Industry/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Industry/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Industry/Create
        [HttpPost]
        public ActionResult Create(BookingsModel.Industry industry_)
        {
            try
            {
                if (ModelState.IsValid)
                db.Industries.Add(industry_);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch(Exception ex)
            {
                return View(industry_);
            }
        }

        // GET: Industry/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Industry/Edit/5
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

        // GET: Industry/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Industry/Delete/5
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
