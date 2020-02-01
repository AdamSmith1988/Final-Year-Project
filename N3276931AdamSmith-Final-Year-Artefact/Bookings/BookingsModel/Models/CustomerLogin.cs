using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BookingsModel;
using BookingsModel.Models;

namespace BookingsModel.Models
{
    public class CustomerLogin
    {
        [Key]
        [Display(Name = "Email Address")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Email ID is required")]
        public string EmailID { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Password is required")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Display(Name = "Remember Me")]
        public bool RememberMe { get; set; }
    }
}
