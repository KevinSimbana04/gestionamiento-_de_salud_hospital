-- crear roles
create role medicos;
create role enfermeras;
create role personal_administrativo;
create role farmaceuticos;
create role tecnicos_laboratorio;

-- creacion_usuario 
-- ENFERMERA
CREATE USER 'enfermera_usuario'@'localhost' IDENTIFIED BY 'password_enfermera';

-- Asignar el rol enfermeras
GRANT enfermeras TO 'enfermera_usuario'@'localhost';

-- PESONAL ADMINISTRATIVO
CREATE USER 'administrativo_usuario'@'localhost' IDENTIFIED BY 'password_administrativo';

-- Asignar el rol personal_administrativo
GRANT personal_administrativo TO 'administrativo_usuario'@'localhost';

-- FARMACEUTICO
CREATE USER 'farmaceutico_usuario'@'localhost' IDENTIFIED BY 'password_farmaceutico';

-- Asignar el rol farmaceuticos
GRANT farmaceuticos TO 'farmaceutico_usuario'@'localhost';

-- Asignar permisos para gestionar prescripciones y el inventario de medicamentos
GRANT SELECT ON prescripciones TO 'farmaceutico_usuario'@'localhost';

-- TECNICOS_LABORATORIO
CREATE USER 'tecnico_laboratorio_usuario'@'localhost' IDENTIFIED BY 'password_tecnico_laboratorio';

-- Asignar el rol tecnicos_laboratorio
GRANT tecnicos_laboratorio TO 'tecnico_laboratorio_usuario'@'localhost';

/*Prmisos*/

-- Permisos para el rol medicos
GRANT SELECT ON hospital_buen_dia.datospersonales TO medicos;
GRANT SELECT ON hospital_buen_dia.pacientes TO medicos;
GRANT SELECT, UPDATE ON hospital_buen_dia.citas TO medicos;
GRANT SELECT, UPDATE ON hospital_buen_dia.historial_medico TO medicos;

-- Permisos para el rol personal_administrativo
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_buen_dia.datosPersonales TO personal_administrativo;
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_buen_dia.citas TO personal_administrativo;
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_buen_dia.medicos TO personal_administrativo;
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_buen_dia.pacientes TO personal_administrativo;

-- Permisos para el rol farmaceuticos
GRANT SELECT ON hospital_buen_dia.pacientes TO farmaceuticos;
GRANT SELECT ON hospital_buen_dia.medicos TO farmaceuticos;
GRANT SELECT ON hospital_buen_dia.citas TO farmaceuticos;
GRANT SELECT, UPDATE ON hospital_buen_dia.medicamentos TO farmaceuticos;


-- Permisos para el rol tecnicos_laboratorio
GRANT SELECT ON  hospital_buen_dia.pacientes TO tecnicos_laboratorio;
GRANT SELECT ON  hospital_buen_dia.citas TO tecnicos_laboratorio;
GRANT SELECT ON hospital_buen_dia.medicos TO tecnicos_laboratorio;
GRANT SELECT, INSERT, UPDATE ON hospital_buen_dia.eexamenes TO tecnico_laboratorio;