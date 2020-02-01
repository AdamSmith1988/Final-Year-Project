using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BookingsModel;
using System.Net.Mail;
using System.Net;
using System.Security.Principal;
using BookingsModel.Models;
using System.Web.Security;

namespace Bookings.Controllers
{
    public class UsersController : Controller
    {
        //Reg Action
        [HttpGet]
        public ActionResult Registration()
        {
            return View();
        }
        //Reg POST Action
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Registration([Bind(Exclude = "IsEmailVerified,ActivationCode")] Users users)
        {
            bool Status = false;
            String Message = "";

            if (ModelState.IsValid)
            { 

                #region Does the Email exist?
                var exists = EmailExists(users.EmailID);
                if (exists)
                {
                    ModelState.AddModelError("EmailExists", "Email already exists");
                    return View(User);
                }
                #endregion

                #region Generate Activation Code
                users.ActivationCode = Guid.NewGuid();
                #endregion

                #region Password Hashing
                users.Password = Crypto.Hash(users.Password);
                users.ConfirmPassword = Crypto.Hash(users.ConfirmPassword);
                users.IsEmailVerified = false;
                #endregion

                #region Save to db
                using (BookingsModel.ModelBookings db = new BookingsModel.ModelBookings())
                {
                    db.Users.Add(users);
                    db.SaveChanges();

                    SendVerificationLink(users.EmailID, users.ActivationCode.ToString());
                    Message = "Registration sucessfully done. Account activation link " +
                        "has been send to your email id " + users.EmailID;
                    Status = true;
                }
                
            }
            else
            {
                Message = "Invalid Request";
            }
            ViewBag.Message = Message;
            ViewBag.Status = Status;

            return View(users);
        }
        #endregion

                #region Account Verification
        [HttpGet]
        public ActionResult VerifyAccount(string id)
        {
            bool Status = false;
            using (BookingsModel.ModelBookings db = new BookingsModel.ModelBookings())
            {
                db.Configuration.ValidateOnSaveEnabled = false;
               var v = db.Users.Where(a => a.ActivationCode == new Guid(id)).FirstOrDefault();
                if (v != null)
                {
                    v.IsEmailVerified = true;
                    db.SaveChanges();
                    Status = true;
                }
                else
                {
                    ViewBag.MEssage = "Invalid Request";
                }
            }
            ViewBag.Status = Status;
            return View();
        }
        #endregion

                #region Customer Login Page GET
                [HttpGet]
                public ActionResult CustomerLogin()
                {
                    return View();
                }

        #endregion

                #region Customer Login Page POST
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CustomerLogin(CustomerLogin login, string ReturnUrl)
        {
            string message = "";
            using (BookingsModel.ModelBookings db = new BookingsModel.ModelBookings())
            {
                var v = db.Users.Where(a => a.EmailID == login.EmailID).FirstOrDefault();
                if (v != null)
                {
                    if (string.Compare(Crypto.Hash(login.Password), v.Password) == 0)
                    {
                        int timeout = login.RememberMe ? 525600 : 20; //525600 min = 1 year
                        var ticket = new FormsAuthenticationTicket(login.EmailID, login.RememberMe, timeout);
                        string encrypted = FormsAuthentication.Encrypt(ticket);
                        var cookie = new HttpCookie(FormsAuthentication.FormsCookieName, encrypted);
                        cookie.Expires = DateTime.Now.AddMinutes(timeout);
                        cookie.HttpOnly = true;
                        Response.Cookies.Add(cookie);

                        if (Url.IsLocalUrl(ReturnUrl))
                        {
                            return Redirect(ReturnUrl);
                        }
                        else
                        {
                            return RedirectToAction("Index", "Home");
                        }
                    }
                    else
                    {
                        message = "Your Credentials appear to be invalid";
                    }
                }
                else
                {
                    message = "Your Credentials appear to be invalid";
                }
            }

                ViewBag.Message = message;
            return View();
        }

        #endregion

