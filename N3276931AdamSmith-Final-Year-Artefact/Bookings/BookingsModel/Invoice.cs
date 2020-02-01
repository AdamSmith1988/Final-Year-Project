namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Booking.Invoice")]
    public partial class Invoice
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int InvoiceID { get; set; }

        public int BookingID { get; set; }

        public int CostID { get; set; }

        public int PaymentMethodID { get; set; }

        public DateTime Date { get; set; }

        public bool Paid { get; set; }

        [StringLength(50)]
        public string Thanks { get; set; }

        public virtual Booking Booking { get; set; }

        public virtual Cost Cost { get; set; }

        public virtual PaymentMethod PaymentMethod { get; set; }
    }
}
