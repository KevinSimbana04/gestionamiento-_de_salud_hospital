INSERT INTO pais_origen (pais, nacionalidad) 
VALUES 
('Ecuador', 'Ecuatoriana');

INSERT INTO direcciones (cuidad, parroquia, calle_principal, calle_secundaria, numero_casa, referencia)
VALUES 
('Quito', 'Centro Histórico', 'Rocafuerte', 'Esquina con Calle Sucre', '123', 'Frente a la iglesia'),
('Quito', 'La Mariscal', 'Wilson', 'Esquina con Amazonas', '456', 'Cerca del parque La Carolina'),
('Quito', 'El Inca', 'Callejón de la Niña', 'Esquina con Av. Occidental', '789', 'A una cuadra del parque El Inca');

INSERT INTO datospersonales (tipo_idnetificacion, numero_indetificacion, nombres_completos, fecha_nacimiento, edad, sexo, estado_civil, telefono, direccion_id, pais_origen_id, correo_electronico, tipo_persona) 
VALUES 
('cedula', '0102030405', 'Juan Pérez', '1990-05-15', 34, 'M', 'Soltero', '+593984567890', 1, 1, 'juan.perez@example.com', 'Paciente'),
('cedula', '0607080901', 'Maria López', '1985-08-25', 39, 'F', 'Casada', '+593987654321', 2, 1, 'maria.lopez@example.com', 'Medico');


INSERT INTO medicos (datos_personales_id, especialidad_id, licencia_profesional, experiencia_years, tipo_contrato, fecha_ingreso, horario_entrada, hora_salida)
VALUES 
(2, 1, 'C12345', 10, 'Permanente', '2015-06-01', '08:00:00', '16:00:00'),
(2, 2, 'P67890', 8, 'Temporal', '2017-08-15', '09:00:00', '17:00:00');


INSERT INTO especialidades (nombre, descripcion)
VALUES 
('Cardiología', 'Especialidad que se encarga del diagnóstico y tratamiento de enfermedades del corazón'),
('Pediatría', 'Especialidad que se enfoca en la atención médica de niños y adolescentes'),
('Neurología', 'Especialidad que estudia el sistema nervioso y sus enfermedades');



INSERT INTO pacientes (datos_personales_id, grupo_sanguineo, alergias, enfermedades_preexistentes, medicamentos_actuales, contacto_emergencia_nombre, contacto_emergencia_telefono)
VALUES 
(1, 'A+', 'Polen', 'Hipertensión', 'Losartan', 'Carlos Pérez', '+593984567890'),
(1, 'O-', 'Ninguna', 'Asma', 'Salbutamol', 'Ana López', '+593987654321');

INSERT INTO areas (nombre, ubicacion, num_consultorio)
VALUES 
('Cardiología', 'Edificio A', 101),
('Pediatría', 'Edificio B', 202),
('Neurología', 'Edificio C', 303);


INSERT INTO citas (paciente_id, medico_id, fecha, hora_inicio, hora_finalizacion, estado, motivo, area_id)
VALUES 
(1, 1, '2025-02-10', '09:00:00', '09:30:00', 'Pendiente', 'Chequeo rutinario', 1),
(2, 2, '2025-02-11', '10:00:00', '10:30:00', 'Completada', 'Consulta por fiebre', 2);


INSERT INTO citas (paciente_id, medico_id, fecha, hora_inicio, hora_finalizacion, estado, motivo, area_id)
VALUES 
(1, 1, '2025-02-10', '09:00:00', '09:30:00', 'Pendiente', 'Chequeo rutinario', 1),
(2, 2, '2025-02-11', '10:00:00', '10:30:00', 'Completada', 'Consulta por fiebre', 2);

INSERT INTO examenesmedicos (nombre, descripcion, tipo_examen, costo)
VALUES 
('Electrocardiograma', 'Examen para evaluar la actividad eléctrica del corazón', 'Laboratorio', 50.00),
('Radiografía de tórax', 'Imagenología para observar el estado de los pulmones', 'Imagenología', 40.00);

INSERT INTO ordenesexamenes (cita_id, examen_id, factura_id, fecha_solicitud, fecha_realizacion, resultados, costo_examen, estado)
VALUES 
(1, 1, NULL, '2025-02-10', '2025-02-10', 'Normal', 50.00, 'Realizado'),
(2, 2, NULL, '2025-02-11', '2025-02-11', 'Normal', 40.00, 'Realizado');


INSERT INTO prescripcionesMedicas (cita_id, medicamento_id, factura_id, cantidad, costo_unitario, instrucciones, estado)
VALUES 
(1, 1, NULL, 2, 10.00, 'Tomar una tableta cada 12 horas', 'Pendiente'),
(2, 2, NULL, 1, 5.00, 'Tomar cada 8 horas', 'Entregado');


INSERT INTO medicamentos (nombre, descripcion, tipo_medicamento, presentacion, dosis, stock, fecha_vencimiento, proveedor_id)
VALUES 
('Losartan', 'Medicamento para la hipertensión', 'Antihipertensivo', 'Tabletas', '50mg', 100, '2025-12-31', 1),
('Paracetamol', 'Medicamento para la fiebre', 'Analgésico', 'Tabletas', '500mg', 200, '2026-06-30', 2);

INSERT INTO proveedores (nombre, contacto, telefono, direccion)
VALUES 
('Farmacia San Juan', 'Juan Pérez', '+593987654321', 'Av. Amazonas 123, Quito'),
('Medicamentos del Ecuador', 'Carlos López', '+593984567890', 'Calle Quito 456, Quito');


INSERT INTO facturas (cita_id, fecha_emision, subtotal, impuestos, total, estado_pago, metodo_pago, total_examenes, total_medicamentos, observaciones)
VALUES 
(1, '2025-02-10', 50.00, 4.50, 54.50, 'Pendiente', 'Efectivo', 50.00, 20.00, 'Examen de rutina y medicación'),
(2, '2025-02-11', 40.00, 3.60, 43.60, 'Pagada', 'Tarjeta de Crédito', 40.00, 10.00, 'Consulta y medicamento entregado');
