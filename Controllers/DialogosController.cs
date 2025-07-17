using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DialogosAPI.Data;
using DialogosAPI.Models;

namespace DialogosAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DialogosController : ControllerBase
    {
        private readonly DataContext _context;

        public DialogosController(DataContext context)
        {
            _context = context;
        }

        // GET: api/dialogos
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Dialogo>>> GetDialogos()
        {
            var dialogos = await _context.Dialogos.OrderBy(d => d.Id).ToListAsync();
            return Ok(dialogos);
        }

        // POST: api/dialogos
        [HttpPost]
        public async Task<ActionResult<Dialogo>> PostDialogo(Dialogo dialogo)
        {
            var apiKeyEnv = Environment.GetEnvironmentVariable("DIALOGOS_API_KEY");
            if (!Request.Headers.TryGetValue("X-Api-Key", out var apiKey) || apiKey != apiKeyEnv)
            {
                return Unauthorized("Chave de API inválida ou ausente.");
            }

            _context.Dialogos.Add(dialogo);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetDialogos), new { id = dialogo.Id }, dialogo);
        }

        // PUT: api/dialogos/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDialogo(int id, Dialogo dialogo)
        {
            var apiKeyEnv = Environment.GetEnvironmentVariable("DIALOGOS_API_KEY");
            if (!Request.Headers.TryGetValue("X-Api-Key", out var apiKey) || apiKey != apiKeyEnv)
            {
                return Unauthorized("Chave de API inválida ou ausente.");
            }

            if (id != dialogo.Id)
            {
                return BadRequest("O ID da URL não corresponde ao ID do diálogo enviado.");
            }

            _context.Entry(dialogo).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DialogoExists(id))
                {
                    return NotFound("Diálogo não encontrado.");
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // Método auxiliar privado para verificar se um diálogo existe
        private bool DialogoExists(int id)
        {
            return _context.Dialogos.Any(e => e.Id == id);
        }
    }
} 