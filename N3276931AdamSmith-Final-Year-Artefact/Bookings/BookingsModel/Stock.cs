namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Stock.Stock")]
    public partial class Stock
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Stock()
        {
            Service_Products = new HashSet<Service_Products>();
            StockLevels = new HashSet<StockLevel>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int StockID { get; set; }

        public int ProductImageID { get; set; }

        public int SupplierID { get; set; }

        public int ProductStockTypeID { get; set; }

        [Required]
        [StringLength(50)]
        public string ProductName { get; set; }

        public virtual ProductImage ProductImage { get; set; }

        public virtual ProductSupplier ProductSupplier { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Service_Products> Service_Products { get; set; }

        public virtual StockType StockType { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<StockLevel> StockLevels { get; set; }
    }
}
