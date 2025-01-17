-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 14-12-2024 a las 17:30:49
-- Versión del servidor: 8.2.0
-- Versión de PHP: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `blog_app`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `email`, `created_date`) VALUES
(1, 'admin', '1234', 'admin@gmail.com', '2024-11-15 08:00:38');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_cat` varchar(100) NOT NULL,
  `description` text,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_cat` (`name_cat`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `name_cat`, `description`, `created_date`) VALUES
(1, 'Terror Contemporáneo', NULL, '2024-11-22 07:59:23'),
(2, 'Terror Gótico', NULL, '2024-11-22 07:59:23'),
(3, 'Reseñas', NULL, '2024-11-22 07:59:23'),
(4, 'Terror Lovecraftiano', NULL, '2024-11-26 09:51:54'),
(5, 'Ensayos', NULL, '2024-12-02 11:38:55'),
(6, 'Terror Psicológico', NULL, '2024-12-02 11:45:06'),
(7, 'Fantasía Oscura', NULL, '2024-12-14 10:30:50'),
(8, 'Folk Horror', NULL, '2024-12-14 10:31:49'),
(9, 'Body Horror', NULL, '2024-12-14 10:33:29'),
(10, 'Terror Sobrenatural', NULL, '2024-12-14 10:34:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `content` text NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `image_url` varchar(255) DEFAULT NULL,
  `excerpt` text,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `posts`
--

INSERT INTO `posts` (`id`, `category_id`, `title`, `content`, `created_date`, `update_date`, `image_url`, `excerpt`) VALUES
(1, 1, 'Expediente Ligotti. Parte I: La tercera pata del banco', 'Algunas de las personas que me frecuentan y unos pocos amigos con los que suelo intercambiar opiniones sobre literatura me han pedido que les explique cabalmente mi fanatismo por Thomas Ligotti. Digo «unos pocos» porque, en realidad, son en verdad muy escasos los que siquiera registran este nombre. Y a estos, lo hayan leído o no, les despierta curiosidad la enorme admiración que he llegado sentir por su literatura. Pero el caso de Ligotti es muy especial; se trata de un autor «incómodo», incluso «antipático». No es un escritor que despierte el fetichismo del lector o sobre el que se pueda debatir abiertamente y con las herramientas tradicionales de la crítica. Por eso pensé que tal vez era hora de expresar por escrito lo que opino sobre su literatura, y qué mejor espacio que este blog, donde siento que puedo comunicarme contigo a mis anchas. En todo caso, es tanto lo que tengo para decirte que voy a estructurar este monográfico por partes. Hoy, vamos con la primera.\r\n    Suele decirse que toda estructura o sistema necesita, como un banco, de al menos tres recias patas que lo sostengan. Quizá todo medio artístico tenga su trinomio indiscutible —en música clásica se habla de Bach-Mozart-Beethoven, por ejemplo—. Como explorador y estudioso del género de terror he llegado a la conclusión de que el horror literario ha encontrado su Santísima Trinidad: Poe-Lovecraft-Ligotti. En el reparto de papeles la cosa quedaría así: Padre (Poe), Hijo (Ligotti), y Espíritu Santo (Lovecraft).\r\n    Antes de que me taches de exagerado o de hereje, paso a explicar los motivos de esta consideración, que son varios.\r\n    En primer lugar, Ligotti ha entendido mejor que nadie que el soporte verdaderamente genuino —y el más eficaz— para la materia terrorífica es el relato, y no la novela. El motivo literario, ese hilo conductor temático que forma el esqueleto de toda obra escrita, necesita en el ámbito del terror permanecer tenso todo el tiempo, sostener al lector en una atmósfera de silencioso pavor y no permitirle una distensión que lo refugie en los confortables huecos de la realidad. El relato, en su propia naturaleza como formato literario, no permite esta distensión. Un relato de terror es siempre de terror; una novela, en cambio, necesita de la combinación de la atmósfera horrorosa con un background de realidad convencional, incluso en escenarios totalmente ilusorios. Así, el efecto terrorífico se diluye de manera inevitable.\r\n    En segundo lugar, Thomas Ligotti se ha desprendido por completo de la tan cacareada «visualidad» en sus relatos, elemento que —siempre lo he dicho— constituye en mi opinión un lastre para la expresión literaria. Cuando Poe escribía sus relatos no existía el cine; cuando escribía Lovecraft sí, pero era tan grande el desprecio y la indiferencia que el genio de Providence sentía hacia este medio expresivo que, en cuestiones estéticas, es como si no hubiera existido; en una de las escasas entrevistas que le he visto dar, Ligotti se confiesa como un gran aficionado al cine de terror, pero lo importante es que no ha permitido que los códigos expresivos del cine invadan y perviertan su literatura. Sus relatos son puramente literarios y se desarrollan exclusivamente mediante las herramientas que el medio tiene a su alcance, mucho más poderosas e ilimitadas que las del cine —otro tema sobre el que he discutido hasta la saciedad, pero no voy a abrir el debate aquí—. Ligotti es el único de los escritores contemporáneos de terror que ha entendido la importancia del lenguaje literario en la comunicación de su mensaje. Autores como Barker, Campbell, Koontz o King han caído inevitablemente en la «visualidad» —especialmente los dos últimos—, y han otorgado a sus narraciones ese aire de película que vuelve a sus escritos más asequibles a los ojos del lector moderno, obnubilado por el bombardeo de imágenes. No tengo duda de que esto obedece en muchos casos a motivos comerciales: los libros escritos bajo los códigos visuales se venden mucho mejor. A Ligotti se nota que los motivos comerciales le importan bien poco y por eso escribe relatos, menos vendibles que las novelas; y relatos totalmente literarios, mucho menos vendibles que los «visuales».\r\n    Tercer punto: la literatura de Thomas Ligotti tiene un trasfondo tan vasto e inabarcable como la de Lovecraft. Obedece a una propia cosmogonía, a un universo creado al margen del papel, pero sumamente coherente, y que basa su discurso en un aspecto del horror que nunca hasta ahora había sido tratado: el concepto de lo grotesco. Poe inventó el horror macabro; Lovecraft dio vida al horror cósmico; Ligotti creó el horror grotesco. Sus relatos están poblados de marionetas, payasos y mascaradas, criaturas híbridas que se han colado en la realidad desde los sueños, supuestos humanos bajo cuya epidermis subyace el embrión de una criatura desarticulada y ancestral; sus escenarios colindan con entornos de pesadilla y su discurso se eleva sobre la acostumbrada banalización del género para instalarse en una especie de terror filosófico donde prima el pensamiento, lo que la mente es capaz de evocar y recrear, la materia del subconsciente que nunca alcanza una forma concreta en la realidad pero que justamente se vuelve más horrorosa por esta cualidad difusa. Y por otras tantas: es una materia subjetiva, inconexa, pulsátil, siempre presente y exclusiva de cada lector, ya que los resortes que activan sus apariciones tienen su origen en sus propios miedos, una especie de punto sensible del subconsciente que el autor de Michigan ha sabido alcanzar como nadie.\r\n    No son solo tres puntos los que sostienen mi teoría de que Thomas Ligotti es la tercera pata del banco de la literatura de terror, sino unos cuantos más, pero no quiero extenderme demasiado hoy. Muy pronto me pasaré por aquí para seguir hablándote de este autor. Por supuesto que no es un autor fácil ni de consumo rápido. No es el escritor que te llevarías al aeropuerto, a la playa o al apartamento donde pasas las vacaciones. Es un autor en el que has de sumergirte en tu rincón de lectura favorito, con diccionarios y libros de consulta al lado, a ser posible con algún volumen de Schopenhauer cerca, con una lámpara que apunte directamente sobre las páginas del libro y sin ruidos o interrupciones que detengan la magia y la hipnosis de su literatura…\r\n    ¿Que cuáles son mis obras favoritas de Thomas Ligotti? Te lo cuento otro día, en la segunda parte de este monográfico. Ese día te prometo ahondar en su obra y desgranarte algunos de los relatos que más me han impactado.\r\n    Con lo de hoy, creo tenemos suficiente como para empezar…', '2024-11-22 07:59:23', '2024-11-26 08:35:52', 'https://leandropintoblog.wordpress.com/wp-content/uploads/2019/11/file_5ca96f2deb_original.jpg', 'Algunas de las personas que me frecuentan y unos pocos amigos con los que suelo intercambiar opiniones sobre literatura me han pedido que les explique cabalmente mi fanatismo por Thomas Ligotti. Digo «unos pocos» porque, en realidad, son en verdad...'),
(6, 3, 'Reseña de El Cuervo, de Edgar Allan Poe', '\"El Cuervo\" es uno de los poemas más emblemáticos de Edgar Allan Poe, publicado por primera vez en 1845. Con su atmósfera oscura y melancólica, Poe crea una obra maestra que explora temas como la desesperación, la pérdida y la obsesión. El poema narra la historia de un hombre que, en medio de la noche, es visitado por un misterioso cuervo que parece haber venido del más allá. El cuervo, al que el hombre pregunta repetidamente, responde siempre con la palabra \"Nunca más\", lo que intensifica la angustia y el tormento emocional del protagonista.\r\n\r\nA través de su impecable uso del ritmo y la métrica, Poe logra una musicalidad hipnótica que contribuye a la atmósfera sombría. Las imágenes vívidas y la repetición de la palabra \"Nevermore\" se convierten en un símbolo de la inevitabilidad del dolor y la pérdida. La figura del cuervo, tradicionalmente un símbolo de la muerte, se convierte aquí en un mensajero de la fatalidad, provocando en el lector una reflexión sobre la muerte y la desesperanza.\r\n\r\nEl poema se distingue por su capacidad para evocar una emoción profunda, mezclando la belleza del verso con el desasosiego de un alma atormentada. El tono de El Cuervo es sombrío, lleno de obsesión y de una tristeza que se va acumulando hasta el final, donde la desesperación total se alcanza cuando el protagonista ya no puede escapar de su dolor.\r\n\r\nEl Cuervo es un brillante ejemplo de la habilidad de Poe para combinar lo gótico con lo psicológico, creando una obra que no solo aterra, sino que también invita a una profunda reflexión sobre la naturaleza humana y la inevitabilidad de la muerte.', '2024-12-14 17:01:10', '2024-12-14 17:01:10', 'https://cdn.zendalibros.com/wp-content/uploads/2018/01/el-cuervo-poe-e1516083315209.jpg', '\"El Cuervo\" es uno de los poemas más emblemáticos de Edgar Allan Poe, publicado por primera vez en 1845. Con su atmósfera oscura y melancólica, Poe crea una obra maestra...'),
(7, 5, 'Expediente Ligotti. Parte II: Un sistema filosófico', '\"Retomo este monográfico sobre Thomas Ligotti no para hablar aún de su narrativa, ya que para entender los entresijos y las claves simbólicas que la componen pienso que es muy aconsejable empaparse antes de sus postulados filosóficos, todo un sistema de pensamiento que tiene como base el nihilismo y también el pesimismo de los filósofos alemanes del siglo XIX, y que Ligotti supo reivindicar y reinterpretar en uno de sus escritos más complejos y extraordinarios. Hablamos de su tratado filosófico publicado en 2010, una obra inclasificable y de ríspido mensaje a la que conocemos con el rimbombante título de La conspiración contra la especie humana. Sin duda se trata de uno de los puntos fuertes de la literatura de Thomas Ligotti, y lo que dota a su narrativa de una solidez y una consistencia de la que carecen las obras de casi todos los escritores de terror contemporáneos: el autor de Michigan establece el mensaje de su ficción sobre los cimientos de una corriente filosófica basada en silogismos y razonamientos que refuerzan el sentido grotesco, absurdo e insignificante de la vida humana, aspecto en el cual ya hiciera especial hincapié su gran maestro H. P. Lovecraft. La diferencia principal radica en que Lovecraft contrastó la insustancialidad humana con la vastedad y hostilidad del inmenso cosmos, mientras que Ligotti la ridiculiza al hacerla entrar en contacto con esferas caricaturescas de su propia esencia. De esta manera invalida la cualidad beatífica de la existencia y plantea el paso vital del ser humano como un obtuso y recalcitrante paréntesis en medio de la Nada, concepto este fundamental para comprender los postulados filosóficos del autor.\r\n\r\nLa conspiración contra la especie humana es un libro de múltiples lecturas. Por un lado, sirve como guía interpretativa de algunas de las obras fundacionales del género de terror; en sus páginas Ligotti elabora profundos análisis de piezas tan magistrales como «La caída de la casa Usher» (Edgar Allan Poe), Los misterios de Udolfo (Ann Radcliffe), «Los sauces» (Algernon Blackwood) o «La llamada de Cthulhu» (H. P. Lovecraft). Son fragmentos sumamente interesantes, y que nos sirven para conocer el perfil crítico y analítico de Ligotti y su manera de aplicarse a los resortes estéticos y discursivos fundamentales del género.\r\n\r\nPor otra parte, el libro ofrece un lúcido análisis de la obra de dos filósofos pesimistas: el noruego Peter Wessel Zapffe (1899-1990) y el alemán Arthur Schopenhauer (1788-1860), este último una de las obsesiones del gran Jorge Luis Borges, cuyo nombre en este análisis monográfico volverá a surgir, ya que representa una de las principales influencias literarias del autor. Ligotti desgrana a través de los postulados de estos filósofos lo que él denomina la «manipulación intelectual» que existe en nuestra sociedad respecto a la supuesta dádiva que representan la vida humana y el derecho a existir. Esgrime así una serie de axiomas pesimistas y antinatalistas y enumera las aportaciones a esta corriente de pensamiento de autores como Friedrich Nietzsche, Julius Bahnsen, Phillip Mainländer y otros. Todo este sistema filosófico, extrapolado a los conceptos estéticos del horror reinterpretados por Lovecraft, forma parte de la miscelánea conceptual que constituye el grueso de la obra de ficción de Thomas Ligotti. Finalmente, el libro ofrece una serie de reflexiones sobre la propia condición humana, con un buen puñado de frases de la cosecha de Ligotti que bien pueden convertirse en aforismos representativos de la evolución del pensamiento humano acerca de su propia naturaleza, una suerte de análisis introspectivo de la especie en pos de algo que, en las líneas maestras del libro, se da por sentado que es imposible alcanzar: el sentido mismo de la existencia.\r\n\r\nDesde luego que no es imprescindible empaparse de este sistema filosófico para disfrutar plenamente de la obra narrativa de Ligotti, pero me permito recomendar su lectura como una magnífica puerta de entrada al personalísimo universo del autor. La casi insondable profundidad intelectual de sus relatos adquiere notoria coherencia a la luz de estos postulados y se refleja en los silogismos de su sistema filosófico. La conspiración contra la especie humana ofrece la visión amarga y pesimista de un autor inexorable, de un creador que no otorga ningún tipo de concesión a los conceptos más manidos y manipulables de la metafísica. Por consiguiente, solo podemos esperar que la ficción resultante de semejante conjunto de teorías nos resulte igual de rigurosa, igual de inapelable, y forzosamente ligada a todo aquello que constituye nuestros temores más recónditos: no ya la muerte o el sufrimiento, sino el misterio mismo de la existencia, su cualidad de inasible e inexplicable, la absurda obligación de ser y estar.\r\n\r\nVolveré dentro de poco con más Thomas Ligotti, por supuesto. Ya va siendo hora de abrirnos paso a través de su ficción y de adentrarnos poco a poco en su narrativa.\r\n\r\nEspérame por aquí…', '2024-12-14 17:13:22', '2024-12-14 17:13:22', 'https://theobjective.com/wp-content/uploads/2023/02/Ligotti-Songs-Grimscribe-Cover-Detail-1-1.jpg', 'Retomo este monográfico sobre Thomas Ligotti no para hablar aún de su narrativa, ya que para entender los entresijos y las claves simbólicas que la componen pienso que es muy aconsejable empaparse antes de sus postulados filosóficos, todo un sistema de pensamiento que tiene como base el nihilismo...'),
(8, 4, 'El susurro en la oscuridad', 'Un relato sobre un hombre que escucha extraños susurros en su casa recién comprada. Desde el primer día en que se muda, algo extraño parece suceder cada noche. Los susurros comienzan como un murmullo bajo, casi imperceptible, pero pronto se convierten en voces claras y aterradoras que parecen provenir de las paredes. Con el tiempo, el hombre descubre que los susurros son las voces de antiguos habitantes de la casa que no pudieron descansar. Aterrorizado, intenta buscar una explicación lógica, pero lo que descubre sobre el pasado de la casa lo lleva a cuestionar su cordura...', '2024-12-14 17:24:02', '2024-12-14 17:24:02', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdMwi27N-mw-2adom5vDtrYNbOq-I5a905DA&s', 'Un relato inquietante sobre los secretos que se esconden en las paredes de una antigua casa. Desde el primer día en que se muda, algo extraño parece suceder cada noche.'),
(9, 1, 'La mansión de los ecos', 'En esta historia, una mansión abandonada oculta algo más allá de la muerte. El protagonista, un escritor en busca de inspiración, decide pasar una noche en la mansión. Sin embargo, lo que comienza como una simple exploración pronto se convierte en una lucha por su vida cuando empieza a escuchar ecos de voces del pasado. Cada habitación de la mansión parece contener fragmentos de la historia de los que alguna vez la habitaron. La mansión, como un ente vivo, parece querer contar su historia, pero a un precio...', '2024-12-14 17:24:02', '2024-12-14 17:24:02', 'https://i.ytimg.com/vi/y1V5Ddf2ZX0/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBo3nDS-86NF2SyMHQ6i3e0hcRr2A', 'Una reseña sobre cómo las mansiones embrujadas representan el miedo a lo desconocido en la literatura de terror. El protagonista, un escritor en busca de inspiración, decide pasar una noche en la mansión.'),
(10, 2, 'La sombra detrás del espejo', 'Relato corto sobre un niño que descubre que la sombra que lo sigue tiene vida propia. Desde que era pequeño, Daniel siempre había tenido miedo de su propio reflejo, pero nunca se imaginó que algo tan aterrador estaba acechando detrás de él. Una noche, al mirarse en el espejo, se da cuenta de que su reflejo no lo sigue; en cambio, comienza a moverse independientemente de sus movimientos. Daniel intenta ignorarlo, pero la sombra se vuelve cada vez más agresiva, hasta que, finalmente, la figura detrás del espejo comienza a invadir su realidad...', '2024-12-14 17:24:02', '2024-12-14 17:24:02', 'https://arquetypus.com/wp-content/uploads/2023/06/CURSOS-BLOG-PARA-NUEVO-SITIO-WEB-16.png', 'Un relato oscuro que explora el miedo infantil y lo sobrenatural. Desde que era pequeño, Daniel siempre había tenido miedo de su propio reflejo.'),
(11, 3, 'El terror de los sueños', 'Un ensayo que analiza los miedos que se manifiestan en nuestros sueños y cómo los escritores de terror los utilizan para crear atmósferas aterradoras. Los sueños, como un territorio en el que todo es posible, se convierten en un vehículo perfecto para explorar lo desconocido y lo macabro. A lo largo de la historia de la literatura de terror, autores como Edgar Allan Poe y H.P. Lovecraft han utilizado los sueños como un medio para desdibujar la línea entre lo real y lo imaginario, sumergiendo al lector en mundos de pesadilla que parecen demasiado reales. El ensayo explora estos temas y cómo la representación de los sueños ha evolucionado en el terror contemporáneo...', '2024-12-14 17:24:02', '2024-12-14 17:24:02', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRr3VOMc08rVV2uM-76I8a6IMh-oenZJQ9nTw&s', 'Estudio sobre cómo los escritores de terror exploran el miedo a lo desconocido a través de los sueños. Los sueños, como un territorio en el que todo es posible, se convierten en un vehículo perfecto para explorar lo desconocido y lo macabro.'),
(12, 1, 'El retorno de la bruja', 'En este relato, una antigua bruja regresa a un pueblo para vengarse de aquellos que la desterraron. Hace años, los habitantes del pueblo habían condenado a la bruja a morir en el bosque, acusada de hechicería. Sin embargo, en lugar de perecer, ella había hecho un pacto con fuerzas oscuras y había jurado regresar para vengarse. Ahora, con el pueblo en plena celebración, los moradores comienzan a desaparecer uno por uno. Los pocos sobrevivientes intentan encontrar una forma de detenerla antes de que todos caigan bajo su maldición...', '2024-12-14 17:24:02', '2024-12-14 17:24:02', 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg67XPWPBap3ViR4CA0X-lnFnn9mgnAwJLuQ-r1PiCQsvUi3VXLDLSXycmVOEz1vbNvPbBcjcPs2B726dACA4-xx94r0OlR8QFxXdOnENZLoyfIN81pBEle3tORGhg1yU8OknWz0KFBsu8/s640/hoya_brujas_lovecraft.jpg', 'Un relato lleno de venganza y magia oscura, donde el pasado nunca se olvida. Hace años, los habitantes del pueblo habían condenado a la bruja a morir en el bosque.'),
(13, 2, 'El horror en la narrativa visual', 'Reseña sobre cómo las películas de terror influyen en la literatura de terror moderna. En las últimas décadas, el cine ha jugado un papel crucial en la evolución de los relatos de terror. Películas clásicas como \"Nosferatu\" o \"El exorcista\" han dejado una huella profunda en cómo los escritores abordan el miedo y el suspenso. La capacidad del cine para crear atmósferas visuales e intensificar las emociones ha sido un recurso que los escritores de terror han adoptado, creando narrativas más dinámicas y visualmente evocadoras. Este artículo explora cómo la narrativa visual ha transformado la forma en que percibimos el terror en la literatura contemporánea...', '2024-12-14 17:24:02', '2024-12-14 17:24:02', 'https://hispacomic.com/wp-content/uploads/2023/12/La-sombra-sobre-Innsmouth-recorte-e1703766551274.jpg', 'Un análisis de cómo las imágenes en el cine complementan la narrativa escrita en los relatos de terror. En las últimas décadas, el cine ha jugado un papel crucial en la evolución de los relatos de terror.'),
(14, 1, 'Los ojos en la niebla', 'Un relato que sigue a un grupo de viajeros perdidos en la niebla, quienes comienzan a ver ojos extraños observándolos. Durante su travesía, la niebla se espesa y la visibilidad se reduce a nada. Uno a uno, los miembros del grupo comienzan a sentirse observados por unos ojos invisibles que parecen seguir sus movimientos. A medida que avanzan, la niebla toma forma, y los ojos comienzan a cobrar vida. El horror no solo viene de lo que ven, sino de lo que saben que acecha en la oscuridad...', '2024-12-14 17:24:02', '2024-12-14 17:24:02', 'https://img.freepik.com/fotos-premium/fantasmas-aterradores-espeluznantes-bosque-niebla-fantasmas-ojos-brillantes_865711-1.jpg', 'Un relato sobre el miedo a lo invisible y lo desconocido, donde los ojos lo ven todo... o quizás nada. Durante su travesía, la niebla se espesa y la visibilidad se reduce a nada.'),
(15, 3, 'La influencia de Poe en la literatura contemporánea', 'Ensayo sobre cómo Edgar Allan Poe sigue siendo una gran influencia para los escritores de terror de hoy. Poe, conocido por su maestría en la creación de atmósferas de terror psicológico, dejó una marca imborrable en el género. A través de relatos como \"El corazón delator\" y \"La caída de la casa Usher\", Poe introdujo temas como la paranoia, la locura y el horror psicológico, elementos que siguen siendo fundamentales en las obras de terror contemporáneas. Este ensayo examina cómo la influencia de Poe persiste, tanto en la narrativa escrita como en el cine de terror, y cómo sus ideas continúan dando forma al género...', '2024-12-14 17:24:02', '2024-12-14 17:24:02', 'https://ichef.bbci.co.uk/ace/ws/640/cpsprodpb/169ED/production/_124635629_gettyimages-517445968.jpg.webp', 'Exploración de cómo los temas de lo macabro y lo insano de Poe siguen presentes en la literatura actual. Poe, conocido por su maestría en la creación de atmósferas de terror psicológico, dejó una marca imborrable en el género.'),
(16, 1, 'La casa de los muertos olvidados', 'En este relato, un grupo de amigos encuentra una antigua casa donde los espíritus de los muertos parecen recordarles algo. En la oscuridad de la noche, los amigos llegan a la casa abandonada que han escuchado en leyendas locales. Pero pronto descubren que la casa no está vacía. Los espíritus de los que alguna vez vivieron allí no descansan y parecen tener un mensaje para los visitantes. A medida que el grupo explora, cada uno de ellos se enfrenta a sus propios miedos más profundos, mientras los muertos intentan comunicarse con ellos...', '2024-12-14 17:24:02', '2024-12-14 17:24:02', 'https://www.fabulantes.com/wp-content/uploads/2019/10/imagen_2_los_suenos_en_la_casa_de_la_bruja_fabulantes.jpg', 'Un cuento sobre lo que sucede cuando la historia no deja descansar a los muertos. En la oscuridad de la noche, los amigos llegan a la casa abandonada que han escuchado en leyendas locales.'),
(17, 2, 'Los mitos de Cthulhu y su legado', 'Reseña sobre el impacto de los mitos de Cthulhu en la literatura de terror moderna. Desde que H.P. Lovecraft introdujo el concepto de los \"antiguos\" y la entidad cósmica Cthulhu, la influencia de estos mitos ha sido profunda en el mundo del terror. Los conceptos de horror cósmico, lo incomprensible y lo ajeno al entendimiento humano han inspirado a generaciones de escritores y cineastas. Esta reseña explora cómo los mitos de Cthulhu han dejado una marca indeleble en la literatura y el cine de terror, así como su reinterpretación en tiempos modernos...', '2024-12-14 17:24:02', '2024-12-14 17:24:02', 'https://wallpapercave.com/wp/wp3008888.jpg', 'Análisis de la creación de Lovecraft y cómo su mundo sobrenatural ha influido en escritores actuales. Desde que H.P. Lovecraft introdujo el concepto de los \"antiguos\" y la entidad cósmica Cthulhu, la influencia de estos mitos ha sido profunda en el mundo del terror.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `post_tags`
--

DROP TABLE IF EXISTS `post_tags`;
CREATE TABLE IF NOT EXISTS `post_tags` (
  `post_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`post_id`,`tag_id`),
  KEY `tag_id` (`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tags`
--

DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
