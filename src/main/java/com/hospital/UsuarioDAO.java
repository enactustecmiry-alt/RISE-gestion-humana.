package com.hospital;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    public boolean insertarUsuario(String nombre, String apPaterno, String apMaterno, String correo, String telefono, String rol) {
        String sql = "INSERT INTO usuarios (nombre, ap_paterno, ap_materno, correo, num_telefono, rol) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, nombre);
            pstmt.setString(2, apPaterno);
            pstmt.setString(3, apMaterno);
            pstmt.setString(4, correo);
            pstmt.setString(5, telefono);
            pstmt.setString(6, rol);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al crear usuario: " + e.getMessage());
            return false;
        }
    }

    public List<Usuario> listarUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios ORDER BY rol, nombre";
        try (Connection conn = ConexionBD.obtenerConexion();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setNombre(rs.getString("nombre"));
                u.setApPaterno(rs.getString("ap_paterno"));
                u.setApMaterno(rs.getString("ap_materno"));
                u.setCorreo(rs.getString("correo"));
                u.setTelefono(rs.getString("num_telefono"));
                u.setRol(rs.getString("rol"));
                lista.add(u);
            }
        } catch (SQLException e) {
            System.err.println("Error al leer usuarios: " + e.getMessage());
        }
        return lista;
    }

    public List<SeguroVigenteDTO> consultarSegurosActivos() {
        List<SeguroVigenteDTO> lista = new ArrayList<>();
        String sql = "{CALL sp_consultar_seguros_activos()}";
        try (Connection conn = ConexionBD.obtenerConexion();
             CallableStatement cstmt = conn.prepareCall(sql);
             ResultSet rs = cstmt.executeQuery()) {
            
            while (rs.next()) {
                String nombreCompleto = rs.getString("nombre") + " " + rs.getString("ap_paterno");
                SeguroVigenteDTO seguro = new SeguroVigenteDTO(
                    nombreCompleto,
                    rs.getString("aseguradora"),
                    rs.getString("numero_poliza"),
                    rs.getDate("vigencia_fin")
                );
                lista.add(seguro);
            }
        } catch (SQLException e) {
            System.err.println("Error al ejecutar procedimiento: " + e.getMessage());
        }
        return lista;
    }

    public boolean actualizarTelefonoUsuario(int idUsuario, String nuevoTelefono) {
        String sql = "UPDATE usuarios SET num_telefono = ? WHERE id_usuario = ?";
        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, nuevoTelefono);
            pstmt.setInt(2, idUsuario);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar usuario: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminarUsuario(int idUsuario) {
        String sql = "DELETE FROM usuarios WHERE id_usuario = ?";
        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idUsuario);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar usuario: " + e.getMessage());
            return false;
        }
    }
}