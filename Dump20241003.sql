CREATE DATABASE  IF NOT EXISTS `swp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `swp`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: swp
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `rated_star` int DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `service_id` int DEFAULT NULL,
  `image_link` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `service_id` (`service_id`) USING BTREE,
  KEY `feedback_status_setting_idx` (`status_id`) USING BTREE,
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `feedback_status_setting` FOREIGN KEY (`status_id`) REFERENCES `setting` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (12,'Giang',1,'giangtthe153299@fpt.edu.vn','0974484610',5,'none',1,'assets/images/default-image.jpg',28),(13,'Delilah Underwood',0,'commodo@metus.org','09 8754 0232',2,'mauris a nunc. In at pede. Cras vulputate velit eu',8,'assets/images/default-image.jpg',28),(14,'Nerea Horne',1,'faucibus@metusAenean.net','00 5295 0037',3,'auctor velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis',6,'assets/images/default-image.jpg',29),(15,'Fulton Owens',1,'scelerisque@Namacnulla.net','01 7856 3576',2,'molestie in, tempus eu, ligula. Aenean euismod mauris eu elit.',12,'assets/images/default-image.jpg',28),(16,'Yvonne Gordon',0,'dolor.quam@sem.edu','01 8360 3310',3,'justo faucibus lectus, a sollicitudin orci sem eget massa. Suspendisse',12,'assets/images/default-image.jpg',29),(17,'Jayme Cortez',0,'tellus@ac.ca','03 2503 7106',0,'Nunc lectus pede, ultrices a, auctor non, feugiat nec, diam.',10,'assets/images/default-image.jpg',29),(18,'Meredith Reyes',1,'velit.in@porttitorinterdumSed.edu','02 1243 7697',0,'consequat auctor, nunc nulla vulputate dui, nec tempus mauris erat',9,'assets/images/default-image.jpg',28),(19,'Jacqueline Cardenas',0,'at.egestas.a@et.edu','07 9374 2511',0,'nonummy ipsum non arcu. Vivamus sit amet risus. Donec egestas.',12,'assets/images/default-image.jpg',29),(20,'Jeremy Browning',0,'sagittis@risus.com','05 3470 5729',1,'Proin sed turpis nec mauris blandit mattis. Cras eget nisi',2,'assets/images/default-image.jpg',29),(21,'Uma Maxwell',0,'Donec.nibh@elementum.org','06 2257 5408',2,'vel sapien imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque tincidunt',2,'assets/images/default-image.jpg',29),(22,'Timon Griffith',0,'feugiat.nec.diam@risus.org','03 6679 4440',3,'orci tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam ornare, libero',6,'assets/images/default-image.jpg',29),(23,'Kareem Rodriguez',0,'ornare@lectusCum.org','01 6085 5294',5,'molestie. Sed id risus quis diam luctus lobortis. Class aptent',4,'assets/images/default-image.jpg',29),(24,'Lev Gay',0,'Mauris.vestibulum@Namtempordiam.edu','08 9545 4597',5,'Quisque ac libero nec ligula consectetuer rhoncus. Nullam velit dui,',8,'assets/images/default-image.jpg',29),(25,'Phyllis Sloan',0,'neque@antedictumcursus.ca','00 0400 8770',2,'magnis dis parturient montes, nascetur ridiculus mus. Donec dignissim magna',7,'assets/images/default-image.jpg',28),(26,'Rina Morse',0,'feugiat.nec@euligulaAenean.co.uk','00 2234 3983',1,'ullamcorper viverra. Maecenas iaculis aliquet diam. Sed diam lorem, auctor',5,'assets/images/default-image.jpg',29),(27,'Mufutau Burris',1,'penatibus@Quisqueimperdiet.org','09 3185 3800',3,'pede. Cum sociis natoque penatibus et magnis dis parturient montes,',1,'assets/images/default-image.jpg',28),(28,'Kadeem Tyson',0,'non@ac.com','08 5687 9917',4,'a sollicitudin orci sem eget massa. Suspendisse eleifend. Cras sed',10,'assets/images/default-image.jpg',28),(29,'Ori Frost',0,'dui.Suspendisse.ac@ipsum.co.uk','09 7453 3992',1,'Fusce mollis. Duis sit amet diam eu dolor egestas rhoncus.',4,'assets/images/default-image.jpg',28),(30,'Arden Montgomery',1,'facilisis@velitjusto.edu','05 9563 1428',0,'pharetra sed, hendrerit a, arcu. Sed et libero. Proin mi.',10,'assets/images/default-image.jpg',28),(31,'Hedwig Abbott',1,'aliquet.sem.ut@lobortismauris.edu','01 1120 3457',3,'ligula. Nullam feugiat placerat velit. Quisque varius. Nam porttitor scelerisque',2,'assets/images/default-image.jpg',28),(32,'Andrew Burns',0,'nec.tempus.scelerisque@magnatellus.co.uk','02 6560 7989',3,'in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla',1,'assets/images/default-image.jpg',28),(33,'Levi Houston',1,'morbi.tristique.senectus@Quisqueliberolacus.com','01 2684 2134',5,'et nunc. Quisque ornare tortor at risus. Nunc ac sem',4,'assets/images/default-image.jpg',29),(34,'Britanni Stanton',1,'felis.adipiscing.fringilla@aliquet.co.uk','00 5204 3641',1,'tortor. Nunc commodo auctor velit. Aliquam nisl. Nulla eu neque',7,'assets/images/default-image.jpg',28),(35,'Aidan Black',1,'taciti.sociosqu.ad@ipsum.org','02 8134 2602',5,'dictum sapien. Aenean massa. Integer vitae nibh. Donec est mauris,',4,'assets/images/default-image.jpg',29),(36,'Bruce Bradshaw',0,'mi.eleifend@molestie.edu','05 0788 0928',3,'malesuada fames ac turpis egestas. Fusce aliquet magna a neque.',6,'assets/images/default-image.jpg',29),(37,'Abdul Davenport',0,'Nulla@cursusinhendrerit.com','06 0994 8786',0,'non, luctus sit amet, faucibus ut, nulla. Cras eu tellus',10,'assets/images/default-image.jpg',28),(38,'Camille Guzman',0,'Vestibulum@suscipitestac.org','08 7350 2381',5,'vulputate, risus a ultricies adipiscing, enim mi tempor lorem, eget',3,'assets/images/default-image.jpg',29),(39,'Sean Alford',1,'nibh@ornaresagittisfelis.com','07 8936 7303',1,'Etiam ligula tortor, dictum eu, placerat eget, venenatis a, magna.',11,'assets/images/default-image.jpg',29),(40,'Adam Compton',0,'non.vestibulum@Aenean.org','01 7527 0414',2,'venenatis vel, faucibus id, libero. Donec consectetuer mauris id sapien.',7,'assets/images/default-image.jpg',28),(41,'Randall Moore',0,'nisi@consequat.ca','05 9223 8473',1,'vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros',6,'assets/images/default-image.jpg',29),(42,'Boris Bowers',0,'velit@elitpellentesquea.edu','01 7809 7435',1,'scelerisque scelerisque dui. Suspendisse ac metus vitae velit egestas lacinia.',2,'assets/images/default-image.jpg',29),(43,'Kennedy Brady',0,'vitae.semper@vehiculaPellentesquetincidunt.com','07 2817 5162',3,'lectus rutrum urna, nec luctus felis purus ac tellus. Suspendisse',8,'assets/images/default-image.jpg',29),(44,'Emmanuel Nielsen',0,'senectus.et.netus@pedenonummy.edu','06 2329 1023',4,'nulla. Integer vulputate, risus a ultricies adipiscing, enim mi tempor',12,'assets/images/default-image.jpg',28),(45,'Jocelyn Rosales',0,'tempus.mauris.erat@metussitamet.ca','06 3173 8876',5,'lacinia. Sed congue, elit sed consequat auctor, nunc nulla vulputate',5,'assets/images/default-image.jpg',28),(46,'Karleigh Rocha',1,'blandit.viverra.Donec@amalesuada.com','00 0546 9746',2,'risus. Nunc ac sem ut dolor dapibus gravida. Aliquam tincidunt,',11,'assets/images/default-image.jpg',29),(47,'Jane Kinney',1,'sit.amet@aliquetnecimperdiet.net','02 3824 2301',3,'ornare, libero at auctor ullamcorper, nisl arcu iaculis enim, sit',7,'assets/images/default-image.jpg',29),(48,'Omar Lopez',0,'ante@nequesedsem.net','07 5094 7203',1,'tempus non, lacinia at, iaculis quis, pede. Praesent eu dui.',2,'assets/images/default-image.jpg',28),(49,'Craig Bass',0,'magna@augueSed.org','01 2853 9006',2,'dui augue eu tellus. Phasellus elit pede, malesuada vel, venenatis',1,'assets/images/default-image.jpg',28),(50,'Gage Durham',0,'elementum@consectetueradipiscingelit.edu','06 8824 0771',5,'eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum',6,'assets/images/default-image.jpg',29),(51,'Amber Klein',0,'In.lorem@bibendum.net','02 1261 1644',5,'pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper,',10,'assets/images/default-image.jpg',29),(52,'Cheyenne Mcleod',1,'eu@blanditatnisi.org','07 2322 6833',2,'aliquet, sem ut cursus luctus, ipsum leo elementum sem, vitae',8,'assets/images/default-image.jpg',29),(53,'Zane Harmon',0,'amet.ornare@nislNulla.net','09 8510 7124',1,'in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris',9,'assets/images/default-image.jpg',29),(54,'Shaine Lyons',0,'erat.neque.non@sedturpisnec.edu','04 9713 2672',5,'sit amet, risus. Donec nibh enim, gravida sit amet, dapibus',2,'assets/images/default-image.jpg',28),(55,'Miriam Whitehead',0,'mauris.ipsum@uterat.ca','03 0608 0834',5,'penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec',3,'assets/images/default-image.jpg',29),(56,'John Short',0,'at.nisi@Etiamlaoreetlibero.co.uk','04 1939 4122',5,'euismod et, commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur',7,'assets/images/default-image.jpg',28),(57,'Joelle Guthrie',1,'dis@incursuset.org','00 9021 9580',4,'mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam',9,'assets/images/default-image.jpg',28),(58,'Clark Hickman',1,'Nunc.commodo.auctor@Sedid.net','05 0559 1071',1,'tempor bibendum. Donec felis orci, adipiscing non, luctus sit amet,',5,'assets/images/default-image.jpg',28),(59,'Nolan Stokes',0,'facilisis@ipsumSuspendisse.net','07 0415 8554',5,'placerat eget, venenatis a, magna. Lorem ipsum dolor sit amet,',4,'assets/images/default-image.jpg',29),(60,'Carla Pruitt',1,'eu.metus.In@pretiumnequeMorbi.edu','06 3619 2227',5,'Sed nunc est, mollis non, cursus non, egestas a, dui.',11,'assets/images/default-image.jpg',28),(61,'Lee Hebert',1,'urna@consequatpurusMaecenas.com','07 9272 7607',1,'ornare, facilisis eget, ipsum. Donec sollicitudin adipiscing ligula. Aenean gravida',5,'assets/images/default-image.jpg',29),(62,'Chaney Mayo',0,'feugiat.Lorem@turpisNulla.org','08 1721 0826',5,'erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse',8,'assets/images/default-image.jpg',29),(63,'Amir Leblanc',0,'ad.litora.torquent@sitametmassa.ca','02 5320 2387',4,'nunc id enim. Curabitur massa. Vestibulum accumsan neque et nunc.',2,'assets/images/default-image.jpg',28),(64,'Eugenia Simpson',0,'risus.varius@vitaemaurissit.net','06 0220 1819',1,'sed sem egestas blandit. Nam nulla magna, malesuada vel, convallis',11,'assets/images/default-image.jpg',29),(65,'Perry Barnes',1,'dolor@Cras.net','09 9834 1823',3,'ut lacus. Nulla tincidunt, neque vitae semper egestas, urna justo',6,'assets/images/default-image.jpg',28),(66,'Jackson Calderon',0,'augue.Sed.molestie@duiFuscealiquam.com','09 0104 8954',1,'orci, in consequat enim diam vel arcu. Curabitur ut odio',6,'assets/images/default-image.jpg',29),(67,'Solomon Nicholson',1,'semper.Nam.tempor@dolorsitamet.com','02 9596 7077',1,'Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci.',11,'assets/images/default-image.jpg',29),(68,'Oleg Graves',0,'et@ultricessit.edu','08 4910 0200',3,'a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu.',3,'assets/images/default-image.jpg',28),(69,'Zachary Hanson',1,'eget.odio@elementumsemvitae.co.uk','08 1665 8322',2,'Fusce aliquet magna a neque. Nullam ut nisi a odio',9,'assets/images/default-image.jpg',29),(70,'Paul Bean',0,'Vivamus@nonummyultricies.com','06 3510 3829',3,'ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam',2,'assets/images/default-image.jpg',29),(71,'Wing Lambert',1,'Phasellus.dolor@nonsollicitudina.com','01 5593 0902',4,'quis accumsan convallis, ante lectus convallis est, vitae sodales nisi',2,'assets/images/default-image.jpg',29),(72,'Knox Bridges',0,'Integer.eu@vel.com','05 0089 7893',3,'magna tellus faucibus leo, in lobortis tellus justo sit amet',1,'assets/images/default-image.jpg',29),(73,'Diana Compton',1,'Vivamus@velmauris.org','09 3708 0928',5,'scelerisque scelerisque dui. Suspendisse ac metus vitae velit egestas lacinia.',4,'assets/images/default-image.jpg',29),(74,'Dale Dean',1,'habitant.morbi@Naminterdumenim.edu','09 1667 7786',1,'nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus',1,'assets/images/default-image.jpg',29),(75,'Dale Downs',1,'egestas.Aliquam.fringilla@Pellentesque.ca','06 6896 3903',4,'Nullam nisl. Maecenas malesuada fringilla est. Mauris eu turpis. Nulla',9,'assets/images/default-image.jpg',29),(76,'Leigh Harrison',0,'Donec.dignissim.magna@turpisegestasFusce.edu','04 1264 6046',5,'eleifend non, dapibus rutrum, justo. Praesent luctus. Curabitur egestas nunc',4,'assets/images/default-image.jpg',29),(77,'Simone Barker',0,'Proin@eratvolutpatNulla.ca','00 1615 2379',1,'a nunc. In at pede. Cras vulputate velit eu sem.',12,'assets/images/default-image.jpg',28),(78,'Summer Terry',1,'Quisque.nonummy.ipsum@AeneanmassaInteger.edu','03 8827 2638',4,'nec, leo. Morbi neque tellus, imperdiet non, vestibulum nec, euismod',10,'assets/images/default-image.jpg',29),(79,'Melvin Ryan',1,'convallis@Nullafacilisi.ca','03 2538 2282',3,'in magna. Phasellus dolor elit, pellentesque a, facilisis non, bibendum',2,'assets/images/default-image.jpg',29),(80,'Griffin Mendez',1,'eget@hendrerita.ca','02 3245 1005',5,'urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante ipsum',4,'assets/images/default-image.jpg',29),(81,'Prescott Parks',0,'turpis.nec.mauris@ac.com','09 9683 6679',2,'bibendum. Donec felis orci, adipiscing non, luctus sit amet, faucibus',11,'assets/images/default-image.jpg',28),(82,'Emmanuel Hensley',0,'diam@Integer.net','08 9737 5159',1,'consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem,',11,'assets/images/default-image.jpg',29),(83,'Ann Solis',1,'facilisis.facilisis@egettinciduntdui.net','03 4427 4523',0,'Integer sem elit, pharetra ut, pharetra sed, hendrerit a, arcu.',6,'assets/images/default-image.jpg',29),(84,'Quentin Schroeder',1,'convallis.ligula@semconsequatnec.org','04 8431 5779',4,'neque sed dictum eleifend, nunc risus varius orci, in consequat',11,'assets/images/default-image.jpg',28),(85,'Owen Melton',0,'mollis@metusvitae.edu','05 0241 8785',1,'mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean',1,'assets/images/default-image.jpg',28),(86,'Violet Whitaker',0,'sed.hendrerit.a@malesuadafamesac.edu','09 7228 7274',0,'tincidunt orci quis lectus. Nullam suscipit, est ac facilisis facilisis,',12,'assets/images/default-image.jpg',28),(87,'Karina Greene',0,'dolor.sit@nonenim.org','08 5813 3822',5,'tristique pellentesque, tellus sem mollis dui, in sodales elit erat',4,'assets/images/default-image.jpg',29),(88,'Elaine Parker',0,'elit@semNulla.co.uk','09 0371 0487',3,'aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam',3,'assets/images/default-image.jpg',29),(89,'Eden Moss',1,'luctus@malesuadafames.org','04 6154 6509',3,'tristique pellentesque, tellus sem mollis dui, in sodales elit erat',6,'assets/images/default-image.jpg',28),(90,'Guy Benjamin',0,'Aliquam@molestieSedid.org','00 2732 7477',1,'gravida nunc sed pede. Cum sociis natoque penatibus et magnis',4,'assets/images/default-image.jpg',29),(91,'Dennis Stewart',1,'Donec@Pellentesquehabitant.com','08 3524 1498',1,'Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque',8,'assets/images/default-image.jpg',29),(92,'Alden Shelton',0,'elit.Nulla@Seddiam.net','01 9321 1930',1,'aliquet. Phasellus fermentum convallis ligula. Donec luctus aliquet odio. Etiam',1,'assets/images/default-image.jpg',29),(93,'Dora Hooper',1,'facilisi.Sed@necante.com','07 6210 7120',5,'odio, auctor vitae, aliquet nec, imperdiet nec, leo. Morbi neque',6,'assets/images/default-image.jpg',29),(94,'Marsden Sparks',0,'laoreet.lectus.quis@gravidasagittis.edu','00 0026 6624',0,'Nullam enim. Sed nulla ante, iaculis nec, eleifend non, dapibus',11,'assets/images/default-image.jpg',29),(95,'Hunter Kinney',1,'lectus.Cum@auctor.net','08 2750 1928',2,'pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero',6,'assets/images/default-image.jpg',28),(96,'Kevin Hubbard',1,'interdum.enim.non@gravidaPraesenteu.ca','07 8925 9579',4,'in sodales elit erat vitae risus. Duis a mi fringilla',10,'assets/images/default-image.jpg',28),(97,'Jaime Conway',0,'cursus.in.hendrerit@metus.edu','01 1302 1642',2,'euismod et, commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur',9,'assets/images/default-image.jpg',28),(98,'Finn Whitley',0,'mattis@acsemut.com','06 8509 1573',4,'massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper, velit',2,'assets/images/default-image.jpg',29),(99,'Katell Pruitt',0,'amet.consectetuer@fermentummetus.net','03 7921 3786',1,'Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit,',8,'assets/images/default-image.jpg',28),(100,'Savannah Sosa',1,'adipiscing.elit@sitamet.net','03 9335 9027',1,'enim. Sed nulla ante, iaculis nec, eleifend non, dapibus rutrum,',5,'assets/images/default-image.jpg',28),(101,'Jakeem Sawyer',0,'convallis.est.vitae@dolortempus.edu','01 9694 1487',5,'placerat, augue. Sed molestie. Sed id risus quis diam luctus',9,'#',29),(102,'Chase Walters',1,'est.ac@massa.ca','00 2630 2770',3,'eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum',9,'#',28),(103,'Giselle Tyler',0,'commodo@elementumsem.co.uk','02 8580 3956',2,'inceptos hymenaeos. Mauris ut quam vel sapien imperdiet ornare. In',10,'#',28),(104,'Quamar Swanson',0,'nostra.per@sociisnatoque.com','05 9469 0665',2,'Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in aliquet lobortis,',8,'#',28),(105,'Devin Holmes',0,'semper.erat@sedsapienNunc.ca','08 4917 3114',0,'Sed nunc est, mollis non, cursus non, egestas a, dui.',3,'#',28),(106,'Deirdre Parker',1,'velit@aaliquetvel.net','08 9491 0964',3,'orci. Phasellus dapibus quam quis diam. Pellentesque habitant morbi tristique',6,'#',28),(107,'Ivory Rodriguez',0,'egestas@egestasnuncsed.org','07 2981 9430',4,'Nunc mauris elit, dictum eu, eleifend nec, malesuada ut, sem.',2,'#',28),(108,'Walter Powell',1,'est.ac.facilisis@pede.net','06 5618 7250',1,'nisi. Mauris nulla. Integer urna. Vivamus molestie dapibus ligula. Aliquam',12,'#',28),(109,'Leo Le',1,'pede.blandit.congue@nonenim.com','07 8903 9931',1,'posuere at, velit. Cras lorem lorem, luctus ut, pellentesque eget,',2,'#',28),(110,'Oprah Wilkins',0,'Nunc.ullamcorper.velit@nunc.co.uk','07 7890 7667',5,'Fusce mollis. Duis sit amet diam eu dolor egestas rhoncus.',8,'#',29),(111,'Ethan Potter',0,'eu.eros.Nam@feugiatSednec.ca','09 1256 6527',0,'vitae semper egestas, urna justo faucibus lectus, a sollicitudin orci',12,'#',28),(112,'Irma Page',0,'hymenaeos.Mauris@diamPellentesquehabitant.co.uk','05 1888 6607',1,'luctus ut, pellentesque eget, dictum placerat, augue. Sed molestie. Sed',8,'#',28);
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_examination`
--

