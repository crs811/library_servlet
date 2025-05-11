/*
Navicat MySQL Data Transfer

Source Server         : local_mysql
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : library

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2025-05-09 21:29:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `bookID` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '书籍ID',
  `bookName` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '书名',
  `bookAuthor` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '书籍作者',
  `bookPublisher` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '出版社',
  `publishTime` date DEFAULT NULL COMMENT '出版日期',
  `bookPrice` float(5,2) DEFAULT NULL COMMENT '单价',
  `bookSum` int(5) NOT NULL COMMENT '总数',
  `bookLend` int(255) NOT NULL COMMENT '借出数量',
  `tag` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '书籍类型',
  `isbn` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'isbn编号',
  PRIMARY KEY (`bookID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('c3739117271111f0989b080058000005', '围城', '钱钟书', '人民文学出版社', '1991-02-01', '39.00', '20', '1', '现当代文学', '9787020090006');
INSERT INTO `book` VALUES ('c379aeef271111f0989b080058000005', '明朝那些事儿', '当年明月', '中国友谊出版公司', '2006-09-01', '358.00', '15', '1', '历史', '9787505722460');
INSERT INTO `book` VALUES ('c37f1cbf271111f0989b080058000005', '百年孤独', '加西亚·马尔克斯', '南海出版公司', '2011-06-01', '39.50', '28', '0', '外国文学', '9787544258974');
INSERT INTO `book` VALUES ('c38423e8271111f0989b080058000005', 'Python编程：从入门到实践', 'Eric Matthes', '人民邮电出版社', '2020-07-01', '89.00', '35', '3', '计算机', '9787115546081');
INSERT INTO `book` VALUES ('c387ddb6271111f0989b080058000005', '小王子', '圣埃克苏佩里', '人民文学出版社', '2003-08-01', '22.00', '40', '1', '童话', '9787020042494');
INSERT INTO `book` VALUES ('c38bddd1271111f0989b080058000005', '人类简史', '尤瓦尔·赫拉利', '中信出版社', '2017-02-01', '68.00', '25', '0', '历史科普', '9787508647357');
INSERT INTO `book` VALUES ('c390feea271111f0989b080058000005', '三体', '刘慈欣', '重庆出版社', '2008-01-01', '23.00', '30', '2', '科幻小说', '9787536692930');
INSERT INTO `book` VALUES ('c394c8e7271111f0989b080058000005', '基地', '艾萨克·阿西莫夫', '江苏文艺出版社', '2015-10-01', '35.00', '18', '1', '科幻', '9787539978969');
INSERT INTO `book` VALUES ('c3987545271111f0989b080058000005', '原则', '瑞·达利欧', '中信出版社', '2018-01-01', '98.00', '25', '2', '管理', '9787508684031');
INSERT INTO `book` VALUES ('c39c3a94271111f0989b080058000005', '万历十五年', '黄仁宇', '生活·读书·新知三联书店', '2006-01-01', '18.00', '20', '2', '历史', '9787108029821');
INSERT INTO `book` VALUES ('c3a02d1c271111f0989b080058000005', '算法导论', 'Thomas H. Cormen', '机械工业出版社', '2013-01-01', '128.00', '25', '0', '计算机', '9787111407010');
INSERT INTO `book` VALUES ('c3a3ad6b271111f0989b080058000005', '黑客与画家', 'Paul Graham', '人民邮电出版社', '2011-04-01', '49.00', '30', '0', '计算机', '9787115249494');
INSERT INTO `book` VALUES ('c3a8d4a2271111f0989b080058000005', '追风筝的人', '卡勒德·胡赛尼', '上海人民出版社', '2006-05-01', '29.00', '35', '0', '外国文学', '9787208061644');
INSERT INTO `book` VALUES ('c3ae1376271111f0989b080058000005', '平凡的世界', '路遥', '北京十月文艺出版社', '2017-06-01', '128.00', '40', '0', '现当代文学', '9787530216784');
INSERT INTO `book` VALUES ('ed6e10fc270711f0989b080058000005', '冬与狮', '兰晓龙', '人民文学出版社', '2021-10-01', '39.00', '20', '1', '小说', '9787020142422');
INSERT INTO `book` VALUES ('ed6e1160270711f0989b080058000005', '孙子兵法', '[春秋]孙武', '蓝天出版社', '2006-04-25', '29.80', '34', '1', '军事', '9787801587466');
INSERT INTO `book` VALUES ('ed6e11bd270711f0989b080058000005', '左宗棠全传', '秦翰才', '中华书局', '2016-06-01', '68.00', '56', '2', '历史', '9787101115079');
INSERT INTO `book` VALUES ('ed6e1213270711f0989b080058000005', '技术与文明：我们的时代和未来', '张笑宇', '广西师范大学出版社', '2021-03-10', '78.00', '23', '1', '历史', '9787559832870');
INSERT INTO `book` VALUES ('ed6e1276270711f0989b080058000005', '杭州古旧地图集', '杭州市档案馆', '浙江古籍出版社', '2007-01-25', '680.00', '20', '0', '地理', '9787807151753');
INSERT INTO `book` VALUES ('ed6e12ce270711f0989b080058000005', '活着', '余华', '作家出版社', '2012-08-01', '20.00', '10', '0', '文学', '9787506365437');
INSERT INTO `book` VALUES ('ed6e1325270711f0989b080058000005', '福尔摩斯探案全集（套装共4册）', '[英]阿瑟·柯南·道尔', '译林出版社', '2017-04-01', '168.00', '15', '0', '小说', '9787544766432');
INSERT INTO `book` VALUES ('ed6e1376270711f0989b080058000005', '红星照耀中国', '斯诺', '中国儿童文学出版社', '2019-11-11', '36.00', '10', '0', '传记', '');
INSERT INTO `book` VALUES ('ed6e13c5270711f0989b080058000005', '细胞生物学（第4版）', '翟中和', '高等教育出版社', '2011-06-01', '78.00', '4', '0', '生物', '9787040321753');
INSERT INTO `book` VALUES ('ed6e1420270711f0989b080058000005', '计算机网络（第7版）', '谢希仁', '电子工业出版社', '2017-01-01', '45.00', '1', '0', '计算机', '9787121302954');
INSERT INTO `book` VALUES ('ed6e147d270711f0989b080058000005', '鲁迅', '鲁迅', '北京日报出版社（原同心出版社）', '2014-05-25', '380.00', '1', '0', '文学', '9787547711101');

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow` (
  `readerID` int(11) NOT NULL COMMENT '读者id',
  `bookID` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '书籍id',
  `borrowTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '借出时间',
  `returnTime` datetime DEFAULT NULL COMMENT '归还时间',
  PRIMARY KEY (`readerID`,`bookID`,`borrowTime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of borrow
-- ----------------------------
INSERT INTO `borrow` VALUES ('2', 'c38423e8271111f0989b080058000005', '2025-05-09 19:05:55', null);
INSERT INTO `borrow` VALUES ('2', 'c387ddb6271111f0989b080058000005', '2025-05-09 19:06:08', null);
INSERT INTO `borrow` VALUES ('2', 'c390feea271111f0989b080058000005', '2025-05-09 19:06:22', null);
INSERT INTO `borrow` VALUES ('2', 'c3987545271111f0989b080058000005', '2025-05-09 19:06:02', null);
INSERT INTO `borrow` VALUES ('2', 'c39c3a94271111f0989b080058000005', '2025-05-09 19:05:59', null);
INSERT INTO `borrow` VALUES ('2', 'ed6e1160270711f0989b080058000005', '2025-05-09 19:06:05', null);
INSERT INTO `borrow` VALUES ('2', 'ed6e11bd270711f0989b080058000005', '2025-05-09 19:06:13', null);
INSERT INTO `borrow` VALUES ('3', 'c3739117271111f0989b080058000005', '2025-05-09 19:06:34', null);
INSERT INTO `borrow` VALUES ('3', 'c379aeef271111f0989b080058000005', '2025-05-09 19:06:45', null);
INSERT INTO `borrow` VALUES ('3', 'c38423e8271111f0989b080058000005', '2025-05-09 19:06:31', null);
INSERT INTO `borrow` VALUES ('3', 'c394c8e7271111f0989b080058000005', '2025-05-09 19:06:37', null);
INSERT INTO `borrow` VALUES ('3', 'c3987545271111f0989b080058000005', '2025-05-09 19:06:29', null);
INSERT INTO `borrow` VALUES ('3', 'ed6e11bd270711f0989b080058000005', '2025-05-09 19:06:40', null);
INSERT INTO `borrow` VALUES ('3', 'ed6e1213270711f0989b080058000005', '2025-05-09 19:06:50', null);
INSERT INTO `borrow` VALUES ('8', 'c38423e8271111f0989b080058000005', '2025-05-09 19:06:55', null);
INSERT INTO `borrow` VALUES ('8', 'c390feea271111f0989b080058000005', '2025-05-09 19:07:01', null);
INSERT INTO `borrow` VALUES ('8', 'c39c3a94271111f0989b080058000005', '2025-05-09 19:06:58', null);
INSERT INTO `borrow` VALUES ('8', 'ed6e10fc270711f0989b080058000005', '2025-05-09 19:07:04', null);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '名',
  `password` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '密',
  `nickname` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT 'avatar.jpg' COMMENT '头像',
  `telephone` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '电',
  `email` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '邮',
  `type` char(1) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '1:读者 0:管理员',
  `status` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '0:正常 1:禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '123456', '管理员1', 'avatar.jpg', '', '', '0', '0');
INSERT INTO `user` VALUES ('2', 'r1', '123456', '读者1', 'avatar.jpg', '', '', '1', '0');
INSERT INTO `user` VALUES ('3', 'r2', '123', '读者2', 'avatar.jpg', null, null, '1', '0');
INSERT INTO `user` VALUES ('4', 'u1', '123', '管理员2', 'avatar.jpg', null, null, '0', '0');
INSERT INTO `user` VALUES ('5', 'u2', '123', '管理员3', 'avatar.jpg', null, null, '0', '0');
INSERT INTO `user` VALUES ('6', 'r3', '123', '读者3', 'avatar.jpg', null, null, '1', '0');
INSERT INTO `user` VALUES ('7', 'a', 'b', '读者4', 'avatar.jpg', '', '', '1', '0');
INSERT INTO `user` VALUES ('8', 'ww', 'ss', '读者51', 'avatar.jpg', '', '', '1', '0');
INSERT INTO `user` VALUES ('9', 'wwww', 'eee', '读者52', 'avatar.jpg', '', '', '1', '0');
INSERT INTO `user` VALUES ('10', '111', '222', '读者53', 'avatar.jpg', '', '', '1', '0');
INSERT INTO `user` VALUES ('11', '33', '44', '读者54', 'avatar.jpg', '', '', '1', '0');
INSERT INTO `user` VALUES ('12', '11', '11', '读者55', 'avatar.jpg', '', '', '1', '0');
INSERT INTO `user` VALUES ('13', '2007ss', '123', '读者56', 'avatar.jpg', '', '', '1', '0');
INSERT INTO `user` VALUES ('14', 'aaa', 'ssss', '读者57', 'avatar.jpg', '', '', '1', '0');
INSERT INTO `user` VALUES ('15', 'r58', '111', '者58', 'avatar.jpg', null, null, '1', '0');

-- ----------------------------
-- View structure for borrow_detail
-- ----------------------------
DROP VIEW IF EXISTS `borrow_detail`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `borrow_detail` AS select `borrow`.`readerID` AS `readerID`,`borrow`.`bookID` AS `bookID`,`user`.`nickname` AS `nickname`,`book`.`bookName` AS `bookName`,`borrow`.`borrowTime` AS `borrowTime`,`borrow`.`returnTime` AS `returnTime` from ((`book` join `borrow` on((`book`.`bookID` = `borrow`.`bookID`))) join `user` on((`user`.`id` = `borrow`.`readerID`))) ;
