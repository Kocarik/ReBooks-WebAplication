﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;

public partial class ReBooksDBEntities : DbContext
{
    public ReBooksDBEntities()
        : base("name=ReBooksDBEntities")
    {
    }

    protected override void OnModelCreating(DbModelBuilder modelBuilder)
    {
        throw new UnintentionalCodeFirstException();
    }

    public DbSet<BookCategory> BookCategories { get; set; }
    public DbSet<BookLanguage> BookLanguages { get; set; }
    public DbSet<Book> Books { get; set; }
    public DbSet<BooksDetail> BooksDetails { get; set; }
    public DbSet<Loan> Loans { get; set; }
    public DbSet<User> Users { get; set; }
    public DbSet<UsersDetail> UsersDetails { get; set; }
    public DbSet<UsersLogin> UsersLogins { get; set; }
}
