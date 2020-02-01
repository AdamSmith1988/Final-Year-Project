namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Booking.Cost")]
    public partial class Cost
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Cost()
        {
            Invoices = new HashSet<Invoice>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int CostID { get; set; }

        public int ServiceID { get; set; }

        [Column("Cost")]
        [Required]
        [StringLength(50)]
        public string Cost1 { get; set; }

        public virtual Service Service { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Invoice> Invoices { get; set; }
    }
}
