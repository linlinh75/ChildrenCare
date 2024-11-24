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
  `isPublic` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `service_id` (`service_id`) USING BTREE,
  KEY `user_id` (`user_id`),
  KEY `fk_feedback_reservation` (`reservation_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_feedback_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,47,0,'No feedback',8,NULL,'Processed',28,'2024-10-24 16:05:42',0),(2,47,0,'No feedback',11,NULL,'Processed',23,'2024-10-24 16:05:42',0),(3,46,3,'ok',3,NULL,'Processed',24,'2024-10-24 16:11:25',1),(4,46,0,NULL,6,NULL,'Processing',25,'2024-11-10 11:02:32',0),(5,44,5,NULL,1,NULL,'Processing',26,'2024-11-10 11:02:32',1),(6,44,4,NULL,3,NULL,'Processing',27,'2024-11-10 11:02:32',1),(7,45,2,NULL,2,NULL,'Processing',28,'2024-11-10 11:02:32',1),(8,45,1,NULL,3,NULL,'Processing',29,'2024-11-10 11:02:32',1);
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_examination`
--

DROP TABLE IF EXISTS `medical_examination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_examination` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reservation_id` int NOT NULL,
  `user_id` int NOT NULL,
  `prescription` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `author_id` int DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_user_exam` (`user_id`) USING BTREE,
  KEY `author_id` (`author_id`),
  KEY `fk_reservation_exam` (`reservation_id`),
  CONSTRAINT `fk_reservation_exam` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_exam` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `medical_examination_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_examination`
--

LOCK TABLES `medical_examination` WRITE;
/*!40000 ALTER TABLE `medical_examination` DISABLE KEYS */;
INSERT INTO `medical_examination` VALUES (1,25,45,'Cannot use more medicine.',3,'2024-08-31 17:00:00'),(2,26,47,'Must not use paracetamol',3,'2024-08-31 17:00:00'),(3,18,18,'Should come back to hospital',3,'2024-08-31 17:00:00'),(4,12,3,'3 times a day',3,'2024-08-31 17:00:00'),(5,3,2,'You need to go to big hospital',3,'2024-08-31 17:00:00'),(6,5,3,'Comeback at next schdule',3,'2024-08-31 17:00:00'),(7,11,5,'Please comeback next time',3,'2024-08-31 17:00:00'),(124,20,45,'Treat mild fever and headache',3,'2024-11-23 17:00:00'),(125,23,45,'Antibiotics for bacterial infection',3,'2024-11-23 17:00:00'),(126,28,47,'Allergy treatment',3,'2024-11-24 06:00:43'),(127,57,47,'Treatment for Type 2 Diabetes',3,'2024-11-24 06:10:43'),(128,55,47,'Post-surgery pain management',3,'2024-11-24 06:31:04');
/*!40000 ALTER TABLE `medical_examination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicines`
--

DROP TABLE IF EXISTS `medicines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicines` (
  `id` int NOT NULL AUTO_INCREMENT,
  `examination_id` int DEFAULT NULL,
  `medicine_name` varchar(255) DEFAULT NULL,
  `dosage` varchar(255) DEFAULT NULL,
  `instructions` text,
  PRIMARY KEY (`id`),
  KEY `examination_id` (`examination_id`),
  CONSTRAINT `medicines_ibfk_1` FOREIGN KEY (`examination_id`) REFERENCES `medical_examination` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicines`
--

LOCK TABLES `medicines` WRITE;
/*!40000 ALTER TABLE `medicines` DISABLE KEYS */;
INSERT INTO `medicines` VALUES (1,1,'Amlodipine','5mg once daily','Take after meals'),(2,1,'Aspirin','75mg once daily','Take in the morning with water'),(3,2,'Omeprazole','20mg twice daily','Take 30 minutes before meals'),(4,3,'Adapalene Gel','Apply a thin layer before bed','Avoid sun exposure after application'),(5,3,'Clindamycin Gel','Apply in the morning','Use only on affected areas'),(6,124,'Paracetamol',' 500 mg','Take one tablet every 6 hours after meals.'),(7,124,'Ibuprofen','200 mg','Take one tablet every 8 hours as needed for pain.'),(8,125,'Amoxicillin','500 mg','Take one capsule three times daily for 7 days.'),(9,125,'Probiotic Capsules','1 capsule ','Take one capsule daily to support gut health while on antibiotics.'),(10,126,'Loratadine','10 mg','Take one tablet once daily, preferably in the morning.'),(11,126,'Hydrocortisone Cream','Apply a thin layer to affected area',' Use twice daily to relieve itching and redness.'),(12,127,'Metformin','500 mg','Take one tablet twice daily after meals.'),(13,127,'Insulin Glargine','10 units',' Inject subcutaneously once daily before bedtime.'),(14,128,'Tramadol',' 50 mg','Take one tablet every 4-6 hours as needed for pain, but not more than 4 tablets per day.'),(15,128,'Omeprazole','20 mg','Take one capsule daily before breakfast to prevent gastric irritation.'),(16,128,'Metformin','500 mg','Take one tablet once daily, preferably in the morning.');
/*!40000 ALTER TABLE `medicines` ENABLE KEYS */;
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
INSERT INTO `password_reset_tokens` VALUES (1,'xgazsqeqbvnsvcboahvv','anhbhnhe180164@fpt.edu.vn','2024-11-10 02:43:38','2024-11-10 02:53:38',49);
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'<blockquote>\r\n<p>This is a quote from a famous person</p>\r\n</blockquote>\r\n\r\n<p>FRESNO, Calif. &mdash; On a Tuesday afternoon in April, among tables of vegetables, clothes and telephone chargers at Fresno&rsquo;s biggest outdoor flea market were prescription drugs being sold as treatments for Covid. Vendors sold $25 injections of the steroid dexamethasone, several kinds of antibiotics and the anti-parasitic drug ivermectin. Chloroquine and hydroxychloroquine &mdash; the malaria drugs pushed by President Donald J. Trump last year &mdash; make regular appearances at the market as well, as do sham herbal supplements. Health and consumer protection agencies have repeatedly warned that several of these treatments, as well as vitamin infusions and expensive injections of &ldquo;peptide therapies&rdquo; sold at alternative wellness clinics for more than $1,000, are not supported by reliable scientific evidence. But such unproven remedies, often promoted by doctors and companies on social media, have appealed to many people in low-income immigrant communities in places across the country where Covid-19 rates have been high but access to health care is low.</p>\r\n\r\n<p>Some turn to unregulated drugs because mainstream medicine is too expensive or is inaccessible because of language or cultural barriers. &quot;It&rsquo;s disappointing but not surprising&rdquo; that people living below the poverty line have spent large sums of money for unproven treatments for Covid-19, said Rais Vohra, the interim head of Fresno County&rsquo;s health department. &ldquo;People are desperate and bombarded with misinformation and may not have the skills, time or context to interpret medical evidence.&rdquo;</p>\r\n','Shut out from mainstream medicine, some immigrants are buying expensive, unproven Covid therapies from wellness clinics or turning to the black market.','2024-07-24 23:08:52',1,'assets/images/blog/01.jpg',3,5,'Published','Desperate for covid care, immigrants are struggling to find cure'),(2,'<p>A study published in the Multiple Sclerosis Journal found that prospective MS patients often had an increased frequency of hospital/GP visits up to 5 years before a clinical diagnosis for their MS symptoms. As with many diseases, the prodromal (pre-symptomatic) stage of disease may or may not come with any noticeable symptoms. However, there may be additional signs which may present during this stage that could be important features associated with the onset of disease-related symptoms in the months or years to come. According to their findings, hospital, and GP visits for 2-4x higher in the prodromal 5 years before MS diagnoses compared to healthy controls. Interestingly, these were specific for conditions related to the sensory organs, the musculoskeletal system, and the genito-urinary system. In addition, people who developed MS had 50% more physician visits for mental health and cognitive related issues (including mood and anxiety disorders) in the 5 years before their symptoms or diagnoses compared to controls, with prescriptions for antidepressants being common, as well as prescriptions for antibiotics.</p>','<p>Talk of \'gain-of-function\' research, a muddy category at best, brings up deep questions about how scientists should study viruses and other pathogens.</p>','2024-11-10 14:28:05',1,'assets/images/blog/02.jpg',3,1,'Hidden','   '),(3,'<p>Getting an early diagnosis for multiple sclerosis (MS) is important in ensuring better long-term outcomes and quality of life. The challenge, however, is that getting an early diagnosis for MS is challenging and diagnoses are currently made in advanced disease stages. MS varies considerably between patients depending on the type and the parts of the body affected. Many of the symptoms of MS can also be associated with other disorders often complicating diagnoses. However, some of the most common symptoms include fatigue, pain, problems with walking or holding items, numbness or tingling in various parts of the body, problems with vision, issues with balance and coordination, bladder/bowel/sexual problems as well as some degree of cognitive disturbances. The most common type of MS (around 80% of all cases) is relapse remitting MS in which there are episodes of existing or new symptoms which worsen over days or weeks/months (relapse) and episodes of slow recovery over time (remitting). However, as the disease progresses over many years, the condition becomes progressively worse (secondary progressive MS). Around 10% of all cases are primary progressive MS cases where symptoms gradually become worse from onset without any remission.</p>','<p>Organisers are to decide as soon as Monday whether to allow domestic spectators into the stadiums for the Games, which were delayed by a year due to the pandemic and now set to start in about a month. Foreign spectators have already been banned.</p>','2024-11-09 00:01:45',1,'assets/images/blog/03.jpg',3,5,'Hidden','Olympics venue medical officers want no spectators amid COVID-19 fears'),(4,'<p>As opioid overdose deaths rose during the COVID-19 pandemic, people seeking treatment for opioid addiction had to wait nearly twice as long to begin methadone treatment in the United States than in Canada, a new Yale study has shown.</p><p>In both countries during the pandemic, about one in 10 methadone clinics were not accepting new patients and a third of those cited COVID-19 as the reason, according to research published July 23 in the journal <em>JAMA Network Open</em>.</p><p>The findings highlight shortcomings providing prompt access to people seeking treatment for opioid addiction, the authors say.</p>','With summer in full swing and excessive heat waves rolling through parts of the country, taking a dip in water can be a refreshing way to cool off.','2024-07-24 23:12:16',1,'assets/images/blog/04.jpg',3,8,'Hidden','What to do to stay safe around water this summer at the pool or beach'),(5,'Whilst the industry continues to focus on the development of vaccines and therapies in response to COVID-19, the crisis has had a considerable impact on clinical trials in other therapy areas, particularly on cardiovascular, dermatology and metabolic. Even though significant regulatory agencies, such as the FDA and EMEA, have promoted guidelines and measures for maintaining the integrity of the trials that attempt to guarantee the rights, safety and wellbeing of patients and healthcare staff during this COVID-19 pandemic, maintaining clinical trials and keeping them on track has been severely challenging.','No Description','2024-06-22 00:47:44',0,'assets/images/blog/05.jpg',3,5,'Published','Pre-COVID-19 vs post-COVID-19 – clinical trial challenges revealed'),(6,'Do you think you\'re living an ordinary life? You are so mistaken it\'s difficult to even explain. The mere fact that you exist makes you extraordinary. The odds of you existing are less than winning the lottery, but here you are. Are you going to let this extraordinary opportunity pass?\r\nShe had come to the conclusion that you could tell a lot about a person by their ears. The way they stuck out and the size of the earlobes could give you wonderful insights into the person. Of course, she couldn\'t scientifically prove any of this, but that didn\'t matter to her. Before anything else, she would size up the ears of the person she was talking to.\r\nIt\'s always good to bring a slower friend with you on a hike. If you happen to come across bears, the whole group doesn\'t have to worry. Only the slowest in the group do. That was the lesson they were about to learn that day.','Recent events have only reinforced the frailty of our existence as well as a collective responsibility to help one another.','2024-06-22 00:47:44',1,'assets/images/blog/06.jpg',3,6,'Hidden','Study reflects shortcomings in how the U.S. handles care for people with opioid addiction'),(7,'\"It was so great to hear from you today and it was such weird timing,\" he said. \"This is going to sound funny and a little strange, but you were in a dream I had just a couple of days ago. I\'d love to get together and tell you about it if you\'re up for a cup of coffee,\" he continued, laying the trap he\'d been planning for years.\r\nColors bounced around in her head. They mixed and threaded themselves together. Even colors that had no business being together. They were all one, yet distinctly separate at the same time. How was she going to explain this to the others?','Whilst expected, there is no guarantee when another pandemic will hit again or what the impact would look like.','2024-06-22 00:58:56',1,'assets/images/blog/07.jpg',3,6,'Hidden','Study finds unacceptable mental health service shortfalls for children in high-income countries'),(8,'Researchers found that of the one in eight children (12.7 per cent) who experience a mental disorder, less than half (44.2 per cent) receive any services for these conditions.  Using systematic review methods, the researchers examined 14 prevalence surveys conducted in 11 high-income countries that included a total of 61,545 children aged four to 18 years. Eight of the 14 studies also assessed service contacts. The 14 surveys were conducted between 2003 and 2020 in Canada as well as the US, Australia, Chile, Denmark, Great Britain, Israel, Lithuania, Norway, South Korea and Taiwan. Researchers note that mental health service provision lags behind services available to treat physical conditions in most of these countries. \"We would not find it acceptable to treat only 44 per cent of children who had cancer or diabetes or infectious diseases,\" says Waddell.','Most children with a mental health disorder are not receiving services to address their needs--according to a new study from researchers at Simon Fraser University\'s Children\'s Health Policy Centre.','2024-06-22 00:47:44',1,'assets/images/blog/08.jpg',3,7,'Hidden','Study finds unacceptable mental health service shortfalls for children in high-income countries'),(9,'Glaucoma results from irreversible neurodegeneration of the optic nerve, the bundle of axons from retinal ganglion cells that transmits signals from the eye to the brain to produce vision. Available therapies slow vision loss by lowering elevated eye pressure, however some glaucoma progresses to blindness despite normal eye pressure. Neuroprotective therapies would be a leap forward, meeting the needs of patients who lack treatment options. The CaMKII (calcium/calmodulin-dependent protein kinase II) pathway regulates key cellular processes and functions throughout the body, including retinal ganglion cells in the eye. Yet the precise role of CaMKII in retinal ganglion cell health is not well understood. Inhibition of CaMKII activity, for example, has been shown to be either protective or detrimental to retinal ganglion cells, depending on the conditions. Using an antibody marker of CaMKII activity, Chen\'s team discovered that CaMKII pathway signaling was compromised whenever retinal ganglion cells were exposed to toxins or trauma from a crush injury to the optic nerve, suggesting a correlation between CaMKII activity and retinal ganglion cell survival. Searching for ways to intervene, they found that activating the CaMKII pathway with gene therapy proved protective to the retinal ganglion cells. Administering the gene therapy to mice just prior to the toxic insult (which initiates rapid damage to the cells), and just after optic nerve crush (which causes slower damage), increased CaMKII activity and robustly protected retinal ganglion cells.','A form of gene therapy protects optic nerve cells and preserves vision in mouse models of glaucoma, according to research supported by NIH\'s National Eye Institute','2024-06-22 00:47:44',1,'assets/images/blog/09.jpg',3,5,'Published','Gene therapy protects optic nerve cells and preserves vision in glaucoma mouse models'),(10,'Thus, an increased GP or hospital visit frequency for specific physical conditions in combination with the need for mental health or cognitive referrals may be important prodromal hallmarks of MS. The combination of antidepressants and antibiotic use seems to be highly associated with the prodromal stage of MS – perhaps to treat symptoms not yet recognized as MS before MS is diagnosed. However, there are some important caveats to this study. Firstly, many of these complaints are largely non-exclusive in everyday life, and simply visiting your GP for sensory dysfunction or mental health-related issues is not specific to the prodromal stage of MS. Even the combination of receiving antidepressants and antibiotics whilst having some degree of musculoskeletal dysfunction is not sufficiently an exclusive combination of MS prodrome. However, it does suggest that these combinations may be related to an increased chance of an MS diagnosis within 5 years and assessments for MS at this stage would only benefit the individual – even if it turns out not to be associated with MS.','MS patients who began natalizumab treatment 1-2 years earlier than those who started later displayed a clear and significant improvement in mortality','2024-07-24 23:08:52',1,'assets/images/blog/01.jpg',3,8,'Hidden','multiple sclerosis (MS) is a demyelinating disorder with varying symptoms and progression from person to person'),(11,'As increased optimism surrounded the control of the virus, the impact on life is still to be fully understood. Some forecasts predict grim long-term societal and financial consequences, across several countries. Whilst the tragic loss of life and the impact on the quality of life should not be overlooked, there are positives to come out of this crisis. This article will outline the impact on clinical trials and drug and diagnostic development. However, many parallels with everyday life can be taken into consideration. Strength through adversity is a commonly used aphorism and one which is true of people and industries alike. When confronted with challenges, human inventiveness knows no limits and COVID-19 has been both the mother of innovation but also the catalyst for the widespread adoption of current technologies. Thus, it is of little surprise that the clinical trial market has swiftly adjusted to the new paradigm circumscribed by restrictions on social interaction, by looking to leverage technological solutions.','Whilst pandemics are thankfully not common; COVID-19 has brought with it a profound global impact.','2024-07-24 23:08:52',1,'assets/images/blog/02.jpg',3,6,'Hidden','The impact of COVID-19 on clinical trials'),(13,'fasdfsadf','ádfsadf','2024-11-07 15:21:37',0,'/ChildrenCare/uploads/Screenshot 2024-10-23 162846.png',1,1,'Hidden','sdafasdf');
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
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_category`
--

LOCK TABLES `post_category` WRITE;
/*!40000 ALTER TABLE `post_category` DISABLE KEYS */;
INSERT INTO `post_category` VALUES (1,'Children Care','Category related to the care of children',1),(2,'Education','Category related to the education of children',1),(3,'Health','Category related to the health of children',1),(4,'Nutrition','Category related to the nutrition of children',1),(5,'LGBT','Category related to the nutrition of children',1);
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
  `payment_method` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `customer_id` (`customer_id`) USING BTREE,
  KEY `staff_id` (`staff_id`) USING BTREE,
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,131,'2024-09-01 00:00:00','Pending',0,'2024-10-29 00:00:00','VNPAY'),(2,1,'2024-09-02 00:00:00','Cancelled',4,'2024-09-09 09:00:00','VNPAY'),(3,2,'2024-09-03 00:00:00','Pending',4,'2024-10-30 00:00:00','VNPAY'),(4,2,'2024-09-04 00:00:00','Approved',4,'2024-10-29 00:00:00','VNPAY'),(5,3,'2024-09-05 00:00:00','Approved',4,'2024-10-29 00:00:00','VNPAY'),(6,4,'2024-09-06 00:00:00','Cancelled',4,'2024-09-13 09:00:00','VNPAY'),(7,3,'2024-09-07 00:00:00','Pending',4,'2024-10-29 00:00:00','VNPAY'),(8,47,'2024-09-08 00:00:00','Pending',4,'2024-10-30 00:00:00','VNPAY'),(9,4,'2024-09-09 00:00:00','Approved',4,'2024-10-29 00:00:00','VNPAY'),(10,2,'2024-09-10 00:00:00','Approved',4,'2024-10-30 00:00:00','VNPAY'),(11,5,'2024-09-11 00:00:00','Approved',4,'2024-10-30 00:00:00','VNPAY'),(12,3,'2024-09-12 00:00:00','Pending',4,'2024-10-29 00:00:00','VNPAY'),(13,47,'2024-09-15 00:00:00','Approved',1,'2024-10-29 00:00:00','VNPAY'),(14,47,'2024-09-16 00:00:00','Pending',2,'2024-10-29 00:00:00','VNPAY'),(15,47,'2024-09-17 00:00:00','Pending',3,'2024-10-29 00:00:00','VNPAY'),(16,47,'2024-09-18 00:00:00','Pending',4,'2024-10-29 00:00:00','VNPAY'),(17,47,'2024-09-19 00:00:00','Cancelled',1,'2024-09-26 15:00:00','VNPAY'),(18,47,'2024-09-20 00:00:00','Approved',2,'2024-10-29 00:00:00','VNPAY'),(19,47,'2024-09-21 00:00:00','Pending',3,'2024-10-29 00:00:00','VNPAY'),(20,45,'2024-09-22 00:00:00','Successful',4,'2024-09-20 09:00:00','VNPAY'),(21,47,'2024-09-23 00:00:00','Pending',1,'2024-10-29 00:00:00','VNPAY'),(22,47,'2024-09-24 00:00:00','Approved',2,'2024-10-29 00:00:00','VNPAY'),(23,45,'2024-09-15 00:00:00','Successful',4,'2024-09-22 09:00:00','VNPAY'),(24,45,'2024-09-18 00:00:00','Successful',4,'2024-09-30 09:00:00','VNPAY'),(25,45,'2024-10-24 11:22:53','Successful',3,'2024-10-26 11:22:00','VNPAY'),(26,47,'2024-10-24 11:26:53','Cancelled',3,'2024-11-09 11:26:00','VNPAY'),(27,47,'2024-10-24 13:51:40','Successful',3,'2024-10-31 13:51:00','VNPAY'),(28,47,'2024-10-24 14:52:26','Successful',3,'2024-11-01 14:52:00','VNPAY'),(29,47,'2024-10-24 15:56:09','Successful',3,'2024-08-24 08:57:00','VNPAY'),(30,47,'2024-10-24 16:24:47','Successful',3,'2024-10-26 16:24:00','VNPAY'),(31,47,'2024-10-24 16:26:16','Cancelled',3,'2024-11-01 16:26:00','VNPAY'),(32,49,'2024-10-31 17:28:49','Successful',3,'2024-11-02 17:28:00','VNPAY'),(33,49,'2024-11-04 10:33:19','Successful',3,'2024-11-07 10:33:00','VNPAY'),(34,49,'2024-11-06 21:25:24','Successful',3,'2024-11-15 21:25:00','VNPAY'),(35,47,'2024-11-08 23:16:25','Pending',3,'2024-11-16 23:16:00','VNPAY'),(36,47,'2024-11-20 00:14:10','Pending',NULL,'2024-11-13 09:13:00','VNPAY'),(37,47,'2024-11-20 00:17:05','Pending',3,'2024-11-16 09:15:00','VNPAY'),(38,47,'2024-11-20 00:26:38','Approved',3,'2024-11-28 00:26:00','VNPAY'),(39,47,'2024-11-20 00:36:12','Approved',NULL,'2024-11-15 00:36:00','VNPAY'),(40,47,'2024-11-21 00:41:13','Approved',NULL,'2024-11-28 00:41:00','VNPAY'),(41,47,'2024-11-21 00:45:28','Cancelled',NULL,'2024-11-27 00:45:00','VNPAY'),(42,47,'2024-11-21 00:57:02','Approved',NULL,'2024-11-28 00:57:00','VNPAY'),(43,47,'2024-11-22 00:58:53','Approved',NULL,'2024-11-28 00:58:00','VNPAY'),(44,47,'2024-11-22 02:57:01','Pending',NULL,'2024-11-22 06:56:00','VNPAY'),(45,47,'2024-11-22 03:06:51','Approved',3,'2024-11-21 03:06:00','VNPAY'),(46,49,'2024-11-22 03:36:43','Successful',3,'2024-11-27 03:36:00','VNPAY'),(47,47,'2024-11-22 11:42:12','Approved',3,'2024-11-15 11:42:00',NULL),(48,47,'2024-11-23 13:02:15','Approved',3,'2024-11-20 13:02:00',NULL),(49,47,'2024-11-23 13:05:55','Approved',3,'2024-11-21 13:05:00',NULL),(50,47,'2024-11-23 13:15:16','Approved',NULL,'2024-11-21 13:15:00',NULL),(51,47,'2024-11-23 13:18:49','Approved',3,'2024-11-29 13:18:00',NULL),(52,47,'2024-11-23 13:32:25','Approved',NULL,'2024-11-15 13:32:00',NULL),(53,47,'2024-11-23 13:34:11','Approved',NULL,'2024-11-29 13:34:00',NULL),(54,47,'2024-11-21 13:36:12','Approved',NULL,'2024-11-21 13:36:00',NULL),(55,47,'2024-11-20 13:48:52','Successful',3,'2024-11-22 13:48:00',NULL),(56,47,'2024-11-20 14:48:04','Pending',NULL,'2024-11-27 14:47:00',NULL),(57,47,'2024-11-19 00:33:51','Successful',3,'2024-11-23 13:00:00',NULL),(58,47,'2024-11-23 00:58:27','Pending',NULL,'2024-11-23 13:00:00',NULL),(59,47,'2024-11-23 10:22:46','Pending',NULL,'2024-11-23 10:22:00',NULL),(60,47,'2024-11-23 10:29:21','Pending',NULL,'2024-11-23 10:29:00',NULL),(61,47,'2024-11-23 10:30:58','Successful',3,'2024-11-29 10:30:00',NULL);
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
INSERT INTO `reservation_service` VALUES (1,1,1,100000),(1,2,1,100000),(1,3,1,460000),(2,4,1,100000),(2,5,1,500000),(3,6,1,200000),(3,7,1,700000),(4,8,1,100000),(4,9,1,200000),(5,10,1,100000),(5,11,1,300000),(6,1,1,90000),(6,12,1,250000),(7,2,1,100000),(8,3,1,150000),(8,4,1,80000),(9,5,1,100000),(9,6,1,150000),(10,7,1,90000),(10,8,1,80000),(11,9,1,150000),(11,10,1,90000),(12,11,1,100000),(12,12,1,100000),(13,1,1,90000),(14,2,1,100000),(15,3,1,150000),(16,4,1,80000),(17,5,1,100000),(18,6,1,150000),(19,7,1,90000),(20,8,1,80000),(21,9,1,150000),(22,10,1,90000),(23,11,1,100000),(24,12,1,100000),(25,3,1,150000),(26,3,1,150000),(27,2,1,100000),(27,5,1,100000),(28,1,1,90000),(28,2,1,100000),(29,1,1,90000),(29,2,1,100000),(30,3,1,150000),(31,3,1,150000),(32,3,1,150000),(33,3,1,150000),(34,3,1,150000),(35,3,1,150000),(36,1,1,90000),(36,7,1,90000),(37,3,1,150000),(38,3,1,150000),(39,3,1,150000),(39,6,1,150000),(40,7,1,90000),(41,6,1,150000),(42,2,1,100000),(43,2,1,100000),(43,7,1,90000),(44,1,1,90000),(44,3,1,150000),(45,2,1,100000),(45,3,1,150000),(46,3,1,150000),(46,6,1,150000),(47,2,1,100000),(47,3,1,150000),(48,2,1,100000),(49,3,1,150000),(50,3,1,150000),(51,3,1,150000),(52,3,1,150000),(53,2,1,100000),(54,2,1,100000),(55,2,1,100000),(56,2,1,100000),(56,3,1,150000),(57,3,1,150000),(57,5,1,100000),(58,5,1,100000),(59,5,1,100000),(60,5,1,100000),(61,5,1,100000);
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
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `details` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `updated_date` datetime DEFAULT NULL,
  `featured` tinyint(1) DEFAULT NULL,
  `status` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `category_id` (`category_id`),
  CONSTRAINT `service_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `service_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'Anesthesiology',100000.00,90000.00,'./img/service_1.jpg',1,'Service 1','Service 1',NULL,NULL,'0',NULL),(2,'\r\nClinical Nutrition',100000.00,100000.00,'./img/service_2.jpg',2,'Service 2','Service 2',NULL,NULL,'1',NULL),(3,'Endocrinology',460000.00,150000.00,'./img/service_3.jpg',3,'Service 3','Service 3',NULL,NULL,'1',NULL),(4,'Gastroenterology',100000.00,80000.00,'./img/service_4.jpg',1,'Service 4','Service 4','2021-07-25 22:34:26',0,'0',12),(5,'Heart Disease',500000.00,100000.00,'./img/service_5.jpg',2,'Service 5','Service 5',NULL,NULL,'1',NULL),(6,'LGBTQ Health',200000.00,150000.00,'./img/service_6.jpg',3,'Service 6','Service 6',NULL,NULL,'1',NULL),(7,'\r\nLong COVID',700000.00,90000.00,'./img/service_7.jpg',1,'Service 7','Service 7',NULL,NULL,'1',NULL),(8,'Neurosurgery',100000.00,80000.00,'./img/service_8.jpg',2,'Service 8','Service 8',NULL,NULL,'1',NULL),(9,'\r\nOphthalmology',200000.00,150000.00,'./img/service_9.jpg',3,'Service 9','Service 9',NULL,NULL,'1',NULL),(10,'\r\nPharmacy',100000.00,90000.00,'./img/service_10.jpg',4,'Service 10','Service 10',NULL,NULL,'1',NULL),(11,'Pulmonology',300000.00,100000.00,'./img/service_11.jpg',4,'Service 11','Service 11','2021-07-25 22:34:38',0,'0',18),(12,'CAR T-Cell therapy',250000.00,100000.00,'./img/service_12.jpg',4,'Service 12','Service 12',NULL,NULL,'1',NULL);
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
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_category`
--

