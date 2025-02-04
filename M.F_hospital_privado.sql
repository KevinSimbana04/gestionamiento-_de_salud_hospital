create database hospital_buen_dia;
use hospital_buen_dia;


-- tabla datos personales
CREATE TABLE datospersonales (
    id  INT AUTO_INCREMENT PRIMARY KEY,
    nombres_completos VARCHAR(100) NOT NULL CHECK (LENGTH(nombres_completos) >= 10),
    fecha_nacimiento DATE NOT NULL,
    edad INT NOT NULL CHECK (edad >= 0),
    sexo ENUM('M','F','O') NOT NULL,
    estado_civil VARCHAR(100),
    telefono VARCHAR(20) NOT NULL CHECK (telefono REGEXP '^\+593[0-9]{9}$'),
    direccion_id INT NOT NULL,
    pais_origen_id INT NOT NULL, 
    correo_electronico VARCHAR(100) UNIQUE NOT NULL CHECK (correo_electronico REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    tipo_persona ENUM('Paciente', 'Medico', 'Personal Administrativo') NOT NULL,
    CONSTRAINT fk_direccion FOREIGN KEY (direccion_id) REFERENCES direcciones(id),
    CONSTRAINT fk_pais_origen FOREIGN KEY (pais_origen_id) REFERENCES pais_origen(id)
);

CREATE TABLE direcciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cuidad VARCHAR(50) NOT NULL,
    parroquia VARCHAR(50) NOT NULL,
    calle_principal VARCHAR(100) NOT NULL,
    calle_secundaria VARCHAR(100),
    numero_casa VARCHAR(10) NOT NULL,
    referencia TEXT
);

CREATE TABLE pais_origen (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pais VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(100) NOT NULL
);

-- Medico
CREATE TABLE medicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    datos_personales_id INT NOT NULL,
    especialidad_id INT NOT NULL,
    licencia_profesional VARCHAR(50) NOT NULL UNIQUE,
    experiencia_years INT NOT NULL CHECK (experiencia_years >= 0),
    tipo_contrato ENUM('Permanente', 'Temporal', 'Por Servicio') NOT NULL,
    fecha_ingreso DATE NOT NULL,
    horario_atencion VARCHAR(100),
    salario DECIMAL(10, 2) NOT NULL CHECK (salario >= 0),
    CONSTRAINT fk_datos_personales_medico FOREIGN KEY (datos_personales_id) REFERENCES datospersonales(id) ON DELETE CASCADE,
    CONSTRAINT fk_especialidad FOREIGN KEY (especialidad_id) REFERENCES especialidades(id)
);

-- Especialidad
CREATE TABLE especialidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);

-- Pacientes
CREATE TABLE pacientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    datos_personales_id INT NOT NULL,
    grupo_sanguineo ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') NOT NULL,
    alergias TEXT,
    enfermedades_preexistentes TEXT,
    medicamentos_actuales TEXT,
    historial_medico TEXT,
    vacunas TEXT,
    contacto_emergencia_nombre VARCHAR(100) NOT NULL,
    contacto_emergencia_telefono VARCHAR(15) NOT NULL CHECK (contacto_emergencia_telefono REGEXP '^\+593[0-9]{9}$'),
    CONSTRAINT fk_datos_personales_pacientes FOREIGN KEY (datos_personales_id) REFERENCES datospersonales(id)
);

-- Citas
CREATE TABLE citas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    medico_id INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    estado ENUM('Pendiente', 'Completada', 'Cancelada') NOT NULL,
    motivo TEXT,
    area_id INT,
    CONSTRAINT fk_paciente_cita FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    CONSTRAINT fk_medico_cita FOREIGN KEY (medico_id) REFERENCES medicos(id) ON DELETE CASCADE,
    CONSTRAINT fk_seccion_cita FOREIGN KEY (area_id) REFERENCES areas(id)
);

