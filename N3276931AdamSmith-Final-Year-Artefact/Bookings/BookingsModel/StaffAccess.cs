namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Staff.StaffAccess")]
    public partial class StaffAccess
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int StaffAccessID { get; set; }

        public int SystemAuthorizationID { get; set; }

        public int StaffRoleID { get; set; }

        public bool IsAccessible { get; set; }

        public virtual StaffRole StaffRole { get; set; }

        public virtual SystemAuthorization SystemAuthorization { get; set; }
    }
}
