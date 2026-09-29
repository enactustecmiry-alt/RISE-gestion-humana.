package com.hospital;

public class RegistroDTO {
    private String nombre;
    private String apPaterno;
    private String apMaterno;
    private String email;
    private String telefono;
    private String rol;
    private String claveAdmin;

    public RegistroDTO() {}

    // Getters y Setters
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getApPaterno() { return apPaterno; }
    public void setApPaterno(String apPaterno) { this.apPaterno = apPaterno; }

    public String getApMaterno() { return apMaterno; }
    public void setApMaterno(String apMaterno) { this.apMaterno = apMaterno; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getRol() { return rol; }
    public void setRol(String rol) { this.rol = rol; }

    public String getClaveAdmin() { return claveAdmin; }
    public void setClaveAdmin(String claveAdmin) { this.claveAdmin = claveAdmin; }
}