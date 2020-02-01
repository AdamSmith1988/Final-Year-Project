namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Stock.StockLevel")]
    public partial class StockLevel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ProductStockLevelID { get; set; }

        public int StockID { get; set; }

        public int ProductStockLevel { get; set; }

        public virtual Stock Stock { get; set; }
    }
}
