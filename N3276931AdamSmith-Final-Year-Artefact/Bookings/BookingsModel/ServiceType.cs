namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Services.ServiceType")]
    public partial class ServiceType
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ServiceType()
        {
            Services = new HashSet<Service>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ServiceTypeID { get; set; }

        [Column("ServiceType")]
        [Required]
        public string ServiceType1 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Service> Services { get; set; }
    }
}
