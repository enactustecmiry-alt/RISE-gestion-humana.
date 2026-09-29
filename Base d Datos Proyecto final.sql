drop database if exists ProyecFinal;

create database if not exists ProyecFinal;

use ProyecFinal;

-- 1. Tabla Usuarios 
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ap_paterno VARCHAR(30) NOT NULL,
    ap_materno VARCHAR(30),
    correo VARCHAR(150) NOT NULL UNIQUE,
    num_telefono VARCHAR(20),
    rol VARCHAR(50) NOT NULL
);

-- 2. Tabla Dirección
CREATE TABLE IF NOT EXISTS direccion (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    calle VARCHAR(150) NOT NULL,
    num_ext VARCHAR(30),
    colonia VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL
);

-- 3. Tabla Hospitales
CREATE TABLE IF NOT EXISTS hospitales (
    id_hospital INT AUTO_INCREMENT PRIMARY KEY,
    id_direccion INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    telefono_hospital VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

-- 4. Tabla Pacientes 
CREATE TABLE IF NOT EXISTS pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero VARCHAR(20) NOT NULL,
    curp VARCHAR(18) NOT NULL UNIQUE,
    metodo_pago VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- 5. Tabla Doctores
CREATE TABLE IF NOT EXISTS doctores (
    id_doctor INT AUTO_INCREMENT PRIMARY KEY,
    id_hospital INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    telefono_doc VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_hospital) REFERENCES hospitales(id_hospital)
);

-- 6. Tabla Citas Médicas 
CREATE TABLE IF NOT EXISTS citas_medicas (
    id_cita INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_doctor INT NOT NULL,
    id_usuario_creador INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    motivo TEXT,
    estado VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_doctor) REFERENCES doctores(id_doctor),
    FOREIGN KEY (id_usuario_creador) REFERENCES usuarios(id_usuario)
);

-- 7. Tabla Seguro Médico
CREATE TABLE IF NOT EXISTS seguro_medico (
    id_seguro INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    aseguradora VARCHAR(100) NOT NULL,
    numero_poliza VARCHAR(50) NOT NULL,
    tipo_cobertura VARCHAR(100) NOT NULL,
    vigencia_fin DATE NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente)
);

-- 8. Tabla Ventas de Citas / Servicios
CREATE TABLE IF NOT EXISTS ventas_citas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cita INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_venta DATETIME NOT NULL,
    canal_venta VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_cita) REFERENCES citas_medicas(id_cita)
);

-- 9. Tabla Inventario de Insumos Médicos
CREATE TABLE IF NOT EXISTS inventario_insumos (
    id_insumo INT AUTO_INCREMENT PRIMARY KEY,
    codigo_barras VARCHAR(50) NOT NULL UNIQUE,
    nombre_insumo VARCHAR(150) NOT NULL,
    stock INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL
);

-- 10. Tabla de Seguimiento de Atención a Clientes
CREATE TABLE IF NOT EXISTS seguimiento_atencion_clientes (
    id_seguimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    nombre_cliente VARCHAR(150) NOT NULL,
    fecha_hora_compra DATETIME NOT NULL,
    canal VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente)
);

-- ==========================================
-- INSERCIÓN DE DATOS
-- ==========================================

INSERT INTO usuarios (nombre, ap_paterno, ap_materno, correo, num_telefono, rol) 
VALUES 
('Carlos', 'Gómez', 'Pérez', 'carlos.gomez@email.com', '5551234567', 'Paciente'), 
('María', 'López', 'Hernández', 'maria.lopez@email.com', '5559876543', 'Paciente'), 
('Juan', 'Martínez', 'Sánchez', 'juan.martinez@email.com', '5554567890', 'Recepcionista'), 
('Ana', 'Rodríguez', 'Torres', 'ana.rodriguez@email.com', '5553216549', 'Paciente'), 
('Luis', 'Fernández', 'Morales', 'luis.fernandez@email.com', '5557890123', 'Administrador');

INSERT INTO direccion (calle, num_ext, colonia, ciudad, codigo_postal)
VALUES
('Av. Insurgentes Sur', '1234', 'Del Valle', 'Ciudad de México', '03100'),
('Calle Reforma', '500', 'Juárez', 'Ciudad de México', '06600'),
('Av. Universidad', '789', 'Copilco', 'Ciudad de México', '04360'),
('Calzada de Tlalpan', '4321', 'Churubusco', 'Ciudad de México', '04120'),
('Av. Hidalgo', '45', 'Centro', 'Monterrey', '64000');

