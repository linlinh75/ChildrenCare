-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: swp
-- ------------------------------------------------------
-- Server version	8.0.25
DROP DATABASE IF EXISTS swp;
Create database swp;
use swp;
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
  `user_id` int DEFAULT NULL,
  `rated_star` int DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `service_id` int DEFAULT NULL,
  `image_link` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `service_id` (`service_id`) USING BTREE,
   FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` (`user_id`, `rated_star`, `content`, `service_id`, `image_link`, `status`) VALUES
(1, 5, 'Great service!', 4, 'image1.jpg', 'Processing'),
(2, 4, 'Good experience.', 4, 'image2.jpg', 'Processed'),
(3, 3, 'Average service.', 3, 'image3.jpg', 'Processing'),
(4, 2, 'Needs improvement.', 2, 'image4.jpg', 'Processed');
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
  `user_id` int NOT NULL,
  `prescription` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`reservation_id`,`service_id`,`user_id`) USING BTREE,
  KEY `fk_service_exam` (`service_id`) USING BTREE,
  KEY `fk_user_exam` (`user_id`) USING BTREE,
  CONSTRAINT `fk_user_exam` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_reservation_exam` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_service_exam` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_examination`
--

LOCK TABLES `medical_examination` WRITE;
/*!40000 ALTER TABLE `medical_examination` DISABLE KEYS */;
INSERT INTO `medical_examination` VALUES (18,4,16,'Three time a day'),(18,4,17,' 3 times a day'),
(18,4,18,'Should come back to hospital'),(18,133,19,'3 times a day'),(18,133,20,'2 times a day');
/*!40000 ALTER TABLE `medical_examination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post_category` (
    id INT AUTO_INCREMENT PRIMARY KEY,   
    name VARCHAR(255) NOT NULL,         
    description TEXT                     
);
DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `updated_date` datetime DEFAULT NULL,
  `featured` tinyint(1) DEFAULT NULL,
  `thumbnail_link` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `title` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `author_id` (`author_id`) USING BTREE,
  CONSTRAINT `post_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  FOREIGN KEY (category_id) REFERENCES post_category(id)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post`(`content`, `description`, `updated_date`, `featured`, `thumbnail_link`, `author_id`, `category_id`, `status`, `title`) VALUES 
('<blockquote>\r\n<p>This is a quote from a famous person</p>\r\n</blockquote>\r\n\r\n<p>FRESNO, Calif. &mdash; On a Tuesday afternoon in April, among tables of vegetables, clothes and telephone chargers at Fresno&rsquo;s biggest outdoor flea market were prescription drugs being sold as treatments for Covid. Vendors sold $25 injections of the steroid dexamethasone, several kinds of antibiotics and the anti-parasitic drug ivermectin. Chloroquine and hydroxychloroquine &mdash; the malaria drugs pushed by President Donald J. Trump last year &mdash; make regular appearances at the market as well, as do sham herbal supplements. Health and consumer protection agencies have repeatedly warned that several of these treatments, as well as vitamin infusions and expensive injections of &ldquo;peptide therapies&rdquo; sold at alternative wellness clinics for more than $1,000, are not supported by reliable scientific evidence. But such unproven remedies, often promoted by doctors and companies on social media, have appealed to many people in low-income immigrant communities in places across the country where Covid-19 rates have been high but access to health care is low.</p>\r\n\r\n<p>Some turn to unregulated drugs because mainstream medicine is too expensive or is inaccessible because of language or cultural barriers. &quot;It&rsquo;s disappointing but not surprising&rdquo; that people living below the poverty line have spent large sums of money for unproven treatments for Covid-19, said Rais Vohra, the interim head of Fresno County&rsquo;s health department. &ldquo;People are desperate and bombarded with misinformation and may not have the skills, time or context to interpret medical evidence.&rdquo;</p>\r\n','Shut out from mainstream medicine, some immigrants are buying expensive, unproven Covid therapies from wellness clinics or turning to the black market.','2021-07-24 23:08:52',1,'assets/images/download.jpg',3,5,'Published','Desperate for covid care, immigrants are struggling to find cure'),
('A study published in the Multiple Sclerosis Journal found that prospective MS patients often had an increased frequency of hospital/GP visits up to 5 years before a clinical diagnosis for their MS symptoms. As with many diseases, the prodromal (pre-symptomatic) stage of disease may or may not come with any noticeable symptoms. However, there may be additional signs which may present during this stage that could be important features associated with the onset of disease-related symptoms in the months or years to come. According to their findings, hospital, and GP visits for 2-4x higher in the prodromal 5 years before MS diagnoses compared to healthy controls. Interestingly, these were specific for conditions related to the sensory organs, the musculoskeletal system, and the genito-urinary system. In addition, people who developed MS had 50% more physician visits for mental health and cognitive related issues (including mood and anxiety disorders) in the 5 years before their symptoms or diagnoses compared to controls, with prescriptions for antidepressants being common, as well as prescriptions for antibiotics.','Talk of \'gain-of-function\' research, a muddy category at best, brings up deep questions about how scientists should study viruses and other pathogens.','2021-07-24 17:26:33',1,'assets/images/download.jpg',3,6,'Hidden','Fight Over Covid\'s Origins Renews Debate on Risks of Lab Work'),
('Getting an early diagnosis for multiple sclerosis (MS) is important in ensuring better long-term outcomes and quality of life. The challenge, however, is that getting an early diagnosis for MS is challenging and diagnoses are currently made in advanced disease stages. MS varies considerably between patients depending on the type and the parts of the body affected. Many of the symptoms of MS can also be associated with other disorders often complicating diagnoses. However, some of the most common symptoms include fatigue, pain, problems with walking or holding items, numbness or tingling in various parts of the body, problems with vision, issues with balance and coordination, bladder/bowel/sexual problems as well as some degree of cognitive disturbances. The most common type of MS (around 80% of all cases) is relapse remitting MS in which there are episodes of existing or new symptoms which worsen over days or weeks/months (relapse) and episodes of slow recovery over time (remitting). However, as the disease progresses over many years, the condition becomes progressively worse (secondary progressive MS). Around 10% of all cases are primary progressive MS cases where symptoms gradually become worse from onset without any remission.','Organisers are to decide as soon as Monday whether to allow domestic spectators into the stadiums for the Games, which were delayed by a year due to the pandemic and now set to start in about a month. Foreign spectators have already been banned.','2021-06-22 00:47:44',1,'assets/images/service/128283710.jpg',3,7,'Hidden','Olympics venue medical officers want no spectators amid COVID-19 fears'),
('<p>As opioid overdose deaths rose during the COVID-19 pandemic, people seeking treatment for opioid addiction had to wait nearly twice as long to begin methadone treatment in the United States than in Canada, a new Yale study has shown.</p><p>In both countries during the pandemic, about one in 10 methadone clinics were not accepting new patients and a third of those cited COVID-19 as the reason, according to research published July 23 in the journal <em>JAMA Network Open</em>.</p><p>The findings highlight shortcomings providing prompt access to people seeking treatment for opioid addiction, the authors say.</p>','With summer in full swing and excessive heat waves rolling through parts of the country, taking a dip in water can be a refreshing way to cool off.','2021-07-24 23:12:16',1,'assets/images/download.jpg',3,8,'Hidden','What to do to stay safe around water this summer at the pool or beach'),
('Whilst the industry continues to focus on the development of vaccines and therapies in response to COVID-19, the crisis has had a considerable impact on clinical trials in other therapy areas, particularly on cardiovascular, dermatology and metabolic. Even though significant regulatory agencies, such as the FDA and EMEA, have promoted guidelines and measures for maintaining the integrity of the trials that attempt to guarantee the rights, safety and wellbeing of patients and healthcare staff during this COVID-19 pandemic, maintaining clinical trials and keeping them on track has been severely challenging.','No Description','2021-06-22 00:47:44',0,'assets/images/service/s3.png',3,5,'Published','Pre-COVID-19 vs post-COVID-19 – clinical trial challenges revealed'),
('Do you think you\'re living an ordinary life? You are so mistaken it\'s difficult to even explain. The mere fact that you exist makes you extraordinary. The odds of you existing are less than winning the lottery, but here you are. Are you going to let this extraordinary opportunity pass?\r\nShe had come to the conclusion that you could tell a lot about a person by their ears. The way they stuck out and the size of the earlobes could give you wonderful insights into the person. Of course, she couldn\'t scientifically prove any of this, but that didn\'t matter to her. Before anything else, she would size up the ears of the person she was talking to.\r\nIt\'s always good to bring a slower friend with you on a hike. If you happen to come across bears, the whole group doesn\'t have to worry. Only the slowest in the group do. That was the lesson they were about to learn that day.','Recent events have only reinforced the frailty of our existence as well as a collective responsibility to help one another.','2021-06-22 00:47:44',1,'assets/images/service/Medical-logo-vector-lage.jpg',3,6,'Hidden','Study reflects shortcomings in how the U.S. handles care for people with opioid addiction'),
('\"It was so great to hear from you today and it was such weird timing,\" he said. \"This is going to sound funny and a little strange, but you were in a dream I had just a couple of days ago. I\'d love to get together and tell you about it if you\'re up for a cup of coffee,\" he continued, laying the trap he\'d been planning for years.\r\nColors bounced around in her head. They mixed and threaded themselves together. Even colors that had no business being together. They were all one, yet distinctly separate at the same time. How was she going to explain this to the others?','Whilst expected, there is no guarantee when another pandemic will hit again or what the impact would look like.','2021-06-22 00:58:56',1,'assets/images/s1.jpg',3,6,'Hidden','Study finds unacceptable mental health service shortfalls for children in high-income countries'),
('Researchers found that of the one in eight children (12.7 per cent) who experience a mental disorder, less than half (44.2 per cent) receive any services for these conditions.  Using systematic review methods, the researchers examined 14 prevalence surveys conducted in 11 high-income countries that included a total of 61,545 children aged four to 18 years. Eight of the 14 studies also assessed service contacts. The 14 surveys were conducted between 2003 and 2020 in Canada as well as the US, Australia, Chile, Denmark, Great Britain, Israel, Lithuania, Norway, South Korea and Taiwan. Researchers note that mental health service provision lags behind services available to treat physical conditions in most of these countries. \"We would not find it acceptable to treat only 44 per cent of children who had cancer or diabetes or infectious diseases,\" says Waddell.','Most children with a mental health disorder are not receiving services to address their needs--according to a new study from researchers at Simon Fraser University\'s Children\'s Health Policy Centre.','2021-06-22 00:47:44',1,'assets/images/s1.jpg',3,7,'Hidden','Study finds unacceptable mental health service shortfalls for children in high-income countries'),
('Glaucoma results from irreversible neurodegeneration of the optic nerve, the bundle of axons from retinal ganglion cells that transmits signals from the eye to the brain to produce vision. Available therapies slow vision loss by lowering elevated eye pressure, however some glaucoma progresses to blindness despite normal eye pressure. Neuroprotective therapies would be a leap forward, meeting the needs of patients who lack treatment options. The CaMKII (calcium/calmodulin-dependent protein kinase II) pathway regulates key cellular processes and functions throughout the body, including retinal ganglion cells in the eye. Yet the precise role of CaMKII in retinal ganglion cell health is not well understood. Inhibition of CaMKII activity, for example, has been shown to be either protective or detrimental to retinal ganglion cells, depending on the conditions. Using an antibody marker of CaMKII activity, Chen\'s team discovered that CaMKII pathway signaling was compromised whenever retinal ganglion cells were exposed to toxins or trauma from a crush injury to the optic nerve, suggesting a correlation between CaMKII activity and retinal ganglion cell survival. Searching for ways to intervene, they found that activating the CaMKII pathway with gene therapy proved protective to the retinal ganglion cells. Administering the gene therapy to mice just prior to the toxic insult (which initiates rapid damage to the cells), and just after optic nerve crush (which causes slower damage), increased CaMKII activity and robustly protected retinal ganglion cells.','A form of gene therapy protects optic nerve cells and preserves vision in mouse models of glaucoma, according to research supported by NIH\'s National Eye Institute','2021-06-22 00:47:44',1,'assets/images/s1.jpg',3,5,'Published','Gene therapy protects optic nerve cells and preserves vision in glaucoma mouse models'),
('Thus, an increased GP or hospital visit frequency for specific physical conditions in combination with the need for mental health or cognitive referrals may be important prodromal hallmarks of MS. The combination of antidepressants and antibiotic use seems to be highly associated with the prodromal stage of MS – perhaps to treat symptoms not yet recognized as MS before MS is diagnosed. However, there are some important caveats to this study. Firstly, many of these complaints are largely non-exclusive in everyday life, and simply visiting your GP for sensory dysfunction or mental health-related issues is not specific to the prodromal stage of MS. Even the combination of receiving antidepressants and antibiotics whilst having some degree of musculoskeletal dysfunction is not sufficiently an exclusive combination of MS prodrome. However, it does suggest that these combinations may be related to an increased chance of an MS diagnosis within 5 years and assessments for MS at this stage would only benefit the individual – even if it turns out not to be associated with MS.',
'MS patients who began natalizumab treatment 1-2 years earlier than those who started later displayed a clear and significant improvement in mortality','2021-07-24 23:08:52',1,'assets/images/s1.jpg',3,8,'Hidden','multiple sclerosis (MS) is a demyelinating disorder with varying symptoms and progression from person to person'),
('As increased optimism surrounded the control of the virus, the impact on life is still to be fully understood. Some forecasts predict grim long-term societal and financial consequences, across several countries. Whilst the tragic loss of life and the impact on the quality of life should not be overlooked, there are positives to come out of this crisis. This article will outline the impact on clinical trials and drug and diagnostic development. However, many parallels with everyday life can be taken into consideration. Strength through adversity is a commonly used aphorism and one which is true of people and industries alike. When confronted with challenges, human inventiveness knows no limits and COVID-19 has been both the mother of innovation but also the catalyst for the widespread adoption of current technologies. Thus, it is of little surprise that the clinical trial market has swiftly adjusted to the new paradigm circumscribed by restrictions on social interaction, by looking to leverage technological solutions.','Whilst pandemics are thankfully not common; COVID-19 has brought with it a profound global impact.','2021-07-24 23:08:52',1,'assets/images/s1.jpg',3,6,'Hidden','The impact of COVID-19 on clinical trials');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
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
  `status` varchar(255) DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `checkup_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `customer_id` (`customer_id`) USING BTREE,
  KEY `staff_id` (`staff_id`) USING BTREE,
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation`(`customer_id`,`reservation_date`,`status`,`staff_id`,`checkup_time`) VALUES(1,'2021-07-25','Success',4,'2021-07-29 00:00:00'),(1,'2021-07-30','Cancel',4,'2021-07-29 00:00:00'),
(2,'2021-07-16','Submitted',4,'2021-07-29 00:00:00'),(2,'2021-07-17','Approved',4,'2021-07-30 00:00:00'),
(3,'2021-07-22','Approved',4,'2021-07-28 00:00:00'),(4,'2021-07-29','Cancel',4,'2021-07-29 00:00:00'),
(3,'2021-07-02','Submitted',4,'2021-07-28 00:00:00'),(1,'2021-07-04','Submitted',4,'2021-07-27 00:00:00'),
(4,'2021-07-08','Approved',4,'2021-07-28 00:00:00'),(2,'2021-07-08','Approved',4,'2021-07-28 00:00:00'),
(5,'2021-07-20','Approved',4,'2021-07-28 00:00:00'),(3,'2021-07-29','Submitted',4,'2021-07-27 00:00:00');

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
INSERT INTO `reservation_service` VALUES 
(18,4,3,80000),(18,11,2,100000),(51,2,2,95980),(52,1,1,80448),(52,5,1,85969),(53,8,2,86387),
(54,8,1,97285),(55,6,2,85783),(55,8,2,87448),(56,2,1,84456),(59,10,3,97916),(60,1,3,95383),
(61,4,3,99552),(61,5,3,88276),(62,4,3,84196),(63,8,2,94850),(63,10,2,95416),(63,11,2,80530),
(64,5,3,93636),(64,8,3,82693),(66,1,5,90000),(66,5,1,94339),(67,2,2,97204),(67,5,2,95074),(68,3,1,97882),
(68,4,3,93604),(69,2,3,96402),(69,6,3,92008),(70,2,1,92466),(70,5,2,92366),(70,9,1,99101),(70,10,1,93601),
(71,6,2,90448),(71,9,3,80444),(72,11,3,82323),(73,8,1,97841),(74,6,2,94349),(75,1,2,94642),(75,3,3,99823),
(75,7,3,83778),(75,8,3,96000),(75,10,2,81863),(76,6,1,95205),(76,7,2,96336),(77,3,2,84521),(77,5,2,93133),
(77,10,2,92768),(77,12,1,91211),(78,1,1,97340),(78,5,1,84511),(78,6,3,83177),(78,11,1,92603),(79,2,3,88654),
(79,7,2,95261),(79,9,3,86615),(80,12,3,99966),(81,2,1,85271),(81,4,1,86290),(81,10,1,95669),(81,12,1,97750),(82,2,3,81159),
(82,4,2,82872),(83,3,3,98668),(83,7,2,83051),(83,9,3,80628),(84,1,1,87566),(84,5,2,94495),(84,8,3,92880),(84,12,1,81517),
(86,1,3,85421),(86,3,1,88323),(87,11,2,96139),(88,5,1,94022),(88,8,2,90936),(88,10,3,85890),(88,11,3,84447),
(90,5,3,82040),(91,1,1,90488),(91,4,2,88321),(92,3,3,88938),(92,6,2,91959),(93,1,1,91249),(93,8,1,87704),(93,11,1,90416);
/*!40000 ALTER TABLE `reservation_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--
CREATE TABLE service_category (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- Khóa chính tự tăng
    name VARCHAR(255) NOT NULL,          -- Tên danh mục
    description TEXT                     -- Mô tả danh mục
);
DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `original_price` float(10,2) DEFAULT NULL,
  `sale_price` float(10,2) DEFAULT NULL,
  `thumbnail_link` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `details` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `updated_date` datetime DEFAULT NULL,
  `featured` tinyint(1) DEFAULT NULL,
  `status` varchar(255)DEFAULT NULL,
   `author_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
   FOREIGN KEY (`category_id`) REFERENCES `service_category`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'Anesthesiology',100000.00,90000.00,'assets/images/7a3a2028872f5aa9752076eb8fcadd67.png',1,'Service 1','Service 1',NULL,NULL,1,NULL),
(2,'\r\nClinical Nutrition',100000.00,100000.00,'assets/images/8223fe77ccc022f23a0621ba829155cc.png',2,'Service 2','Service 2',NULL,NULL,1,NULL),
(3,'Endocrinology',460000.00,150000.00,'assets/images/128283710.jpg',3,'Service 3','Service 3',NULL,NULL,1,NULL),
(4,'Gastroenterology',100000.00,80000.00,'assets/images/d20140c66092cd2e66dada9a9f9104e6.jpg',1,'Service 4','Service 4','2021-07-25 22:34:26',0,0,12),
(5,'Heart Disease',500000.00,100000.00,'assets/images/dd7184.png',2,'Service 5','Service 5',NULL,NULL,1,NULL),
(6,'LGBTQ Health',200000.00,150000.00,'assets/images/download (1).png',3,'Service 6','Service 6',NULL,NULL,1,NULL),
(7,'\r\nLong COVID',700000.00,90000.00,'assets/images/Medical-logo-vector-lage.jpg',1,'Service 7','Service 7',NULL,NULL,1,NULL),
(8,'Neurosurgery',100000.00,80000.00,'assets/images/png-transparent-bit-animation-pixel-art-medical-records-game-logo-video-game.png',2,'Service 8','Service 8',NULL,NULL,1,NULL),
(9,'\r\nOphthalmology',200000.00,150000.00,'assets/images/s1.jpg',3,'Service 9','Service 9',NULL,NULL,1,NULL),
(10,'\r\nPharmacy',100000.00,90000.00,'assets/images/s3.png',4,'Service 10','Service 10',NULL,NULL,1,NULL),
(11,'Pulmonology',300000.00,100000.00,'assets/images/7a3a2028872f5aa9752076eb8fcadd67.png',4,'Service 11','Service 11','2021-07-25 22:34:38',0,0,18),
(12,'CAR T-Cell therapy',250000.00,100000.00,'assets/images/7a3a2028872f5aa9752076eb8fcadd67.png',4,'Service 12','Service 12',NULL,NULL,1,NULL);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;



-- LOCK TABLES `setting` WRITE;
-- /*!40000 ALTER TABLE `setting` DISABLE KEYS */;
-- INSERT INTO `setting` VALUES (1,'Role','Admin',1,NULL,'1'),(2,'Role','Manager',2,NULL,'1'),(3,'Role','Staff',3,NULL,'1'),(4,'Role','Customer',4,NULL,'1'),
-- (5,'Post category','Category_1',1,NULL,'1'),(6,'Post category','Category_2',2,NULL,'1'),(7,'Post category','Category_3',3,NULL,'1'),
-- (8,'Post category','Category_4',4,NULL,'1'),(9,'Service Category','Pediatrics',1,NULL,'1'),(10,'Service Category','Cardiology',2,NULL,'1'),
-- (11,'Service Category','Neurosurgery',3,NULL,'1'),(12,'Service Category','Cancer Care',4,NULL,'1'),
-- (13,'User Status','Not verified',1,NULL,'1'),(14,'User Status','Active',2,NULL,'1'),(15,'User Status','Contact',3,NULL,'1'),
-- (16,'User Status','Potential',4,NULL,'1'),(17,'User Status','Customer',5,NULL,'1'),(18,'User Status','Inactive',6,NULL,'1'),
-- (19,'Reservation Status','Pending',1,NULL,'1'),(20,'Reservation Status','Submitted',2,NULL,'1'),(21,'Reservation Status','Cancel',3,NULL,'1'),
-- (22,'Reservation Status','Approved',4,NULL,'1'),(23,'Reservation Status','Rejected',5,NULL,'1'),(24,'Post Status','Draft',0,NULL,'1'),
-- (25,'Post Status','Published',1,NULL,'1'),(26,'Post Status','Hidden',2,NULL,'1'),(27,'Reservation Status','Success',6,NULL,'1'),
-- (28,'Feedback Status','Processing',1,NULL,'1'),(29,'Feedback Status','Processed',2,NULL,'1');
-- /*!40000 ALTER TABLE `setting` ENABLE KEYS */;
-- UNLOCK TABLES;

