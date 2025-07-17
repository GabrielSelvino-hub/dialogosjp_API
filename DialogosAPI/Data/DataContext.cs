using Microsoft.EntityFrameworkCore;
using DialogosAPI.Models;

namespace DialogosAPI.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {
        }

        public DbSet<Dialogo> Dialogos { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Dialogo>().ToTable("dialogos");
        }
    }
} 