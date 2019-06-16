-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-06-2019 a las 20:12:55
-- Versión del servidor: 10.1.38-MariaDB
-- Versión de PHP: 7.1.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `new tekonn`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `avisos`
--

CREATE TABLE `avisos` (
  `id_aviso` int(11) NOT NULL,
  `nombre_aviso` varchar(50) NOT NULL,
  `descripcion_aviso` varchar(500) NOT NULL,
  `fecha_aviso` datetime NOT NULL,
  `codigo_usuario` int(11) NOT NULL,
  `codigo_tipo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `avisos`
--

INSERT INTO `avisos` (`id_aviso`, `nombre_aviso`, `descripcion_aviso`, `fecha_aviso`, `codigo_usuario`, `codigo_tipo`) VALUES
(1, 'Creación de capataces', 'Se han creado 4 capataces para iniciar el sistema tekonn', '2019-06-08 00:10:33', 2, 1),
(2, 'Creación de operaciones ', 'Se han creado tres operaciones en modo de prueba', '2019-06-11 01:27:28', 7, 3),
(3, 'Equipo número 1 - operación 4', 'Se rechaza la operación 4 debido a que miembros del equipo no poseen conocimientos y/o charlas referentes a riesgos.', '2019-06-12 22:25:32', 7, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargos`
--

CREATE TABLE `cargos` (
  `id_cargo` int(11) NOT NULL,
  `nombre_cargo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `cargos`
--

INSERT INTO `cargos` (`id_cargo`, `nombre_cargo`) VALUES
(1, 'Geólogo'),
(2, 'Ingeniero Civil Geólogo'),
(3, 'Ingeniero Civil en Metalurgia'),
(4, 'Ingeniero Civil de Minas'),
(5, 'Ingeniero Civil Industrial'),
(6, 'Ingeniero Ejec. Metalúrgico'),
(7, 'Ingeniero Ejec. en Minas'),
(8, 'Ingeniero Civil Químico'),
(9, 'Técnico Nivel Sup. Minero Metalúrgico'),
(10, 'Técnico Nivel Sup. en Minas'),
(11, 'Técnico Nivel Sup. en Procesamiento de Minerales'),
(12, 'Técnico Nivel Sup. en Geominería'),
(13, 'Técnico Nivel Sup. en Minería y Operaciones de Planta'),
(14, 'Ingeniero Civil Electricista'),
(15, 'Ingeniero Civil Electrónico'),
(16, 'Ingeniero Civil en Automatización'),
(17, 'Ingeniero Civil Mecánico'),
(18, 'Técnico en Mecánica Industrial, mantención y similares'),
(19, 'Técnico en Mecánica Automotriz'),
(20, 'Técnico en Electricidad, Electrónica y similares'),
(21, 'Técnico Nivel Sup. en Topografía'),
(22, 'Técnico Nivel Sup. en Proyectos y Diseño Mecánico'),
(23, 'Técnico Nivel Sup. en Mantención de Equipos Industriales'),
(24, 'Técnico Nivel Sup. Mecánico Mantenedor de Maquinaria Pesada'),
(25, 'Técnico Nivel Sup. en Mantenimiento Electromecánico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `columnas`
--

CREATE TABLE `columnas` (
  `id_rmsColumna` int(11) NOT NULL,
  `descripcion_rmsColumna` varchar(250) NOT NULL,
  `codigo_rms` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `columnas`
--

INSERT INTO `columnas` (`id_rmsColumna`, `descripcion_rmsColumna`, `codigo_rms`) VALUES
(1, 'Realizar programa de manteciones de vehículos', 1),
(2, 'Revisar el cumplimiento de programa de control de fatiga y somnolencia', 1),
(3, 'Elementos de protección para volcamiento de vehículo', 1),
(4, 'Dispositivo de advertencia de proximidad, control de desviación de calzada y GPS', 1),
(5, 'Inspección y mantenimiento de carretera', 1),
(6, 'Control de tráfico', 1),
(7, 'Incorporar tecnología para regadío de caminos', 1),
(8, 'Guardas y protecciones', 2),
(9, 'Traba/bloqueo mecánico', 2),
(10, 'Ejecutar aislamiento e instalación de bloqueo', 2),
(11, 'Realizar prueba de energía cero', 2),
(12, 'Lista de chequeo - Inicio de sondaje', 2),
(13, 'Plataformas y superficies de trabajo temporales según estándar', 3),
(14, 'Uso y existencia de puntos de anclaje según estándar', 3),
(15, 'Plataformas móvile sde trabajo según estándar', 3),
(16, 'Plataformas fijas de trabajo con borde abierto según estándar', 3),
(17, 'Uso de arnés de seguridad y accesorios', 3),
(18, 'Segregar áreas cuando exista potencial de caída o borde abierto', 3),
(19, 'Sistema de control de somnolencia', 4),
(20, 'Sistema de frenos y dirección en equipos móviles', 4),
(21, 'Sistema de frenos, dirección y neumáticos en vehículos', 4),
(22, 'Sistema de comunicación radial', 4),
(23, 'Realizar detención total de equipo carguío pala', 4),
(24, 'Segregar áreas expuestas', 4),
(25, 'Pretiles centrales', 4),
(26, 'Ejecución de diseño por operaciones', 5),
(27, 'Validar diseño geotécnico del pit', 5),
(28, 'Sistema de inspección, instrumentación y monitoreo del terreno', 5),
(29, 'Mantener diseño de botadores y stock validados y auditados', 6),
(30, 'Control de plan de llenado y altura de botadores', 6),
(31, 'Construcción de la pila de acuerdo a diseño', 7),
(32, 'Inspeccionar y monitorear pila', 7),
(33, 'Ejecutar aislamiento e instalación de bloqueo', 8),
(34, 'Realizar prueba de energía cero', 8),
(35, 'Protecciones eléctricas', 8),
(36, 'Utilizar equipo de protección personal dieléctrico e ignífugo', 8),
(37, 'Uso de herramientas y equipos de maniobras aislados eléctricamente', 8),
(38, 'Acceso controlado/restringido a instalación eléctrica', 8),
(39, 'Dejar distancia segura a líneas eléctricas (servidumbre)', 8),
(40, 'Diseñar excavaciones y zanjas de acuerdo a norma 349', 9),
(41, 'Ejecutar cumplimiento del diseño de excavación y acopio de material en stock pile', 9),
(42, 'Ejecutar recomendación sobre la evaluación geotécnica en pilas/botaderos sobre relaves', 9),
(43, 'Realizar el protocolo de entrega diaria', 9),
(44, 'Ejecución de diseño de operaciones', 9),
(45, 'Segregación de áreas mediante barreras duras', 9),
(46, 'Verificar especificaciones técnicas', 9),
(47, 'Monitorear condiciones de estructuras', 10),
(48, 'Ingeniería y reparación/mantención de estructuras', 10),
(49, 'Realizar prácticas de almacenamiento de acuerdo a estandar', 10),
(50, 'Acceso controlado/restringido a área con material combustible o explosivo', 11),
(51, 'Sistema de protección y control de incendio', 11),
(52, 'Control de trabajo en caliente', 11),
(53, 'Sistema de aterrizaje de líneas SX', 11),
(54, 'Programa de inspección y mantención SX, equipos críticos', 11),
(55, 'Monitorear condiciones estructurales de tuberías, estanques y espesadores', 12),
(56, 'Sistema de alarma de nivel de rebalse', 12),
(57, 'Revisar plan de izaje, previo a cada maniobra de levante', 13),
(58, 'Sistema anti-volcamiento', 13),
(59, 'Segregar áreas para maniobras de izaje', 13),
(60, 'Inspección de pre uso y mantención de elementos y equipos de izaje', 13),
(61, 'Sistema de seguridad limitador de carrera (limit switch)', 13),
(62, 'Certificar equipos y accesorios de levante, rigger y operadores', 13),
(63, 'Sistema de frenos y dirección en equipos móviles', 14),
(64, 'Sistema de frenos, dirección y neumáticos en vehículos', 14),
(65, 'Sistema control de somnolencia', 14),
(66, 'Pretiles de contención para botaderos y rampas', 14),
(67, 'Control del plan de llenado y altura de botaderos', 14),
(68, 'Usar GPS y equipos de comunicación operativos', 16),
(69, 'Revisar lista de chequeo de vehículos en zonas remotas', 16),
(70, 'Señalizar y desmarcar áreas para el control de tránsito', 15),
(71, 'Segregar áreas', 15),
(72, 'Sistema de comunicación radial', 15),
(73, 'Sistema de freno y dirección en equipos móviles', 15),
(75, 'Sistema de freno, dirección y neumáticos en vehículos', 15),
(76, 'Ejectuar aislamiento y bloqueo de equipos móviles o vehículos', 15),
(77, 'Realizar segregación hombre/máquina', 15),
(78, 'Segregar áreas expuestas/maniobras', 17),
(79, 'Revisar orden y limpieza del área de trabajo', 17),
(80, 'Contar con línea hazard (virtual) en pantalla de equipo de carguío o marcación topográfica', 17),
(81, 'Lista de chequeo - inicio de sondaje', 17),
(82, 'Inspección de pre uso y mantención de elementos y equipos e izaje', 17),
(83, 'Utilizar equipo de protección personal específico', 18),
(84, 'Inspeccionar estructuras de sistema de descarga, almacenamiento, distribución, trasvasije y transporte', 18),
(85, 'Control de acceso a áreas de almacenamiento y manipulación', 18),
(86, 'Disponer de sensores y alarmas de gas sulfhídrico', 18),
(87, 'Ejecutar aislamiento y bloqueo de línea ácido sulfúrico según estándar', 18),
(88, 'Utilizar protección de uniones, válvulas del sistema de bombeo y transporte ante proyecciones de ácido sulfúrico', 18),
(89, 'Observar la tensión de las espías', 19),
(90, 'Maniobras espías en los dolphins', 19),
(91, 'Supervisar los amarres en el cabezal del muelle', 19),
(92, 'Revisar estado y condiciones de las espías a utilizar en maniobras', 19),
(93, 'Almacenamiento, manipulación y transporte de explosivos de acuerdo a estándar', 20),
(94, 'Realizar el cierre, despeje', 20),
(95, 'Control de acceso al área de tronadura', 20),
(96, 'Revisar tiempos iguales para carguíos de pozo menor o igual a 2,5 m de saparación', 20),
(97, 'Ejecutar detección y eliminación de tiros quedados (TQ)', 20),
(98, 'Medición de gases tóxicos y atmósferas en espacios confinados', 21),
(99, 'Ejecutar aislamiento y bloqueo de flujos para espacios confinados', 21),
(100, 'Controlar el carguío de explosivos en pozos de tronadura', 21),
(101, 'Utilizar herramientas eléctricas de bajo voltaje (24V) a con relé de fuga a tierra operativo de 220V con aprobación de supervisor eléctrico', 21),
(102, 'Revisar certificado vigente de registro de calibración', 21),
(103, 'Controlar acceso de personas con marcapasos a EW', 22),
(104, 'Barreras en accesos a zona tránsito del tren', 23),
(105, 'Ejecutar procedimiento de ingreso y salida de los patios de cátodos', 23),
(106, 'Contar con puerta para cuando el tren maniobra en Patios 7 y 8 de la nave EW-2', 23),
(107, 'Asegurar competencia demostrada de buzo profesiona, acorde a su función', 24),
(108, 'Emplear tablas de descompresión actualizadas y reglamentarias', 24),
(109, 'Realizar evaluación paramédica a los buzos antes y posterior al buceo', 24),
(110, 'Limitar sobre la exigencia de la legislación en la profundidad máxima para buceo con aire y empleo de gas mezclado para profundidades mayores', 24),
(111, 'Monitorear y realizar comunicación permanente entre estación de control de buceo y el buzo (comunicación, video). Respaldo permanecen 3 semanas', 24),
(112, 'Revisar la operatividad de equipos y cámara hiperbárica antes de cada buceo, revisión de la certificación de los equipos críticos', 24),
(113, 'Eejcutar aislamiento e instalación de bloqueo', 25),
(114, 'Realizar prueba de energía cero', 25),
(115, 'Sistema de aseguramiento y mecanismos de acople para alta presión', 25),
(116, 'Válvulas de alivio', 25),
(117, 'Disponer de protecciones y guardas de equipos y líneas de alta presión', 25),
(118, 'Realizar plan de mantenimiento y certificación para sistemas/equipos ductos/estanque para el transporte o almacenamiento con alta presión', 25),
(119, 'Revisar manipulación, cambio y chequeo de neumáticos equipos móviles (OTRACO)', 25),
(120, 'Segregar áreas más expuestas', 25),
(121, 'Verificar la tensión y monitoreo de correas transportadoras (chancado y correas)', 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenidos`
--

CREATE TABLE `contenidos` (
  `id_contenido` int(11) NOT NULL,
  `nombre_contenido` varchar(100) NOT NULL,
  `descripcion_contenido` varchar(300) NOT NULL,
  `ruta_contenido` varchar(300) NOT NULL,
  `tipo_contenido` varchar(50) NOT NULL,
  `codigo_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipos`
--

CREATE TABLE `equipos` (
  `id_equipo` int(11) NOT NULL,
  `nombre_equipo` varchar(50) NOT NULL,
  `descripcion_equipo` varchar(300) NOT NULL,
  `lider_equipo` varchar(100) NOT NULL,
  `email_lider` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `equipos`
--

INSERT INTO `equipos` (`id_equipo`, `nombre_equipo`, `descripcion_equipo`, `lider_equipo`, `email_lider`) VALUES
(1, 'DEFECTO', 'DEFECTO', 'ADMIN', 'ADMIN@ADMIN.CL'),
(2, 'Equipo Terreno Sur', 'Equipo especializado para la limpieza de terreno en la zona sur de la minera', 'Miryam Alexandra Fuentes Fuentes', 'fuentesma@hotmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rms`
--

CREATE TABLE `rms` (
  `id_riesgo` int(11) NOT NULL,
  `nombre_riesgo` varchar(50) NOT NULL,
  `numero_riesgo` int(11) NOT NULL,
  `rutaImagen_riesgo` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `rms`
--

INSERT INTO `rms` (`id_riesgo`, `nombre_riesgo`, `numero_riesgo`, `rutaImagen_riesgo`) VALUES
(1, 'ACCIDENTE EN RUTA', 1, 'media/imagenes/riesgos/riesgoCritAccidenteRutaNew.png'),
(2, 'ATRAPAMIENTO', 2, 'media/imagenes/riesgos/riesgoCritAtrapamientoNew.png'),
(3, 'CAÍDA DE DISTINTO NIVEL', 3, 'media/imagenes/riesgos/riesgoCritCaidaDesnivelNew.png'),
(4, 'CHOQUE/COLISIÓN EN MINA/PILA', 4, 'media/imagenes/riesgos/riesgoCritChoqueMinaNew.png'),
(5, 'DERRUMBE DE PARED', 5, 'media/imagenes/riesgos/riesgoCritDerrumbeParedNew.png'),
(6, 'COLAPSO DE BOTADERO', 6, 'media/imagenes/riesgos/riesgoCritColpasoBotaderoNew.png'),
(7, 'COLAPSO DE TALUD DE PILA', 7, 'media/imagenes/riesgos/riesgoCritColpasoTaludNew.png'),
(8, 'CONTACTO CON ENERGÍA ELÉCTRICA/ARCO ELÉCTRICO', 8, 'media/imagenes/riesgos/riesgoCritContactoArcoElectricoNew.png'),
(9, 'FALLA DE TERRENO', 9, 'media/imagenes/riesgos/riesgoCritFallaTerrenoNew.png'),
(10, 'FALLA/COLAPSO ESTRUCTURAL', 10, 'media/imagenes/riesgos/riesgoCritFallaEstructuralNew.png'),
(11, 'INCENDIO', 11, 'media/imagenes/riesgos/riesgoCritIncendioNew.png'),
(12, 'PÉRDIDA DE GRAN VOLUMEN', 12, 'media/imagenes/riesgos/riesgoCritPerdidaVolumenNew.png'),
(13, 'MANIOBRAS DE IZAJE', 13, 'media/imagenes/riesgos/riesgoCritManiobrasNew.png'),
(14, 'VOLCAMIENTO/CAÍDA DE EQUIPO/VEHÍCULO', 14, 'media/imagenes/riesgos/riesgosCritVolcamientoEquipoNew.png'),
(15, 'IMPACTO EQUIPO/VEHÍCULO PERSONA', 15, 'media/imagenes/riesgos/riesgosCritImpactoPersonaNew.png'),
(16, 'EXTRAVÍO EN ZONAS AISLADAS', 16, 'media/imagenes/riesgos/riesgosCritExtravioZonasNew.png'),
(17, 'CAÍDA DE OBJETOS', 17, 'media/imagenes/riesgos/riesgosCritCaidaObjetosNew.png'),
(18, 'INHALACIÓN/CONTACTO DE SUSTANCIAS PELIGROSAS', 18, 'media/imagenes/riesgos/riesgosCritInhalacionSustanciasNew.png'),
(19, 'CORTE DE ESPÍAS', 19, 'media/imagenes/riesgos/riesgosCritCorteEspiasNew.png'),
(20, 'DETONACIÓN EN TRONADURA', 20, 'media/imagenes/riesgos/riesgosCritDetonacionTronaduraNew.png'),
(21, 'ESPACIOS CONFINADOS/ATMÓSFERA CONTAMINADA', 21, 'media/imagenes/riesgos/riesgosCritEspaciosConfinadosNew.png'),
(22, 'EXPOSICIÓN A CAMPO MAGNÉTICO', 22, 'media/imagenes/riesgos/riesgosCritExposicionCampoNew.png'),
(23, 'IMPACTO PERSONA TREN', 23, 'media/imagenes/riesgos/riesgosCritImpactoTrenNew.png'),
(24, 'LABORES DE BUCEO', 24, 'media/imagenes/riesgos/riesgosCritLaboresBuceoNew.png'),
(25, 'LIBERACIÓN DESCONTROLADA DE ENERGÍA', 25, 'media/imagenes/riesgos/riesgosCritLiberacionEnergiaNew.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre_rol`) VALUES
(1, 'GENERAL'),
(2, 'ADMINISTRADOR'),
(3, 'SUPERVISOR'),
(4, 'CAPATAZ'),
(5, 'TRABAJADOR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos`
--

CREATE TABLE `tipos` (
  `id_tipoAv` int(11) NOT NULL,
  `nombre_tipoAv` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipos`
--

INSERT INTO `tipos` (`id_tipoAv`, `nombre_tipoAv`) VALUES
(1, 'INFORMATIVO'),
(2, 'ALERTA'),
(3, 'TRABAJO'),
(4, 'EDICIÓN'),
(5, 'OTROS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `activado_usuario` tinyint(1) NOT NULL,
  `nombre_usuario` varchar(100) NOT NULL,
  `rut_usuario` varchar(14) NOT NULL,
  `sexo_usuario` char(2) NOT NULL,
  `email_usuario` varchar(100) NOT NULL,
  `fono_usuario` varchar(13) DEFAULT NULL,
  `celular_usuario` varchar(16) NOT NULL,
  `direccion_usuario` varchar(100) NOT NULL,
  `ciudad_usuario` varchar(50) NOT NULL,
  `region_usuario` varchar(50) NOT NULL,
  `comuna_usuario` varchar(50) NOT NULL,
  `empresa_usuario` varchar(50) NOT NULL,
  `nick_usuario` varchar(50) NOT NULL,
  `pass_usuario` varchar(20) NOT NULL,
  `codigoRecuperacion_usuario` char(10) DEFAULT NULL,
  `imagenPerfil` varchar(300) DEFAULT NULL,
  `codigo_cargo` int(11) NOT NULL,
  `codigo_rol` int(11) NOT NULL,
  `codigo_equipo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `activado_usuario`, `nombre_usuario`, `rut_usuario`, `sexo_usuario`, `email_usuario`, `fono_usuario`, `celular_usuario`, `direccion_usuario`, `ciudad_usuario`, `region_usuario`, `comuna_usuario`, `empresa_usuario`, `nick_usuario`, `pass_usuario`, `codigoRecuperacion_usuario`, `imagenPerfil`, `codigo_cargo`, `codigo_rol`, `codigo_equipo`) VALUES
(1, 1, 'ADMIN', 'ADMIN', 'M', 'ADMIN@ADMIN', 'ADMIN', 'ADMIN', 'ADMIN', 'ADMIN', 'ADMIN', 'ADMIN', 'TEKONN', 'ADMIN', 'ADMIN', 'ADMIN', 'media/imagenes/perfilFotos/fotodefectohombreperfil.png', 11, 1, 1),
(2, 1, 'Cristopher Andrés Pérez Vargas', '18.973.714-9', 'M', 'vargass.cristopher@gmail.com', '00 000000', '+(569) 78829337', 'Villa El Remanso, psj. Mariano LaTorre #1487', 'Los Andes', 'Valparaíso', 'Los Andes', 'Tekkon Ltda.', 'vargas.cristopherpe', 'ever1995', NULL, 'media/imagenes/perfilFotos/fotovargasscristopher@gmailcomperfil.png', 10, 2, 1),
(3, 1, 'Luis Armando Díaz Cotapo', '12.312.445-3', 'M', 'copatodiaz@hotmail.com', '02 123123', '+(569) 12347755', 'Villa Los Aromos s/n', 'San Felipe', 'Valparaíso', 'San Felipe', 'Tekkon Ltda.', 'cotapo.luisdi', '123456asdfg', NULL, 'media/imagenes/perfilFotos/fotodefectohombreperfil.png', 19, 3, 1),
(4, 1, 'Kevin Hernán Labarca Muñoz', '19.123.665-4', 'M', 'labarcamunios@hotmail.com', '00 000000', '+(569) 77228833', 'Pasaje Hernán de la Fuente #21', 'Los Andes', 'Valparaíso', 'Valparaíso', 'Tekkon Ltda.', 'munoz.kevinla', 'ever1995', NULL, 'media/imagenes/perfilFotos/fotodefectohombreperfil.png', 9, 4, 1),
(5, 1, 'Francisca Alejandra Díaz Hernandez', '19.234.663-3', 'F', 'francis43@hotmail.com', '00 000000', '+(569) 11231122', 'Avenida Pajaritas con Robles #11', 'Osorno', 'Los Lagos', 'Osorno', 'Otra', 'hernandez.franciscadi', '123456asdfg', NULL, 'media/imagenes/perfilFotos/fotodefectomujerperfil.png', 3, 4, 1),
(6, 1, 'Maria Isabel Alcántara Cifuentes', '19.023.212-1', 'F', 'cifuentes_11@gmail.com', '02 117754', '+(569) 11277433', 'El Conde Alto, psj. Marible Díaz  #112', 'Coyhaique', 'Aysén', 'Coyhaique', 'Otra', 'cifuentes.mariaal', '123456asdfg', NULL, 'media/imagenes/perfilFotos/fotodefectomujerperfil.png', 24, 4, 1),
(7, 1, 'Miryam Alexandra Fuentes Fuentes', '15.234.123-1', 'F', 'fuentesma@hotmail.com', '00 000000', '+(569) 22567854', 'Los Kilos s/n', 'Los Andes', 'Valparaíso', 'Valparaíso', 'Tekkon Ltda.', 'fuentes.miryamfu', 'ever1995', NULL, 'media/imagenes/perfilFotos/fotodefectomujerperfil.png', 25, 4, 2),
(8, 1, 'Maribel Rosa Díaz Carvallo', '14.288.123-4', 'F', 'rosa12_3@gmail.com', '00 000000', '+(569) 64922341', 'El Pueblo, psj. El Cónder #18', 'Romeral', 'Maule', 'Romeral', 'Otra', 'carvallo.maribeldi', '123456asdfg', NULL, 'media/imagenes/perfilFotos/fotodefectomujerperfil.png', 23, 5, 2),
(9, 1, 'Antonio José Fuenzalida Díaz', '22.123.254-6', 'M', 'toniojose1@gmail.com', '00 000000', '+(569) 32423432', 'Avenida La Plata, Edificio Cordillera #22', 'Porvenir', 'Magallanes', 'Porvenir', 'Otra', 'diaz.antoniofu', '123456asdfg', NULL, 'media/imagenes/perfilFotos/fotodefectohombreperfil.png', 2, 5, 2),
(10, 1, 'Valentina Andrea Hormazabal Sanchez', '16.231.215-6', 'F', 'arista@gmail.com', '00 000000', '+(569) 12853212', 'El Amanecer s/n', 'Tongoy', 'Coquimbo', 'Tongoy', 'Tekonn Ltda.', 'sanchez.valentinaho', '123456asdfg', '3223', 'media/imagenes/perfilFotos/fotodefectomujerperfil.png', 6, 5, 1),
(11, 1, 'Guillermo Andrés Pérez Labarca', '17.231.111-6', 'M', 'guillenbu@gmail.com', '00 000000', '+(569) 12571212', 'Juegos Florales #4611', 'Los Andes', 'Valparaíso', 'Los Andes', 'Tekonn Ltda.', 'labarca.guillermope', 'ever1995', '3223', 'media/imagenes/perfilFotos/fotodefectohombreperfil.png', 6, 5, 1),
(12, 1, 'José Luis Alcantara Alcantara', '18.271.111-6', 'M', 'visualcantarau@gmail.com', '00 000000', '+(569) 13331212', 'Juegos Florales #4622', 'Los Andes', 'Valparaíso', 'Los Andes', 'Tekonn Ltda.', 'alcantara.joseal', '123456asdfg', '3223', 'media/imagenes/perfilFotos/fotodefectohombreperfil.png', 12, 5, 1),
(13, 1, 'Alejandra Mariela Rodriguez Martines', '18.212.111-8', 'F', 'marible12@gmail.com', '02 125713', '+(569) 14491212', 'El Batallón, psj. Noranbuena #19', 'Santiago', 'Metropolitana de Santiago', 'Talagante', 'Tekonn Ltda.', 'martines.alejandraro', '123456asdfg', '3223', 'media/imagenes/perfilFotos/fotodefectomujerperfil.png', 12, 5, 1),
(14, 1, 'Valentina Alexandra Ruiz Tagle', '20.231.311-1', 'F', 'eltambor@gmail.com', '00 000000', '+(569) 12516177', 'Villa Los Acacios #12', 'Los Andes', 'Valparaíso', 'Los Andes', 'Tekonn Ltda.', 'tagle.valentinaru', '123456asdfg', '3223', 'media/imagenes/perfilFotos/fotodefectomujerperfil.png', 2, 5, 1),
(15, 1, 'Fabian Andrés Vargas Zapata', '20.536.111-8', 'M', 'fabian_zapata1@hotmail.com', '00 000000', '+(569) 44441212', 'Villa Minera Andina, San Lorenzo #43', 'Los Andes', 'Valparaíso', 'Los Andes', 'Tekonn Ltda.', 'zapata.fabianva', '123456asdfg', '3223', 'media/imagenes/perfilFotos/fotodefectohombreperfil.png', 17, 5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vccpdetallescolumnas`
--

CREATE TABLE `vccpdetallescolumnas` (
  `id_detalleColumna` int(11) NOT NULL,
  `valoracion` int(11) NOT NULL,
  `codigo_operacion` int(11) NOT NULL,
  `codigo_columna` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `vccpdetallescolumnas`
--

INSERT INTO `vccpdetallescolumnas` (`id_detalleColumna`, `valoracion`, `codigo_operacion`, `codigo_columna`) VALUES
(1, 3, 1, 13),
(2, 3, 1, 14),
(3, 3, 1, 15),
(4, 3, 1, 16),
(5, 3, 1, 17),
(6, 3, 1, 18),
(7, 3, 1, 57),
(8, 3, 1, 58),
(9, 3, 1, 59),
(10, 3, 1, 60),
(11, 3, 1, 61),
(12, 3, 1, 62),
(13, 3, 2, 50),
(14, 3, 2, 51),
(15, 3, 2, 52),
(16, 3, 2, 53),
(17, 3, 2, 54),
(23, 2, 3, 103),
(24, 3, 3, 26),
(25, 3, 3, 27),
(26, 3, 3, 28),
(27, 3, 4, 89),
(28, 3, 4, 90),
(29, 2, 4, 91),
(30, 3, 4, 92),
(31, 1, 4, 8),
(32, 1, 4, 9),
(33, 1, 4, 10),
(34, 1, 4, 11),
(35, 1, 4, 12),
(36, 3, 4, 31),
(37, 1, 4, 32);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vccpformularios`
--

CREATE TABLE `vccpformularios` (
  `id_operacion` int(11) NOT NULL,
  `estado_operacion` varchar(30) NOT NULL,
  `nombre_operacion` varchar(50) NOT NULL,
  `descripcion_operacion` varchar(300) NOT NULL,
  `fechainicio_operacion` datetime DEFAULT NULL,
  `fechatermino_operacion` datetime DEFAULT NULL,
  `codigo_usuario` int(11) NOT NULL,
  `codigo_zonadeoperacion` int(11) NOT NULL,
  `observaciones_operacion` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `vccpformularios`
--

INSERT INTO `vccpformularios` (`id_operacion`, `estado_operacion`, `nombre_operacion`, `descripcion_operacion`, `fechainicio_operacion`, `fechatermino_operacion`, `codigo_usuario`, `codigo_zonadeoperacion`, `observaciones_operacion`) VALUES
(1, 'EN MARCHA', 'Instalación antena receptora', 'Se procede a la instalación de una antena receptora de señal en la entrada oeste de la minera.', '2019-06-10 00:41:41', '2019-06-10 00:41:41', 7, 18, 'Se procede a comenzar la operación sin demora'),
(2, 'FINALIZADA', 'Informe final', 'Se crea un informe a modo de prueba', '2019-06-11 00:16:48', '2019-06-11 00:16:48', 7, 14, 'Finalizamos operación sin problema alguno'),
(3, 'FINALIZADA', 'Entable de nueva comisión', 'Se analiza la posibilidad de crear una nueva comisión encargada de verificar el correcto funcionamiento del caudal.', '2019-06-11 01:10:16', '2019-06-11 01:10:16', 7, 12, 'Se posterga la comisión hasta nuevo aviso'),
(4, 'RECHAZADA', 'Prueba 1', 'Se realiza prueba en zona de estallido nº4', '2019-06-12 22:18:05', '2019-06-12 22:18:05', 7, 20, 'Se rechaza porque no se tienen conocimeintos '),
(5, 'PENDIENTE', 'Aplicar cimientos nuevos', 'Verificar que los cimientos no están aptos para seguir siendo usados', '2019-06-12 22:41:01', '2019-06-12 22:41:01', 7, 14, 'A la espera de edición');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zonasdeoperaciones`
--

CREATE TABLE `zonasdeoperaciones` (
  `id_zona` int(11) NOT NULL,
  `nombre_zona` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `zonasdeoperaciones`
--

INSERT INTO `zonasdeoperaciones` (`id_zona`, `nombre_zona`) VALUES
(1, 'Interior zona norte'),
(2, 'Interior zona sur'),
(3, 'Interior zona este'),
(4, 'Interior zona oeste'),
(5, 'Exterior zona norte '),
(6, 'Exterior zona sur '),
(7, 'Exterior zona este'),
(8, 'Exterior zona oeste '),
(9, 'Túnel norte 1'),
(10, 'Túnel norte 2'),
(11, 'Túnel norte 3'),
(12, 'Zona aislada sur 1'),
(13, 'Zona aislada sur 2'),
(14, 'Camino norte 1'),
(15, 'Camino norte 2'),
(16, 'Camino sur 1'),
(17, 'Camino sur 1'),
(18, 'Entrada oeste 1'),
(19, 'Entrada oeste 2'),
(20, 'Salida este 1'),
(21, 'Salida este 2');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `avisos`
--
ALTER TABLE `avisos`
  ADD PRIMARY KEY (`id_aviso`);

--
-- Indices de la tabla `cargos`
--
ALTER TABLE `cargos`
  ADD PRIMARY KEY (`id_cargo`);

--
-- Indices de la tabla `columnas`
--
ALTER TABLE `columnas`
  ADD PRIMARY KEY (`id_rmsColumna`);

--
-- Indices de la tabla `contenidos`
--
ALTER TABLE `contenidos`
  ADD PRIMARY KEY (`id_contenido`);

--
-- Indices de la tabla `equipos`
--
ALTER TABLE `equipos`
  ADD PRIMARY KEY (`id_equipo`);

--
-- Indices de la tabla `rms`
--
ALTER TABLE `rms`
  ADD PRIMARY KEY (`id_riesgo`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `tipos`
--
ALTER TABLE `tipos`
  ADD PRIMARY KEY (`id_tipoAv`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indices de la tabla `vccpdetallescolumnas`
--
ALTER TABLE `vccpdetallescolumnas`
  ADD PRIMARY KEY (`id_detalleColumna`);

--
-- Indices de la tabla `vccpformularios`
--
ALTER TABLE `vccpformularios`
  ADD PRIMARY KEY (`id_operacion`);

--
-- Indices de la tabla `zonasdeoperaciones`
--
ALTER TABLE `zonasdeoperaciones`
  ADD PRIMARY KEY (`id_zona`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `avisos`
--
ALTER TABLE `avisos`
  MODIFY `id_aviso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cargos`
--
ALTER TABLE `cargos`
  MODIFY `id_cargo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `columnas`
--
ALTER TABLE `columnas`
  MODIFY `id_rmsColumna` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT de la tabla `contenidos`
--
ALTER TABLE `contenidos`
  MODIFY `id_contenido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `equipos`
--
ALTER TABLE `equipos`
  MODIFY `id_equipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `rms`
--
ALTER TABLE `rms`
  MODIFY `id_riesgo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tipos`
--
ALTER TABLE `tipos`
  MODIFY `id_tipoAv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `vccpdetallescolumnas`
--
ALTER TABLE `vccpdetallescolumnas`
  MODIFY `id_detalleColumna` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `vccpformularios`
--
ALTER TABLE `vccpformularios`
  MODIFY `id_operacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `zonasdeoperaciones`
--
ALTER TABLE `zonasdeoperaciones`
  MODIFY `id_zona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
