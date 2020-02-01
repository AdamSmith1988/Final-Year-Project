using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Principal;

namespace BookingsModel
{
    [MetadataType(typeof(UserMetaData))]
    public partial class Users
    {
        public string ConfirmPassword { get; set; }
    }

    public class UserMetaData
    {

        [Display(Name = "First Name")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "First Name Required")]
        public string FirstName { get; set; }

        [Display(Name = "Last Name")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Last Name Required")]
        public string LastName { get; set; }

        [Display(Name = "Email ID")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Email ID Required")]
        [DataType(DataType.EmailAddress)]
        public string EmailID { get; set; }

        [Display(Name = "Date of Birth")]
        [DataType(DataType.Date)]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:MM/dd/yyyy}")]
        public DateTime DateOfBirth { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Password is Required")]
        [DataType(DataType.Password)]
        [MinLength(6, ErrorMessage = "There is a minimum of 6 characters required")]
        public string Password { get; set; }

        [Display(Name = "Confirm Password")]
        [DataType(DataType.Password)]
        [Compare("Password", ErrorMessage ="Passwords are not similar!")]
        public string ConfirmPassword { get; set; }
    }
}
