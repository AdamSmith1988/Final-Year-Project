using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BookingsModel;

namespace Bookings.Models
{
    public class companyrep
    {

        private ModelBookings db = new ModelBookings();

        public IEnumerable<BookingsModel.Company> All() {
            return db.Companies;
        }
    }
}