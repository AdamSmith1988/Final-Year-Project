namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Equipment.Equiptment")]
    public partial class Equiptment
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Equiptment()
        {
            EquiptmentNeededs = new HashSet<EquiptmentNeeded>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int EquiptmentID { get; set; }

        public int EquiptmentTypeID { get; set; }

        [Required]
        [StringLength(50)]
        public string EquiptmentName { get; set; }

        public virtual EquiptmentType EquiptmentType { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<EquiptmentNeeded> EquiptmentNeededs { get; set; }
    }
}
