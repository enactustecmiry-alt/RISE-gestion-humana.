package com.hospital;

import java.sql.Date;

public class SeguroVigenteDTO {
    private String paciente;
    private String aseguradora;
    private String numeroPoliza;
    private Date vigenciaFin;

    public SeguroVigenteDTO() {}

    public SeguroVigenteDTO(String paciente, String aseguradora, String numeroPoliza, Date vigenciaFin) {
        this.paciente = paciente;
        this.aseguradora = aseguradora;
        this.numeroPoliza = numeroPoliza;
        this.vigenciaFin = vigenciaFin;
    }

    // Getters y Setters
    public String getPaciente() { return paciente; }
    public void setPaciente(String paciente) { this.paciente = paciente; }

    public String getAseguradora() { return aseguradora; }
    public void setAseguradora(String aseguradora) { this.aseguradora = aseguradora; }

    public String getNumeroPoliza() { return numeroPoliza; }
    public void setNumeroPoliza(String numeroPoliza) { this.numeroPoliza = numeroPoliza; }

    public Date getVigenciaFin() { return vigenciaFin; }
    public void setVigenciaFin(Date vigenciaFin) { this.vigenciaFin = vigenciaFin; }
}