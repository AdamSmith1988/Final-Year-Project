namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Stock.ProductImage")]
    public partial class ProductImage
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ProductImage()
        {
            Stocks = new HashSet<Stock>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ProductImageID { get; set; }

        [Required]
        public string ProductImageURL { get; set; }

        public string Notes { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Stock> Stocks { get; set; }
    }
}