--
-- Table structure for table `slider`
--

DROP TABLE IF EXISTS `slider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slider` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `image_link` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `backlink` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `notes` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slider`
--

LOCK TABLES `slider` WRITE;
/*!40000 ALTER TABLE `slider` DISABLE KEYS */;
INSERT INTO `slider` VALUES (1,'A  Response Plan to counter Covid-19','assets/images/slider/slider_1_dad_and_girl.jpg','#',1,'Pushing the boundaries of what’s possible in children’s health.'),(2,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',1,'Get the most advanced emergency care anywhere in just minutes.'),(5,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none'),(6,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none'),(7,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none'),(8,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none'),(9,'HueMedical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none'),(10,'naviMedical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none'),(11,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.'),(12,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.'),(13,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.'),(14,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.'),(15,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.'),(16,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.'),(18,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.');
/*!40000 ALTER TABLE `slider` ENABLE KEYS */;
UNLOCK TABLES;

CREATE TABLE `role`(
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
);
INSERT INTO `role` (`id`,`role_name`) VALUES 
(1,'Admin'), (2,'Manager'),(3,'Staff'),(4,'Customer') ;
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
  `image_link` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_roleid_idx` (`role_id`) USING BTREE,
  KEY `fk_status_user` (`status`) USING BTREE,
  CONSTRAINT `FK_roleid` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (-1,'guest','none','guest',1,'0123456789','nowhere','#',4,14),(1,'giangtthe153299@fpt.edu.vn','58228426789508bbbb13d9f11e05bf6b','Giang',1,'0974484610','Vietnam','assets/images/default.png',1,14),(2,'hattnhe153222@fpt.edu.vn','58228426789508bbbb13d9f11e05bf6b','Ha',0,'0974484610','Viet Nam','assets/images/default.png',4,14),(3,'anhntnhe151378@fpt.edu.vn','58228426789508bbbb13d9f11e05bf6b','Ngoc Anh',0,'0974484610','Viet Nam','assets/images/default.png',2,14),(4,'tranglvqhe153785@fpt.edu.vn','58228426789508bbbb13d9f11e05bf6b','Trang',0,'0974484610','Viet Nam','assets/images/default.png',3,14),(5,'minhhnhe151181@fpt.edu.vn','58228426789508bbbb13d9f11e05bf6b','Minh',1,'0974484610','Viet Nam','assets/images/default.png',4,14),(91,'Fusce.dolor@auctor.com','58228426789508bbbb13d9f11e05bf6b','Cameran Randall',1,'03 3098 2170','676-4438 At, Rd.','assets/images/default.png',4,16),(92,'Aliquam.fringilla.cursus@tellusPhaselluselit.net','58228426789508bbbb13d9f11e05bf6b','Travis Booth',1,'05 2741 5626','855-6756 Aliquam St.','assets/images/default.png',4,16),(93,'Cum.sociis@lectusNullamsuscipit.edu','58228426789508bbbb13d9f11e05bf6b','Erasmus Miles',0,'06 5922 9897','P.O. Box 578, 1680 Nunc Ave','assets/images/default.png',4,17),(94,'imperdiet@semut.net','58228426789508bbbb13d9f11e05bf6b','Virginia Patrick',0,'09 0823 2167','8273 Lorem St.','assets/images/default.png',4,15),(95,'dolor.elit.pellentesque@gravida.net','58228426789508bbbb13d9f11e05bf6b','Merrill Dodson',1,'08 4181 7222','P.O. Box 968, 2771 Nunc Ave','assets/images/default.png',4,15),(96,'pede.Nunc@rutrummagnaCras.net','58228426789508bbbb13d9f11e05bf6b','Herrod Garrison',0,'01 5261 9252','P.O. Box 100, 7977 Eget Rd.','assets/images/default.png',4,15),(97,'sit.amet.consectetuer@enimcondimentumeget.com','58228426789508bbbb13d9f11e05bf6b','Nyssa Whitehead',0,'03 1619 9741','348 Sapien, Rd.','assets/images/default.png',4,16),(98,'in.molestie@consectetuerrhoncusNullam.ca','58228426789508bbbb13d9f11e05bf6b','Rhoda Atkins',1,'07 1611 8568','294-8716 Justo Rd.','assets/images/default.png',4,16),(99,'tempor@necligula.edu','58228426789508bbbb13d9f11e05bf6b','Jonah Delacruz',1,'07 4581 3242','Ap #210-5290 Amet Street','assets/images/default.png',4,17),(100,'pede.nonummy@id.edu','58228426789508bbbb13d9f11e05bf6b','Jolene Hatfield',1,'03 7598 6632','377-4202 Sit St.','assets/images/default.png',4,17),(101,'augue@necurnasuscipit.org','58228426789508bbbb13d9f11e05bf6b','Jana Everett',1,'09 5683 8841','650-539 Pharetra Rd.','assets/images/default.png',4,17),(102,'auctor.Mauris@aliquetmagna.com','58228426789508bbbb13d9f11e05bf6b','Maryam Coffey',0,'00 8591 6584','9325 Libero Av.','assets/images/default.png',4,16),(103,'cursus@estacfacilisis.com','58228426789508bbbb13d9f11e05bf6b','Kermit Burton',0,'01 1323 3633','Ap #900-8190 Lacus, St.','assets/images/default.png',4,17),(104,'tempor@sociosquad.ca','58228426789508bbbb13d9f11e05bf6b','Merritt Buckley',0,'00 2488 9979','P.O. Box 169, 5855 Sed Ave','assets/images/default.png',4,15),(105,'venenatis.vel@auctor.edu','58228426789508bbbb13d9f11e05bf6b','Benjamin Roman',1,'06 3883 3084','374-9446 Mus. Avenue','assets/images/default.png',4,17),(106,'ultrices.posuere@perinceptos.net','58228426789508bbbb13d9f11e05bf6b','Ian Potter',0,'06 3685 0102','P.O. Box 708, 2807 Nunc Ave','assets/images/default.png',4,15),(107,'Cras.lorem@faucibusutnulla.co.uk','58228426789508bbbb13d9f11e05bf6b','Craig Albert',1,'06 5895 7788','P.O. Box 656, 5569 Nec Road','assets/images/default.png',4,15),(108,'arcu.Vestibulum.ut@infaucibus.com','58228426789508bbbb13d9f11e05bf6b','Jameson Savage',0,'08 0534 5067','344-8652 Sem Road','assets/images/default.png',4,17),(109,'sem.Pellentesque.ut@iaculisenim.edu','58228426789508bbbb13d9f11e05bf6b','Dillon Beach',0,'08 0362 8209','P.O. Box 795, 863 Enim. Rd.','assets/images/default.png',4,16),(110,'erat.Vivamus@musProinvel.co.uk','58228426789508bbbb13d9f11e05bf6b','Ebony Dean',1,'08 9087 2089','P.O. Box 187, 8252 Tellus Ave','assets/images/default.png',4,15),(111,'ultrices.sit.amet@scelerisque.com','58228426789508bbbb13d9f11e05bf6b','Cedric Young',0,'09 5523 8563','8655 Dolor. Road','assets/images/default.png',4,16),(112,'mauris@enimcondimentum.org','58228426789508bbbb13d9f11e05bf6b','Lillith Morton',1,'07 5555 0052','Ap #737-2514 Neque St.','assets/images/default.png',4,16),(113,'dolor.quam.elementum@Suspendisseseddolor.org','58228426789508bbbb13d9f11e05bf6b','Ezra Banks',0,'07 1798 5418','P.O. Box 357, 6736 Nisl. St.','assets/images/default.png',4,15),(114,'porttitor.vulputate@etmalesuada.net','58228426789508bbbb13d9f11e05bf6b','Debra Rodgers',1,'04 7276 6369','P.O. Box 407, 317 Cras Road','assets/images/default.png',4,16),(115,'ac.mi.eleifend@metus.org','58228426789508bbbb13d9f11e05bf6b','Basil Holmes',1,'07 0184 5611','P.O. Box 351, 9486 Dolor Street','assets/images/default.png',4,17),(116,'Duis.volutpat@dapibusquam.edu','58228426789508bbbb13d9f11e05bf6b','Kermit Madden',1,'02 5291 5691','371-7540 Ultricies Av.','assets/images/default.png',4,17),(117,'aliquam.adipiscing.lacus@hendreritconsectetuer.edu','58228426789508bbbb13d9f11e05bf6b','Merritt Love',0,'02 8510 5414','989-5503 Vestibulum, Rd.','assets/images/default.png',4,17),(118,'Nunc.sollicitudin.commodo@nibhAliquam.org','58228426789508bbbb13d9f11e05bf6b','Olga Merrill',0,'03 0153 1977','639-8895 Nulla Rd.','assets/images/default.png',4,17),(119,'porttitor.interdum.Sed@inaliquet.co.uk','58228426789508bbbb13d9f11e05bf6b','Camden Mcclure',1,'08 7569 4261','753-4388 Etiam St.','assets/images/default.png',4,16),(120,'congue@odiotristique.edu','58228426789508bbbb13d9f11e05bf6b','Keane Pitts',1,'04 7014 7684','Ap #446-1701 Cursus Rd.','assets/images/default.png',4,15),(121,'dui@Quisquefringilla.net','58228426789508bbbb13d9f11e05bf6b','Maile Dillon',0,'07 6283 3004','7075 Non Av.','assets/images/default.png',4,16),(122,'sit.amet.risus@sagittis.co.uk','58228426789508bbbb13d9f11e05bf6b','Azalia Kirkland',1,'01 0267 4556','5299 Hendrerit Rd.','assets/images/default.png',4,15),(123,'elit.Nulla.facilisi@ametrisus.ca','58228426789508bbbb13d9f11e05bf6b','Mohammad Frye',1,'07 4728 5661','P.O. Box 109, 4891 Neque Av.','assets/images/default.png',4,15),(124,'odio@ridiculus.net','58228426789508bbbb13d9f11e05bf6b','Melvin Juarez',0,'07 4577 7948','586-936 Dictum Road','assets/images/default.png',4,16),(125,'Mauris.nulla@quamvelsapien.co.uk','58228426789508bbbb13d9f11e05bf6b','Hamilton Berg',0,'05 4379 9506','Ap #196-3025 Blandit Av.','assets/images/default.png',4,16),(126,'metus.Aliquam@fermentumconvallis.com','58228426789508bbbb13d9f11e05bf6b','Trevor Williams',0,'00 2660 8006','Ap #908-5583 Rhoncus. Street','assets/images/default.png',4,15),(127,'ridiculus.mus@pretium.ca','58228426789508bbbb13d9f11e05bf6b','Herrod Armstrong',1,'09 6236 0421','Ap #162-5003 Ut Street','assets/images/default.png',4,15),(128,'dui.lectus.rutrum@infelis.ca','58228426789508bbbb13d9f11e05bf6b','Ashton Houston',1,'06 2648 5883','1432 A St.','assets/images/default.png',4,16),(129,'sociis@vitae.org','58228426789508bbbb13d9f11e05bf6b','MacKensie Morris',0,'05 3255 1627','7704 Vestibulum St.','assets/images/default.png',4,15),(130,'Phasellus.ornare@massarutrummagna.net','58228426789508bbbb13d9f11e05bf6b','Mariko Jacobs',0,'03 4174 1097','786-4568 Ridiculus Avenue','assets/images/default.png',4,16);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-31 20:31:26