LOCK TABLES `service_category` WRITE;
/*!40000 ALTER TABLE `service_category` DISABLE KEYS */;
INSERT INTO `service_category` VALUES (1,'Pediatrics','Pediatric services for children',1),(2,'Cardiology','Cardiology services for children',1),(3,'Neurosurgery','Neurosurgery services for children',1),(4,'Cancer Care','Cancer care services for children',1);
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
  `status` varchar(255) DEFAULT NULL,
  `notes` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  `update_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_slider_author` (`author_id`),
  CONSTRAINT `fk_slider_author` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slider`
--

LOCK TABLES `slider` WRITE;
/*!40000 ALTER TABLE `slider` DISABLE KEYS */;
INSERT INTO `slider` VALUES (1,'A  Response Plan to counter Covid-19','./img/slider1.jpg','#','1','Pushing the boundaries of what’s possible in children’s health.',NULL,NULL),(2,'Medical Emergencies Always Come Unannounced!','./img/slider2.jpg','http://localhost:8080/ChildrenCare/post?action=detail&id=2','1','Get the most advanced emergency care anywhere in just minutes.',NULL,'2024-11-09 17:00:00'),(6,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#','Deleted','none',NULL,NULL),(7,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#','Deleted','none',NULL,NULL),(8,'Medical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#','Deleted','none',NULL,NULL),(9,'HueMedical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#','Deleted','none',NULL,NULL),(10,'naviMedical Emergencies Always Come Unannounced!','assets/images/slider/slider_1_dad_and_girl.jpg','#','Deleted','none',NULL,NULL),(11,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#','Deleted','Get the most advanced emergency care anywhere in just minutes.',NULL,NULL),(12,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#','Deleted','Get the most advanced emergency care anywhere in just minutes.',NULL,NULL),(13,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#','Deleted','Get the most advanced emergency care anywhere in just minutes.',NULL,NULL),(14,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#','Deleted','Get the most advanced emergency care anywhere in just minutes.',NULL,NULL),(15,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#','Deleted','Get the most advanced emergency care anywhere in just minutes.',NULL,NULL),(16,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#','Deleted','Get the most advanced emergency care anywhere in just minutes.',NULL,NULL),(18,'Medical Emergencies Always Come Unannounced!','assets/images/slider/Yuna-color-correction.jpg','#','Deleted','Get the most advanced emergency care anywhere in just minutes.',NULL,NULL),(48,'Medical Emergencies Always Come','./uploads/Q1_20240317083718.jpg','http://localhost:8080/ChildrenCare/post?action=detail&id=3','1','notes',48,'2024-11-09 17:00:00'),(49,'Medical Emergencies Always Come 34','./uploads/Exquisite Krunk-Bruticus.png','http://localhost:8080/ChildrenCare/post?action=detail&id=7','Deleted','notes',48,'2024-11-09 17:00:00'),(50,'A  Response Plan to counter Covid-19','./uploads/ERD for PRJ301 Assignment.png','http://localhost:8080/ChildrenCare/post?action=detail&id=3','0','notes',48,'2024-11-09 17:00:00');
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
  `created_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_roleid_idx` (`role_id`) USING BTREE,
  CONSTRAINT `FK_roleid` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'childrencaresystemse1874@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Giang',1,'0974484610','Vietnam','/uploads/Screenshot 2024-10-23 155356.png',1,'Active','2024-09-01 17:00:00'),(2,'hattnhe153222@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Ha',0,'0974484610','Viet Nam','assets/images/default.png',4,'Active','2024-09-01 17:00:00'),(3,'anhntnhe151378@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Ngoc Anh',0,'0974484610','Viet Nam','assets/images/default.png',3,'Active','2024-09-01 17:00:00'),(4,'nguyetanh0944@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Nguyet Anh',0,'0974484610','Viet Nam','assets/images/default.png',2,'Active','2024-09-01 17:00:00'),(5,'minhhnhe151181@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Minh',1,'0974484610','Viet Nam','assets/images/default.png',3,'Active','2024-09-01 17:00:00'),(7,'Fusce.dolor@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Cameran Randall',1,'03 3098 2170','676-4438 At, Rd.','assets/images/default.png',3,'Active','2024-09-01 17:00:00'),(8,'Aliquam.fringilla.cursus@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Travis Booth',1,'05 2741 5626','855-6756 Aliquam St.','assets/images/default.png',3,'Active','2024-09-01 17:00:00'),(9,'Cum.sociis@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Erasmus Miles',0,'06 5922 9897','P.O. Box 578, 1680 Nunc Ave','assets/images/default.png',3,'Active','2024-09-01 17:00:00'),(10,'imperdiet@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Virginia Patrick',0,'09 0823 2167','8273 Lorem St.','assets/images/default.png',3,'Active','2024-09-01 17:00:00'),(11,'dolor.elit.pellentesque@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Merrill Dodson',1,'08 4181 7222','P.O. Box 968, 2771 Nunc Ave','assets/images/default.png',3,'Active','2024-09-14 17:00:00'),(12,'pede.Nunc@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Herrod Garrison',0,'01 5261 9252','P.O. Box 100, 7977 Eget Rd.','assets/images/default.png',3,'Active','2024-09-14 17:00:00'),(13,'sit.amet.consectetuer@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Nyssa Whitehead',0,'03 1619 9741','348 Sapien, Rd.','assets/images/default.png',3,'Active','2024-09-14 17:00:00'),(14,'in.molestie@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Rhoda Atkins',1,'07 1611 8568','294-8716 Justo Rd.','assets/images/default.png',4,'Active','2024-09-14 17:00:00'),(15,'tempor@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Jonah Delacruz',1,'07 4581 3242','Ap #210-5290 Amet Street','assets/images/default.png',4,'Active','2024-09-14 17:00:00'),(16,'pede.nonummy@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Jolene Hatfield',1,'03 7598 6632','377-4202 Sit St.','assets/images/default.png',4,'Active','2024-09-14 17:00:00'),(17,'augue@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Jana Everett',1,'09 5683 8841','650-539 Pharetra Rd.','assets/images/default.png',4,'Active','2024-09-14 17:00:00'),(18,'auctor.Mauris@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Maryam Coffey',0,'00 8591 6584','9325 Libero Av.','assets/images/default.png',4,'Active','2024-09-14 17:00:00'),(19,'cursus@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Kermit Burton',0,'01 1323 3633','Ap #900-8190 Lacus, St.','assets/images/default.png',4,'Active','2024-09-14 17:00:00'),(20,'tempor@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Merritt Buckley',0,'00 2488 9979','P.O. Box 169, 5855 Sed Ave','assets/images/default.png',4,'Active','2024-09-14 17:00:00'),(21,'venenatis.vel@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Benjamin Roman',1,'06 3883 3084','374-9446 Mus. Avenue','assets/images/default.png',4,'Active','2024-10-29 17:00:00'),(22,'ultrices.posuere@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Ian Potter',0,'06 3685 0102','P.O. Box 708, 2807 Nunc Ave','assets/images/default.png',4,'Active','2024-10-29 17:00:00'),(23,'Cras.lorem@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Craig Albert',1,'06 5895 7788','P.O. Box 656, 5569 Nec Road','assets/images/default.png',4,'Active','2024-10-29 17:00:00'),(24,'arcu.Vestibulum.ut@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Jameson Savage',0,'08 0534 5067','344-8652 Sem Road','assets/images/default.png',4,'Active','2024-10-29 17:00:00'),(25,'sem.Pellentesque.ut@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Dillon Beach',0,'08 0362 8209','P.O. Box 795, 863 Enim. Rd.','assets/images/default.png',4,'Active','2024-10-29 17:00:00'),(26,'erat.Vivamus@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Ebony Dean',1,'08 9087 2089','P.O. Box 187, 8252 Tellus Ave','assets/images/default.png',4,'Active','2024-10-29 17:00:00'),(27,'ultrices.sit.amet@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Cedric Young',0,'09 5523 8563','8655 Dolor. Road','assets/images/default.png',4,'Active','2024-10-29 17:00:00'),(28,'mauris@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Lillith Morton',1,'07 5555 0052','Ap #737-2514 Neque St.','assets/images/default.png',4,'Active','2024-10-29 17:00:00'),(29,'dolor.quam.elementum@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Ezra Banks',0,'07 1798 5418','P.O. Box 357, 6736 Nisl. St.','assets/images/default.png',4,'Active','2024-10-29 17:00:00'),(30,'porttitor.vulputate@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Debra Rodgers',1,'04 7276 6369','P.O. Box 407, 317 Cras Road','assets/images/default.png',4,'Active','2024-10-29 17:00:00'),(31,'ac.mi.eleifend@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Basil Holmes',1,'07 0184 5611','P.O. Box 351, 9486 Dolor Street','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(32,'Duis.volutpat@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Kermit Madden',1,'02 5291 5691','371-7540 Ultricies Av.','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(33,'aliquam.adipiscing.lacus@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Merritt Love',0,'02 8510 5414','989-5503 Vestibulum, Rd.','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(34,'Nunc.sollicitudin.commodo@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Olga Merrill',0,'03 0153 1977','639-8895 Nulla Rd.','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(35,'porttitor.interdum.Sed@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Camden Mcclure',1,'08 7569 4261','753-4388 Etiam St.','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(36,'congue@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Keane Pitts',1,'04 7014 7684','Ap #446-1701 Cursus Rd.','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(37,'dui@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Maile Dillon',0,'07 6283 3004','7075 Non Av.','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(38,'sit.amet.risus@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Azalia Kirkland',1,'01 0267 4556','5299 Hendrerit Rd.','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(39,'elit.Nulla.facilisi@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Mohammad Frye',1,'07 4728 5661','P.O. Box 109, 4891 Neque Av.','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(40,'odio@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Melvin Juarez',0,'07 4577 7948','586-936 Dictum Road','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(41,'Mauris.nulla@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Hamilton Berg',0,'05 4379 9506','Ap #196-3025 Blandit Av.','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(42,'metus.Aliquam@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Trevor Williams',0,'00 2660 8006','Ap #908-5583 Rhoncus. Street','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(43,'ridiculus.mus@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Herrod Armstrong',1,'09 6236 0421','Ap #162-5003 Ut Street','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(44,'dui.lectus.rutrum@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Ashton Houston',1,'06 2648 5883','1432 A St.','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(45,'sociis@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','MacKensie Morris',0,'05 3255 1627','7704 Vestibulum St.','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(46,'Phasellus.ornare@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Mariko Jacobs',0,'03 4174 1097','786-4568 Ridiculus Avenue','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(47,'nguyetanh0945@gmail.com','7mxNXPJ8xHU4gIVOe71ohJK46Kc=','Bui Hoang Nguyet Anh',0,'0972427628','Hai Phong','assets/images/default.png',4,'Active','2024-11-08 17:00:00'),(48,'thanhmanager@gmail.com','7mxNXPJ8xHU4gIVOe71ohJK46Kc=','Thanh',0,'0902004117','Hai Phong','assets/images/default.png',2,'Active','2024-11-08 17:00:00'),(49,'anhbhnhe180164@gmail.com','qXNsrZcd7Ns3yp5ssl8jmwU0Hpk=','Bui Hoang Nguyet Anh (K18 HL)',0,NULL,NULL,'https://lh3.googleusercontent.com/a/ACg8ocI5yBqa1JZ-DYT_gmNKcFvkPWCd4tjzn4lAN502OuTE59z07A=s96-c',4,'Active',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_schedule`
