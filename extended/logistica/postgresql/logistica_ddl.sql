-- CREATE DATABASE logistica;
-- \c logistica;

CREATE TABLE vehiculo (
    id SERIAL PRIMARY KEY,
    marca VARCHAR(50) NOT NULL,
    modelo INT NOT NULL
);

CREATE TABLE panel (
    volumen_m3 INT NOT NULL
) INHERITS (vehiculo);

CREATE TABLE camion (
    num_ejes INT NOT NULL
) INHERITS (vehiculo);

CREATE TABLE destino_nacional (
    id SERIAL PRIMARY KEY,
    departamento VARCHAR(50) NOT NULL,
    municipio VARCHAR(50) NOT NULL
);

CREATE TABLE destino_internacional (
    id SERIAL PRIMARY KEY,
    pais VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    codigo_postal VARCHAR(20) NOT NULL
);

CREATE TABLE envio (
    id SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    peso_kg DECIMAL(8,2),
    estado VARCHAR(20) DEFAULT 'pendiente' CHECK (
        estado IN ('pendiente', 'transito', 'entregado', 'cancelado')
    ),
    
    destino_nacional_id INT NULL,
    destino_internacional_id INT NULL,

    CONSTRAINT destino_nacional_fk FOREIGN KEY (destino_nacional_id)
        REFERENCES destino_nacional (id) ON DELETE RESTRICT,

    CONSTRAINT destino_internacional_fk FOREIGN KEY (destino_internacional_id)
        REFERENCES destino_internacional (id) ON DELETE RESTRICT,

    CONSTRAINT arco_exclusivo_envio CHECK (
        (destino_nacional_id IS NOT NULL AND destino_internacional_id IS NULL) OR
        (destino_nacional_id IS NULL AND destino_internacional_id IS NOT NULL)
    )
);

CREATE TABLE ruta (
    id SERIAL PRIMARY KEY,
    fecha_asignacion DATE NOT NULL,
    hora_salida TIME NOT NULL,
    conductor_id INTEGER NOT NULL,
    estado VARCHAR(20) DEFAULT 'programado' CHECK (
        estado IN ('programado', 'en_ruta', 'completado', 'cancelado')
    ),

    vehiculo_id INT NOT NULL,
    envio_id INT NOT NULL,

    CONSTRAINT vehiculo_id_fk FOREIGN KEY (vehiculo_id) 
        REFERENCES vehiculo(id) ON DELETE RESTRICT,

    CONSTRAINT envio_id_fk FOREIGN KEY (envio_id) 
        REFERENCES envio(id) ON DELETE RESTRICT
);

CREATE FUNCTION actualizar_ruta() RETURNS TRIGGER AS $$
BEGIN
    IF (OLD.envio_id IS DISTINCT FROM NEW.envio_id) THEN
        RAISE EXCEPTION 'Non Transferable FK constraint violated.';
    END IF;

    IF (OLD.vehiculo_id IS DISTINCT FROM NEW.vehiculo_id) THEN
        RAISE EXCEPTION 'Non Transferable FK constraint violated.';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_actualizar_ruta
BEFORE UPDATE OF envio_id, vehiculo_id ON ruta
FOR EACH ROW
EXECUTE FUNCTION actualizar_ruta();

CREATE INDEX idx_ruta_vehiculo ON ruta(vehiculo_id);
CREATE INDEX idx_ruta_envio ON ruta(envio_id);
CREATE INDEX idx_envio_destino_nacional ON envio(destino_nacional_id);
CREATE INDEX idx_envio_destino_internacional ON envio(destino_internacional_id);