-----------

-- Insert four categories into the swp.post_category table
INSERT INTO post_category (name, description) VALUES 
('Children Care', 'Category related to the care of children'),
('Education', 'Category related to the education of children'),
('Health', 'Category related to the health of children'),
('Nutrition', 'Category related to the nutrition of children');

-- Insert four categories into the swp.service_category table
INSERT INTO service_category (name, description) VALUES 
('Pediatrics', 'Pediatric services for children'),
('Cardiology', 'Cardiology services for children'),
('Neurosurgery', 'Neurosurgery services for children'),
('Cancer Care', 'Cancer care services for children');


-- Thêm cột author_id vào bảng swp.slider và thiết lập khóa ngoại trỏ đến bảng swp.user
ALTER TABLE slider 
ADD COLUMN author_id INT,                -- Thêm cột author_id kiểu INT
ADD CONSTRAINT fk_slider_author          -- Khóa ngoại trỏ đến bảng swp.user
FOREIGN KEY (author_id) REFERENCES user(id);
CREATE TABLE password_reset_tokens (
	id int  PRIMARY KEY auto_increment,
    token VARCHAR(255),
    email VARCHAR(255),
    created_at TIMESTAMP,
    expires_at TIMESTAMP,
    user_id int, 
    foreign key (user_id) references user(id)
);
UPDATE swp.service
SET thumbnail_link = CONCAT('./img/service_', id,'.jpg')
WHERE id BETWEEN 1 AND 12;
UPDATE swp.post
SET thumbnail_link = CASE id
    WHEN 32 THEN './img/blog1.jpg'
    WHEN 33 THEN './img/blog2.jpg'
    WHEN 34 THEN './img/blog3.jpg'
    WHEN 35 THEN './img/blog4.jpg'
    WHEN 36 THEN './img/blog5.jpg'
    WHEN 37 THEN './img/blog6.jpg'
    WHEN 39 THEN './img/blog7.jpg'
    WHEN 42 THEN './img/blog8.jpg'
    WHEN 43 THEN './img/blog9.jpg'
    WHEN 44 THEN './img/blog10.jpg'
    WHEN 45 THEN './img/blog11.jpg'
    END
WHERE id IN (32, 33, 34, 35, 36, 37, 39, 42, 43, 44, 45);
UPDATE swp.slider
SET image_link = CASE id
    WHEN 1 THEN './img/slider1.jpg'
    WHEN 2 THEN './img/slider2.jpg'
    END
WHERE id IN (1, 2);
