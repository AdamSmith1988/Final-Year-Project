using BookingsModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;

namespace Bookings.Models
{
    public class CustomerRep
    {
        private ModelBookings db = new ModelBookings();

        public IEnumerable<BookingsModel.Customer> All()
        {
            return db.Customers;
        }
    }
    
}