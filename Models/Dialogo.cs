using System.ComponentModel.DataAnnotations;

namespace DialogosAPI.Models
{
    public class Dialogo
    {
        [Key]
        public int Id { get; set; }
        public string? Nome { get; set; }
        public string? Url_Img { get; set; }
        public string? Japones { get; set; }
        public string? Japones_Sem_Kanji { get; set; }
        public string? Romaji { get; set; }
        public string? Traducao { get; set; }
    }
} 