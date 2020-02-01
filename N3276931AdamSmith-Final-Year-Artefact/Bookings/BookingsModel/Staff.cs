namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Staff.Staff")]
    public partial class Staff
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int StaffID { get; set; }

        public int CompanyID { get; set; }

        public int StaffRoleID { get; set; }

        [Required]
        public string First_Name { get; set; }

        [Required]
        public string Last_Name { get; set; }

        [Required]
        [StringLength(20)]
        public string Username { get; set; }

        [Required]
        [StringLength(20)]
        public string Password { get; set; }

        public bool? Active { get; set; }

        public virtual Company Company { get; set; }

        public virtual StaffRole StaffRole { get; set; }
    }
}
