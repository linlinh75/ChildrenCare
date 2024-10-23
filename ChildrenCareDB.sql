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
  `user_id` int DEFAULT NULL,
  `rated_star` int DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `service_id` int DEFAULT NULL,
  `image_link` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `reservation_id` int DEFAULT NULL,
  `feedback_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `service_id` (`service_id`) USING BTREE,
  KEY `user_id` (`user_id`),
  KEY `fk_feedback_reservation` (`reservation_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_feedback_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (113,1,5,'Great service!',4,'image1.jpg','Processing',NULL,'2024-10-22 13:15:03'),(114,2,4,'Good experience.',4,'image2.jpg','Processed',NULL,'2024-10-22 13:15:03'),(115,3,3,'Average service.',3,'image3.jpg','Processing',NULL,'2024-10-22 13:15:03'),(116,4,2,'Needs improvement.',2,'image4.jpg','Processed',NULL,'2024-10-22 13:15:03');
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
  CONSTRAINT `fk_reservation_exam` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_service_exam` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_exam` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_examination`
--

LOCK TABLES `medical_examination` WRITE;
/*!40000 ALTER TABLE `medical_examination` DISABLE KEYS */;
INSERT INTO `medical_examination` VALUES (18,4,16,'Three time a day'),(18,4,17,' 3 times a day'),(18,4,18,'Should come back to hospital'),(18,133,19,'3 times a day'),(18,133,20,'2 times a day');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `status` varchar(255) DEFAULT NULL,
  `title` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `author_id` (`author_id`) USING BTREE,
  KEY `category_id` (`category_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `post_category` (`id`),
  CONSTRAINT `post_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (46,'<blockquote>\r\n<p>This is a quote from a famous person</p>\r\n</blockquote>\r\n\r\n<p>FRESNO, Calif. &mdash; On a Tuesday afternoon in April, among tables of vegetables, clothes and telephone chargers at Fresno&rsquo;s biggest outdoor flea market were prescription drugs being sold as treatments for Covid. Vendors sold $25 injections of the steroid dexamethasone, several kinds of antibiotics and the anti-parasitic drug ivermectin. Chloroquine and hydroxychloroquine &mdash; the malaria drugs pushed by President Donald J. Trump last year &mdash; make regular appearances at the market as well, as do sham herbal supplements. Health and consumer protection agencies have repeatedly warned that several of these treatments, as well as vitamin infusions and expensive injections of &ldquo;peptide therapies&rdquo; sold at alternative wellness clinics for more than $1,000, are not supported by reliable scientific evidence. But such unproven remedies, often promoted by doctors and companies on social media, have appealed to many people in low-income immigrant communities in places across the country where Covid-19 rates have been high but access to health care is low.</p>\r\n\r\n<p>Some turn to unregulated drugs because mainstream medicine is too expensive or is inaccessible because of language or cultural barriers. &quot;It&rsquo;s disappointing but not surprising&rdquo; that people living below the poverty line have spent large sums of money for unproven treatments for Covid-19, said Rais Vohra, the interim head of Fresno County&rsquo;s health department. &ldquo;People are desperate and bombarded with misinformation and may not have the skills, time or context to interpret medical evidence.&rdquo;</p>\r\n','Shut out from mainstream medicine, some immigrants are buying expensive, unproven Covid therapies from wellness clinics or turning to the black market.','2021-07-24 23:08:52',1,'assets/images/blog/01.jpg',3,5,'Published','Desperate for covid care, immigrants are struggling to find cure'),(47,'A study published in the Multiple Sclerosis Journal found that prospective MS patients often had an increased frequency of hospital/GP visits up to 5 years before a clinical diagnosis for their MS symptoms. As with many diseases, the prodromal (pre-symptomatic) stage of disease may or may not come with any noticeable symptoms. However, there may be additional signs which may present during this stage that could be important features associated with the onset of disease-related symptoms in the months or years to come. According to their findings, hospital, and GP visits for 2-4x higher in the prodromal 5 years before MS diagnoses compared to healthy controls. Interestingly, these were specific for conditions related to the sensory organs, the musculoskeletal system, and the genito-urinary system. In addition, people who developed MS had 50% more physician visits for mental health and cognitive related issues (including mood and anxiety disorders) in the 5 years before their symptoms or diagnoses compared to controls, with prescriptions for antidepressants being common, as well as prescriptions for antibiotics.','Talk of \'gain-of-function\' research, a muddy category at best, brings up deep questions about how scientists should study viruses and other pathogens.','2021-07-24 17:26:33',1,'assets/images/blog/02.jpg',3,6,'Hidden','Fight Over Covid\'s Origins Renews Debate on Risks of Lab Work'),(48,'Getting an early diagnosis for multiple sclerosis (MS) is important in ensuring better long-term outcomes and quality of life. The challenge, however, is that getting an early diagnosis for MS is challenging and diagnoses are currently made in advanced disease stages. MS varies considerably between patients depending on the type and the parts of the body affected. Many of the symptoms of MS can also be associated with other disorders often complicating diagnoses. However, some of the most common symptoms include fatigue, pain, problems with walking or holding items, numbness or tingling in various parts of the body, problems with vision, issues with balance and coordination, bladder/bowel/sexual problems as well as some degree of cognitive disturbances. The most common type of MS (around 80% of all cases) is relapse remitting MS in which there are episodes of existing or new symptoms which worsen over days or weeks/months (relapse) and episodes of slow recovery over time (remitting). However, as the disease progresses over many years, the condition becomes progressively worse (secondary progressive MS). Around 10% of all cases are primary progressive MS cases where symptoms gradually become worse from onset without any remission.','Organisers are to decide as soon as Monday whether to allow domestic spectators into the stadiums for the Games, which were delayed by a year due to the pandemic and now set to start in about a month. Foreign spectators have already been banned.','2021-06-22 00:47:44',1,'assets/images/blog/03.jpg',3,7,'Hidden','Olympics venue medical officers want no spectators amid COVID-19 fears'),(49,'<p>As opioid overdose deaths rose during the COVID-19 pandemic, people seeking treatment for opioid addiction had to wait nearly twice as long to begin methadone treatment in the United States than in Canada, a new Yale study has shown.</p><p>In both countries during the pandemic, about one in 10 methadone clinics were not accepting new patients and a third of those cited COVID-19 as the reason, according to research published July 23 in the journal <em>JAMA Network Open</em>.</p><p>The findings highlight shortcomings providing prompt access to people seeking treatment for opioid addiction, the authors say.</p>','With summer in full swing and excessive heat waves rolling through parts of the country, taking a dip in water can be a refreshing way to cool off.','2021-07-24 23:12:16',1,'assets/images/blog/04.jpg',3,8,'Hidden','What to do to stay safe around water this summer at the pool or beach'),(50,'Whilst the industry continues to focus on the development of vaccines and therapies in response to COVID-19, the crisis has had a considerable impact on clinical trials in other therapy areas, particularly on cardiovascular, dermatology and metabolic. Even though significant regulatory agencies, such as the FDA and EMEA, have promoted guidelines and measures for maintaining the integrity of the trials that attempt to guarantee the rights, safety and wellbeing of patients and healthcare staff during this COVID-19 pandemic, maintaining clinical trials and keeping them on track has been severely challenging.','No Description','2021-06-22 00:47:44',0,'assets/images/blog/05.jpg',3,5,'Published','Pre-COVID-19 vs post-COVID-19 – clinical trial challenges revealed'),(51,'Do you think you\'re living an ordinary life? You are so mistaken it\'s difficult to even explain. The mere fact that you exist makes you extraordinary. The odds of you existing are less than winning the lottery, but here you are. Are you going to let this extraordinary opportunity pass?\r\nShe had come to the conclusion that you could tell a lot about a person by their ears. The way they stuck out and the size of the earlobes could give you wonderful insights into the person. Of course, she couldn\'t scientifically prove any of this, but that didn\'t matter to her. Before anything else, she would size up the ears of the person she was talking to.\r\nIt\'s always good to bring a slower friend with you on a hike. If you happen to come across bears, the whole group doesn\'t have to worry. Only the slowest in the group do. That was the lesson they were about to learn that day.','Recent events have only reinforced the frailty of our existence as well as a collective responsibility to help one another.','2021-06-22 00:47:44',1,'assets/images/blog/06.jpg',3,6,'Hidden','Study reflects shortcomings in how the U.S. handles care for people with opioid addiction'),(52,'\"It was so great to hear from you today and it was such weird timing,\" he said. \"This is going to sound funny and a little strange, but you were in a dream I had just a couple of days ago. I\'d love to get together and tell you about it if you\'re up for a cup of coffee,\" he continued, laying the trap he\'d been planning for years.\r\nColors bounced around in her head. They mixed and threaded themselves together. Even colors that had no business being together. They were all one, yet distinctly separate at the same time. How was she going to explain this to the others?','Whilst expected, there is no guarantee when another pandemic will hit again or what the impact would look like.','2021-06-22 00:58:56',1,'assets/images/blog/07.jpg',3,6,'Hidden','Study finds unacceptable mental health service shortfalls for children in high-income countries'),(53,'Researchers found that of the one in eight children (12.7 per cent) who experience a mental disorder, less than half (44.2 per cent) receive any services for these conditions.  Using systematic review methods, the researchers examined 14 prevalence surveys conducted in 11 high-income countries that included a total of 61,545 children aged four to 18 years. Eight of the 14 studies also assessed service contacts. The 14 surveys were conducted between 2003 and 2020 in Canada as well as the US, Australia, Chile, Denmark, Great Britain, Israel, Lithuania, Norway, South Korea and Taiwan. Researchers note that mental health service provision lags behind services available to treat physical conditions in most of these countries. \"We would not find it acceptable to treat only 44 per cent of children who had cancer or diabetes or infectious diseases,\" says Waddell.','Most children with a mental health disorder are not receiving services to address their needs--according to a new study from researchers at Simon Fraser University\'s Children\'s Health Policy Centre.','2021-06-22 00:47:44',1,'assets/images/blog/08.jpg',3,7,'Hidden','Study finds unacceptable mental health service shortfalls for children in high-income countries'),(54,'Glaucoma results from irreversible neurodegeneration of the optic nerve, the bundle of axons from retinal ganglion cells that transmits signals from the eye to the brain to produce vision. Available therapies slow vision loss by lowering elevated eye pressure, however some glaucoma progresses to blindness despite normal eye pressure. Neuroprotective therapies would be a leap forward, meeting the needs of patients who lack treatment options. The CaMKII (calcium/calmodulin-dependent protein kinase II) pathway regulates key cellular processes and functions throughout the body, including retinal ganglion cells in the eye. Yet the precise role of CaMKII in retinal ganglion cell health is not well understood. Inhibition of CaMKII activity, for example, has been shown to be either protective or detrimental to retinal ganglion cells, depending on the conditions. Using an antibody marker of CaMKII activity, Chen\'s team discovered that CaMKII pathway signaling was compromised whenever retinal ganglion cells were exposed to toxins or trauma from a crush injury to the optic nerve, suggesting a correlation between CaMKII activity and retinal ganglion cell survival. Searching for ways to intervene, they found that activating the CaMKII pathway with gene therapy proved protective to the retinal ganglion cells. Administering the gene therapy to mice just prior to the toxic insult (which initiates rapid damage to the cells), and just after optic nerve crush (which causes slower damage), increased CaMKII activity and robustly protected retinal ganglion cells.','A form of gene therapy protects optic nerve cells and preserves vision in mouse models of glaucoma, according to research supported by NIH\'s National Eye Institute','2021-06-22 00:47:44',1,'assets/images/blog/09.jpg',3,5,'Published','Gene therapy protects optic nerve cells and preserves vision in glaucoma mouse models'),(55,'Thus, an increased GP or hospital visit frequency for specific physical conditions in combination with the need for mental health or cognitive referrals may be important prodromal hallmarks of MS. The combination of antidepressants and antibiotic use seems to be highly associated with the prodromal stage of MS – perhaps to treat symptoms not yet recognized as MS before MS is diagnosed. However, there are some important caveats to this study. Firstly, many of these complaints are largely non-exclusive in everyday life, and simply visiting your GP for sensory dysfunction or mental health-related issues is not specific to the prodromal stage of MS. Even the combination of receiving antidepressants and antibiotics whilst having some degree of musculoskeletal dysfunction is not sufficiently an exclusive combination of MS prodrome. However, it does suggest that these combinations may be related to an increased chance of an MS diagnosis within 5 years and assessments for MS at this stage would only benefit the individual – even if it turns out not to be associated with MS.','MS patients who began natalizumab treatment 1-2 years earlier than those who started later displayed a clear and significant improvement in mortality','2021-07-24 23:08:52',1,'assets/images/blog/01.jpg',3,8,'Hidden','multiple sclerosis (MS) is a demyelinating disorder with varying symptoms and progression from person to person'),(56,'As increased optimism surrounded the control of the virus, the impact on life is still to be fully understood. Some forecasts predict grim long-term societal and financial consequences, across several countries. Whilst the tragic loss of life and the impact on the quality of life should not be overlooked, there are positives to come out of this crisis. This article will outline the impact on clinical trials and drug and diagnostic development. However, many parallels with everyday life can be taken into consideration. Strength through adversity is a commonly used aphorism and one which is true of people and industries alike. When confronted with challenges, human inventiveness knows no limits and COVID-19 has been both the mother of innovation but also the catalyst for the widespread adoption of current technologies. Thus, it is of little surprise that the clinical trial market has swiftly adjusted to the new paradigm circumscribed by restrictions on social interaction, by looking to leverage technological solutions.','Whilst pandemics are thankfully not common; COVID-19 has brought with it a profound global impact.','2021-07-24 23:08:52',1,'assets/images/blog/02.jpg',3,6,'Hidden','The impact of COVID-19 on clinical trials');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_category`
