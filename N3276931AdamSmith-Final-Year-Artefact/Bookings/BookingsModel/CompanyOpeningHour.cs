namespace BookingsModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Company.CompanyOpeningHours")]
    public partial class CompanyOpeningHour
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int OpeningTimeID { get; set; }

        public int CompanyID { get; set; }

        public int DayOfWeek { get; set; }

        public TimeSpan OpeningTime { get; set; }

        public TimeSpan ClosingTime { get; set; }

        public string NotesIfClosed { get; set; }

        public virtual Company Company { get; set; }
    }
}
