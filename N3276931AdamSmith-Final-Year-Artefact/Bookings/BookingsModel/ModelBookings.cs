namespace BookingsModel
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;
    using BookingsModel;

    public partial class ModelBookings : DbContext
    {
        public ModelBookings()
            : base("name=ModelBookingsdb")
        {
        }

        public virtual DbSet<Booking> Bookings { get; set; }
        public virtual DbSet<BookingAttendance> BookingAttendances { get; set; }
        public virtual DbSet<BookingTime> BookingTimes { get; set; }
        public virtual DbSet<Cost> Costs { get; set; }
        public virtual DbSet<Invoice> Invoices { get; set; }
        public virtual DbSet<PaymentMethod> PaymentMethods { get; set; }
        public virtual DbSet<Company> Companies { get; set; }
        public virtual DbSet<CompanyOpeningHour> CompanyOpeningHours { get; set; }
        public virtual DbSet<Industry> Industries { get; set; }
        public virtual DbSet<CompanyReview> CompanyReviews { get; set; }
        public virtual DbSet<Customer> Customers { get; set; }
        public virtual DbSet<Equiptment> Equiptments { get; set; }
        public virtual DbSet<EquiptmentType> EquiptmentTypes { get; set; }
        public virtual DbSet<EquiptmentNeeded> EquiptmentNeededs { get; set; }
        public virtual DbSet<Service> Services { get; set; }
        public virtual DbSet<ServiceType> ServiceTypes { get; set; }
        public virtual DbSet<Staff> Staffs { get; set; }
        public virtual DbSet<StaffAccess> StaffAccesses { get; set; }
        public virtual DbSet<StaffRole> StaffRoles { get; set; }
        public virtual DbSet<SystemAuthorization> SystemAuthorizations { get; set; }
        public virtual DbSet<ProductImage> ProductImages { get; set; }
        public virtual DbSet<ProductSupplier> ProductSuppliers { get; set; }
        public virtual DbSet<Stock> Stocks { get; set; }
        public virtual DbSet<StockLevel> StockLevels { get; set; }
        public virtual DbSet<StockType> StockTypes { get; set; }
        public virtual DbSet<Service_Products> Service_Products { get; set; }

        public virtual DbSet<Events> Events { get; set; }

        public virtual DbSet<Users> Users { get; set; }

        //public virtual DbSet<CustomerLogin> CustomerLogin { get; set; }

        //public virtual DbSet<ResetPassword> ResetPassword { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Booking>()
                .HasMany(e => e.BookingAttendances)
                .WithRequired(e => e.Booking)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Booking>()
                .HasMany(e => e.BookingTimes)
                .WithRequired(e => e.Booking)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Booking>()
                .HasMany(e => e.Invoices)
                .WithRequired(e => e.Booking)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Cost>()
                .HasMany(e => e.Invoices)
                .WithRequired(e => e.Cost)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<PaymentMethod>()
                .HasMany(e => e.Invoices)
                .WithRequired(e => e.PaymentMethod)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Company>()
                .HasMany(e => e.Bookings)
                .WithRequired(e => e.Company)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Company>()
                .HasMany(e => e.CompanyOpeningHours)
                .WithRequired(e => e.Company)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Company>()
                .HasMany(e => e.CompanyReviews)
                .WithRequired(e => e.Company)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Company>()
                .HasMany(e => e.Staffs)
                .WithRequired(e => e.Company)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Industry>()
                .HasMany(e => e.Companies)
                .WithRequired(e => e.Industry)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Customer>()
                .HasMany(e => e.Bookings)
                .WithRequired(e => e.Customer)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Customer>()
                .HasMany(e => e.BookingAttendances)
                .WithRequired(e => e.Customer)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Customer>()
                .HasMany(e => e.CompanyReviews)
                .WithRequired(e => e.Customer)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Equiptment>()
                .HasMany(e => e.EquiptmentNeededs)
                .WithRequired(e => e.Equiptment)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<EquiptmentType>()
                .HasMany(e => e.Equiptments)
                .WithRequired(e => e.EquiptmentType)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Service>()
                .HasMany(e => e.Bookings)
                .WithRequired(e => e.Service)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Service>()
                .HasMany(e => e.Costs)
                .WithRequired(e => e.Service)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Service>()
                .HasMany(e => e.EquiptmentNeededs)
                .WithRequired(e => e.Service)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Service>()
                .HasMany(e => e.Service_Products)
                .WithRequired(e => e.Service)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ServiceType>()
                .HasMany(e => e.Services)
                .WithRequired(e => e.ServiceType)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<StaffRole>()
                .HasMany(e => e.Staffs)
                .WithRequired(e => e.StaffRole)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<StaffRole>()
                .HasMany(e => e.StaffAccesses)
                .WithRequired(e => e.StaffRole)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<SystemAuthorization>()
                .HasMany(e => e.StaffAccesses)
                .WithRequired(e => e.SystemAuthorization)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ProductImage>()
                .HasMany(e => e.Stocks)
                .WithRequired(e => e.ProductImage)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ProductSupplier>()
                .HasMany(e => e.Stocks)
                .WithRequired(e => e.ProductSupplier)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Stock>()
                .HasMany(e => e.Service_Products)
                .WithRequired(e => e.Stock)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Stock>()
                .HasMany(e => e.StockLevels)
                .WithRequired(e => e.Stock)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<StockType>()
                .HasMany(e => e.Stocks)
                .WithRequired(e => e.StockType)
                .HasForeignKey(e => e.ProductStockTypeID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Users>()
                .Property(e => e.FirstName)
                .IsUnicode(false);

            modelBuilder.Entity<Users>()
                .Property(e => e.LastName)
                .IsUnicode(false);

            modelBuilder.Entity<Users>()
                .Property(e => e.EmailID)
                .IsUnicode(false);

            modelBuilder.Entity<Users>()
                .Property(e => e.Password)
                .IsUnicode(false);
        }

        public System.Data.Entity.DbSet<BookingsModel.Models.CustomerLogin> CustomerLogins { get; set; }

        public System.Data.Entity.DbSet<BookingsModel.Models.ResetPasswordModel> ResetPasswordModels { get; set; }
    }
}
