namespace BookingsModel
{

    using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

    [Table("dbo.Events")]
    public class Events

    {
        [Key]
        public int EventID { get; set; }
            public String Subject { get; set; }

            public String Description { get; set; }

            public DateTime Start { get; set; }

            public DateTime End { get; set; }
        public String ThemeColor { get; set; }

            public bool? IsFullDay { get; set; }

        }
    }


