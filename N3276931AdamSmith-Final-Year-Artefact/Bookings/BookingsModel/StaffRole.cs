namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Staff.StaffRole")]
    public partial class StaffRole
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public StaffRole()
        {
            Staffs = new HashSet<Staff>();
            StaffAccesses = new HashSet<StaffAccess>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int StaffRoleID { get; set; }

        [Required]
        [StringLength(30)]
        public string RoleName { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Staff> Staffs { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<StaffAccess> StaffAccesses { get; set; }
    }
}
