/*
SQLyog Ultimate v8.55 
MySQL - 5.1.36-community : Database - food_order_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`food_order_db` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `food_order_db`;

/*Table structure for table `items` */

DROP TABLE IF EXISTS `items`;

CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `price` int(11) NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `items` */

insert  into `items`(`id`,`name`,`price`,`deleted`) values (1,'Item 1',25,1),(2,'Item 2',45,0),(3,'Item 3',20,0),(4,'Item 4',15,1),(5,'Item 5',20,0);

/*Table structure for table `order_details` */

DROP TABLE IF EXISTS `order_details`;

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `item_id` (`item_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `order_details` */

insert  into `order_details`(`id`,`order_id`,`item_id`,`quantity`,`price`) values (1,1,2,2,90),(2,1,3,3,60),(3,2,2,2,90),(4,2,3,2,40),(5,3,2,2,90),(6,3,3,2,40),(7,4,2,2,90),(8,4,3,2,40),(9,5,2,5,225),(10,5,3,2,40),(11,5,5,1,20),(12,6,2,5,225),(13,6,3,3,60),(14,6,5,2,40);

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `address` varchar(300) NOT NULL,
  `description` varchar(300) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_type` varchar(16) NOT NULL DEFAULT 'Wallet',
  `total` int(11) NOT NULL,
  `status` varchar(25) NOT NULL DEFAULT 'Yet to be delivered',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `orders` */

insert  into `orders`(`id`,`customer_id`,`address`,`description`,`date`,`payment_type`,`total`,`status`,`deleted`) values (1,2,'Address 2','Sample Description 1','2017-03-28 23:02:41','Wallet',150,'Yet to be delivered',0),(2,2,'New address 2','','2017-03-28 23:13:05','Wallet',130,'Cancelled by Customer',1),(3,3,'Address 3','Sample Description 2','2017-03-29 01:19:33','Cash On Delivery',130,'Yet to be delivered',0),(4,3,'Address 3','','2017-03-29 01:22:01','Cash On Delivery',130,'Cancelled by Customer',1),(5,3,'New Address 3','','2017-03-29 02:17:28','Wallet',285,'Paused',0),(6,3,'New Address 3','','2017-03-30 06:13:31','Wallet',325,'Cancelled by Customer',1);

/*Table structure for table `ticket_details` */

DROP TABLE IF EXISTS `ticket_details`;

CREATE TABLE `ticket_details` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ticket_details` */

insert  into `ticket_details`(`id`,`ticket_id`,`user_id`,`description`,`date`) values (1,1,2,'New Description for Subject 1','2017-03-30 23:38:51'),(2,1,2,'Reply-1 for Subject 1','2017-03-31 01:29:09'),(3,1,1,'Reply-2 for Subject 1 from Administrator.','2017-03-31 02:05:39'),(4,1,1,'Reply-3 for Subject 1 from Administrator.','2017-03-31 02:19:35');

/*Table structure for table `tickets` */

DROP TABLE IF EXISTS `tickets`;

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `poster_id` int(11) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `description` varchar(3000) NOT NULL,
  `status` varchar(8) NOT NULL DEFAULT 'Open',
  `type` varchar(30) NOT NULL DEFAULT 'Others',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `poster_id` (`poster_id`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`poster_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `tickets` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(15) NOT NULL DEFAULT 'Customer',
  `name` varchar(15) NOT NULL,
  `username` varchar(10) NOT NULL,
  `password` varchar(16) NOT NULL,
  `email` varchar(35) DEFAULT NULL,
  `address` varchar(300) DEFAULT NULL,
  `contact` bigint(11) NOT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`role`,`name`,`username`,`password`,`email`,`address`,`contact`,`verified`,`deleted`) values (1,'Administrator','Admin 1','root','toor','','Address 1',9898000000,1,0),(2,'Customer','Customer 1','user1','pass1','mail2@example.com','Address 2',9898000001,1,0),(3,'Customer','Customer 2','user2','pass2','mail3@example.com','Address 3',9898000002,1,0),(4,'Customer','Customer 3','user3','pass3','','',9898000003,0,0),(5,'Customer','Customer 4','user4','pass4','','',9898000004,0,1);

/*Table structure for table `wallet` */

DROP TABLE IF EXISTS `wallet`;

CREATE TABLE `wallet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_id` (`customer_id`),
  UNIQUE KEY `id` (`id`),
  CONSTRAINT `wallet_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `wallet` */

insert  into `wallet`(`id`,`customer_id`) values (1,1),(2,2),(3,3),(4,4),(5,5);

/*Table structure for table `wallet_details` */

DROP TABLE IF EXISTS `wallet_details`;

CREATE TABLE `wallet_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wallet_id` int(11) NOT NULL,
  `number` varchar(16) NOT NULL,
  `cvv` int(3) NOT NULL,
  `balance` int(11) NOT NULL DEFAULT '2000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `wallet_id` (`wallet_id`),
  UNIQUE KEY `id` (`id`),
  CONSTRAINT `wallet_details_ibfk_1` FOREIGN KEY (`wallet_id`) REFERENCES `wallet` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `wallet_details` */

insert  into `wallet_details`(`id`,`wallet_id`,`number`,`cvv`,`balance`) values (1,1,'6155247490533921',983,3430),(2,2,'1887587142382050',772,1850),(3,3,'4595809639046830',532,1585),(4,4,'5475856443351234',521,2000),(5,5,'9076633115663264',229,2000);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
