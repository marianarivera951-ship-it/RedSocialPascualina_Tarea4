CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo_institucional VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE perfiles (
    id_perfil SERIAL PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL,
    carrera VARCHAR(100) NOT NULL,
    intereses TEXT,
    habilidades TEXT,
    CONSTRAINT fk_perfil_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE publicaciones (
    id_publicacion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    analitica_interacciones JSONB,
    CONSTRAINT fk_publicacion_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE eventos (
    id_evento SERIAL PRIMARY KEY,
    id_creador INT NOT NULL,
    nombre_evento VARCHAR(150) NOT NULL,
    descripcion TEXT,
    fecha_evento TIMESTAMP NOT NULL,
    telemetria_iot JSONB,
    CONSTRAINT fk_evento_creador FOREIGN KEY (id_creador) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE grupos (
    id_grupo SERIAL PRIMARY KEY,
    nombre_grupo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE miembros_grupo (
    id_grupo INT NOT NULL,
    id_usuario INT NOT NULL,
    rol VARCHAR(50) DEFAULT 'Miembro',
    PRIMARY KEY (id_grupo, id_usuario),
    CONSTRAINT fk_miembro_grupo FOREIGN KEY (id_grupo) REFERENCES grupos(id_grupo) ON DELETE CASCADE,
    CONSTRAINT fk_miembro_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);
