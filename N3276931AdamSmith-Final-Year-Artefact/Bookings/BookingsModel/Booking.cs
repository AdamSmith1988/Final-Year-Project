namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Booking.Booking")]
    public partial class Booking
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Booking()
        {
            BookingAttendances = new HashSet<BookingAttendance>();
            BookingTimes = new HashSet<BookingTime>();
            Invoices = new HashSet<Invoice>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int BookingID { get; set; }

        public int ServiceID { get; set; }

        public int StaffID { get; set; }

        public int CompanyID { get; set; }

        public int CustomerID { get; set; }

        public string Notes { get; set; }

        public bool? Active { get; set; }

        public virtual Company Company { get; set; }

        public virtual Customer Customer { get; set; }

        public virtual Service Service { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BookingAttendance> BookingAttendances { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BookingTime> BookingTimes { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Invoice> Invoices { get; set; }
    }
}
