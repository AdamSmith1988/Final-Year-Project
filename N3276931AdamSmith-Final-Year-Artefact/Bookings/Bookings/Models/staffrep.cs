
using System.Collections.Generic;
using System.Linq;
using BookingsModel;

namespace Bookings.Models
{
    public class staffrep
    {
        private ModelBookings db = new ModelBookings();

        public IEnumerable<BookingsModel.Staff> All()
        {
            return db.Staffs;
        }
    }
}