--

DROP TABLE IF EXISTS `work_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_schedule` (
  `reservation_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `start_at` timestamp NULL DEFAULT NULL,
  `end_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`reservation_id`) USING BTREE,
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `work_schedule_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `user` (`id`),
  CONSTRAINT `work_schedule_ibfk_2` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_schedule`
--

LOCK TABLES `work_schedule` WRITE;
/*!40000 ALTER TABLE `work_schedule` DISABLE KEYS */;
INSERT INTO `work_schedule` VALUES (25,3,'2024-10-26 04:22:00','2024-10-26 06:22:00'),(26,3,'2024-11-09 04:26:00','2024-11-09 06:26:00'),(27,3,'2024-10-31 06:51:00','2024-10-31 08:51:00'),(28,3,'2024-11-01 07:52:00','2024-11-01 09:52:00'),(29,3,'2024-08-24 01:57:00','2024-08-24 03:57:00'),(30,3,'2024-10-26 09:24:00','2024-10-26 11:24:00'),(31,3,'2024-10-20 02:19:10','2024-10-20 04:19:10'),(32,3,'2024-11-02 10:28:00','2024-11-02 12:28:00'),(33,3,'2024-11-07 03:33:00','2024-11-07 05:33:00'),(34,3,'2024-11-15 14:25:00','2024-11-15 16:25:00'),(35,3,'2024-11-16 16:16:00','2024-11-16 18:16:00'),(37,3,'2024-11-16 02:15:00','2024-11-16 04:15:00'),(38,3,'2024-11-27 17:26:00','2024-11-27 19:26:00'),(45,3,'2024-11-20 20:06:00','2024-11-20 22:06:00'),(46,3,'2024-11-26 20:36:00','2024-11-26 22:36:00'),(47,3,'2024-11-15 04:42:00','2024-11-15 06:42:00'),(48,3,'2024-11-20 06:02:00','2024-11-20 08:02:00'),(49,3,'2024-11-21 06:05:00','2024-11-21 08:05:00'),(51,3,'2024-11-29 06:18:00','2024-11-29 08:18:00'),(55,3,'2024-11-22 06:48:00','2024-11-22 08:48:00'),(57,3,'2024-11-23 06:00:00','2024-11-23 08:00:00'),(61,3,'2024-11-29 03:30:00','2024-11-29 05:30:00');
/*!40000 ALTER TABLE `work_schedule` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
CREATE EVENT IF NOT EXISTS auto_cancel_reservations
ON SCHEDULE EVERY 1 HOUR
DO
  UPDATE reservation
  SET status = 'Cancelled'
  WHERE status != 'Completed'
    AND TIMESTAMPDIFF(HOUR, checkup_time, NOW()) > 3;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-24 14:00:29
