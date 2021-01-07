
DELIMITER $$


CREATE PROCEDURE `decquan` (IN `rbgname` CHAR(5))  BEGIN
declare rquan int default 350;
declare iquan int default 0;
select quantity into iquan from inventory where bgname=rbgname;
update inventory set quantity=iquan-rquan where bgname=rbgname;
END$$

CREATE PROCEDURE `incquan` (IN `dbgname` CHAR(5))  BEGIN
declare dquan int default 350;
declare iquan int default 0;
select quantity into iquan from inventory where bgname=dbgname;
update inventory set quantity=iquan+dquan where bgname=dbgname;
END$$

DELIMITER ;



CREATE TABLE `doctor` (
  `id` int(11) NOT NULL,
  `doctorname` char(10) DEFAULT NULL,
  `doctoraddress` char(10) DEFAULT NULL,
  `doctorcontact` char(11) DEFAULT NULL,
  `doctorbg` char(10) NOT NULL
);



CREATE TABLE `donor` (
  `id` int(11) NOT NULL,
  `name` char(10) DEFAULT NULL,
  `gender` char(10) DEFAULT NULL,
  `address` char(10) DEFAULT NULL,
  `date` char(10) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `contact` char(11) DEFAULT NULL,
  `bg` char(5) DEFAULT NULL
);


DELIMITER $$
CREATE TRIGGER `updateinvincre` AFTER INSERT ON `donor` FOR EACH ROW BEGIN
DECLARE donbgname char(10) DEFAULT '';
select bg into donbgname from donor WHERE id=new.id;
call incquan(donbgname);
END
$$
DELIMITER ;



CREATE TABLE `inventory` (
  `id` int(11) NOT NULL,
  `bgname` char(10) NOT NULL,
  `quantity` int(11) DEFAULT NULL
);



CREATE TABLE `admin` (
  `username` char(10) DEFAULT NULL,
  `passwd` char(10) DEFAULT NULL
);



CREATE TABLE `receiver` (
  `id` int(11) NOT NULL,
  `receivername` char(10) DEFAULT NULL,
  `gender` char(10) DEFAULT NULL,
  `address` char(10) DEFAULT NULL,
  `date` char(10) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `contact` char(11) DEFAULT NULL,
  `bg` char(5) DEFAULT NULL,
  `doctorname` char(10) DEFAULT NULL,
  `donorid` int(11) DEFAULT NULL
);



DELIMITER $$
CREATE TRIGGER `updateinvdecre` AFTER INSERT ON `receiver` FOR EACH ROW BEGIN
DECLARE recbgname char(10) DEFAULT '';
select bg into recbgname from receiver WHERE id=new.id;
call decquan(recbgname);
END
$$
DELIMITER ;



ALTER TABLE `doctor`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `donor`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`) USING BTREE;


ALTER TABLE `receiver`
  ADD PRIMARY KEY (`id`);




ALTER TABLE `doctor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3012;


ALTER TABLE `donor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1044;


ALTER TABLE `inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4005;


ALTER TABLE `receiver`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2002;

