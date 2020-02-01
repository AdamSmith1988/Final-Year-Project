namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Services.EquiptmentNeeded")]
    public partial class EquiptmentNeeded
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int EquiptmentNeededID { get; set; }

        public int ServiceID { get; set; }

        public int EquiptmentID { get; set; }

        public int Quantity { get; set; }

        public virtual Equiptment Equiptment { get; set; }

        public virtual Service Service { get; set; }
    }
}
