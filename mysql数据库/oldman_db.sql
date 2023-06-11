/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : oldman_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2018-01-08 00:49:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_department`
-- ----------------------------
DROP TABLE IF EXISTS `t_department`;
CREATE TABLE `t_department` (
  `departmentId` int(11) NOT NULL auto_increment COMMENT '部门编号',
  `departName` varchar(20) NOT NULL COMMENT '部门名称',
  `bornDate` varchar(20) default NULL COMMENT '成立日期',
  `mainPerson` varchar(20) NOT NULL COMMENT '负责人',
  PRIMARY KEY  (`departmentId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_department
-- ----------------------------
INSERT INTO `t_department` VALUES ('1', '医护部', '2017-12-28', '王敏');

-- ----------------------------
-- Table structure for `t_employee`
-- ----------------------------
DROP TABLE IF EXISTS `t_employee`;
CREATE TABLE `t_employee` (
  `employeeNo` varchar(30) NOT NULL COMMENT 'employeeNo',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `departmentObj` int(11) NOT NULL COMMENT '所在部门',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `employeePhoto` varchar(60) NOT NULL COMMENT '员工照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  PRIMARY KEY  (`employeeNo`),
  KEY `departmentObj` (`departmentObj`),
  CONSTRAINT `t_employee_ibfk_1` FOREIGN KEY (`departmentObj`) REFERENCES `t_department` (`departmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_employee
-- ----------------------------
INSERT INTO `t_employee` VALUES ('YG001', '123', '1', '李倩', '女', '2017-12-07', 'upload/c4352916-089a-49b8-93c2-445e5d0204c5.jpg', '13598340835', '福建福州');

-- ----------------------------
-- Table structure for `t_nurse`
-- ----------------------------
DROP TABLE IF EXISTS `t_nurse`;
CREATE TABLE `t_nurse` (
  `nurseId` int(11) NOT NULL auto_increment COMMENT '记录id',
  `nurseType` varchar(20) NOT NULL COMMENT '信息类别',
  `title` varchar(80) NOT NULL COMMENT '信息标题',
  `content` varchar(5000) NOT NULL COMMENT '信息内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`nurseId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_nurse
-- ----------------------------
INSERT INTO `t_nurse` VALUES ('1', '特殊医嘱', '心脏病老人注意', '<p>不要吃太油腻的食品</p>', '2017-12-28 23:19:41');

-- ----------------------------
-- Table structure for `t_oldman`
-- ----------------------------
DROP TABLE IF EXISTS `t_oldman`;
CREATE TABLE `t_oldman` (
  `oldManId` int(11) NOT NULL auto_increment COMMENT '老人编号',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `sex` varchar(4) NOT NULL COMMENT '性别',
  `age` int(11) NOT NULL COMMENT '年龄',
  `manPhoto` varchar(60) NOT NULL COMMENT '老人照片',
  `manDesc` varchar(5000) default NULL COMMENT '老人介绍',
  `userObj` varchar(30) NOT NULL COMMENT '登记用户',
  `addTime` varchar(20) default NULL COMMENT '登记时间',
  PRIMARY KEY  (`oldManId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_oldman_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_oldman
-- ----------------------------
INSERT INTO `t_oldman` VALUES ('1', '王树明', '男', '82', 'upload/01cf090a-1ce2-4c3e-b0d7-a32ed9b536e6.jpg', '<p>老人有心脏病</p>', 'user1', '2017-12-28 23:15:53');
INSERT INTO `t_oldman` VALUES ('2', '李明倩', '女', '87', 'upload/a482c7bf-253a-424c-aaa8-fe93bc5a109a.jpg', '<p>老人有脊柱炎，经常背痛！</p>', 'user1', '2018-01-07 22:16:13');

-- ----------------------------
-- Table structure for `t_reception`
-- ----------------------------
DROP TABLE IF EXISTS `t_reception`;
CREATE TABLE `t_reception` (
  `receptionId` int(11) NOT NULL auto_increment COMMENT '接待记录id',
  `receptType` varchar(20) NOT NULL COMMENT '接待类别',
  `title` varchar(20) NOT NULL COMMENT '接待主题',
  `content` varchar(5000) default NULL COMMENT '接待内容',
  `receptDate` varchar(20) default NULL COMMENT '接待日期',
  PRIMARY KEY  (`receptionId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_reception
-- ----------------------------
INSERT INTO `t_reception` VALUES ('1', '客户咨询', '111', '<p>222</p>', '2017-12-28');

-- ----------------------------
-- Table structure for `t_room`
-- ----------------------------
DROP TABLE IF EXISTS `t_room`;
CREATE TABLE `t_room` (
  `roomNo` varchar(20) NOT NULL COMMENT 'roomNo',
  `roomTypeObj` int(11) NOT NULL COMMENT '房间类型',
  `roomName` varchar(20) NOT NULL COMMENT '房间名称',
  `mainPhoto` varchar(60) NOT NULL COMMENT '房间主图',
  `price` float NOT NULL COMMENT '房间价格',
  `roomDesc` varchar(5000) default NULL COMMENT '房间详情',
  `roomState` varchar(20) NOT NULL COMMENT '房间状态',
  PRIMARY KEY  (`roomNo`),
  KEY `roomTypeObj` (`roomTypeObj`),
  CONSTRAINT `t_room_ibfk_1` FOREIGN KEY (`roomTypeObj`) REFERENCES `t_roomtype` (`typeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_room
-- ----------------------------
INSERT INTO `t_room` VALUES ('101', '1', '1楼1号', 'upload/41c2c324-c5cb-4c2e-bb92-f6c936f01de2.jpg', '200', '<p>简单实用</p>', '空闲');
INSERT INTO `t_room` VALUES ('201', '2', '2楼1号', 'upload/b41a31b9-df17-4829-96d0-960e71709329.jpg', '400', '<p>干净的房间，自己感觉舒心</p>', '空闲');

-- ----------------------------
-- Table structure for `t_roomorder`
-- ----------------------------
DROP TABLE IF EXISTS `t_roomorder`;
CREATE TABLE `t_roomorder` (
  `orderId` int(11) NOT NULL auto_increment COMMENT '订单编号',
  `roomObj` varchar(20) NOT NULL,
  `oldManObj` int(11) NOT NULL COMMENT '入住老人',
  `liveDate` varchar(20) default NULL COMMENT '入住日期',
  `monthNum` int(11) NOT NULL COMMENT '入住时间',
  `orderMoney` float NOT NULL COMMENT '订单总金额',
  `orderState` varchar(20) NOT NULL COMMENT '订单状态',
  `orderDesc` varchar(5000) default NULL COMMENT '订单费用明细',
  `orderTime` varchar(20) default NULL COMMENT '订单时间',
  PRIMARY KEY  (`orderId`),
  KEY `oldManObj` (`oldManObj`),
  KEY `roomObj` (`roomObj`),
  CONSTRAINT `t_roomorder_ibfk_2` FOREIGN KEY (`roomObj`) REFERENCES `t_room` (`roomNo`),
  CONSTRAINT `t_roomorder_ibfk_1` FOREIGN KEY (`oldManObj`) REFERENCES `t_oldman` (`oldManId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_roomorder
-- ----------------------------
INSERT INTO `t_roomorder` VALUES ('1', '101', '1', '2018-02-02', '3', '600', '部分付款', '<p>2017-12-28 11:11:23 &nbsp;微信支付200定金</p>', '2018-02-01 23:18:22');
INSERT INTO `t_roomorder` VALUES ('2', '201', '2', '2018-01-08', '2', '800', '部分付款', '<p>2018-01-07 22:52:14 支付宝付款400</p>', '2018-01-07 23:20:51');

-- ----------------------------
-- Table structure for `t_roomtype`
-- ----------------------------
DROP TABLE IF EXISTS `t_roomtype`;
CREATE TABLE `t_roomtype` (
  `typeId` int(11) NOT NULL auto_increment COMMENT '房间类型id',
  `typeName` varchar(20) NOT NULL COMMENT '房间类型名称',
  PRIMARY KEY  (`typeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_roomtype
-- ----------------------------
INSERT INTO `t_roomtype` VALUES ('1', '普通单人间');
INSERT INTO `t_roomtype` VALUES ('2', '豪华单人间');

-- ----------------------------
-- Table structure for `t_salary`
-- ----------------------------
DROP TABLE IF EXISTS `t_salary`;
CREATE TABLE `t_salary` (
  `salaryId` int(11) NOT NULL auto_increment COMMENT '工资id',
  `employeeObj` varchar(30) NOT NULL COMMENT '员工',
  `year` int(11) NOT NULL COMMENT '工资年份',
  `month` int(11) NOT NULL COMMENT '工资月份',
  `salaryMoney` float NOT NULL COMMENT '工资金额',
  `giveDate` varchar(20) default NULL COMMENT '发放日期',
  `salaryMemo` varchar(500) default NULL COMMENT '工资备注',
  PRIMARY KEY  (`salaryId`),
  KEY `employeeObj` (`employeeObj`),
  CONSTRAINT `t_salary_ibfk_1` FOREIGN KEY (`employeeObj`) REFERENCES `t_employee` (`employeeNo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_salary
-- ----------------------------
INSERT INTO `t_salary` VALUES ('1', 'YG001', '2017', '12', '4982', '2017-12-28', '全勤奖励了150');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '双鱼林', '男', '2017-12-07', 'upload/bb7ecfae-2a1f-4964-9657-bfc47103f5cb.jpg', '13589834234', 'syl@163.com', '四川成都红星路', '2017-12-28 23:14:11');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '李小双', '女', '2018-01-03', 'upload/d1b75f7b-1313-4b43-a2f0-61033f4545e3.jpg', '13958342342', 'xiaoshuang@126.com', '四川南充海阳路', '2018-01-07 23:14:07');
