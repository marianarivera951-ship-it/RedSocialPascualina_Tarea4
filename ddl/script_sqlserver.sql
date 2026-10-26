CREATE TABLE usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo_institucional VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro DATETIME DEFAULT GETDATE()
);

CREATE TABLE perfiles (
    id_perfil INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL,
    carrera VARCHAR(100) NOT NULL,
    intereses VARCHAR(MAX),
    habilidades VARCHAR(MAX),
    CONSTRAINT fk_perfil_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE publicaciones (
    id_publicacion INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    contenido VARCHAR(MAX) NOT NULL,
    fecha_publicacion DATETIME DEFAULT GETDATE(),
    analitica_interacciones NVARCHAR(MAX) CHECK (ISJSON(analitica_interacciones) = 1),
    CONSTRAINT fk_publicacion_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE eventos (
    id_evento INT IDENTITY(1,1) PRIMARY KEY,
    id_creador INT NOT NULL,
    nombre_evento VARCHAR(150) NOT NULL,
    descripcion VARCHAR(MAX),
    fecha_evento DATETIME NOT NULL,
    telemetria_iot NVARCHAR(MAX) CHECK (ISJSON(telemetria_iot) = 1),
    CONSTRAINT fk_evento_creador FOREIGN KEY (id_creador) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE grupos (
    id_grupo INT IDENTITY(1,1) PRIMARY KEY,
    nombre_grupo VARCHAR(100) NOT NULL,
    descripcion VARCHAR(MAX),
    fecha_creacion DATETIME DEFAULT GETDATE()
);

CREATE TABLE miembros_grupo (
    id_grupo INT NOT NULL,
    id_usuario INT NOT NULL,
    rol VARCHAR(50) DEFAULT 'Miembro',
    PRIMARY KEY (id_grupo, id_usuario),
    CONSTRAINT fk_miembro_grupo FOREIGN KEY (id_grupo) REFERENCES grupos(id_grupo) ON DELETE CASCADE,
    CONSTRAINT fk_miembro_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);
