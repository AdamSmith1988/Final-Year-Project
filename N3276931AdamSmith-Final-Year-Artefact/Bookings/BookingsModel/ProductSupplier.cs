namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Stock.ProductSuppliers")]
    public partial class ProductSupplier
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ProductSupplier()
        {
            Stocks = new HashSet<Stock>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int SupplierID { get; set; }

        [Required]
        [StringLength(50)]
        public string Name { get; set; }

        [Required]
        [StringLength(50)]
        public string ContactName { get; set; }

        [Required]
        public string Address { get; set; }

        [Required]
        [StringLength(50)]
        public string PostCode { get; set; }

        [Required]
        [StringLength(50)]
        public string Country { get; set; }

        [Required]
        [StringLength(50)]
        public string PhoneNo { get; set; }

        [Required]
        [StringLength(50)]
        public string Email { get; set; }

        public string URL { get; set; }

        public string Logo { get; set; }

        public string Notes { get; set; }

        [StringLength(50)]
        public string CurrentOrder { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Stock> Stocks { get; set; }
    }
}
