namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Staff.SystemAuthorization")]
    public partial class SystemAuthorization
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public SystemAuthorization()
        {
            StaffAccesses = new HashSet<StaffAccess>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int SystemAuthorizationID { get; set; }

        [Required]
        [StringLength(50)]
        public string Add_Edit_Del { get; set; }

        [Required]
        [StringLength(50)]
        public string AuthorzationName { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<StaffAccess> StaffAccesses { get; set; }
    }
}