--

DROP TABLE IF EXISTS `post_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_category`
--

LOCK TABLES `post_category` WRITE;
/*!40000 ALTER TABLE `post_category` DISABLE KEYS */;
INSERT INTO `post_category` VALUES (1,'Children Care','Category related to the care of children'),(2,'Education','Category related to the education of children'),(3,'Health','Category related to the health of children'),(4,'Nutrition','Category related to the nutrition of children');
/*!40000 ALTER TABLE `post_category` ENABLE KEYS */;
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
  `reservation_date` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `checkup_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `customer_id` (`customer_id`) USING BTREE,
  KEY `staff_id` (`staff_id`) USING BTREE,
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (102,131,'2021-07-25 00:00:00','Submitted',4,'2021-07-29 00:00:00'),(103,1,'2021-07-30 00:00:00','Cancel',4,'2021-07-29 00:00:00'),(104,2,'2021-07-16 00:00:00','Submitted',4,'2021-07-29 00:00:00'),(105,2,'2021-07-17 00:00:00','Approved',4,'2021-07-30 00:00:00'),(106,3,'2021-07-22 00:00:00','Approved',4,'2021-07-28 00:00:00'),(107,4,'2021-07-29 00:00:00','Cancel',4,'2021-07-29 00:00:00'),(108,3,'2021-07-02 00:00:00','Submitted',4,'2021-07-28 00:00:00'),(109,1,'2021-07-04 00:00:00','Submitted',4,'2021-07-27 00:00:00'),(110,4,'2021-07-08 00:00:00','Approved',4,'2021-07-28 00:00:00'),(111,2,'2021-07-08 00:00:00','Approved',4,'2021-07-28 00:00:00'),(112,5,'2021-07-20 00:00:00','Approved',4,'2021-07-28 00:00:00'),(113,3,'2021-07-29 00:00:00','Submitted',4,'2021-07-27 00:00:00');
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
INSERT INTO `reservation_service` VALUES (102,11,3,300000);
/*!40000 ALTER TABLE `reservation_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Admin'),(2,'Manager'),(3,'Staff'),(4,'Customer');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
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
  `status` varchar(255) DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `category_id` (`category_id`),
  CONSTRAINT `service_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `service_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'Anesthesiology',100000.00,90000.00,'./img/service_1.jpg',1,'Service 1','Service 1',NULL,NULL,'1',NULL),(2,'\r\nClinical Nutrition',100000.00,100000.00,'./img/service_2.jpg',2,'Service 2','Service 2',NULL,NULL,'1',NULL),(3,'Endocrinology',460000.00,150000.00,'./img/service_3.jpg',3,'Service 3','Service 3',NULL,NULL,'1',NULL),(4,'Gastroenterology',100000.00,80000.00,'./img/service_4.jpg',1,'Service 4','Service 4','2021-07-25 22:34:26',0,'0',12),(5,'Heart Disease',500000.00,100000.00,'./img/service_5.jpg',2,'Service 5','Service 5',NULL,NULL,'1',NULL),(6,'LGBTQ Health',200000.00,150000.00,'./img/service_6.jpg',3,'Service 6','Service 6',NULL,NULL,'1',NULL),(7,'\r\nLong COVID',700000.00,90000.00,'./img/service_7.jpg',1,'Service 7','Service 7',NULL,NULL,'1',NULL),(8,'Neurosurgery',100000.00,80000.00,'./img/service_8.jpg',2,'Service 8','Service 8',NULL,NULL,'1',NULL),(9,'\r\nOphthalmology',200000.00,150000.00,'./img/service_9.jpg',3,'Service 9','Service 9',NULL,NULL,'1',NULL),(10,'\r\nPharmacy',100000.00,90000.00,'./img/service_10.jpg',4,'Service 10','Service 10',NULL,NULL,'1',NULL),(11,'Pulmonology',300000.00,100000.00,'./img/service_11.jpg',4,'Service 11','Service 11','2021-07-25 22:34:38',0,'0',18),(12,'CAR T-Cell therapy',250000.00,100000.00,'./img/service_12.jpg',4,'Service 12','Service 12',NULL,NULL,'1',NULL);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_category`
--

DROP TABLE IF EXISTS `service_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_category`
--

LOCK TABLES `service_category` WRITE;
/*!40000 ALTER TABLE `service_category` DISABLE KEYS */;
INSERT INTO `service_category` VALUES (1,'Pediatrics','Pediatric services for children'),(2,'Cardiology','Cardiology services for children'),(3,'Neurosurgery','Neurosurgery services for children'),(4,'Cancer Care','Cancer care services for children');
/*!40000 ALTER TABLE `service_category` ENABLE KEYS */;
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
  `author_id` int DEFAULT NULL,
  `update_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_slider_author` (`author_id`),
  CONSTRAINT `fk_slider_author` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slider`