-- Historial Médico
CREATE TABLE historialmedico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cita_id INT NOT NULL,
    paciente_id INT NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observaciones TEXT,
    CONSTRAINT fk_historial_cita FOREIGN KEY (cita_id) REFERENCES citas(id) ON DELETE CASCADE,
    CONSTRAINT fk_historial_paciente FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE
);

-- Area
CREATE TABLE areas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(50) NOT NULL,
    num_consultorio INT NOT NULL
);

-- Exámenes Médicos
CREATE TABLE examenesmedicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    tipo_examen ENUM('Laboratorio', 'Imagenología', 'Funcional', 'Otros') NOT NULL,
    costo DECIMAL(10, 2) NOT NULL CHECK (costo >= 0)
);

-- Ordenes de Exámenes
CREATE TABLE ordenesexamenes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cita_id INT NOT NULL,
    examen_id INT NOT NULL,
    factura_id INT,
    fecha_solicitud DATE NOT NULL,
    fecha_realizacion DATE,
    resultados TEXT,
    costo_examen DECIMAL(10, 2) NOT NULL CHECK (costo_examen >= 0),
    estado ENUM('Pendiente', 'Realizado', 'Cancelado') NOT NULL,
    CONSTRAINT fk_orden_examen_cita FOREIGN KEY (cita_id) REFERENCES citas(id) ON DELETE CASCADE,
    CONSTRAINT fk_orden_examen FOREIGN KEY (examen_id) REFERENCES examenesmedicos(id),
    CONSTRAINT fk_factura_examen FOREIGN KEY (factura_id) REFERENCES facturas(id) ON DELETE CASCADE
);

-- Prescripciones Médicas
CREATE TABLE prescripcionesMedicas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cita_id INT NOT NULL,
    medicamento_id INT NOT NULL,
    factura_id INT,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    costo_unitario DECIMAL(10, 2) NOT NULL CHECK (costo_unitario >= 0),
    costo_total DECIMAL(10, 2) GENERATED ALWAYS AS (cantidad * costo_unitario) STORED,
    instrucciones TEXT NOT NULL,
    estado ENUM('Pendiente', 'Entregado') NOT NULL,
    CONSTRAINT fk_prescripcion_cita FOREIGN KEY (cita_id) REFERENCES citas(id) ON DELETE CASCADE,
    CONSTRAINT fk_prescripcion_medicamento FOREIGN KEY (medicamento_id) REFERENCES medicamentos(id),
    CONSTRAINT fk_factura_medicamento FOREIGN KEY (factura_id) REFERENCES facturas(id) ON DELETE CASCADE
);

-- Medicamentos
CREATE TABLE medicamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    tipo_medicamento ENUM('Analgésico', 'Antibiótico', 'Antiinflamatorio', 'Antipirético', 'Otros') NOT NULL,
    presentacion ENUM('Tabletas', 'Jarabe', 'Inyección', 'Cápsulas') NOT NULL,
    dosis VARCHAR(50) NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0),
    fecha_vencimiento DATE NOT NULL,
    proveedor_id INT NOT NULL,
    CONSTRAINT fk_medicamento_proveedor FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
);

-- Proveedores
CREATE TABLE proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(255) NOT NULL
);

-- Facturas
CREATE TABLE facturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cita_id INT NOT NULL,
    fecha_emision DATE NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL CHECK (subtotal >= 0),
    impuestos DECIMAL(10, 2) NOT NULL CHECK (impuestos >= 0),
    total DECIMAL(10, 2) NOT NULL CHECK (total >= 0),
    estado_pago ENUM('Pagada', 'Pendiente', 'Cancelada') NOT NULL,
    metodo_pago ENUM('Efectivo', 'Tarjeta de Crédito', 'Transferencia Bancaria', 'Seguro Médico') NOT NULL,
    total_examenes DECIMAL(10, 2) DEFAULT 0 CHECK (total_examenes >= 0),
    total_medicamentos DECIMAL(10, 2) DEFAULT 0 CHECK (total_medicamentos >= 0),
    observaciones TEXT,
    CONSTRAINT fk_factura_cita FOREIGN KEY (cita_id) REFERENCES citas(id) ON DELETE CASCADE
);