                #region Logout 
                [Authorize]
                [HttpPost]
                public ActionResult Logout()
                {
                    FormsAuthentication.SignOut();
                    return RedirectToAction("Login", "Users");
                }
                #endregion


        [NonAction]
        public bool EmailExists(string emailID)
        {
            using (BookingsModel.ModelBookings db = new BookingsModel.ModelBookings())
            {
                var v = db.Users.Where(a => a.EmailID == emailID).FirstOrDefault();
                return v != null;
            }
        }

        [NonAction]
        public void SendVerificationLink(string emailID, string activationCode, string emailFor = "VerifyAccount")
        {
            var varifyURL = "/Users/"+emailFor+"/" + activationCode;
            var link = Request.Url.AbsoluteUri.Replace(Request.Url.PathAndQuery, varifyURL);

            var fromEmail = new MailAddress("onlinebookingbridge@gmail.com", "Booking Bridge");
            var toEmail = new MailAddress(emailID);
            var fromEmailPassword = "BookingBridge123!";
            string subject = "";
            string body = "";

            if (emailFor == "VerifyAccount")
            {
                subject = "Your Account is successfully created";

                body = "<br/><br/>We are excited to tell you that your Bookings account is created, happy Booking!!" +
                    " Please click on the below link to verify your account" + "<br/><br/><a href='" + link + "'>" + link + "</a>";
            }
            else if (emailFor == "ResetPassword")
            {
                subject = "Reset Password";
                body = "Hi, </br></br>We have recieved a request that you want to reset your password, please click on the link below" +
            "</br></br><a href=" + link + ">Reset Password link</a>";
            }

            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromEmail.Address, fromEmailPassword)
            };

            using (var message = new MailMessage(fromEmail, toEmail)
            {
                Subject = subject,
                Body = body,
                IsBodyHtml = true
            })
                smtp.Send(message); }

        #region Forgot Password
        public ActionResult ForgotPassword()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ForgotPassword(string EmailID)
        {
            string message = "";
            bool status = false;

            using (BookingsModel.ModelBookings db = new BookingsModel.ModelBookings())
            {
                var acc = db.Users.Where(a => a.EmailID == EmailID).FirstOrDefault();
                if (acc != null)
                {
                    string resetCode = Guid.NewGuid().ToString();
                    SendVerificationLink(acc.EmailID, resetCode, "ResetPassword");
                    acc.ResetPasswordCode = resetCode;
                    db.Configuration.ValidateOnSaveEnabled = false;
                    db.SaveChanges();
                    message = "The reset password link has been sent to the email listed on your account!";
                }
                else
                {
                    message = "Im affraid the account you've requested has not been found";
                }
            }
            ViewBag.Message = message;
            return View();
        }

        public ActionResult ResetPassword(string id)
        {
            using (BookingsModel.ModelBookings db = new BookingsModel.ModelBookings())
            {
                var users = db.Users.Where(a => a.ResetPasswordCode == id).FirstOrDefault();
                if (users != null)
                {
                    ResetPasswordModel model = new ResetPasswordModel();
                    model.ResetCode = id;
                    return View(model);
                }
                else
                {
                    return HttpNotFound();
                }
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ResetPassword(ResetPasswordModel model)
        {
            var message = "";
            if (ModelState.IsValid)
            {
                using (BookingsModel.ModelBookings db = new BookingsModel.ModelBookings())
                {
                    var users = db.Users.Where(a => a.ResetPasswordCode == model.ResetCode).FirstOrDefault();
                    if (User != null)
                    {
                        users.Password = Crypto.Hash(model.NewPassword);
                        users.ResetPasswordCode = "";
                        db.Configuration.ValidateOnSaveEnabled = false;
                        db.SaveChanges();
                        message = "Your new password has been updated succesfully!";
                    }
                }
            }
            else
            {
                message = "Invalid request";
            }
            ViewBag.Message = message; 

            return View(model);
        }
        #endregion

    }
}