using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using BookingsModel;

namespace Bookings.Controllers
{
    public class StaffController : Controller
    {
        BookingsModel.ModelBookings db = new BookingsModel.ModelBookings();
        // GET: Staff
        public ActionResult Index() //Display staff in the same company as the customer logged in using the session record
        {
            int staffID = (int)Session["StaffID"];
            var staffRecord = db.Staffs.FirstOrDefault(staff => staff.StaffID == staffID);
            var company = staffRecord.Company;
            var staffForCompany = company.Staffs;
            return View(staffForCompany);
        }

        // GET: Staff/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var staff = db.Staffs.Find(id); // Creating variable staff to find a staff member with a certain id (the one the user picks.)
            if (staff == null || staff.Active == false) //if theres no such staff member
            {
                return HttpNotFound(); //send error message
            }
            return View(staff); //otherwise return the edited staff.


        }

        // GET: ServiceType/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Staff/Create
        [HttpPost]
        public ActionResult Create(BookingsModel.Staff staff)
        {
            try
            {
                if (ModelState.IsValid) //if model state is active/.
                    staff.Active = true; //I have set active so what sstaff are created its shows in the view .
                db.Staffs.Add(staff); //create the bu in the database
                db.SaveChanges(); //save the changes. 
                return RedirectToAction("Index"); //retur nto index
            }
            catch
            {
                return View(staff);
            }
        }

        // GET: Staff/Edit/5
        public ActionResult Edit(int id)
        {

            if (id == 0) //if ID is equal to null.
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest); //reutnr with error
            }
            BookingsModel.Staff staff = db.Staffs.Find(id); //find the specified Staff.
            if (staff == null) // if its not hthere
            {
                return HttpNotFound();//throw error
            }
          
            return View(staff);//oftherwise through the view.
        }

        // POST: Staff/Edit/5
        [HttpPost]
        public ActionResult Edit(BookingsModel.Staff staff)
        {
            try
            {
                if (ModelState.IsValid)
                    staff.Active = true;
                db.Entry(staff).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View(staff);
            }
        }

        // GET: Staff/Delete/5
        public ActionResult Delete(int? id)
        {
            BookingsModel.Staff staff = db.Staffs.Find(id);
            if (staff == null) // if its not hthere
            {
                return HttpNotFound();//throw error
            }

            return View(staff);//oftherwise through the view.
        }

        // POST: Staff/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            if (id == 0)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest); // displays error message is not existant
            }
            try {
                BookingsModel.Staff staff = db.Staffs.Find(id);
                staff.Active = false;
                db.Entry(staff).State = System.Data.Entity.EntityState.Modified;
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
