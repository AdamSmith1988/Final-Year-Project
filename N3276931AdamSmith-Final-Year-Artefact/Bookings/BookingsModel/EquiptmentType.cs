namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Equipment.EquiptmentType")]
    public partial class EquiptmentType
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public EquiptmentType()
        {
            Equiptments = new HashSet<Equiptment>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int EquiptmentTypeID { get; set; }

        [Required]
        [StringLength(50)]
        public string EquiptmentTypeName { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Equiptment> Equiptments { get; set; }
    }
}
