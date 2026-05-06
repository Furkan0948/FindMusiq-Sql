-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1:3306
-- Üretim Zamanı: 18 Ara 2024, 12:45:59
-- Sunucu sürümü: 5.7.36
-- PHP Sürümü: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `findmusic`
--

DELIMITER $$
--
-- Yordamlar
--
DROP PROCEDURE IF EXISTS `2001_ile_2020_arası_uretilen_urunler`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `2001_ile_2020_arası_uretilen_urunler` ()  SELECT
	*
FROM
	urun
WHERE
	uretim_yili BETWEEN 2008 AND 2020$$

DROP PROCEDURE IF EXISTS `Girilen_yillardan_sonra_üretilen_urunler`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Girilen_yillardan_sonra_üretilen_urunler` (IN `yil` YEAR)  SELECT ureticifirma.firma_adi AS firma, ensturman.ensturman_id AS urun_adi, ensturman.ensturman_adi AS urun_adi, urun.uretim_yili
FROM ensturman, urun , ureticifirma
WHERE ensturman.ensturman_id=urun.urun_id
 AND urun.uretim_yili>yil
ORDER BY urun.uretim_yili$$

DROP PROCEDURE IF EXISTS `Girilen_yillar_arasinda_uretilen_urunler`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Girilen_yillar_arasinda_uretilen_urunler` (IN `y1` YEAR, IN `y2` YEAR)  SELECT ureticifirma.firma_adi AS firma, ensturman.ensturman_adi AS urun_adi, urun.uretim_yili
FROM ensturman, urun , ureticifirma
WHERE ensturman.ensturman_id=urun.urun_id
 AND urun.uretim_yili BETWEEN y1 and y2
ORDER BY urun.uretim_yili$$

DROP PROCEDURE IF EXISTS `katagoriye_gore_urun_Sayisi`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `katagoriye_gore_urun_Sayisi` (IN `isim` VARCHAR(255))  SELECT katagori.Katagori_adi,
COUNT(ensturman.ensturman_id) AS urun_sayisi
FROM ureticifirma, ensturman, urun,katagori
WHERE ensturman.katagori_id= katagori.katagori_id AND
ensturman.firma_id=ureticifirma.firma_id and urun.ensturman_id= ensturman.ensturman_id
 AND katagori.Katagori_adi=isim$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ensturman`
--

DROP TABLE IF EXISTS `ensturman`;
CREATE TABLE IF NOT EXISTS `ensturman` (
  `ensturman_id` int(11) NOT NULL AUTO_INCREMENT,
  `ensturman_adi` varchar(255) DEFAULT NULL,
  `katagori_id` int(11) DEFAULT NULL,
  `firma_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ensturman_id`),
  KEY `kadagori_idfk` (`katagori_id`),
  KEY `firma_idfk` (`firma_id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `ensturman`
--

