namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity;
    using System.Data.Entity.Spatial;

    [Table("Services.Service")]
    public partial class Service
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Service()
        {
            Bookings = new HashSet<Booking>();
            Costs = new HashSet<Cost>();
            EquiptmentNeededs = new HashSet<EquiptmentNeeded>();
            Service_Products = new HashSet<Service_Products>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ServiceID { get; set; }

        public int ServiceTypeID { get; set; }

        [Required]
        [StringLength(50)]
        public string ServiceName { get; set; }

        [Required]
        public string Description { get; set; }

        public DateTime Created { get; set; }

        public DateTime Modified { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Booking> Bookings { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Cost> Costs { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<EquiptmentNeeded> EquiptmentNeededs { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Service_Products> Service_Products { get; set; }

        public virtual ServiceType ServiceType { get; set; }

    }
}
