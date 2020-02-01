using BookingsModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;


namespace Bookings.Models
{
    public class PayMethod
    {

        private ModelBookings db = new ModelBookings();
        public IEnumerable<BookingsModel.PaymentMethod> All() {
            return db.PaymentMethods;
        }
        }
}