namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Customer.Customer")]
    public partial class Customer
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Customer()
        {
            Bookings = new HashSet<Booking>();
            BookingAttendances = new HashSet<BookingAttendance>();
            CompanyReviews = new HashSet<CompanyReview>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int CustomerId { get; set; }

        [Required]
        public string FirstName { get; set; }

        [Required]
        public string LastName { get; set; }

        [Required]
        [StringLength(40)]
        public string Title { get; set; }

        public DateTime DateOfBirth { get; set; }

        [Required]
        public string Address { get; set; }

        [Required]
        [StringLength(10)]
        public string Postcode { get; set; }

        [Required]
        [StringLength(10)]
        public string Gender { get; set; }

        [Required]
        [StringLength(256)]
        public string Email { get; set; }

        [Required]
        public string PhoneNumber { get; set; }

        public bool? Active { get; set; }


        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Booking> Bookings { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BookingAttendance> BookingAttendances { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CompanyReview> CompanyReviews { get; set; }
    }
}
