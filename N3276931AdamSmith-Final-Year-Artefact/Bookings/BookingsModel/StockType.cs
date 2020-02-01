namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Stock.StockType")]
    public partial class StockType
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public StockType()
        {
            Stocks = new HashSet<Stock>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int StockTypeID { get; set; }

        [Required]
        [StringLength(50)]
        public string StockTypeName { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Stock> Stocks { get; set; }
    }
}