--

LOCK TABLES `slider` WRITE;
/*!40000 ALTER TABLE `slider` DISABLE KEYS */;
INSERT INTO `slider` VALUES (1,'A  Response Plan to counter Covid-19','./img/slider1.jpg','#',1,'Pushing the boundaries of what’s possible in children’s health.',NULL,NULL),(2,'Medical Emergencies Always Come Unannounced!','./img/slider2.jpg','#',1,'Get the most advanced emergency care anywhere in just minutes.',NULL,NULL),(5,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none',NULL,NULL),(6,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none',NULL,NULL),(7,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none',NULL,NULL),(8,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none',NULL,NULL),(9,'HueMedical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none',NULL,NULL),(10,'naviMedical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#',0,'none',NULL,NULL),(11,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.',NULL,NULL),(12,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.',NULL,NULL),(13,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.',NULL,NULL),(14,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.',NULL,NULL),(15,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.',NULL,NULL),(16,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.',NULL,NULL),(18,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#',0,'Get the most advanced emergency care anywhere in just minutes.',NULL,NULL);
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
  `full_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `image_link` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_roleid_idx` (`role_id`) USING BTREE,
  CONSTRAINT `FK_roleid` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (-1,'guest','none','guest',1,'0123456789','nowhere','#',4,'14'),(1,'childrencaresystemse1874@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Giang',1,'0974484610','Vietnam','assets/images/default.png',1,'14'),(2,'hattnhe153222@fpt.edu.vn','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Ha',0,'0974484610','Viet Nam','assets/images/default.png',4,'14'),(3,'anhntnhe151378@fpt.edu.vn','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Ngoc Anh',0,'0974484610','Viet Nam','assets/images/default.png',2,'14'),(4,'nguyetanh0944@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Nguyet Anh',0,'0974484610','Viet Nam','assets/images/default.png',3,'14'),(5,'minhhnhe151181@fpt.edu.vn','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Minh',1,'0974484610','Viet Nam','assets/images/default.png',3,'14'),(91,'Fusce.dolor@auctor.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Cameran Randall',1,'03 3098 2170','676-4438 At, Rd.','assets/images/default.png',3,'16'),(92,'Aliquam.fringilla.cursus@tellusPhaselluselit.net','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Travis Booth',1,'05 2741 5626','855-6756 Aliquam St.','assets/images/default.png',3,'16'),(93,'Cum.sociis@lectusNullamsuscipit.edu','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Erasmus Miles',0,'06 5922 9897','P.O. Box 578, 1680 Nunc Ave','assets/images/default.png',4,'17'),(94,'imperdiet@semut.net','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Virginia Patrick',0,'09 0823 2167','8273 Lorem St.','assets/images/default.png',4,'15'),(95,'dolor.elit.pellentesque@gravida.net','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Merrill Dodson',1,'08 4181 7222','P.O. Box 968, 2771 Nunc Ave','assets/images/default.png',4,'15'),(96,'pede.Nunc@rutrummagnaCras.net','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Herrod Garrison',0,'01 5261 9252','P.O. Box 100, 7977 Eget Rd.','assets/images/default.png',4,'15'),(97,'sit.amet.consectetuer@enimcondimentumeget.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Nyssa Whitehead',0,'03 1619 9741','348 Sapien, Rd.','assets/images/default.png',4,'16'),(98,'in.molestie@consectetuerrhoncusNullam.ca','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Rhoda Atkins',1,'07 1611 8568','294-8716 Justo Rd.','assets/images/default.png',4,'16'),(99,'tempor@necligula.edu','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Jonah Delacruz',1,'07 4581 3242','Ap #210-5290 Amet Street','assets/images/default.png',4,'17'),(100,'pede.nonummy@id.edu','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Jolene Hatfield',1,'03 7598 6632','377-4202 Sit St.','assets/images/default.png',4,'17'),(101,'augue@necurnasuscipit.org','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Jana Everett',1,'09 5683 8841','650-539 Pharetra Rd.','assets/images/default.png',4,'17'),(102,'auctor.Mauris@aliquetmagna.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Maryam Coffey',0,'00 8591 6584','9325 Libero Av.','assets/images/default.png',4,'16'),(103,'cursus@estacfacilisis.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Kermit Burton',0,'01 1323 3633','Ap #900-8190 Lacus, St.','assets/images/default.png',4,'17'),(104,'tempor@sociosquad.ca','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Merritt Buckley',0,'00 2488 9979','P.O. Box 169, 5855 Sed Ave','assets/images/default.png',4,'15'),(105,'venenatis.vel@auctor.edu','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Benjamin Roman',1,'06 3883 3084','374-9446 Mus. Avenue','assets/images/default.png',4,'17'),(106,'ultrices.posuere@perinceptos.net','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Ian Potter',0,'06 3685 0102','P.O. Box 708, 2807 Nunc Ave','assets/images/default.png',4,'15'),(107,'Cras.lorem@faucibusutnulla.co.uk','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Craig Albert',1,'06 5895 7788','P.O. Box 656, 5569 Nec Road','assets/images/default.png',4,'15'),(108,'arcu.Vestibulum.ut@infaucibus.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Jameson Savage',0,'08 0534 5067','344-8652 Sem Road','assets/images/default.png',4,'17'),(109,'sem.Pellentesque.ut@iaculisenim.edu','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Dillon Beach',0,'08 0362 8209','P.O. Box 795, 863 Enim. Rd.','assets/images/default.png',4,'16'),(110,'erat.Vivamus@musProinvel.co.uk','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Ebony Dean',1,'08 9087 2089','P.O. Box 187, 8252 Tellus Ave','assets/images/default.png',4,'15'),(111,'ultrices.sit.amet@scelerisque.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Cedric Young',0,'09 5523 8563','8655 Dolor. Road','assets/images/default.png',4,'16'),(112,'mauris@enimcondimentum.org','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Lillith Morton',1,'07 5555 0052','Ap #737-2514 Neque St.','assets/images/default.png',4,'16'),(113,'dolor.quam.elementum@Suspendisseseddolor.org','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Ezra Banks',0,'07 1798 5418','P.O. Box 357, 6736 Nisl. St.','assets/images/default.png',4,'15'),(114,'porttitor.vulputate@etmalesuada.net','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Debra Rodgers',1,'04 7276 6369','P.O. Box 407, 317 Cras Road','assets/images/default.png',4,'16'),(115,'ac.mi.eleifend@metus.org','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Basil Holmes',1,'07 0184 5611','P.O. Box 351, 9486 Dolor Street','assets/images/default.png',4,'17'),(116,'Duis.volutpat@dapibusquam.edu','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Kermit Madden',1,'02 5291 5691','371-7540 Ultricies Av.','assets/images/default.png',4,'17'),(117,'aliquam.adipiscing.lacus@hendreritconsectetuer.edu','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Merritt Love',0,'02 8510 5414','989-5503 Vestibulum, Rd.','assets/images/default.png',4,'17'),(118,'Nunc.sollicitudin.commodo@nibhAliquam.org','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Olga Merrill',0,'03 0153 1977','639-8895 Nulla Rd.','assets/images/default.png',4,'17'),(119,'porttitor.interdum.Sed@inaliquet.co.uk','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Camden Mcclure',1,'08 7569 4261','753-4388 Etiam St.','assets/images/default.png',4,'16'),(120,'congue@odiotristique.edu','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Keane Pitts',1,'04 7014 7684','Ap #446-1701 Cursus Rd.','assets/images/default.png',4,'15'),(121,'dui@Quisquefringilla.net','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Maile Dillon',0,'07 6283 3004','7075 Non Av.','assets/images/default.png',4,'16'),(122,'sit.amet.risus@sagittis.co.uk','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Azalia Kirkland',1,'01 0267 4556','5299 Hendrerit Rd.','assets/images/default.png',4,'15'),(123,'elit.Nulla.facilisi@ametrisus.ca','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Mohammad Frye',1,'07 4728 5661','P.O. Box 109, 4891 Neque Av.','assets/images/default.png',4,'15'),(124,'odio@ridiculus.net','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Melvin Juarez',0,'07 4577 7948','586-936 Dictum Road','assets/images/default.png',4,'16'),(125,'Mauris.nulla@quamvelsapien.co.uk','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Hamilton Berg',0,'05 4379 9506','Ap #196-3025 Blandit Av.','assets/images/default.png',4,'16'),(126,'metus.Aliquam@fermentumconvallis.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Trevor Williams',0,'00 2660 8006','Ap #908-5583 Rhoncus. Street','assets/images/default.png',4,'15'),(127,'ridiculus.mus@pretium.ca','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Herrod Armstrong',1,'09 6236 0421','Ap #162-5003 Ut Street','assets/images/default.png',4,'15'),(128,'dui.lectus.rutrum@infelis.ca','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Ashton Houston',1,'06 2648 5883','1432 A St.','assets/images/default.png',4,'16'),(129,'sociis@vitae.org','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','MacKensie Morris',0,'05 3255 1627','7704 Vestibulum St.','assets/images/default.png',4,'15'),(130,'Phasellus.ornare@massarutrummagna.net','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Mariko Jacobs',0,'03 4174 1097','786-4568 Ridiculus Avenue','assets/images/default.png',4,'16'),(131,'nguyetanh0945@gmail.com','7mxNXPJ8xHU4gIVOe71ohJK46Kc=','Bui Hoang Nguyet Anh',0,'0972427628','Hai Phong','assets/images/default.png',4,'Inactive');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_schedule`
--

DROP TABLE IF EXISTS `work_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_schedule` (
  `doctor_id` int NOT NULL,
  `start_at` timestamp NULL DEFAULT NULL,
  `end_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`doctor_id`) USING BTREE,
  CONSTRAINT `work_schedule_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_schedule`
--

LOCK TABLES `work_schedule` WRITE;
/*!40000 ALTER TABLE `work_schedule` DISABLE KEYS */;
INSERT INTO `work_schedule` VALUES (3,'2024-10-20 02:19:10','2024-10-20 04:19:10'),(4,'2024-10-20 02:19:10','2024-10-20 04:19:10'),(91,'2024-10-20 02:19:10','2024-10-20 04:19:10');
/*!40000 ALTER TABLE `work_schedule` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-22 13:21:57
