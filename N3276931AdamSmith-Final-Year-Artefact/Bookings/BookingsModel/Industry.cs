namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Company.Industry")]
    public partial class Industry
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Industry()
        {
            Companies = new HashSet<Company>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int IndustryID { get; set; }

        [Required]
        public string SectorName { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Company> Companies { get; set; }
    }
}
