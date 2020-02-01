namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Booking.BookingTime")]
    public partial class BookingTime
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int BookingTimeID { get; set; }

        public int BookingID { get; set; }

        [Column(TypeName = "date")]
        public DateTime Date { get; set; }

        public TimeSpan TimeStart { get; set; }

        public TimeSpan Duration { get; set; }

        public virtual Booking Booking { get; set; }
    }
}
