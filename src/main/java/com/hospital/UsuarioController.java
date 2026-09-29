package com.hospital;

import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/usuarios")
@CrossOrigin(origins = "*")
public class UsuarioController {

    private UsuarioDAO dao = new UsuarioDAO();

    @GetMapping
    public List<Usuario> listarUsuarios() {
        return dao.listarUsuarios();
    }

    @GetMapping("/seguros-activos")
    public List<SeguroVigenteDTO> consultarSegurosActivos() {
        return dao.consultarSegurosActivos();
    }

    @PostMapping
    public String registrarUsuario(@RequestBody RegistroDTO registro) {
        String rol = registro.getRol();

        if ("Administrador".equalsIgnoreCase(rol)) {
            if (!"Admin123*".equals(registro.getClaveAdmin())) {
                return "Error: Contraseña de Administrador incorrecta.";
            }
        }

        boolean exito = dao.insertarUsuario(
            registro.getNombre(),
            registro.getApPaterno(),
            registro.getApMaterno(),
            registro.getEmail(),
            registro.getTelefono(),
            rol
        );

        return exito ? "Usuario registrado con éxito." : "Error al registrar usuario.";
    }

    @PutMapping("/{id}/telefono")
    public String actualizarTelefono(@PathVariable int id, @RequestParam String telefono) {
        boolean exito = dao.actualizarTelefonoUsuario(id, telefono);
        return exito ? "Teléfono actualizado correctamente." : "Error al actualizar.";
    }

    @DeleteMapping("/{id}")
    public String eliminarUsuario(@PathVariable int id) {
        boolean exito = dao.eliminarUsuario(id);
        return exito ? "Usuario eliminado correctamente." : "Error al eliminar.";
    }
}