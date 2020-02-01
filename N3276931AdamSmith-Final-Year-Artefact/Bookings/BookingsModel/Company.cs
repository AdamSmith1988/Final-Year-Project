namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Company.Company")]
    public partial class Company
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Company()
        {
            Bookings = new HashSet<Booking>();
            CompanyOpeningHours = new HashSet<CompanyOpeningHour>();
            CompanyReviews = new HashSet<CompanyReview>();
            Staffs = new HashSet<Staff>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int CompanyID { get; set; }

        public int IndustryID { get; set; }

        [Required]
        public string CompanyName { get; set; }

        [Required]
        public string Address { get; set; }

        [Required]
        [StringLength(50)]
        public string Postcode { get; set; }

        [Required]
        public string PhoneNumber { get; set; }

        [Required]
        public string FaxNumber { get; set; }

        public string Website { get; set; }

        public string Facebook { get; set; }

        public string Twitter { get; set; }

        public string LinkedIn { get; set; }

        public DateTime RegistrationDate { get; set; }

        public DbGeography Location { get; set; }

        public bool? Active { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Booking> Bookings { get; set; }

        public virtual Industry Industry { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CompanyOpeningHour> CompanyOpeningHours { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CompanyReview> CompanyReviews { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Staff> Staffs { get; set; }
    }
}
