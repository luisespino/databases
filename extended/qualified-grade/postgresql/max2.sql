CREATE TABLE empleado (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE puesto (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE empleado_puesto (
    empleado_id INTEGER REFERENCES empleado(id),
    puesto_id INTEGER REFERENCES puesto(id),
    fecha_asignacion DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (empleado_id, puesto_id)
);

CREATE FUNCTION check_max_2_puestos() RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM empleado_puesto 
        WHERE empleado_id = NEW.empleado_id;
    
    IF v_count >= 2 THEN
        RAISE EXCEPTION 
            'Un empleado no puede tener más de 2 puestos. Empleado ID: %', 
            NEW.empleado_id;
    END IF;
    
    RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER trg_max_2_puestos
BEFORE INSERT OR UPDATE ON empleado_puesto
FOR EACH ROW
EXECUTE FUNCTION check_max_2_puestos();