package com.hospital;

import com.hospital.CitaMedica;
import com.hospital.CitaMedicaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/citas")
@CrossOrigin(origins = "*")
public class CitaMedicaController {

    @Autowired
    private CitaMedicaRepository citaRepository;

    // Obtener todas las citas
    @GetMapping
    public List<CitaMedica> obtenerTodas() {
        return citaRepository.findAll();
    }

    // Guardar una nueva cita
    @PostMapping
    public ResponseEntity<CitaMedica> crearCita(@RequestBody CitaMedica cita) {
        if (cita.getEstado() == null || cita.getEstado().isEmpty()) {
            cita.setEstado("PROGRAMADA");
        }
        CitaMedica nuevaCita = citaRepository.save(cita);
        return ResponseEntity.ok(nuevaCita);
    }
}