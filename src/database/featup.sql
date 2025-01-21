DROP DATABASE IF EXISTS dbFeatUp;
CREATE DATABASE dbFeatUp;
USE dbFeatUp;

CREATE TABLE produtor (
	idProdutor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    alias VARCHAR(50) NOT NULL UNIQUE,
    senha VARCHAR(45) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(400) NOT NULL,
    pathFotoPerfil VARCHAR(200) DEFAULT './assets/profiles/default.png',
    pontoForte VARCHAR(12) NOT NULL,
    aplicativo VARCHAR(45) NOT NULL,
    codigoBackUp CHAR(5),
    lastLogin DATETIME DEFAULT now(),
    CONSTRAINT chkPontoForte CHECK(pontoForte IN ('Instrumental','Beat','Mix','Master'))
);

CREATE TABLE feat (
	idFeat INT PRIMARY KEY AUTO_INCREMENT,
    dtFeat DATETIME NOT NULL DEFAULT now(),
    statusFeat TINYINT NOT NULL DEFAULT 0,
    fkProdutorSolicita INT NOT NULL,
    fkProdutorAceita INT NOT NULL,
    CONSTRAINT chkStatusFeat CHECK(statusFeat IN (0, 1, 2)),
    CONSTRAINT fkProdutorSolicitaFeat FOREIGN KEY (fkProdutorSolicita) REFERENCES produtor(idProdutor),
    CONSTRAINT fkProdutorAceitaFeat FOREIGN KEY (fkProdutorAceita) REFERENCES produtor(idProdutor)
);

CREATE TABLE rede_social (
	idRede INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
    url VARCHAR(150),
    fontAwesomeTag VARCHAR(45)
);

CREATE TABLE rede_produtor (
	fkProdutor INT NOT NULL,
    fkRede INT NOT NULL,
    usuario VARCHAR(45) NOT NULL,
    PRIMARY KEY(fkProdutor, fkRede),
    CONSTRAINT fkProdutorUsuario FOREIGN KEY (fkProdutor) REFERENCES produtor(idProdutor),
    CONSTRAINT fkRedeUsuario FOREIGN KEY (fkRede) REFERENCES rede_social(idRede)
);