INSERT INTO `ensturman` (`ensturman_id`, `ensturman_adi`, `katagori_id`, `firma_id`) VALUES
(1, 'SG Modern Elektro Gitar TRANS BLACK FADE', 3, 3),
(2, 'Les Paul Standard 60s Elektro Gitar BOURBON BURST', 3, 3),
(3, 'ES335 Semi Hollow Elektro Gitar VINTAGE EBONY', 3, 3),
(4, 'SG Tribute Elektro Gitar VINTAGE CHERRY SATIN', 3, 3),
(5, 'KLP-STD-BK Elektro Gitar', 3, 1),
(6, 'KHB-JZ1000-BK Hollow Body Siyah Elektro Gitar', 3, 1),
(7, 'KST-BSWSSS-GMN-DBL Elektro Gitar', 3, 1),
(8, 'Telecaster Akcaagac Klavye Butterscotch Blonde Elektro Gitar', 3, 2),
(9, 'Player Stratocaster Pau Ferro Klavye Black Elektro Gitar', 3, 2),
(10, 'Player Stratocaster HSS Akcaagac Klavye Polar White Elektro Gitar', 3, 2),
(11, 'KHP-164RW Dijital Duvar Piyanosu', 1, 1),
(12, 'KPP-125BK Mat Siyah Dijital Duvar Piyanosu', 1, 1),
(13, 'KUP-118 BK / Duvar Piyanosu', 1, 1),
(14, 'EUP-123 E / 123 CM Duvar Piyanosu', 1, 7),
(15, 'ESSEX EUP-116 E / 118 CM Duvar Piyanosu', 1, 7),
(16, 'CT-S195BK 61 Tuslu Org', 2, 9),
(17, 'SA-51 51 Tuslu Org', 2, 9),
(18, 'DEK-610P 61 Tuslu Org', 2, 10),
(19, 'Toys SD-6111A Org', 2, 11),
(20, 'Toys MQ-3768 37 Tuslu Org ', 2, 11),
(21, 'Casiotone CT-S400 61 Tuslu Org', 2, 11),
(27, 'Debut 10e Combo Amfi', 4, 13),
(28, 'THR100H 100-Watt Modeling Head', 4, 12),
(29, 'THRC212 300-Watt 2x12 Kabin', 4, 12),
(30, 'HT5R MKII Kombo Amfi', 4, 13),
(31, 'YSV104BRO Silent Keman', 5, 12),
(32, 'YEV104NT Elektro Keman (Natural)', 5, 12),
(33, '1400/C Student I Keman', 5, 14),
(34, 'RS3A Keman (1/4)', 5, 15),
(35, 'II 4/4 Çello (Satin Finish)', 5, 14),
(36, 'MC6012 Çello (1/2)', 5, 15),
(37, 'XTN2001 Tenor Saksafon', 6, 17),
(38, 'XST1001 Soprano Saksafon', 6, 17),
(39, 'AAS33-OT Eb Alto Saksafon', 6, 16),
(40, 'YDS150 Dijital Saksafon', 6, 12),
(41, 'XTN2001 Tenor Saksafon', 6, 17),
(42, 'DDS-520 22\" 5-Parça Silent Set Akustik Davul', 7, 18),
(43, 'EDS-220 14-inch 5 Parça Mini Akustik Davul ', 7, 18),
(44, '5 Parça Akustik Davul (Silver Oyster Pearl)', 7, 19),
(45, '4 Parça Akustik Davul (Cherry Burst)', 7, 19),
(46, 'Stage Custom Birch 5-Parça Akustik Davul Seti (Cranberry Red)', 7, 12),
(52, 'Scarlett Solo Gen 3 USB Ses Karti', 8, 20),
(53, 'Scarlett 2i2 Gen 3 USB Ses Karti', 8, 20),
(54, 'Artist 1.2 2 in x 2 out USB Ses Karti', 8, 21),
(55, 'Producer 2.2 2 in x 2 out USB Ses Karti', 8, 21),
(56, 'Scarlett 18i20 Gen 3 USB Ses Karti', 8, 20),
(61, 'SE25 Mini USB MIDI Klavye', 8, 23),
(62, 'Launchkey Mini MK3 Midi Klavye', 8, 22),
(63, 'Launchkey 25 MK3 Midi Klavye', 8, 22),
(64, 'Impact GXP88 88-Tus Midi Controller', 8, 23),
(74, 'TT Dahili Premamfili Pikap - AT3600L igne ile (Saten Maun)', 9, 24),
(75, 'TT-3 Pikap - Ortofon OM 5E Igne ile - (Disbudak)\r\n', 9, 24),
(76, 'Alto Center Hoparlor (Beyaz)', 9, 24),
(77, 'Alto 5 MK2 5\" Bookshelf Hoparlor (Beyaz)', 9, 24),
(78, 'Alto 55 MK2 Kule Tipi Hoparlor (Siyah)', 9, 24),
(79, 'SA1 Bluetooth Baglantili Stereo Amfi (Siyah)', 9, 24),
(80, 'Pop 2 Hi-Fi Bluetooth Kulaklik (Beyaz)', 9, 24),
(81, 'Pop 2 Hi-Fi Bluetooth Kulaklik (Siyah)\r\n', 9, 24),
(82, 'Hi-X25BT Bluetooth Kulaklik (Siyah)', 9, 24),
(83, 'DOREXOS-02 Cift Ayakli Org Standi', 10, 25),
(84, 'HCHA-206 Gitar Bakim Standi', 10, 26),
(85, 'HCGS-414B Gitar Standi', 10, 25),
(86, 'HCDS-513BB Coklu Trompet Standi\r\n', 10, 25),
(87, 'HCGS-523B 3-Enstruman Gitar Rack\r\n', 10, 25),
(88, 'HCGS-415B Katlanabilir Gitar Standi', 10, 25);

