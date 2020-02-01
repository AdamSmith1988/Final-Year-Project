namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Booking.BookingAttendance")]
    public partial class BookingAttendance
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int AttendanceID { get; set; }

        public int BookingID { get; set; }

        public int CustomerID { get; set; }

        public bool Attended { get; set; }

        public virtual Booking Booking { get; set; }

        public virtual Customer Customer { get; set; }
    }
}
