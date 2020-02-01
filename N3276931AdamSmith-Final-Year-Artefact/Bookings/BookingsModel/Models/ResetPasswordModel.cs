using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BookingsModel.Models
{
    public class ResetPasswordModel
    {
        [Key]
        [Required(ErrorMessage ="New Password Required", AllowEmptyStrings =false)]
        [DataType(DataType.Password)]
        public string NewPassword { get; set; }

        [DataType(DataType.Password)]
        [Compare("NewPassword", ErrorMessage ="These passwords are not similar")]
        public string ConfirmPassword { get; set; }

        [Required]
        public string ResetCode { get; set; }
    }
}