--
-- Tetikleyiciler `ensturman`
--
DROP TRIGGER IF EXISTS `guncel_urun_sayisi_cıkarma`;
DELIMITER $$
CREATE TRIGGER `guncel_urun_sayisi_cıkarma` AFTER DELETE ON `ensturman` FOR EACH ROW INSERT INTO guncel_urun_sayisi VALUES ((SELECT COUNT(*)FROM ensturman), now())
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `guncel_urun_sayisi_ekleme`;
DELIMITER $$
CREATE TRIGGER `guncel_urun_sayisi_ekleme` AFTER INSERT ON `ensturman` FOR EACH ROW INSERT INTO guncel_urun_sayisi VALUES ((SELECT COUNT(*)FROM ensturman), now())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `guncel_urun_sayisi`
--

DROP TABLE IF EXISTS `guncel_urun_sayisi`;
CREATE TABLE IF NOT EXISTS `guncel_urun_sayisi` (
  `urun_sayisi` int(11) DEFAULT NULL,
  `guncelleme_tarihi` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `guncel_urun_sayisi`
--

INSERT INTO `guncel_urun_sayisi` (`urun_sayisi`, `guncelleme_tarihi`) VALUES
(65, '2022-12-14 08:27:03');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `katagori`
--

DROP TABLE IF EXISTS `katagori`;
CREATE TABLE IF NOT EXISTS `katagori` (
  `katagori_id` int(11) NOT NULL AUTO_INCREMENT,
  `Katagori_adi` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`katagori_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `katagori`
--

INSERT INTO `katagori` (`katagori_id`, `Katagori_adi`) VALUES
(1, 'Piyanolar'),
(2, 'Tuslular'),
(3, 'Gitarlar'),
(4, 'Amfi ve Efekt '),
(5, 'Yaylilar'),
(6, 'Nefesliler'),
(7, 'Davul ve Perkusyon'),
(8, 'Studyo ve sahne '),
(9, 'Hi-Fi'),
(10, 'Aksesuarlar');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `musteri`
--

DROP TABLE IF EXISTS `musteri`;
CREATE TABLE IF NOT EXISTS `musteri` (
  `musteri_id` int(11) NOT NULL AUTO_INCREMENT,
  `musteri_adi` varchar(255) NOT NULL,
  `musteri_soyadi` varchar(255) DEFAULT NULL,
  `musteri_tel` int(11) DEFAULT NULL,
  `musteri_email` varchar(255) DEFAULT NULL,
  `musteri_adres` varchar(255) DEFAULT NULL,
  `ulke_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`musteri_id`),
  KEY `ulke_idfkk` (`ulke_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `musteri`
--

INSERT INTO `musteri` (`musteri_id`, `musteri_adi`, `musteri_soyadi`, `musteri_tel`, `musteri_email`, `musteri_adres`, `ulke_id`) VALUES
(15, 'Furkan', 'Solak', 543736398, 'furkansolak3456@gmail.com', 'Cetinemec mahalessi mahmut sevket pasa sokak no:7 daire:6', 1),
(16, 'Sevval', 'Elidogru', 534824625, 'se0123@gmail.com', 'burasi neresi mahallesi valla buradayim sokak no:3 daire:3', 2),
(17, 'Berkin', 'Dundar', 585498545, 'BD2003@gmail.com', 'Evsizim mahallesi fukara sokak no:9 daire:2', 6),
(18, 'Emre', 'Uludag', 597846245, 'eu20213@gmail.com', 'çine mahallesi tepeköy sokak no:29 daire:1', 8),
(19, 'Ege ', 'Daskin', 54871351, 'Edg213@gmail.com', 'aydinliyim mahallesi malesef sokak no:5 daire:1', 7),
(20, 'Figen', 'buluc', 87495245, 'FB1973@gmail.com', 'annem mahallesi canim anam sokak no:34 daire:12', 9),
(21, 'Enes ', 'Imam', 58749516, 'imam2077@gmail.com', 'cedin emec mahallesi mahmut sevket pasa sokak no:3 daire:2', 3),
(23, 'Eren ', 'Damar', 764653, 'ed999@gmail.com', 'teleferik mahallesi sakarya cadde no:7 daire:2', 1);

--
-- Tetikleyiciler `musteri`
--
DROP TRIGGER IF EXISTS `yeni_musteri`;
DELIMITER $$
CREATE TRIGGER `yeni_musteri` AFTER INSERT ON `musteri` FOR EACH ROW INSERT INTO yeni_musteri VALUES ((SELECT COUNT(*)FROM musteri), now())
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `yeni_musteri_2`;
DELIMITER $$
CREATE TRIGGER `yeni_musteri_2` AFTER DELETE ON `musteri` FOR EACH ROW INSERT INTO yeni_musteri VALUES ((SELECT COUNT(*)FROM musteri), now())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `siparis`
--

DROP TABLE IF EXISTS `siparis`;
CREATE TABLE IF NOT EXISTS `siparis` (
  `siparis_id` int(11) NOT NULL AUTO_INCREMENT,
  `musteri_id` int(11) DEFAULT NULL,
  `durum_id` int(11) DEFAULT NULL,
  `siparis_tarihi` int(11) DEFAULT NULL,
  PRIMARY KEY (`siparis_id`),
  KEY `musteri_idfk` (`musteri_id`),
  KEY `durum_idfk` (`durum_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `siparis`
--

INSERT INTO `siparis` (`siparis_id`, `musteri_id`, `durum_id`, `siparis_tarihi`) VALUES
(1, 17, 5, 2021),
(2, 16, 4, 2022),
(3, 20, 2, 2022),
(4, 21, 5, 2016);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `siparisdurumu`
--

DROP TABLE IF EXISTS `siparisdurumu`;
CREATE TABLE IF NOT EXISTS `siparisdurumu` (
  `durum_id` int(11) NOT NULL AUTO_INCREMENT,
  `durum_adi` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`durum_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `siparisdurumu`
--

INSERT INTO `siparisdurumu` (`durum_id`, `durum_adi`) VALUES
(1, 'Hazirlaniyor'),
(2, 'Cikis Verildi'),
(3, 'Kargoda'),
(4, 'Dagitimda'),
(5, 'Teslim edildi');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ulke`
--

DROP TABLE IF EXISTS `ulke`;
CREATE TABLE IF NOT EXISTS `ulke` (
  `ulke_id` int(11) NOT NULL AUTO_INCREMENT,
  `ulke_adi` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ulke_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `ulke`
--

INSERT INTO `ulke` (`ulke_id`, `ulke_adi`) VALUES
(1, 'Turkiye'),
(2, 'Amerika '),
(3, 'Kanada'),
(4, 'Rusya '),
(5, 'Hollanda'),
(6, 'Azerbaycan'),
(7, 'Ingiltere'),
(8, 'Almanya'),
(9, 'Japonya');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ureticifirma`
--

DROP TABLE IF EXISTS `ureticifirma`;
CREATE TABLE IF NOT EXISTS `ureticifirma` (
  `firma_id` int(11) NOT NULL AUTO_INCREMENT,
  `ulke_id` int(11) DEFAULT NULL,
  `firma_adi` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`firma_id`),
  KEY `ulke_idfk` (`ulke_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `ureticifirma`
--

INSERT INTO `ureticifirma` (`firma_id`, `ulke_id`, `firma_adi`) VALUES
(1, 1, 'Kozmos'),
(2, 2, 'Fender'),
(3, 2, 'Gibson'),
(4, 2, 'Jackson'),
(5, 7, 'Marshall'),
(6, 9, 'Kawai'),
(7, 7, 'Essex '),
(8, 7, 'Steinway & Sons'),
(9, 9, 'Casio'),
(10, 2, 'Donner '),
(11, 7, 'Capable'),
(12, 9, 'Yamaha'),
(13, 7, 'Blackstar'),
(14, 2, 'Stentor'),
(15, 8, 'Rösler'),
(16, 5, 'Amati'),
(17, 9, 'Bohemia '),
(18, 3, 'Donner'),
(19, 7, 'Gretsch Renown'),
(20, 2, 'Focusrite'),
(21, 5, 'Mackie Onyx'),
(22, 4, 'Novation'),
(23, 1, 'Nektar '),
(24, 3, 'Argon Audio '),
(25, 2, 'Hercules '),
(26, 1, 'Doremusic');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `urun`
--

DROP TABLE IF EXISTS `urun`;
CREATE TABLE IF NOT EXISTS `urun` (
  `urun_id` int(11) NOT NULL AUTO_INCREMENT,
  `uretim_yili` int(11) DEFAULT NULL,
  `seri_numarası` int(11) DEFAULT NULL,
  `ensturman_id` int(11) DEFAULT NULL,
  `ulke_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`urun_id`),
  KEY `ulke_iddfk` (`ulke_id`),
  KEY `ensturman_iddfk` (`ensturman_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `urun`
--

INSERT INTO `urun` (`urun_id`, `uretim_yili`, `seri_numarası`, `ensturman_id`, `ulke_id`) VALUES
(1, 2019, 123123, 1, 2),
(2, 2020, 12341234, 2, 4),
(3, 2017, 1234123, 3, 3),
(4, 2014, 1234123, 4, 7),
(5, 2022, 43215, 5, 9),
(6, 2010, 544536, 6, 9),
(7, 2011, 151323, 7, 3),
(8, 2000, 19467, 8, 9),
(9, 2003, 74568, 9, 5),
(10, 2002, 467234, 10, 2),
(11, 2005, 82347, 11, 2),
(12, 2003, 67346, 12, 8),
(13, 2006, 71235, 13, 1),
(14, 2020, 87234, 14, 9),
(15, 2000, 63543, 15, 8),
(16, 2009, 151321, 16, 1),
(17, 2001, 521321, 17, 1),
(18, 2002, 12372, 18, 1),
(19, 2001, 9048, 19, 3),
(20, 2007, 4535, 20, 4),
(21, 2004, 73421, 21, 6),
(22, 2015, 252089, 27, 5),
(23, 2000, 65472, 28, 6),
(24, 2022, 9456, 29, 8),
(25, 2018, 74785, 30, 8),
(26, 2021, 3471, 31, 3),
(27, 2022, 8234, 32, 1),
(28, 2009, 56372, 33, 4),
(29, 2003, 75834, 34, 9),
(30, 2001, 9235, 35, 7),
(31, 2005, 45305, 36, 3),
(32, 2018, 7948, 37, 7),
(33, 2003, 74544, 38, 1),
(34, 2015, 85454, 39, 3),
(35, 2019, 72624, 40, 3),
(36, 2022, 8234, 41, 9),
(37, 2019, 89248, 42, 5),
(38, 2018, 94534, 43, 5),
(39, 2011, 3457, 44, 9),
(40, 2000, 7593, 45, 4),
(41, 2021, 83354, 46, 3),
(42, 2004, 8445376, 52, 6),
(43, 2005, 843255, 53, 7),
(44, 2000, 81235, 54, 1),
(45, 2005, 737429, 55, 7),
(46, 2006, 24754, 56, 3),
(47, 2007, 59505, 61, 2),
(48, 2008, 7743, 62, 7),
(49, 2009, 32753, 63, 8),
(50, 2010, 457224, 64, 9),
(51, 2011, 934534, 74, 2),
(52, 2012, 82301, 75, 8),
(53, 2013, 83428923, 76, 1),
(54, 2014, 9878623, 77, 7),
(55, 2015, 8687654, 78, 4),
(56, 2016, 95025, 79, 3),
(57, 2017, 909025, 80, 7),
(58, 2018, 532072, 81, 9),
(59, 2019, 1124146, 82, 4),
(60, 2020, 220292, 83, 8),
(61, 2021, 3302343, 84, 2),
(62, 2022, 4456345, 85, 1),
(63, 2001, 5565567, 86, 8),
(64, 2002, 6668486, 87, 1);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `urun_siparis`
--

DROP TABLE IF EXISTS `urun_siparis`;
CREATE TABLE IF NOT EXISTS `urun_siparis` (
  `urunsiparis_id` int(11) NOT NULL AUTO_INCREMENT,
  `siparis_id` int(11) DEFAULT NULL,
  `urun_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`urunsiparis_id`),
  KEY `siparis_idfk` (`siparis_id`),
  KEY `urun_idfk` (`urun_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `urun_siparis`
--

INSERT INTO `urun_siparis` (`urunsiparis_id`, `siparis_id`, `urun_id`) VALUES
(1, 1, 15),
(2, 2, 11),
(3, 3, 7),
(4, 4, 31);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yeni_musteri`
--

DROP TABLE IF EXISTS `yeni_musteri`;
CREATE TABLE IF NOT EXISTS `yeni_musteri` (
  `musteri_sayisi` int(11) DEFAULT NULL,
  `guncelleme_tarihi` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `yeni_musteri`
--

INSERT INTO `yeni_musteri` (`musteri_sayisi`, `guncelleme_tarihi`) VALUES
(8, '2022-12-18 15:44:46');

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `ensturman`
--
ALTER TABLE `ensturman`
  ADD CONSTRAINT `firma_idfk` FOREIGN KEY (`firma_id`) REFERENCES `ureticifirma` (`firma_id`),
  ADD CONSTRAINT `kadagori_idfk` FOREIGN KEY (`katagori_id`) REFERENCES `katagori` (`katagori_id`);

--
-- Tablo kısıtlamaları `musteri`
--
ALTER TABLE `musteri`
  ADD CONSTRAINT `ulke_idfkk` FOREIGN KEY (`ulke_id`) REFERENCES `ulke` (`ulke_id`);

--
-- Tablo kısıtlamaları `siparis`
--
ALTER TABLE `siparis`
  ADD CONSTRAINT `durum_idfk` FOREIGN KEY (`durum_id`) REFERENCES `siparisdurumu` (`durum_id`),
  ADD CONSTRAINT `musteri_idfk` FOREIGN KEY (`musteri_id`) REFERENCES `musteri` (`musteri_id`);

--
-- Tablo kısıtlamaları `ureticifirma`
--
ALTER TABLE `ureticifirma`
  ADD CONSTRAINT `ulke_idfk` FOREIGN KEY (`ulke_id`) REFERENCES `ulke` (`ulke_id`);

--
-- Tablo kısıtlamaları `urun`
--
ALTER TABLE `urun`
  ADD CONSTRAINT `ensturman_iddfk` FOREIGN KEY (`ensturman_id`) REFERENCES `ensturman` (`ensturman_id`),
  ADD CONSTRAINT `ulke_iddfk` FOREIGN KEY (`ulke_id`) REFERENCES `ulke` (`ulke_id`);

--
-- Tablo kısıtlamaları `urun_siparis`
--
ALTER TABLE `urun_siparis`
  ADD CONSTRAINT `siparis_idfk` FOREIGN KEY (`siparis_id`) REFERENCES `siparis` (`siparis_id`),
  ADD CONSTRAINT `urun_idfk` FOREIGN KEY (`urun_id`) REFERENCES `urun` (`urun_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;