INSERT INTO hospitales (id_direccion, nombre, telefono_hospital)
VALUES
(1, 'Hospital General del Sur', '5511223344'),
(2, 'Clínica Médica Central', '5522334455'),
(3, 'Centro Médico Universidad', '5533445566'),
(4, 'Hospital de Especialidades Tlalpan', '5544556677'),
(5, 'Sanatorio San José', '8188990011');

INSERT INTO pacientes (id_usuario, fecha_nacimiento, genero, curp, metodo_pago)
VALUES
(1, '1990-05-15', 'Masculino', 'GOPC900515HDFRRL01', 'Tarjeta débito'),
(2, '1985-08-22', 'Femenino', 'LOHM850822MDFRRN02', 'Tarjeta crédito'),
(4, '1998-12-01', 'Femenino', 'ROTA981201MDFRRD03', 'Efectivo'),
(3, '1992-03-10', 'Masculino', 'MASJ920310HDFRRN04', 'Tarjeta débito'),
(5, '1979-11-30', 'Masculino', 'FEML791130HNLRLS05', 'Tarjeta crédito');

INSERT INTO doctores (id_hospital, nombre, especialidad, telefono_doc)
VALUES
(1, 'Dr. Roberto Silva', 'Cardiología', '5551112233'),
(2, 'Dra. Elena Ramos', 'Pediatría', '5552223344'),
(3, 'Dr. Fernando Castro', 'Dermatología', '5553334455'),
(4, 'Dra. Sofia Mendoza', 'Ginecología', '5554445566'),
(5, 'Dr. Ricardo Vargas', 'Medicina General', '8185556677');

INSERT INTO citas_medicas (id_paciente, id_doctor, id_usuario_creador, fecha_hora, motivo, estado)
VALUES
(1, 1, 1, '2026-03-10 09:00:00', 'Chequeo cardiológico de rutina', 'Confirmada'),
(2, 2, 3, '2026-03-11 11:30:00', 'Consulta pediátrica de seguimiento', 'Pendiente'),
(3, 3, 4, '2026-03-12 16:00:00', 'Revisión por alergia en la piel', 'Completada'),
(4, 4, 3, '2026-03-15 10:00:00', 'Control ginecológico anual', 'Confirmada'),
(5, 5, 5, '2026-03-18 08:30:00', 'Valoración por dolor abdominal', 'Cancelada');

INSERT INTO seguro_medico (id_paciente, aseguradora, numero_poliza, tipo_cobertura, vigencia_fin)
VALUES
(1, 'AXA Seguros', 'POL998877-A', 'Cobertura Amplia', '2026-12-31'),
(2, 'GNP Seguros', 'POL-112233-B', 'Gastos Médicos Mayores', '2027-05-15'),
(3, 'Seguros Monterrey', 'POL-445566-C', 'Básica Nacional', '2026-10-01'),
(4, 'Mapfre', 'POL-778899-D', 'Cobertura Total', '2026-08-20'),
(5, 'MetLife', 'POL-334455-E', 'Gastos Médicos Mayores', '2027-01-10');

INSERT INTO ventas_citas (id_cita, monto, fecha_venta, canal_venta)
VALUES 
(1, 1500.00, '2026-03-10 09:30:00', 'Sitio Web'),
(2, 800.00, '2026-03-11 12:00:00', 'App Móvil'),
(3, 1200.00, '2026-03-12 16:30:00', 'Presencial');

-- ==========================================
-- CONSULTAS Y PROCEDIMIENTOS
-- ==========================================

-- A. ORDER BY
SELECT * FROM citas_medicas ORDER BY fecha_hora DESC;

SELECT * FROM citas_medicas ORDER BY fecha_hora ASC;

-- B. UNION
SELECT nombre, correo, 'Paciente' AS tipo FROM usuarios WHERE rol = 'Paciente'
UNION
SELECT nombre, correo, 'Doctor' AS tipo FROM usuarios WHERE rol = 'Doctor';

-- C. JOIN
SELECT 
    u.nombre AS Nombre_Usuario,
    p.curp,
    c.fecha_hora,
    c.estado,
    d.nombre AS Doctor_Asignado
FROM usuarios u
JOIN pacientes p ON u.id_usuario = p.id_usuario
JOIN citas_medicas c ON p.id_paciente = c.id_paciente
JOIN doctores d ON c.id_doctor = d.id_doctor;

-- D. GROUP BY
SELECT 
    canal_venta, 
    COUNT(id_venta) AS total_ventas, 
    SUM(monto) AS ingreso_total
FROM ventas_citas
GROUP BY canal_venta;

DELIMITER //

