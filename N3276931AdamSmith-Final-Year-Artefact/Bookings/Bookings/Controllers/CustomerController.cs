using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Bookings.Models;
using BookingsModel;

namespace Bookings.Controllers
{
    public class CustomerController : Controller
    {

        BookingsModel.ModelBookings db = new ModelBookings();

        // GET: Customer
        public ActionResult Index() //Getting the customers of the company of the staff member logging in.
        {
            int staffID = (int)Session["StaffID"];
            var staffRecord = db.Staffs.FirstOrDefault(staff => staff.StaffID == staffID);
            var customers = staffRecord.Company.Bookings.Select(b => b.Customer);
            return View(customers);
           
        }

        // GET: Customer/Details/5
        public ActionResult Details(int? id) 
        {
           Customer customer = db.Customers.Find(id);
                if (customer == null || customer.Active == false)
            {
                return HttpNotFound(); //return not found
            }
                return View(customer); //return the details of customer
        }

        // GET: Customer/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Customer/Create
        [HttpPost]
        public ActionResult Create(Customer customer)
        {

            
                if (ModelState.IsValid)
                    customer.Active = true;
                    db.Customers.Add(customer);
                        db.SaveChanges();

                return RedirectToAction("Index");
           
            
            {
                return View(customer);
            }
        }

        // GET: Customer/Edit/5
        public ActionResult Edit(int id)
        {
            if (id == 0)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
                Customer customer = db.Customers.Find(id);
                    if (customer == null)
            {
                    return HttpNotFound();
            }

                    return View(customer);
        }

        // POST: Customer/Edit/5
        [HttpPost]
        public ActionResult Edit(Customer customer)
        {
            try
            {
                if (ModelState.IsValid)
                    customer.Active = true;
                        db.Entry(customer).State = EntityState.Modified;
                    db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View(customer);
            }
        }

        // GET: Customer/Delete/5
        public ActionResult Delete(int? id)
        {

            Customer customer = db.Customers.Find(id);
            if (customer == null || customer.Active == false)
            {
                return HttpNotFound();
            }
            return View(customer);
        }

        // POST: Customer/Delete/5
        [HttpPost]
        public ActionResult Delete(int id)
        {
            if (id == 0)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest); // displays error message is not existant
            }
            try
            {
                Customer customer = db.Customers.Find(id);
                    customer.Active = false;
                        db.Entry(customer).State = EntityState.Modified;
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
