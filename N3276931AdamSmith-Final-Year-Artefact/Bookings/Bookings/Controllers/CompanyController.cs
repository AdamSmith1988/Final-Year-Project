using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Bookings.Controllers
{
    public class CompanyController : Controller
    {
        BookingsModel.ModelBookings db = new BookingsModel.ModelBookings();
        // GET: Company
        public ActionResult Index()
        {
            Models.companyrep comrep = new Models.companyrep();
                var company_ = comrep.All().Where(b => b.Active == true);
                    return View(company_);
        }

        // GET: Company/Details/5
        public ActionResult Details(int? id)
        {
            if (id == 0)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var company_ = db.Companies.Find(id);
            if (company_ == null || company_.Active == false)
            {
                return HttpNotFound(); //send error message
            }
            return View(company_);
        }


        // GET: Company/Create
        public ActionResult Create()
        {
                return View();
        }
        // GET: Company/Create
        [HttpPost]
        public ActionResult Create(BookingsModel.Company company_)
        {
            try
            {
                if (ModelState.IsValid) //if model state is active/.
                    company_.Active = true;
                        db.Companies.Add(company_);
                    db.SaveChanges();
                return RedirectToAction("Index"); //retur nto index
            }
            catch {
                return View(company_);
            }
        }


        // GET: Company/Edit/5000
        public ActionResult Edit(int id)
        {
            if (id == 0) //if ID is equal to null.
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest); //reutnr with error
            }

            BookingsModel.Company company_ = db.Companies.Find(id);
            if (company_ == null) // if its not hthere
            {
                return HttpNotFound();//throw error
            }
            return View(company_);
        }

        // POST: Company/Edit/5
        [HttpPost]
        public ActionResult Edit(BookingsModel.Company company_)
        {

            try
            {
                if (ModelState.IsValid)
                    company_.Active = true;
                db.Entry(company_).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View(company_);
            }
        }

        // GET: Company/Delete/5
        public ActionResult Delete(int? id)
        {
            BookingsModel.Company company_ = db.Companies.Find(id);
            if (company_ == null) // if its not hthere
            {
                return HttpNotFound();//throw error
            }
            return View(company_);
        }

        // POST: Company/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            if (id == 0)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest); // displays error message is not existant
            }
            try
            {
                BookingsModel.Company company_ = db.Companies.Find(id);
                company_.Active = false;
                db.Entry(company_).State = System.Data.Entity.EntityState.Modified;
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