-- Procedimiento existente de ventas
CREATE PROCEDURE sp_reporte_ventas_diarias(IN p_fecha DATE)
BEGIN
    SELECT * FROM ventas_citas 
    WHERE DATE(fecha_venta) = p_fecha;

    SELECT 
        p_fecha AS Fecha_Reporte,
        COUNT(id_venta) AS Total_Transacciones,
        IFNULL(SUM(monto), 0.00) AS Monto_Total_Vendido
    FROM ventas_citas 
    WHERE DATE(fecha_venta) = p_fecha;
END //

-- Procedimiento existente del primer trimestre
CREATE PROCEDURE sp_clientes_vigentes_primer_trimestre(IN p_anio INT)
BEGIN
    SELECT DISTINCT
        p.id_paciente,
        u.nombre,
        u.ap_paterno,
        u.correo,
        u.num_telefono,
        MIN(c.fecha_hora) AS primera_cita_periodo
    FROM usuarios u
    JOIN pacientes p ON u.id_usuario = p.id_usuario
    JOIN citas_medicas c ON p.id_paciente = c.id_paciente
    WHERE c.fecha_hora BETWEEN CONCAT(p_anio, '-01-01 00:00:00') AND CONCAT(p_anio, '-03-31 23:59:59')
    GROUP BY p.id_paciente, u.nombre, u.ap_paterno, u.correo, u.num_telefono;
END //

-- NUEVO PROCEDURE: Consultar seguros médicos activos (vigentes)
CREATE PROCEDURE sp_consultar_seguros_activos()
BEGIN
    SELECT 
        u.nombre,
        u.ap_paterno,
        s.aseguradora,
        s.numero_poliza,
        s.tipo_cobertura,
        s.vigencia_fin
    FROM seguro_medico s
    JOIN pacientes p ON s.id_paciente = p.id_paciente
    JOIN usuarios u ON p.id_usuario = u.id_usuario
    WHERE s.vigencia_fin >= CURDATE();
END //

-- Procedimiento de registro con control de excepciones
CREATE PROCEDURE sp_agregar_usuario_seguro(
    IN p_nombre VARCHAR(100),
    IN p_ap_paterno VARCHAR(30),
    IN p_ap_materno VARCHAR(30),
    IN p_correo VARCHAR(150),
    IN p_num_telefono VARCHAR(20),
    IN p_rol VARCHAR(50),
    OUT p_mensaje VARCHAR(255)
)
BEGIN
    DECLARE duplicate_email INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR 1062 
    BEGIN
        SET duplicate_email = 1;
    END;

    INSERT INTO usuarios (nombre, ap_paterno, ap_materno, correo, num_telefono, rol)
    VALUES (p_nombre, p_ap_paterno, p_ap_materno, p_correo, p_num_telefono, p_rol);

    IF duplicate_email = 1 THEN
        SET p_mensaje = 'Error: Excepción de restricción única. El correo electrónico ya se encuentra registrado.';
    ELSE
        SET p_mensaje = 'Éxito: Usuario registrado correctamente.';
    END IF;
END //

-- TRIGGER: Validar que no se inserte un seguro vencido
CREATE TRIGGER trg_validar_vigencia_seguro
BEFORE INSERT ON seguro_medico
FOR EACH ROW
BEGIN
    IF NEW.vigencia_fin < CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No se puede registrar un seguro médico que ya se encuentra vencido.';
    END IF;
END //

-- Trigger de inventario
CREATE TRIGGER TRG_BEFORE_INSERT_INVENTARIO 
BEFORE INSERT ON inventario_insumos
FOR EACH ROW
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*) INTO v_count 
    FROM inventario_insumos 
    WHERE codigo_barras = NEW.codigo_barras;
    
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Excepción: No se pueden almacenar datos duplicados. El código de barras ya existe en el inventario.';
    END IF;
END //

-- Trigger de seguimiento de compras
CREATE TRIGGER trg_seguimiento_compras_online
AFTER INSERT ON ventas_citas
FOR EACH ROW
BEGIN
    DECLARE v_id_paciente INT;
    DECLARE v_nombre_completo VARCHAR(150);

    IF NEW.canal_venta IN ('Sitio Web', 'App Móvil') THEN
        SELECT c.id_paciente INTO v_id_paciente
        FROM citas_medicas c
        WHERE c.id_cita = NEW.id_cita;

        SELECT CONCAT(u.nombre, ' ', u.ap_paterno, ' ', IFNULL(u.ap_materno, '')) INTO v_nombre_completo
        FROM pacientes p
        JOIN usuarios u ON p.id_usuario = u.id_usuario
        WHERE p.id_paciente = v_id_paciente;

        INSERT INTO seguimiento_atencion_clientes (id_paciente, nombre_cliente, fecha_hora_compra, canal)
        VALUES (v_id_paciente, v_nombre_completo, NEW.fecha_venta, NEW.canal_venta);
    END IF;
END //

DELIMITER ;