CREATE TABLE genero (
	idGenero INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE genero_produtor (
	fkProdutor INT NOT NULL,
    fkGenero INT NOT NULL,
    CONSTRAINT fkProdutorGenero FOREIGN KEY (fkProdutor) REFERENCES produtor(idProdutor),
    CONSTRAINT fkGeneroProdutor FOREIGN KEY (fkGenero) REFERENCES genero(idGenero)
);

INSERT INTO produtor (nome, alias, senha, email, descricao, pontoForte, aplicativo, pathFotoPerfil) VALUES
('Carlos Almeida', 'DJ Alme', 'Urubu#100', 'carlos.almeida@example.com', 'Produtor focado em beats eletrônicos.', 'Beat', 'FL Studio', DEFAULT),
('Ana Souza', 'AnaBeats', 'Urubu#100', 'ana.souza@example.com', 'Apaixonada por trap e hip-hop.', 'Instrumental', 'Ableton Live', DEFAULT),
('Marcos Silva', 'MK Sound', 'Urubu#100', 'marcos.silva@example.com', 'Produtor de pop e eletrônico.', 'Master', 'Logic Pro', DEFAULT),
('Beatriz Costa', 'BiaMix', 'Urubu#100', 'beatriz.costa@example.com', 'Especialista em mixagem para rock e pop.', 'Mix', 'Pro Tools', DEFAULT),
('José Santos', 'ZéBeats', 'Urubu#100', 'jose.santos@example.com', 'Criador de beats para trap e rap.', 'Beat', 'FL Studio', DEFAULT),
('Rafael Oliveira', 'RafMix', 'Urubu#100', 'rafael.oliveira@example.com', 'Mixagem e masterização de qualidade.', 'Mix', 'Cubase', DEFAULT),
('Larissa Gomes', 'LariSound', 'Urubu#100', 'larissa.gomes@example.com', 'Produtora e engenheira de som.', 'Instrumental', 'Logic Pro', DEFAULT),
('Pedro Rocha', 'PRock', 'Urubu#100', 'pedro.rocha@example.com', 'Especialista em beats de trap.', 'Beat', 'Ableton Live', DEFAULT),
('Carla Martins', 'CarlaM', 'Urubu#100', 'carla.martins@example.com', 'Produção de beats para hip-hop.', 'Beat', 'FL Studio', DEFAULT),
('Fábio Lima', 'FabSound', 'Urubu#100', 'fabio.lima@example.com', 'Engenheiro de som para pop.', 'Master', 'Pro Tools', DEFAULT),
('André Mafra','China Mafra','Urubu#100','email', 'Sou André Mafra, mais conhecido como “China”, baixista, produtor e sócio fundador do selo/gravadora UCLÃ.', 'Instrumental', 'Ableton Live', './assets/profiles/chinamafra.jpg'),
('Rafael', '6ee','Urubu#100','6ee@gmail.com','Sou 6ee, produtor musical focado em trap e rap, apaixonado por criar beats que combinam 808s impactantes, melodias cativantes e percussões dinâmicas. Busco sempre inovar, misturando influências para entregar sons autênticos e de alta qualidade. Minha missão é ajudar artistas a traduzirem suas ideias em músicas que conectem e inspirem o público.', 'Beat', 'FL Studio', './assets/profiles/6ee.jpg'),
('admin', 'admin','Urubu#100','admin@email.com','Usuário Admin', 'Master', 'FL Studio', './assets/profiles/admin.jpg'),
('Ajaxx', 'Ajaxx','Urubu#100','ajaxx@gmail.com','Sou Ajaxx, produtor musical focado em trap e rap, apaixonado por criar beats que combinam 808s impactantes, melodias cativantes e percussões dinâmicas. Busco sempre inovar, misturando influências para entregar sons autênticos e de alta qualidade. Minha missão é ajudar artistas a traduzirem suas ideias em músicas que conectem e inspirem o público.', 'Beat', 'Pro Tools', './assets/profiles/ajaxx.jpg'),
('Allan Portuga', 'Alllan Portuga','Urubu#100','allan@gmail.com','Sou Allan Portuga, produtor musical dedicado ao rap nacional, com trabalhos marcantes ao lado dos Racionais MC’s e outros grandes artistas. Minha paixão está em criar beats autênticos, explorando samplers e melodias únicas para dar vida a músicas que conectam e inspiram.', 'Instrumental', 'FL Studio', './assets/profiles/allanportuga.jpg'),
('Bighead', 'Bighead','Urubu#100','bighead@gmail.com','Sou Bighead, produtor musical focado no trap, conhecido por criar beats energéticos e diretos, marcados por melodias simples e impacto cru. Já trabalhei com artistas como Lil Pump e Smokepurpp, ajudando a moldar o som do trap da era SoundCloud.', 'Beat', 'FL Studio', './assets/profiles/bighead.jpg'),
('Celo', 'Celo', 'Urubu#100', 'celo.beats@example.com', 'Produtor focado em criar beats autênticos para o trap, misturando elementos melódicos e pesados.', 'Beat', 'FL Studio', './assets/profiles/celo.jpeg'),
('Coyote Beatz', 'Coyote Beatz', 'Urubu#100', 'coyotebatz@example.com', 'Produtor de trap e hip-hop com estilo único, conhecido por beats pesados e inovadores.', 'Beat', 'FL Studio', './assets/profiles/coyotebeatz.jpg'),
('Dallas', 'Dallas', 'Urubu#100', 'dallas.beats@example.com', 'Especialista em beats melódicos para trap, com foco em atmosferas imersivas e sons intensos.', 'Beat', 'Ableton Live', './assets/profiles/dallas.jpeg'),
('DJ Khaled', 'DJ Khaled', 'Urubu#100', 'djkhaled@example.com', 'Sou DJ Khaled, um dos maiores produtores e executivos da música. Com uma carreira marcada por hits colaborativos, trago energia, visibilidade e sucesso para o rap e hip-hop, sempre buscando juntar os melhores talentos do jogo.', 'Master', 'FL Studio', './assets/profiles/djkhaled.jpg'),
('DJ Kore', 'DJ Kore', 'Urubu#100', 'djkore@example.com', 'Produtor com uma longa trajetória na cena do rap e trap, com beats e remixes pesados e marcantes.', 'Mix', 'Pro Tools', './assets/profiles/djkore.jpg'),
('DJ Mustard', 'DJ Mustard', 'Urubu#100', 'djmustard@example.com', 'Sou DJ Mustard, produtor e DJ reconhecido por definir o som do West Coast rap. Com batidas pesadas e o estilo "Mustard on the beat", ajudo a criar músicas que ficam na cabeça e fazem a festa, com grandes sucessos ao lado de artistas de peso.', 'Beat', 'FL Studio', './assets/profiles/djmustard.jpg'),
('DJ THG', 'DJ THG', 'Urubu#100', 'djthg@example.com', 'Produtor criativo de trap, conhecido por suas batidas inovadoras e sonoridades únicas.', 'Beat', 'Ableton Live', './assets/profiles/djthg.jpg'),
('Dr. Dre', 'Dr. Dre', 'Urubu#100', 'ddre.beats@example.com', 'Sou Dr. Dre, pioneiro no hip-hop e rap, com uma carreira que moldou o som moderno. Fundador da Aftermath Entertainment e mentor de gigantes como Eminem e Snoop Dogg, sempre busco inovação e perfeição em cada produção.', 'Beat', 'FL Studio', './assets/profiles/drdre.png'), -- 
('EcologyK', 'EcologyK', 'Urubu#100', 'ecologyk@example.com', 'Sou EcologyK, produtor e engenheiro de som. Com um estilo único que mistura trap e experimentalismo, crio beats atmosféricos e inovadores, sempre explorando novas texturas e sonoridades para um som futurista.', 'Instrumental', 'Pro Tools', './assets/profiles/ecologyk.jpg'),
('Ghosty', 'Ghosty', 'Urubu#100', 'ghosty@example.com', 'Criador de beats com uma abordagem melódica e impactante, especialmente voltados para trap e hip-hop.', 'Beat', 'FL Studio', './assets/profiles/ghosty.jpeg'),
('Gordox', 'Gordox', 'Urubu#100', 'gordox.beats@example.com', 'Criador de beats com uma abordagem melódica e impactante, especialmente voltados para trap e hip-hop.', 'Beat', 'FL Studio', './assets/profiles/gordox.jpg'),
('Hit-Boy', 'Hit-Boy', 'Urubu#100', 'hitboy@example.com', 'Produtor e compositor premiado, conhecido por sua habilidade em misturar trap com influências do rap clássico.', 'Master', 'Logic Pro', './assets/profiles/hit-boy.jpg'),
('JXNV', 'JXNV', 'Urubu#100', 'jxnv.beats@example.com', 'Produtor de trap experimental, trazendo novas perspectivas para a produção de beats pesados e melódicos.', 'Beat', 'FL Studio', './assets/profiles/jxnv.jpg'),
('KL Jay', 'KL Jay', 'Urubu#100', 'kjay.beats@example.com', 'Sou KL Jay, produtor e DJ, um dos nomes mais respeitados do rap e hip-hop nacional. Com mais de 20 anos de carreira, sou conhecido por minha habilidade em criar beats clássicos e inovadores, colaborando com grandes nomes da música brasileira.', 'Mix', 'Ableton Live', './assets/profiles/kljay.jpeg'),
('LondonOnDaTrack', 'London On Da Track', 'Urubu#100', 'londonondatrack@example.com', 'Sou London on da Track, produtor de trap e hip-hop, reconhecido por meus beats pesados e melodiosos. Com produções marcantes para artistas como 2 Chainz e Young Thug, trago sempre a energia certa para fazer os hits acontecerem.', 'Beat', 'FL Studio', './assets/profiles/londonondatrack.jpg'), -- 
('LucasBoomBeat', 'LucasBoomBeat', 'Urubu#100', 'lucasboombeat@example.com', 'Produtor de trap com beats pesados e criativos, influenciando a nova geração de rappers.', 'Master', 'Pro Tools', './assets/profiles/lucasboombeat.jpg'),
('M1On The Beat', 'M1On The Beat', 'Urubu#100', '1monthebeat@example.com', 'Produtor com um estilo único, focado em beats melódicos e energéticos para o trap e rap.', 'Instrumental', 'FL Studio', './assets/profiles/m1onthebeat.jpg'),
('Metro Boomin', 'Metro Boomin', 'Urubu#100', 'metroboomin@example.com', 'Sou Metro Boomin, produtor e beatmaker. Com meu estilo melódico e som atmosférico, sou um dos principais responsáveis pelo sucesso do trap moderno, colaborando com grandes artistas como Future, 21 Savage e Future.', 'Beat', 'FL Studio', './assets/profiles/metroboomin.jpg'), -- 
('MurdaBeatz', 'MurdaBeatz', 'Urubu#100', 'murdabeatz@example.com', 'Produtor canadense de trap, responsável por inúmeros hits com artistas como Drake, Migos e Cardi B.', 'Beat', 'FL Studio', './assets/profiles/murdabeatz.jpg'),
('Nagalli', 'NagalliBeats', 'Urubu#100', 'nagalli.beats@example.com', '"Sou Nagalli, produtor de trap com foco em beats melódicos e influências de EDM. Minha música é uma fusão de sons pesados e texturas atmosféricas, criando uma experiência sonora única e inovadora para os fãs de trap e rap.', 'Instrumental', 'Ableton Live', './assets/profiles/nagalli.jpg'),
('Neobeats', 'Neobeats', 'Urubu#100', 'neobets@example.com', 'Produtor de beats atmosféricos e inovadores, trazendo uma vibe única para o trap e o rap.', 'Beat', 'FL Studio', './assets/profiles/neobets.jpg'),
('Nobre Beats', 'Nobre Beats', 'Urubu#100', 'nobrebeats@example.com', 'Sou Nobrebeats, produtor de trap com uma abordagem única para criar beats pesados e atmosféricos, sempre buscando inovar e trazer algo novo para a cena do rap.', 'Beat', 'FL Studio', './assets/profiles/nobrebeats.jpeg'),
('Papatinho', 'Papatinho', 'Urubu#100', 'papatinho@example.com', 'Sou Papatinho, produtor e DJ, conhecido por minhas batidas inovadoras no trap e hip-hop. Com uma combinação de 808s pesados e melodias cativantes, crio músicas que se conectam com a cultura urbana e fazem a galera vibrar.', 'Beat', 'FL Studio', './assets/profiles/papatinho.jpg'),
('Pedro Lotto', 'Pedro Lotto', 'Urubu#100', 'pedrolotto@example.com', 'Produtor de trap e rap, sempre criando beats energéticos com influências modernas e inovadoras, trazendo frescor à cena musical.', 'Master', 'Pro Tools', './assets/profiles/pedrolotto.jpg'),
('Pedro Qualy', 'Pedro Qualy', 'Urubu#100', 'pedroqualy@example.com', 'Sou PedroQualy, produtor musical de trap e hip-hop, criando beats que misturam sonoridades eletrônicas com o peso do rap moderno.', 'Beat', 'Ableton Live', './assets/profiles/pedroqualy.jpg'),
('RayNier', 'RayNier', 'Urubu#100', 'raynier@example.com', 'Eu sou Ranier, tenho 18 anos apaixonado por música. Os gêneros que mais me fascinaram são trap e a eletrônica. Com um computador e fones de ouvido, começo a transformar minhas inspirações musicais em realidade.', 'Mix', 'FL Studio', './assets/profiles/raynier.jpg'),
('Retroboy', 'Retroboy', 'Urubu#100', 'retroboy@example.com', 'Sou RetroBoy, produtor com foco em trap e beats experimentais, trazendo um estilo único que mistura influências do passado com o som moderno. Meu objetivo é criar atmosferas sonoras envolventes que conectam com os ouvintes de maneira autêntica.', 'Beat', 'Logic Pro', './assets/profiles/retroboy.jpg'),
('Rincon Sapiencia', 'Rincon Sapiência', 'Urubu#100', 'rinconsapiencia@example.com', 'Sou RinconSapiencia, produtor e rapper, trazendo beats que mesclam elementos tradicionais e contemporâneos, com um toque único de autenticidade.', 'Instrumental', 'Pro Tools', './assets/profiles/rinconsapiencia.jpg'),
('Sonny Digital', 'Sonny Digital', 'Urubu#100', 'sonnydigital@example.com', 'Sou Sonny Digital, produtor e beatmaker. Com um estilo único e sonoridades cativantes, crio beats que marcam a diferença no trap e rap. Fui pioneiro na cena do SoundCloud e continuo a criar músicas que moldam o futuro do gênero.', 'Beat', 'FL Studio', './assets/profiles/sonnydigital.png'),
('Sono TWS', 'Sono TWS', 'Urubu#100', 'sonotws@example.com', 'Sou Sono TWS, produtor de Boom Bap focado em batidas pesadas e melodiosas. Com uma vibe única, crio músicas que misturam elementos melódicos e energéticos, ajudando a contar histórias através do som e sempre inovando no processo criativo.', 'Instrumental', 'Ableton Live', './assets/profiles/sonotws.jpg'),
('Southside', 'Southside', 'Urubu#100', 'southside@example.com', 'Sou Southside, um dos produtores mais reconhecidos do trap, com beats característicos que unem 808s potentes e melodias sombrias.', 'Beat', 'FL Studio', './assets/profiles/southside.jpg'),
('Tay Keith', 'Tay Keith', 'Urubu#100', 'taykeith@example.com', 'Sou Tay Keith, produtor de trap com uma abordagem criativa e inovadora, conhecido por criar hits para artistas de rap de grande sucesso.', 'Master', 'Pro Tools', './assets/profiles/taykeith.jpg'),
('TM88', 'TM88', 'Urubu#100', 'tm88@example.com', 'Sou TM88, produtor de trap e hip-hop, com uma abordagem única para beats pesados e melodias distorcidas que fazem a diferença no som.', 'Beat', 'FL Studio', './assets/profiles/tm88.jpg'),
('WC no Beat', 'WcnoBeat', 'Urubu#100', 'wcnobeat@example.com', 'Sou WCnoBeat, um produtor de trap focado em criar atmosferas sonoras profundas com 808s marcantes e influências da música eletrônica.', 'Instrumental', 'Ableton Live', './assets/profiles/wcnobeat.jpg'),
('Wheezy', 'Wheezy', 'Urubu#100', 'wheezy@example.com', 'Sou Wheezy, produtor de trap e hip-hop, com uma abordagem que mistura sons melódicos e batidas pesadas, criando hits com os maiores nomes do gênero.', 'Mix', 'FL Studio', './assets/profiles/wheezy.png'),
('Young Chop', 'Young Chop', 'Urubu#100', 'youngchop@example.com', 'Sou Young Chop, produtor de trap e rap, conhecido por criar batidas pesadas e enérgicas, trazendo uma sonoridade única e impactante.', 'Beat', 'FL Studio', './assets/profiles/youngchop.jpg'),
('Yung Buda', 'Yung Buda', 'Urubu#100', 'yungbuda@example.com', 'Sou Yung Buda, produtor musical especializado em trap e beats experimentais. Com um estilo inovador e influências variadas, meu som vai além dos limites, criando experiências sonoras impactantes que são ideais para a nova geração do rap.', 'Instrumental', 'Pro Tools', './assets/profiles/yungbuda.jpg'),
('Zaytoven', 'Zaytoven', 'Urubu#100', 'zaytoven@example.com', 'Sou Zaytoven, um dos maiores produtores de trap, com uma carreira que moldou o som da cena trap e hip-hop com meus beats inconfundíveis e imersivos.', 'Beat', 'FL Studio', './assets/profiles/zaytoven.jpg');

INSERT INTO rede_social (nome, url, fontAwesomeTag) VALUES
('Instagram', 'https://instagram.com/', 'fa-square-instagram'),
('Twitter', 'https://twitter.com/', 'fa-square-x-twitter'),
('Facebook', 'https://facebook.com/', 'fa-square-facebook'),
('YouTube', 'https://youtube.com/', 'fa-square-youtube'),
('SoundCloud', 'https://soundcloud.com/', 'fa-soundcloud'),
('Spotify', 'https://spotify.com/', 'fa-spotify'),
('TikTok', 'https://tiktok.com/@', 'fa-tiktok'),
('LinkedIn', 'https://linkedin.com/in/', 'fa-linkedin'),
('Deezer', 'https://deezer.com/profile/', 'fa-deezer'),
('Bandcamp', 'https://bandcamp.com/', 'fa-bandcamp'),
('Twitch', 'https://twitch.tv/', 'fa-twitch'),
('Reddit', 'https://reddit.com/u/', 'fa-square-reddit');

INSERT INTO genero (nome) VALUES
('Hip Hop'), 
('Trap'), 
('Rock'), 
('Pop'),
('Eletrônica'), 
('Jazz'), 
('Reggae'), 
('R&B'), 
('Funk'), 
('Sertanejo'),
('MPB'),
('KPOP'), 
('Boom Bap'), 
('Forró'),
('Lo-Fi'), 
('Afrobeat'); 

INSERT INTO genero_produtor (fkProdutor, fkGenero) VALUES
(1, 1),  
(1, 2), 
(2, 3),  
(3, 4),  
(4, 5),  
(4, 7), 
(4, 11), 
(5, 1),  
(5, 8),  
(6, 6),  
(7, 3),  
(7, 9), 
(8, 2), 
(9, 10), 
(9, 4),  
(10, 5), 
(11, 2),
(11, 11),
(12, 2),
(12, 4),
(14, 2),
(14, 4),
(15, 1),
(15, 2),
(15, 11),
(16, 1),
(16, 2),
(16, 13),
(17, 2),
(17, 4),
(18, 2),
(18, 4),
(19, 2),
(19, 13),
(20, 1), 
(20, 2),
(20, 4), 
(20, 5),
(20, 8),
(20, 16), 
(21, 2),
(21, 13),
(22, 1),
(22, 2),
(23, 1),
(23, 2),
(24, 1),
(24, 13),
(25, 1),
(25, 2),
(25, 13),
(26, 1),
(26, 2),
(27, 13),
(27, 1),
(27, 14), 
(27, 15), 
(28, 1),
(28, 2),
(29, 2),
(30, 1), 
(30, 4), 
(30, 5), 
(30, 8),
(30, 16), 
(31, 1),  
(32, 3),   
(33, 1),   
(34, 1),  
(35, 1),  
(36, 2),  
(37, 1),   
(37, 1),  
(38, 1),
(39, 2),
(39, 5),
(39, 9),  
(40, 3),   
(41, 1),  
(42, 2),
(42, 1),
(42, 5),   
(43, 1),  
(44, 2),  
(44, 1),  
(44, 3),
(44, 7),
(44, 8),
(44, 9),
(44, 16),   
(45, 1),   
(46, 2),  
(47, 1),   
(48, 3),  
(49, 1),   
(50, 9),   
(51, 1),   
(52, 1),   
(53, 2),   
(5, 1);   


INSERT INTO rede_produtor (fkProdutor, fkRede, usuario) VALUES
(1, 1, 'dj_alme_insta'),  
(1, 4, 'dj_alme_yt'),    
(2, 2, 'ana_beats'),      
(2, 5, 'ana_beats_sc'),   
(3, 3, 'mksound_fb'),     
(3, 6, 'mksound_spotify'),
(4, 8, 'bia_mix'),        
(4, 9, 'bia_mix_dzr'),    
(5, 1, 'zebeats_insta'),  
(5, 11, 'zebeats_tw'),    
(6, 2, 'rafmix_tw'),     
(6, 4, 'rafmix_yt'), 
(7, 10, 'larisound_bc'),
(7, 3, 'larisound_fb'),   
(8, 5, 'prock_sc'),       
(8, 12, 'prock_reddit'), 
(9, 7, 'carla_m_tiktok'), 
(9, 6, 'carla_m_spotify'),
(10, 1, 'fabsound_insta'),
(10, 8, 'fabsound_li'), 
(11, 2, 'china_mafra_tw'),
(11, 4, 'china_mafra_yt'),  
(12, 5, '05jfoavrchev'),     
(12, 7, 'rafael6ee_tiktok'), 
(14, 1, 'ajaxx_insta'),  
(14, 2, 'ajaxx_twitter'),  
(15, 1, 'allanportuga_insta'), 
(15, 3, 'allanportuga_facebook'), 
(16, 1, 'bighead_insta'), 
(16, 4, 'bighead_linkedin'), 
(17, 2, 'celobeats_twitter'),
(17, 5, 'celo1st-music'),
(18, 1, 'coyotebeatz_insta'), 
(18, 6, 'coyotebeatz_spotify'),  
(19, 7, 'dallas_tiktok'), 
(19, 1, 'dallas_instagram'), 
(20, 8, 'djkhaled_linkedin'),  
(20, 2, 'djkhaled_twitter'), 
(21, 1, 'djkore_insta'),  
(21, 9, 'djkore_reddit'),  
(22, 3, 'djmustard_facebook'), 
(22, 10, 'djmustard_bandcamp'),  
(23, 4, 'djthg_youtube'),  
(23, 2, 'djthg_twitter'),  
(24, 1, 'drdre_insta'), 
(24, 5, 'dr-dre-music'), 
(25, 7, 'ecologyk_tiktok'),  
(25, 3, 'ecologyk_facebook'),  
(26, 6, 'ghosty_spotify'),
(26, 1, 'ghosty_instagram'), 
(27, 9, 'gordox_reddit'),
(27, 1, 'gordox_insta'), 
(28, 2, 'hitboy_twitter'),
(28, 5, 'hit-boy'), 
(29, 8, 'jxnv_linkedin'), 
(29, 6, 'jxnv_spotify'),
(30, 7, 'kljay_tiktok'),
(30, 3, 'kljay_facebook'),
(31, 1, 'londonondatrack_insta'), 
(31, 2, 'londonondatrack_twitter'),  
(32, 5, 'lucasboombeat_soundcloud'),
(32, 8, 'lucasboombeat_linkedin'), 
(33, 9, 'm1onthebeat_reddit'),  
(33, 3, 'm1onthebeat_facebook'),  
(34, 1, 'metroboomin_insta'), 
(34, 6, 'metroboomin_spotify'), 
(35, 4, 'murdabeatz_youtube'),
(35, 2, 'murdabeatz_twitter'),  
(36, 1, 'nagallibeats_insta'),  
(36, 7, 'nagallibeats_tiktok'),  
(37, 5, 'neobeats_soundcloud'),  
(37, 8, 'neobeats_linkedin'),  
(38, 6, 'nobrebeats_spotify'),  
(38, 3, 'nobrebeats_facebook'), 
(39, 1, 'papatinho_insta'), 
(39, 2, 'papatinho_twitter'), 
(40, 9, 'pedrolotto_reddit'), 
(40, 5, 'pedrolotto'),  
(41, 6, 'pedroqualy_spotify'), 
(41, 7, 'pedroqualy_tiktok'), 
(42, 2, 'CoutoRanier'), 
(42, 1, 'ranierdcpop'),  
(42, 5, 'ranierd'),
(43, 3, 'retroboy_facebook'),  
(43, 8, 'retroboy_linkedin'),  
(44, 4, 'rinconsapiencia_youtube'), 
(44, 6, 'rinconsapiencia_spotify'),  
(45, 7, 'sonnydigital_tiktok'), 
(45, 1, 'sonnydigital_instagram'),  
(46, 2, 'sonotws_twitter'), 
(46, 3, 'sonotws_facebook'),  
(47, 8, 'southside_linkedin'),  
(47, 7, 'southside_tiktok'),  
(48, 9, 'taykeith_reddit'), 
(48, 5, 'taykeith'), 
(49, 1, 'tm88_insta'), 
(49, 3, 'tm88_facebook'), 
(50, 6, 'wcnobeat_spotify'),  
(50, 2, 'wcnobeat_twitter'), 
(51, 8, 'wheezy_linkedin'), 
(51, 7, 'wheezy_tiktok'), 
(52, 4, 'youngchop_youtube'),  
(52, 1, 'youngchop_insta'),  
(53, 5, 'yungbuda-music'),  
(53, 2, 'yungbuda_twitter'), 
(54, 1, 'zaytoven_insta'), 
(54, 3, 'zaytoven_facebook'); 


INSERT INTO feat (dtFeat, statusFeat, fkProdutorSolicita, fkProdutorAceita) VALUES
('2024-02-23 22:00:00', 1, 1, 3),
('2024-02-24 10:00:00', 0, 2, 4),
('2024-02-25 11:00:00', 0, 5, 6),
('2024-02-26 12:00:00', 1, 7, 8),
('2024-02-27 13:00:00', 0, 9, 10),
('2024-02-28 14:00:00', 0, 11, 12),
('2024-02-29 15:00:00', 1, 14, 15),
('2024-03-01 16:00:00', 1, 16, 17),
('2024-03-02 17:00:00', 1, 18, 19),
('2024-03-03 18:00:00', 1, 20, 21),
('2024-03-04 19:00:00', 1, 22, 23),
('2024-03-05 20:00:00', 0, 24, 25),
('2024-03-06 21:00:00', 1, 26, 27),
('2024-03-07 22:00:00', 1, 28, 29),
('2024-03-08 23:00:00', 1, 30, 31),
('2024-03-09 10:00:00', 1, 32, 33),
('2024-03-10 11:00:00', 1, 34, 35),
('2024-03-11 12:00:00', 0, 36, 37),
('2024-03-12 13:00:00', 0, 38, 39),
('2024-03-13 14:00:00', 0, 40, 41),
('2024-03-14 15:00:00', 1, 42, 43),
('2024-03-15 16:00:00', 1, 44, 45),
('2024-03-16 17:00:00', 1, 46, 47),
('2024-03-17 18:00:00', 1, 48, 49),
('2024-03-18 19:00:00', 1, 50, 51),
('2024-03-19 20:00:00', 0, 52, 53),
('2024-03-20 21:00:00', 0, 54, 1),
('2024-03-21 22:00:00', 0, 2, 3),
('2024-03-22 10:00:00', 0, 4, 5),
('2024-03-23 11:00:00', 0, 6, 7),
('2024-03-24 12:00:00', 1, 8, 9),
('2024-03-25 13:00:00', 1, 10, 11),
('2024-03-26 14:00:00', 0, 12, 14),
('2024-03-27 15:00:00', 0, 15, 16),
('2024-03-28 16:00:00', 0, 17, 18),
('2024-03-29 17:00:00', 0, 19, 20),
('2024-03-30 18:00:00', 0, 21, 22),
('2024-03-31 19:00:00', 0, 23, 24),
('2024-04-01 20:00:00', 0, 25, 26),
('2024-04-02 21:00:00', 0, 27, 28),
('2024-04-03 22:00:00', 1, 29, 30),
('2024-04-04 23:00:00', 0, 31, 32),
('2024-04-05 10:00:00', 1, 33, 34),
('2024-04-06 11:00:00', 0, 35, 36),
('2024-04-07 12:00:00', 0, 37, 38),
('2024-04-08 13:00:00', 0, 39, 40),
('2024-04-09 14:00:00', 0, 41, 42),
('2024-04-10 15:00:00', 0, 43, 44),
('2024-04-11 16:00:00', 0, 45, 46),
('2024-04-12 17:00:00', 0, 47, 48),
('2024-04-13 18:00:00', 1, 49, 50),
('2024-04-14 19:00:00', 1, 51, 52),
('2024-04-15 20:00:00', 2, 53, 54),
('2024-04-16 21:00:00', 2, 1, 2),
('2024-04-17 22:00:00', 2, 3, 4),
('2024-04-18 10:00:00', 2, 5, 6),
('2024-04-19 11:00:00', 2, 7, 8),
('2024-04-20 12:00:00', 1, 9, 10),
('2024-04-21 13:00:00', 2, 11, 12),
('2024-04-22 14:00:00', 2, 14, 15),
('2024-04-23 15:00:00', 1, 16, 17),
('2024-04-24 16:00:00', 0, 18, 19),
('2024-04-25 17:00:00', 0, 20, 21),
('2024-04-26 18:00:00', 0, 22, 23),
('2024-04-27 19:00:00', 1, 24, 25),
('2024-04-28 20:00:00', 1, 26, 27),
('2024-04-29 21:00:00', 1, 28, 29),
('2024-04-30 22:00:00', 2, 30, 31),
('2024-05-01 10:00:00', 1, 32, 34);

-- ----------------------------
-- SRCIPTS DO PRÓPRIO SISTEMA
-- ----------------------------

-- SCRIPT DE SELECIONAR TODAS AS REDES, Gêneros 
-- SELECT idRede as id, nome FROM rede_social ORDER BY nome;
-- SELECT idGenero as id, nome FROM genero ORDER BY nome;

-- SCRIPT DE LOGIN
-- SELECT COUNT(idProdutor) FROM produtor WHERE alias = apelidoInformado AND senha = senhaInformada;
-- ------------------------------------------------------------------------------------------------

-- SCRIPT DE CADASTRO
-- INSERT INTO produtor (nome, alias, senha, email, descricao, pontoForte, aplicativo) VALUES (nome, apelido, senha, email, descricao, pontoForte, aplicativo);
-- SELECT idProdutor FROM produtor WHERE alias = alias que acabou de cadastrar;
-- INSERT INTO rede_produtor (fkProdutor, fkRede, usuario) VALUES (idProdutor, idRede, user); FAZER LOOP EM CASO DE MAIS DE UMA REDE
-- INSERT INTO genero_produtor (fkProdutor, fkGenero) VALUES (idProdutor, idGenero),  FAZER LOOP EM CASO DE MAIS DE UM GENERO
-- SCRIPT MOSTRAR PRODUTORES PARA FEAT
-- SELECT idProdutor, alias, aplicativo, pontoForte, g.nome as genero FROM produtor JOIN genero_produtor as gp ON gp.fkProdutor = idProdutor JOIN genero as g ON gp.fkGenero = g.idGenero WHERE adicionar genero de acordo com os generos que o user que acessou;
-- ------------------------------------------------------------------------------------------------

-- SCRIPT MOSTRAR CONVITES PARA FEAT
-- SELECT idProdutor, alias, aplicativo, pontoForte, g.nome as genero FROM produtor JOIN genero_produtor as gp ON gp.fkProdutor = idProdutor JOIN genero as g ON gp.fkGenero = g.idGenero JOIN feat ON idProdutor = feat.fkProdutorSolicita WHERE fkProdutorAceita = 1;
-- --------------------------------------------------------------------------------------------------

-- -- SCRIPT PARA MOSTRAR OS FEATS FEITOS 
-- SELECT a.alias as 'apelido', b.alias as 'apelido b' FROM produtor as a 
-- JOIN produtor as b
-- JOIN feat ON a.idProdutor = fkProdutorSolicita;
-- -------------------------------------------------------------------------------------------------

-- SCRIPT PARA ACESSAR INFORMAÇÕES DO PERFIL DE USUÁRIO
-- SELECT idProdutor, alias, aplicativo, pontoForte, g.nome as genero FROM produtor JOIN genero_produtor as gp ON gp.fkProdutor = idProdutor JOIN genero as g ON gp.fkGenero = g.idGenero WHERE idProdutor = idPerfilQueUserClicou;
-- --------------------------------------------------------------------------------------------------

-- SCRIPT PARA EDITAR O PERFIL DO USUÁRIO
-- UPDATE produtor SET cada campo igual ao input dos perfil WHERE idProdutor = idProdutor perfil;
-- UPDATE rede_produtor SET usuario = usuarioInformado WHERE fkProdutor = idprodutoratualizar AND fkRede = redeInformada; ATUALIZAR EM LOOP TODAS AS REDES DO PRODUTOR QUE JA EXISTIREM
-- POREM INSERIR UMA REDE CASO O PRODUTOR NÃO TENHA CADASTRADO
-- UPDATE genero_produtor SET usuario = usuarioInformado WHERE fkProdutor = idprodutoratualizar AND fkRede = redeInformada; ATUALIZAR EM LOOP TODAS OS GENEROS DO PRODUTOR QUE JA EXISTIREM
-- POREM INSERIR UM GENERO CASO O PRODUTOR NÃO TENHA CADASTRADO
-- --------------------------------------------------------------------------------------------------

-- SCRIPT PARA ATUALIZAR STATUS DE UM FEAT 
-- UPDATE feat SET statusFeat WHERE idProdutorAceita = idProdutorClicouAceitar AND idProdutorSolicita = idProdutorSolicitou;
-- --------------------------------------------------------------------------------------------------

-- SCRIPT INSERIR UM NOVO FEAT 
-- INSERT INTO feat (dtFeat, fkProdutorSolicita, fkProdutorAceita) VALUES (now(), idSolicita, idAceita);

-- ----------------------------
-- SRCIPTS DA DASHBOARD
-- ----------------------------

-- SCRIPT USUARIOS TOTAL
-- SELECT COUNT(idProdutor) FROM produtor;

-- SCRIPT USUARIOS ATIVO
-- SELECT COUNT(idProdutor) FROM produtor WHERE TIMESTAMPDIFF(DAY,now(),lastLogin) <= 10;

-- SCRIPT FEATS FEITOS
-- SELECT COUNT(idFeat) FROM feat;

-- SCRIPT GENEROS MAIS USADOS
-- SELECT COUNT(fkGenero), nome as genero FROM genero_produtor JOIN genero ON genero.idGenero = fkGenero GROUP BY fkGenero;

-- SCRIPT STATUS DOS FEATS
-- SELECT COUNT(statusFeat), CASE WHEN statusFeat = 0 THEN 'Pendente' WHEN statusFeat = 1 THEN 'Aceito' ELSE 'Recusado' END AS stausFeat FROM feat GROUP BY statusFeat;

-- SCRIPT APPS MAIS USADOS
-- SELECT COUNT(aplicativo), aplicativo FROM produtor GROUP BY aplicativo;