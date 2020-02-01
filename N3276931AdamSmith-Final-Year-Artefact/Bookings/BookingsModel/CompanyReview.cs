namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Customer.CompanyReviews")]
    public partial class CompanyReview
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int CompanyReviewsID { get; set; }

        public int CompanyID { get; set; }

        public int CustomerID { get; set; }

        public int Rating { get; set; }

        public string Comments { get; set; }

        public virtual Company Company { get; set; }

        public virtual Customer Customer { get; set; }
    }
}