DROP TABLE IF EXISTS `medical_examination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_examination` (
  `reservation_id` int NOT NULL,
  `service_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `prescription` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`reservation_id`,`service_id`,`receiver_id`) USING BTREE,
  KEY `fk_service_exam` (`service_id`) USING BTREE,
  KEY `fk_recicever_exam` (`receiver_id`) USING BTREE,
  CONSTRAINT `fk_recicever_exam` FOREIGN KEY (`receiver_id`) REFERENCES `receiver` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_reservation_exam` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_service_exam` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_examination`
--

LOCK TABLES `medical_examination` WRITE;
/*!40000 ALTER TABLE `medical_examination` DISABLE KEYS */;
INSERT INTO `medical_examination` VALUES (18,4,16,'Three time a day'),(18,4,17,' 3 times a day'),(18,4,18,'Should come back to hospital'),(18,11,19,'3 times a day'),(18,11,20,'2 times a day');
/*!40000 ALTER TABLE `medical_examination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `password_reset_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `updated_date` datetime DEFAULT NULL,
  `featured` tinyint(1) DEFAULT NULL,
  `thumbnail_link` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `author_id` (`author_id`) USING BTREE,
  KEY `post_status_setting_fk_idx` (`status_id`) USING BTREE,
  CONSTRAINT `post_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `post_status_setting_fk` FOREIGN KEY (`status_id`) REFERENCES `setting` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (32,'<blockquote>\r\n<p>This is a quote from a famous person</p>\r\n</blockquote>\r\n\r\n<p>FRESNO, Calif. &mdash; On a Tuesday afternoon in April, among tables of vegetables, clothes and telephone chargers at Fresno&rsquo;s biggest outdoor flea market were prescription drugs being sold as treatments for Covid. Vendors sold $25 injections of the steroid dexamethasone, several kinds of antibiotics and the anti-parasitic drug ivermectin. Chloroquine and hydroxychloroquine &mdash; the malaria drugs pushed by President Donald J. Trump last year &mdash; make regular appearances at the market as well, as do sham herbal supplements. Health and consumer protection agencies have repeatedly warned that several of these treatments, as well as vitamin infusions and expensive injections of &ldquo;peptide therapies&rdquo; sold at alternative wellness clinics for more than $1,000, are not supported by reliable scientific evidence. But such unproven remedies, often promoted by doctors and companies on social media, have appealed to many people in low-income immigrant communities in places across the country where Covid-19 rates have been high but access to health care is low.</p>\r\n\r\n<p>Some turn to unregulated drugs because mainstream medicine is too expensive or is inaccessible because of language or cultural barriers. &quot;It&rsquo;s disappointing but not surprising&rdquo; that people living below the poverty line have spent large sums of money for unproven treatments for Covid-19, said Rais Vohra, the interim head of Fresno County&rsquo;s health department. &ldquo;People are desperate and bombarded with misinformation and may not have the skills, time or context to interpret medical evidence.&rdquo;</p>\r\n','Shut out from mainstream medicine, some immigrants are buying expensive, unproven Covid therapies from wellness clinics or turning to the black market.','2021-07-24 23:08:52',1,'./img/blog1.jpg',3,5,24,'Desperate for covid care, immigrants are struggling to find cure'),(33,'A study published in the Multiple Sclerosis Journal found that prospective MS patients often had an increased frequency of hospital/GP visits up to 5 years before a clinical diagnosis for their MS symptoms. As with many diseases, the prodromal (pre-symptomatic) stage of disease may or may not come with any noticeable symptoms. However, there may be additional signs which may present during this stage that could be important features associated with the onset of disease-related symptoms in the months or years to come. According to their findings, hospital, and GP visits for 2-4x higher in the prodromal 5 years before MS diagnoses compared to healthy controls. Interestingly, these were specific for conditions related to the sensory organs, the musculoskeletal system, and the genito-urinary system. In addition, people who developed MS had 50% more physician visits for mental health and cognitive related issues (including mood and anxiety disorders) in the 5 years before their symptoms or diagnoses compared to controls, with prescriptions for antidepressants being common, as well as prescriptions for antibiotics.','Talk of \'gain-of-function\' research, a muddy category at best, brings up deep questions about how scientists should study viruses and other pathogens.','2021-07-24 17:26:33',1,'./img/blog2.jpg',3,6,25,'Fight Over Covid\'s Origins Renews Debate on Risks of Lab Work'),(34,'Getting an early diagnosis for multiple sclerosis (MS) is important in ensuring better long-term outcomes and quality of life. The challenge, however, is that getting an early diagnosis for MS is challenging and diagnoses are currently made in advanced disease stages. MS varies considerably between patients depending on the type and the parts of the body affected. Many of the symptoms of MS can also be associated with other disorders often complicating diagnoses. However, some of the most common symptoms include fatigue, pain, problems with walking or holding items, numbness or tingling in various parts of the body, problems with vision, issues with balance and coordination, bladder/bowel/sexual problems as well as some degree of cognitive disturbances. The most common type of MS (around 80% of all cases) is relapse remitting MS in which there are episodes of existing or new symptoms which worsen over days or weeks/months (relapse) and episodes of slow recovery over time (remitting). However, as the disease progresses over many years, the condition becomes progressively worse (secondary progressive MS). Around 10% of all cases are primary progressive MS cases where symptoms gradually become worse from onset without any remission.','Organisers are to decide as soon as Monday whether to allow domestic spectators into the stadiums for the Games, which were delayed by a year due to the pandemic and now set to start in about a month. Foreign spectators have already been banned.','2021-06-22 00:47:44',1,'./img/blog3.jpg',3,7,25,'Olympics venue medical officers want no spectators amid COVID-19 fears'),(35,'<p>As opioid overdose deaths rose during the COVID-19 pandemic, people seeking treatment for opioid addiction had to wait nearly twice as long to begin methadone treatment in the United States than in Canada, a new Yale study has shown.</p><p>In both countries during the pandemic, about one in 10 methadone clinics were not accepting new patients and a third of those cited COVID-19 as the reason, according to research published July 23 in the journal <em>JAMA Network Open</em>.</p><p>The findings highlight shortcomings providing prompt access to people seeking treatment for opioid addiction, the authors say.</p>','With summer in full swing and excessive heat waves rolling through parts of the country, taking a dip in water can be a refreshing way to cool off.','2021-07-24 23:12:16',1,'./img/blog4.jpg',3,8,25,'What to do to stay safe around water this summer at the pool or beach'),(36,'Whilst the industry continues to focus on the development of vaccines and therapies in response to COVID-19, the crisis has had a considerable impact on clinical trials in other therapy areas, particularly on cardiovascular, dermatology and metabolic. Even though significant regulatory agencies, such as the FDA and EMEA, have promoted guidelines and measures for maintaining the integrity of the trials that attempt to guarantee the rights, safety and wellbeing of patients and healthcare staff during this COVID-19 pandemic, maintaining clinical trials and keeping them on track has been severely challenging.','No Description','2021-06-22 00:47:44',0,'./img/blog5.jpg',3,5,24,'Pre-COVID-19 vs post-COVID-19 – clinical trial challenges revealed'),(37,'Do you think you\'re living an ordinary life? You are so mistaken it\'s difficult to even explain. The mere fact that you exist makes you extraordinary. The odds of you existing are less than winning the lottery, but here you are. Are you going to let this extraordinary opportunity pass?\r\nShe had come to the conclusion that you could tell a lot about a person by their ears. The way they stuck out and the size of the earlobes could give you wonderful insights into the person. Of course, she couldn\'t scientifically prove any of this, but that didn\'t matter to her. Before anything else, she would size up the ears of the person she was talking to.\r\nIt\'s always good to bring a slower friend with you on a hike. If you happen to come across bears, the whole group doesn\'t have to worry. Only the slowest in the group do. That was the lesson they were about to learn that day.','Recent events have only reinforced the frailty of our existence as well as a collective responsibility to help one another.','2021-06-22 00:47:44',1,'./img/blog6.jpg',3,6,25,'Study reflects shortcomings in how the U.S. handles care for people with opioid addiction'),(39,'\"It was so great to hear from you today and it was such weird timing,\" he said. \"This is going to sound funny and a little strange, but you were in a dream I had just a couple of days ago. I\'d love to get together and tell you about it if you\'re up for a cup of coffee,\" he continued, laying the trap he\'d been planning for years.\r\nColors bounced around in her head. They mixed and threaded themselves together. Even colors that had no business being together. They were all one, yet distinctly separate at the same time. How was she going to explain this to the others?','Whilst expected, there is no guarantee when another pandemic will hit again or what the impact would look like.','2021-06-22 00:58:56',1,'./img/blog7.jpg',3,6,25,'Study finds unacceptable mental health service shortfalls for children in high-income countries'),(42,'Researchers found that of the one in eight children (12.7 per cent) who experience a mental disorder, less than half (44.2 per cent) receive any services for these conditions.  Using systematic review methods, the researchers examined 14 prevalence surveys conducted in 11 high-income countries that included a total of 61,545 children aged four to 18 years. Eight of the 14 studies also assessed service contacts. The 14 surveys were conducted between 2003 and 2020 in Canada as well as the US, Australia, Chile, Denmark, Great Britain, Israel, Lithuania, Norway, South Korea and Taiwan. Researchers note that mental health service provision lags behind services available to treat physical conditions in most of these countries. \"We would not find it acceptable to treat only 44 per cent of children who had cancer or diabetes or infectious diseases,\" says Waddell.','Most children with a mental health disorder are not receiving services to address their needs--according to a new study from researchers at Simon Fraser University\'s Children\'s Health Policy Centre.','2021-06-22 00:47:44',1,'./img/blog8.jpg',3,7,25,'Study finds unacceptable mental health service shortfalls for children in high-income countries'),(43,'Glaucoma results from irreversible neurodegeneration of the optic nerve, the bundle of axons from retinal ganglion cells that transmits signals from the eye to the brain to produce vision. Available therapies slow vision loss by lowering elevated eye pressure, however some glaucoma progresses to blindness despite normal eye pressure. Neuroprotective therapies would be a leap forward, meeting the needs of patients who lack treatment options. The CaMKII (calcium/calmodulin-dependent protein kinase II) pathway regulates key cellular processes and functions throughout the body, including retinal ganglion cells in the eye. Yet the precise role of CaMKII in retinal ganglion cell health is not well understood. Inhibition of CaMKII activity, for example, has been shown to be either protective or detrimental to retinal ganglion cells, depending on the conditions. Using an antibody marker of CaMKII activity, Chen\'s team discovered that CaMKII pathway signaling was compromised whenever retinal ganglion cells were exposed to toxins or trauma from a crush injury to the optic nerve, suggesting a correlation between CaMKII activity and retinal ganglion cell survival. Searching for ways to intervene, they found that activating the CaMKII pathway with gene therapy proved protective to the retinal ganglion cells. Administering the gene therapy to mice just prior to the toxic insult (which initiates rapid damage to the cells), and just after optic nerve crush (which causes slower damage), increased CaMKII activity and robustly protected retinal ganglion cells.','A form of gene therapy protects optic nerve cells and preserves vision in mouse models of glaucoma, according to research supported by NIH\'s National Eye Institute','2021-06-22 00:47:44',1,'./img/blog9.jpg',3,5,24,'Gene therapy protects optic nerve cells and preserves vision in glaucoma mouse models'),(44,'Thus, an increased GP or hospital visit frequency for specific physical conditions in combination with the need for mental health or cognitive referrals may be important prodromal hallmarks of MS. The combination of antidepressants and antibiotic use seems to be highly associated with the prodromal stage of MS – perhaps to treat symptoms not yet recognized as MS before MS is diagnosed. However, there are some important caveats to this study. Firstly, many of these complaints are largely non-exclusive in everyday life, and simply visiting your GP for sensory dysfunction or mental health-related issues is not specific to the prodromal stage of MS. Even the combination of receiving antidepressants and antibiotics whilst having some degree of musculoskeletal dysfunction is not sufficiently an exclusive combination of MS prodrome. However, it does suggest that these combinations may be related to an increased chance of an MS diagnosis within 5 years and assessments for MS at this stage would only benefit the individual – even if it turns out not to be associated with MS.','MS patients who began natalizumab treatment 1-2 years earlier than those who started later displayed a clear and significant improvement in mortality','2021-07-24 23:08:52',1,'./img/blog10.jpg',3,8,25,'multiple sclerosis (MS) is a demyelinating disorder with varying symptoms and progression from person to person'),(45,'As increased optimism surrounded the control of the virus, the impact on life is still to be fully understood. Some forecasts predict grim long-term societal and financial consequences, across several countries. Whilst the tragic loss of life and the impact on the quality of life should not be overlooked, there are positives to come out of this crisis. This article will outline the impact on clinical trials and drug and diagnostic development. However, many parallels with everyday life can be taken into consideration. Strength through adversity is a commonly used aphorism and one which is true of people and industries alike. When confronted with challenges, human inventiveness knows no limits and COVID-19 has been both the mother of innovation but also the catalyst for the widespread adoption of current technologies. Thus, it is of little surprise that the clinical trial market has swiftly adjusted to the new paradigm circumscribed by restrictions on social interaction, by looking to leverage technological solutions.','Whilst pandemics are thankfully not common; COVID-19 has brought with it a profound global impact.','2021-07-24 23:08:52',1,'./img/blog11.jpg',3,6,25,'The impact of COVID-19 on clinical trials');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receiver`
--

DROP TABLE IF EXISTS `receiver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receiver` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `full_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `mobile` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_userid_idx` (`user_id`) USING BTREE,
  CONSTRAINT `FK_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receiver`
--

LOCK TABLES `receiver` WRITE;
/*!40000 ALTER TABLE `receiver` DISABLE KEYS */;
INSERT INTO `receiver` VALUES (16,1,'Giang',1,'0977659677','Vietnam','giangtthe153299@fpt.edu.vn'),(17,-1,'trang',1,'0977659677','Viet nam','tranglvqhe153785@fpt.edu.vn'),(18,-1,'Ha',1,'0977659677','Viet Nam','hattnhe153299@fpt.edu.vn'),(19,-1,'Bo Yates',0,'0977659677','Viet Nam','Fusce@loremipsum.ca'),(20,-1,'Ngoc anh',1,'0977659677','Viet Nam','anhntnhe151378@fpt.edu.vn'),(21,2,'Ha',0,NULL,'Viet Nam','hattnhe153222@fpt.edu.vn');
/*!40000 ALTER TABLE `receiver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `reservation_date` date DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `receiver_id` int DEFAULT NULL,
  `checkup_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `customer_id` (`customer_id`) USING BTREE,
  KEY `staff_id` (`staff_id`) USING BTREE,
  KEY `fk_receiver` (`receiver_id`) USING BTREE,
  CONSTRAINT `fk_receiver` FOREIGN KEY (`receiver_id`) REFERENCES `receiver` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (18,1,'2021-07-25',27,4,16,'2021-07-29 00:00:00'),(50,1,'2021-07-30',21,4,16,'2021-07-29 00:00:00'),(51,2,'2021-07-16',20,4,16,'2021-07-29 00:00:00'),(52,2,'2021-07-17',22,4,16,'2021-07-30 00:00:00'),(53,3,'2021-07-22',22,4,16,'2021-07-28 00:00:00'),(54,4,'2021-07-29',21,4,16,'2021-07-29 00:00:00'),(55,3,'2021-07-02',20,4,16,'2021-07-28 00:00:00'),(56,1,'2021-07-04',20,4,16,'2021-07-27 00:00:00'),(57,4,'2021-07-08',22,4,16,'2021-07-28 00:00:00'),(58,2,'2021-07-08',22,4,16,'2021-07-28 00:00:00'),(59,5,'2021-07-20',22,4,16,'2021-07-28 00:00:00'),(60,3,'2021-07-29',20,4,16,'2021-07-27 00:00:00'),(61,3,'2021-07-12',20,4,16,'2021-07-31 00:00:00'),(62,1,'2021-07-14',22,4,16,'2021-07-27 00:00:00'),(63,1,'2021-07-20',20,4,16,'2021-07-30 00:00:00'),(64,4,'2021-07-05',20,4,16,'2021-07-28 00:00:00'),(65,4,'2021-07-04',22,4,16,'2021-07-30 00:00:00'),(66,2,'2021-07-31',20,4,21,'2021-08-04 00:00:00'),(67,2,'2021-07-20',21,4,16,'2021-07-28 00:00:00'),(68,4,'2021-07-18',22,4,16,'2021-07-28 00:00:00'),(69,4,'2021-07-02',23,4,16,'2021-07-31 00:00:00'),(70,4,'2021-07-17',20,4,16,'2021-07-29 00:00:00'),(71,1,'2021-07-26',22,4,16,'2021-07-27 00:00:00'),(72,4,'2021-07-10',20,4,16,'2021-07-31 00:00:00'),(73,3,'2021-07-19',20,4,16,'2021-07-28 00:00:00'),(74,3,'2021-07-08',20,4,16,'2021-07-31 00:00:00'),(75,1,'2021-07-03',22,4,16,'2021-07-31 00:00:00'),(76,5,'2021-07-28',20,4,16,'2021-07-31 00:00:00'),(77,3,'2021-07-25',22,4,16,'2021-07-28 00:00:00'),(78,3,'2021-07-13',22,4,16,'2021-07-30 00:00:00'),(79,1,'2021-07-14',22,4,16,'2021-07-30 00:00:00'),(80,2,'2021-07-26',22,4,16,'2021-07-28 00:00:00'),(81,4,'2021-07-05',20,4,16,'2021-07-28 00:00:00'),(82,5,'2021-07-24',21,4,16,'2021-07-31 00:00:00'),(83,5,'2021-07-02',22,4,16,'2021-07-29 00:00:00'),(84,1,'2021-07-20',21,4,16,'2021-07-30 00:00:00'),(85,3,'2021-07-11',21,4,16,'2021-07-29 00:00:00'),(86,3,'2021-07-21',20,4,16,'2021-07-31 00:00:00'),(87,2,'2021-07-04',23,4,16,'2021-07-28 00:00:00'),(88,2,'2021-07-04',22,4,16,'2021-07-29 00:00:00'),(89,4,'2021-07-27',20,4,16,'2021-07-31 00:00:00'),(90,3,'2021-07-28',21,4,16,'2021-07-28 00:00:00'),(91,3,'2021-07-06',21,4,16,'2021-07-31 00:00:00'),(92,2,'2021-07-01',21,4,16,'2021-07-30 00:00:00'),(93,4,'2021-07-08',21,4,16,'2021-07-28 00:00:00'),(94,4,'2021-07-12',20,4,16,'2021-07-28 00:00:00'),(95,2,'2021-07-08',20,4,16,'2021-07-30 00:00:00'),(96,3,'2021-07-18',20,4,16,'2021-07-31 00:00:00'),(97,1,'2021-07-26',23,4,16,'2021-07-29 00:00:00'),(98,5,'2021-07-14',23,4,16,'2021-07-29 00:00:00'),(99,5,'2021-07-10',22,4,16,'2021-07-30 00:00:00'),(100,5,'2021-07-24',22,4,16,'2021-07-27 00:00:00'),(101,2,'2021-07-31',20,4,21,'2021-08-05 00:00:00');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation_service`
--

DROP TABLE IF EXISTS `reservation_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_service` (
  `reservation_id` int NOT NULL,
  `service_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` float(255,0) DEFAULT NULL,
  PRIMARY KEY (`reservation_id`,`service_id`) USING BTREE,
  KEY `fk_service` (`service_id`) USING BTREE,
  CONSTRAINT `fk_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_service` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation_service`
--

LOCK TABLES `reservation_service` WRITE;
/*!40000 ALTER TABLE `reservation_service` DISABLE KEYS */;
INSERT INTO `reservation_service` VALUES (18,4,3,80000),(18,11,2,100000),(51,2,2,95980),(52,1,1,80448),(52,5,1,85969),(53,8,2,86387),(54,8,1,97285),(55,6,2,85783),(55,8,2,87448),(56,2,1,84456),(59,10,3,97916),(60,1,3,95383),(61,4,3,99552),(61,5,3,88276),(62,4,3,84196),(63,8,2,94850),(63,10,2,95416),(63,11,2,80530),(64,5,3,93636),(64,8,3,82693),(66,1,5,90000),(66,5,1,94339),(67,2,2,97204),(67,5,2,95074),(68,3,1,97882),(68,4,3,93604),(69,2,3,96402),(69,6,3,92008),(70,2,1,92466),(70,5,2,92366),(70,9,1,99101),(70,10,1,93601),(71,6,2,90448),(71,9,3,80444),(72,11,3,82323),(73,8,1,97841),(74,6,2,94349),(75,1,2,94642),(75,3,3,99823),(75,7,3,83778),(75,8,3,96000),(75,10,2,81863),(76,6,1,95205),(76,7,2,96336),(77,3,2,84521),(77,5,2,93133),(77,10,2,92768),(77,12,1,91211),(78,1,1,97340),(78,5,1,84511),(78,6,3,83177),(78,11,1,92603),(79,2,3,88654),(79,7,2,95261),(79,9,3,86615),(80,12,3,99966),(81,2,1,85271),(81,4,1,86290),(81,10,1,95669),(81,12,1,97750),(82,2,3,81159),(82,4,2,82872),(83,3,3,98668),(83,7,2,83051),(83,9,3,80628),(84,1,1,87566),(84,5,2,94495),(84,8,3,92880),(84,12,1,81517),(86,1,3,85421),(86,3,1,88323),(87,11,2,96139),(88,5,1,94022),(88,8,2,90936),(88,10,3,85890),(88,11,3,84447),(90,5,3,82040),(91,1,1,90488),(91,4,2,88321),(92,3,3,88938),(92,6,2,91959),(93,1,1,91249),(93,8,1,87704),(93,11,1,90416),(94,4,3,80249),(95,4,1,88860),(95,9,1,84906),(95,12,2,98745),(96,4,2,96113),(96,9,1,89908),(96,10,1,88359),(98,6,2,90737),(99,7,2,84707),(101,12,1,100000);
/*!40000 ALTER TABLE `reservation_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `original_price` float(10,2) DEFAULT NULL,
  `sale_price` float(10,2) DEFAULT NULL,
  `thumbnail_link` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `details` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `updated_date` datetime DEFAULT NULL,
  `featured` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'Anesthesiology',100000.00,90000.00,'./img/service_1.jpg',9,'Service 1','Service 1',NULL,NULL,1,NULL),(2,'\r\nClinical Nutrition',100000.00,100000.00,'./img/service_2.jpg',10,'Service 2','Service 2',NULL,NULL,1,NULL),(3,'Endocrinology',460000.00,150000.00,'./img/service_3.jpg',11,'Service 3','Service 3',NULL,NULL,1,NULL),(4,'Gastroenterology',100000.00,80000.00,'./img/service_4.jpg',9,'Service 4','Service 4','2021-07-25 22:34:26',0,0,12),(5,'Heart Disease',500000.00,100000.00,'./img/service_5.jpg',10,'Service 5','Service 5',NULL,NULL,1,NULL),(6,'LGBTQ Health',200000.00,150000.00,'./img/service_6.jpg',11,'Service 6','Service 6',NULL,NULL,1,NULL),(7,'\r\nLong COVID',700000.00,90000.00,'./img/service_7.jpg',9,'Service 7','Service 7',NULL,NULL,1,NULL),(8,'Neurosurgery',100000.00,80000.00,'./img/service_8.jpg',10,'Service 8','Service 8',NULL,NULL,1,NULL),(9,'\r\nOphthalmology',200000.00,150000.00,'./img/service_9.jpg',11,'Service 9','Service 9',NULL,NULL,1,NULL),(10,'\r\nPharmacy',100000.00,90000.00,'./img/service_10.jpg',12,'Service 10','Service 10',NULL,NULL,1,NULL),(11,'Pulmonology',300000.00,100000.00,'./img/service_11.jpg',12,'Service 11','Service 11','2021-07-25 22:34:38',0,0,18),(12,'CAR T-Cell therapy',250000.00,100000.00,'./img/service_12.jpg',12,'Service 12','Service 12',NULL,NULL,1,NULL);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setting` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `name` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `value` int NOT NULL,
  `description` varchar(2048) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting`
--

LOCK TABLES `setting` WRITE;
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
INSERT INTO `setting` VALUES (1,'Role','Admin',1,NULL,'1'),(2,'Role','Manager',2,NULL,'1'),(3,'Role','Staff',3,NULL,'1'),(4,'Role','Customer',4,NULL,'1'),(5,'Post category','Category_1',1,NULL,'1'),(6,'Post category','Category_2',2,NULL,'1'),(7,'Post category','Category_3',3,NULL,'1'),(8,'Post category','Category_4',4,NULL,'1'),(9,'Service Category','Pediatrics',1,NULL,'1'),(10,'Service Category','Cardiology',2,NULL,'1'),(11,'Service Category','Neurosurgery',3,NULL,'1'),(12,'Service Category','Cancer Care',4,NULL,'1'),(13,'User Status','Not verified',1,NULL,'1'),(14,'User Status','Active',2,NULL,'1'),(15,'User Status','Contact',3,NULL,'1'),(16,'User Status','Potential',4,NULL,'1'),(17,'User Status','Customer',5,NULL,'1'),(18,'User Status','Inactive',6,NULL,'1'),(19,'Reservation Status','Pending',1,NULL,'1'),(20,'Reservation Status','Submitted',2,NULL,'1'),(21,'Reservation Status','Cancel',3,NULL,'1'),(22,'Reservation Status','Approved',4,NULL,'1'),(23,'Reservation Status','Rejected',5,NULL,'1'),(24,'Post Status','Draft',0,NULL,'1'),(25,'Post Status','Published',1,NULL,'1'),(26,'Post Status','Hidden',2,NULL,'1'),(27,'Reservation Status','Success',6,NULL,'1'),(28,'Feedback Status','Processing',1,NULL,'1'),(29,'Feedback Status','Processed',2,NULL,'1');
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slider`
--

DROP TABLE IF EXISTS `slider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slider` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `image_link` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `backlink` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `notes` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slider`
--

LOCK TABLES `slider` WRITE;
/*!40000 ALTER TABLE `slider` DISABLE KEYS */;
INSERT INTO `slider` VALUES (1,'A  Response Plan to counter Covid-19','./img/slider1.jpg','#',1,'Pushing the boundaries of what’s possible in children’s health.'),(2,'Medical Emergencies Always Come Unannounced!','./img/slider2.jpg','#',1,'Get the most advanced emergency care anywhere in just minutes.'),(5,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none'),(6,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none'),(7,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none'),(8,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none'),(9,'HueMedical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none'),(10,'naviMedical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none'),(11,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.'),(12,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.'),(13,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.'),(14,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.'),(15,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.'),(16,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.'),(18,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.');
/*!40000 ALTER TABLE `slider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `full_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `image_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_roleid_idx` (`role_id`) USING BTREE,
  KEY `fk_status_user` (`status`) USING BTREE,
  CONSTRAINT `FK_roleid` FOREIGN KEY (`role_id`) REFERENCES `setting` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_status_user` FOREIGN KEY (`status`) REFERENCES `setting` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (-1,'guest','none','guest',1,'0123456789','nowhere','#',4,14),(1,'giangtthe153299@fpt.edu.vn','dEZJRv/K/qzPzW2uTGHyam0msZc=','Giang',1,'0974484610','Vietnam','assets/images/default.png',1,14),(2,'hattnhe153222@fpt.edu.vn','dEZJRv/K/qzPzW2uTGHyam0msZc=','Ha',0,'0974484610','Viet Nam','assets/images/default.png',4,14),(3,'anhntnhe151378@fpt.edu.vn','dEZJRv/K/qzPzW2uTGHyam0msZc=','Ngoc Anh',0,'0974484610','Viet Nam','assets/images/default.png',2,14),(4,'tranglvqhe153785@fpt.edu.vn','dEZJRv/K/qzPzW2uTGHyam0msZc=','Trang',0,'0974484610','Viet Nam','assets/images/default.png',3,14),(5,'minhhnhe151181@fpt.edu.vn','dEZJRv/K/qzPzW2uTGHyam0msZc=','Minh',1,'0974484610','Viet Nam','assets/images/default.png',4,14),(91,'Fusce.dolor@auctor.com','dEZJRv/K/qzPzW2uTGHyam0msZc=','Cameran Randall',1,'03 3098 2170','676-4438 At, Rd.','assets/images/default.png',4,16),(92,'Aliquam.fringilla.cursus@tellusPhaselluselit.net','dEZJRv/K/qzPzW2uTGHyam0msZc=','Travis Booth',1,'05 2741 5626','855-6756 Aliquam St.','assets/images/default.png',4,16),(93,'Cum.sociis@lectusNullamsuscipit.edu','dEZJRv/K/qzPzW2uTGHyam0msZc=','Erasmus Miles',0,'06 5922 9897','P.O. Box 578, 1680 Nunc Ave','assets/images/default.png',4,17),(94,'imperdiet@semut.net','dEZJRv/K/qzPzW2uTGHyam0msZc=','Virginia Patrick',0,'09 0823 2167','8273 Lorem St.','assets/images/default.png',4,15),(95,'dolor.elit.pellentesque@gravida.net','dEZJRv/K/qzPzW2uTGHyam0msZc=','Merrill Dodson',1,'08 4181 7222','P.O. Box 968, 2771 Nunc Ave','assets/images/default.png',4,15),(96,'pede.Nunc@rutrummagnaCras.net','dEZJRv/K/qzPzW2uTGHyam0msZc=','Herrod Garrison',0,'01 5261 9252','P.O. Box 100, 7977 Eget Rd.','assets/images/default.png',4,15),(97,'sit.amet.consectetuer@enimcondimentumeget.com','dEZJRv/K/qzPzW2uTGHyam0msZc=','Nyssa Whitehead',0,'03 1619 9741','348 Sapien, Rd.','assets/images/default.png',4,16),(98,'in.molestie@consectetuerrhoncusNullam.ca','dEZJRv/K/qzPzW2uTGHyam0msZc=','Rhoda Atkins',1,'07 1611 8568','294-8716 Justo Rd.','assets/images/default.png',4,16),(99,'tempor@necligula.edu','dEZJRv/K/qzPzW2uTGHyam0msZc=','Jonah Delacruz',1,'07 4581 3242','Ap #210-5290 Amet Street','assets/images/default.png',4,17),(100,'pede.nonummy@id.edu','dEZJRv/K/qzPzW2uTGHyam0msZc=','Jolene Hatfield',1,'03 7598 6632','377-4202 Sit St.','assets/images/default.png',4,17),(101,'augue@necurnasuscipit.org','dEZJRv/K/qzPzW2uTGHyam0msZc=','Jana Everett',1,'09 5683 8841','650-539 Pharetra Rd.','assets/images/default.png',4,17),(102,'auctor.Mauris@aliquetmagna.com','dEZJRv/K/qzPzW2uTGHyam0msZc=','Maryam Coffey',0,'00 8591 6584','9325 Libero Av.','assets/images/default.png',4,16),(103,'cursus@estacfacilisis.com','dEZJRv/K/qzPzW2uTGHyam0msZc=','Kermit Burton',0,'01 1323 3633','Ap #900-8190 Lacus, St.','assets/images/default.png',4,17),(104,'tempor@sociosquad.ca','dEZJRv/K/qzPzW2uTGHyam0msZc=','Merritt Buckley',0,'00 2488 9979','P.O. Box 169, 5855 Sed Ave','assets/images/default.png',4,15),(105,'venenatis.vel@auctor.edu','dEZJRv/K/qzPzW2uTGHyam0msZc=','Benjamin Roman',1,'06 3883 3084','374-9446 Mus. Avenue','assets/images/default.png',4,17),(106,'ultrices.posuere@perinceptos.net','dEZJRv/K/qzPzW2uTGHyam0msZc=','Ian Potter',0,'06 3685 0102','P.O. Box 708, 2807 Nunc Ave','assets/images/default.png',4,15),(107,'Cras.lorem@faucibusutnulla.co.uk','dEZJRv/K/qzPzW2uTGHyam0msZc=','Craig Albert',1,'06 5895 7788','P.O. Box 656, 5569 Nec Road','assets/images/default.png',4,15),(108,'arcu.Vestibulum.ut@infaucibus.com','dEZJRv/K/qzPzW2uTGHyam0msZc=','Jameson Savage',0,'08 0534 5067','344-8652 Sem Road','assets/images/default.png',4,17),(109,'sem.Pellentesque.ut@iaculisenim.edu','dEZJRv/K/qzPzW2uTGHyam0msZc=','Dillon Beach',0,'08 0362 8209','P.O. Box 795, 863 Enim. Rd.','assets/images/default.png',4,16),(110,'erat.Vivamus@musProinvel.co.uk','dEZJRv/K/qzPzW2uTGHyam0msZc=','Ebony Dean',1,'08 9087 2089','P.O. Box 187, 8252 Tellus Ave','assets/images/default.png',4,15),(111,'ultrices.sit.amet@scelerisque.com','dEZJRv/K/qzPzW2uTGHyam0msZc=','Cedric Young',0,'09 5523 8563','8655 Dolor. Road','assets/images/default.png',4,16),(112,'mauris@enimcondimentum.org','dEZJRv/K/qzPzW2uTGHyam0msZc=','Lillith Morton',1,'07 5555 0052','Ap #737-2514 Neque St.','assets/images/default.png',4,16),(113,'dolor.quam.elementum@Suspendisseseddolor.org','dEZJRv/K/qzPzW2uTGHyam0msZc=','Ezra Banks',0,'07 1798 5418','P.O. Box 357, 6736 Nisl. St.','assets/images/default.png',4,15),(114,'porttitor.vulputate@etmalesuada.net','dEZJRv/K/qzPzW2uTGHyam0msZc=','Debra Rodgers',1,'04 7276 6369','P.O. Box 407, 317 Cras Road','assets/images/default.png',4,16),(115,'ac.mi.eleifend@metus.org','dEZJRv/K/qzPzW2uTGHyam0msZc=','Basil Holmes',1,'07 0184 5611','P.O. Box 351, 9486 Dolor Street','assets/images/default.png',4,17),(116,'Duis.volutpat@dapibusquam.edu','dEZJRv/K/qzPzW2uTGHyam0msZc=','Kermit Madden',1,'02 5291 5691','371-7540 Ultricies Av.','assets/images/default.png',4,17),(117,'aliquam.adipiscing.lacus@hendreritconsectetuer.edu','dEZJRv/K/qzPzW2uTGHyam0msZc=','Merritt Love',0,'02 8510 5414','989-5503 Vestibulum, Rd.','assets/images/default.png',4,17),(118,'Nunc.sollicitudin.commodo@nibhAliquam.org','dEZJRv/K/qzPzW2uTGHyam0msZc=','Olga Merrill',0,'03 0153 1977','639-8895 Nulla Rd.','assets/images/default.png',4,17),(119,'porttitor.interdum.Sed@inaliquet.co.uk','dEZJRv/K/qzPzW2uTGHyam0msZc=','Camden Mcclure',1,'08 7569 4261','753-4388 Etiam St.','assets/images/default.png',4,16),(120,'congue@odiotristique.edu','dEZJRv/K/qzPzW2uTGHyam0msZc=','Keane Pitts',1,'04 7014 7684','Ap #446-1701 Cursus Rd.','assets/images/default.png',4,15),(121,'dui@Quisquefringilla.net','dEZJRv/K/qzPzW2uTGHyam0msZc=','Maile Dillon',0,'07 6283 3004','7075 Non Av.','assets/images/default.png',4,16),(122,'sit.amet.risus@sagittis.co.uk','dEZJRv/K/qzPzW2uTGHyam0msZc=','Azalia Kirkland',1,'01 0267 4556','5299 Hendrerit Rd.','assets/images/default.png',4,15),(123,'elit.Nulla.facilisi@ametrisus.ca','dEZJRv/K/qzPzW2uTGHyam0msZc=','Mohammad Frye',1,'07 4728 5661','P.O. Box 109, 4891 Neque Av.','assets/images/default.png',4,15),(124,'odio@ridiculus.net','dEZJRv/K/qzPzW2uTGHyam0msZc=','Melvin Juarez',0,'07 4577 7948','586-936 Dictum Road','assets/images/default.png',4,16),(125,'Mauris.nulla@quamvelsapien.co.uk','dEZJRv/K/qzPzW2uTGHyam0msZc=','Hamilton Berg',0,'05 4379 9506','Ap #196-3025 Blandit Av.','assets/images/default.png',4,16),(126,'metus.Aliquam@fermentumconvallis.com','dEZJRv/K/qzPzW2uTGHyam0msZc=','Trevor Williams',0,'00 2660 8006','Ap #908-5583 Rhoncus. Street','assets/images/default.png',4,15),(127,'ridiculus.mus@pretium.ca','dEZJRv/K/qzPzW2uTGHyam0msZc=','Herrod Armstrong',1,'09 6236 0421','Ap #162-5003 Ut Street','assets/images/default.png',4,15),(128,'dui.lectus.rutrum@infelis.ca','dEZJRv/K/qzPzW2uTGHyam0msZc=','Ashton Houston',1,'06 2648 5883','1432 A St.','assets/images/default.png',4,16),(129,'sociis@vitae.org','dEZJRv/K/qzPzW2uTGHyam0msZc=','MacKensie Morris',0,'05 3255 1627','7704 Vestibulum St.','assets/images/default.png',4,15),(130,'Phasellus.ornare@massarutrummagna.net','dEZJRv/K/qzPzW2uTGHyam0msZc=','Mariko Jacobs',0,'03 4174 1097','786-4568 Ridiculus Avenue','assets/images/default.png',4,16),(133,'anhbhnhe180164@fpt.edu.vn','dEZJRv/K/qzPzW2uTGHyam0msZc=','Bui Hoang Nguyet Anh (K18 HL)',0,NULL,NULL,'https://lh3.googleusercontent.com/a/ACg8ocI5yBqa1JZ-DYT_gmNKcFvkPWCd4tjzn4lAN502OuTE59z07A=s96-c',4,17);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_history`
--

DROP TABLE IF EXISTS `user_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_history` (
  `user_id` int NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime NOT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`user_id`,`updated_date`) USING BTREE,
  KEY `FK_updated_by_idx` (`updated_by`) USING BTREE,
  CONSTRAINT `FK_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_history`
--

LOCK TABLES `user_history` WRITE;
/*!40000 ALTER TABLE `user_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_history` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-03 16:22:42
