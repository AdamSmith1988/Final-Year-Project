using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;
using BookingsModel;
using System.Security.Principal;

namespace BookingsModel
{

    public partial class Users
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int UserID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string EmailID { get; set; }
        public Nullable<System.DateTime> DateOfBirth { get; set; }
        public string Password { get; set; }
        //public string ConfirmPassword { get; set; }
        public bool IsEmailVerified { get; set; }
        public System.Guid ActivationCode { get; set; }
        public string ResetPasswordCode { get; set; }

    }
}
