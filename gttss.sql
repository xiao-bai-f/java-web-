/*
Navicat MySQL Data Transfer

Source Server         : mysql5.7.1
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : gttss

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2020-06-17 14:48:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_approvetopic
-- ----------------------------
DROP TABLE IF EXISTS `t_approvetopic`;
CREATE TABLE `t_approvetopic` (
  `topicName` varchar(30) NOT NULL,
  `topicDesc` text NOT NULL,
  `topicRequier` text NOT NULL,
  `teacherId` varchar(30) NOT NULL,
  `teacherName` varchar(50) NOT NULL,
  `studentId` varchar(30) NOT NULL,
  `approveData` date NOT NULL,
  PRIMARY KEY (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_approvetopic
-- ----------------------------
INSERT INTO `t_approvetopic` VALUES ('12', '23', '231', '101', 'xmy', '2016116106', '2020-04-27');

-- ----------------------------
-- Table structure for t_class
-- ----------------------------
DROP TABLE IF EXISTS `t_class`;
CREATE TABLE `t_class` (
  `classId` varchar(30) NOT NULL COMMENT '班级编号',
  `classHeadTeacherName` varchar(30) NOT NULL COMMENT '班主任姓名',
  `Count` varchar(4) NOT NULL COMMENT '班级人数',
  `schoolId` varchar(30) NOT NULL DEFAULT '666666' COMMENT '所属学校Id',
  PRIMARY KEY (`classId`,`schoolId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_class
-- ----------------------------
INSERT INTO `t_class` VALUES ('20161161', 'cys', '39', '666666');
INSERT INTO `t_class` VALUES ('20161162', 'cys', '39', '666666');
INSERT INTO `t_class` VALUES ('20161191', 'bzd', '39', '666666');
INSERT INTO `t_class` VALUES ('20161192', 'asd', '39', '666666');
INSERT INTO `t_class` VALUES ('20164911', 'zxm', '56', '666666');

-- ----------------------------
-- Table structure for t_class_major
-- ----------------------------
DROP TABLE IF EXISTS `t_class_major`;
CREATE TABLE `t_class_major` (
  `classId` varchar(30) NOT NULL COMMENT '班级编号',
  `majorId` varchar(30) NOT NULL COMMENT '专业编号',
  `schoolId` varchar(30) NOT NULL DEFAULT '666666' COMMENT '学校编号',
  PRIMARY KEY (`schoolId`,`classId`) USING BTREE,
  KEY `fk_class` (`classId`),
  KEY `fk_major` (`majorId`),
  CONSTRAINT `fk_class` FOREIGN KEY (`classId`) REFERENCES `t_class` (`classId`),
  CONSTRAINT `fk_major` FOREIGN KEY (`majorId`) REFERENCES `t_major` (`majorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_class_major
-- ----------------------------
INSERT INTO `t_class_major` VALUES ('20164911', '005001', '666666');
INSERT INTO `t_class_major` VALUES ('20161161', '010001', '666666');
INSERT INTO `t_class_major` VALUES ('20161162', '010001', '666666');
INSERT INTO `t_class_major` VALUES ('20161191', '010002', '666666');
INSERT INTO `t_class_major` VALUES ('20161192', '010002', '666666');

-- ----------------------------
-- Table structure for t_college
-- ----------------------------
DROP TABLE IF EXISTS `t_college`;
CREATE TABLE `t_college` (
  `collegeId` varchar(30) NOT NULL COMMENT '学院编号',
  `collegeName` varchar(50) NOT NULL COMMENT '学院名字',
  `schoolId` varchar(30) NOT NULL DEFAULT '666666' COMMENT '学校编号',
  `schoolName` varchar(50) NOT NULL DEFAULT '韩式师范学院' COMMENT '学校名字',
  PRIMARY KEY (`collegeId`,`schoolId`) USING BTREE,
  KEY `college_school` (`schoolId`),
  CONSTRAINT `college_school` FOREIGN KEY (`schoolId`) REFERENCES `t_school` (`schoolId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_college
-- ----------------------------
INSERT INTO `t_college` VALUES ('001', '材料科学与工程学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('002', '化学与环境工程学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('003', '计算机与信息工程学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('004', '经济与管理学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('005', '教育科学学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('006', '历史文化学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('007', '马克思主义学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('008', '美术与设计学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('009', '食品工程与生物科技学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('010', '数学与统计学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('011', '体育学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('012', '陶瓷与非物质文化遗产传承学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('013', '广东陶瓷职业技术学校', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('014', '文学与新闻传播学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('015', '外国语学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('016', '物理与电子工程学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('017', '音乐学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('018', '政法学院', '666666', '韩式师范学院');
INSERT INTO `t_college` VALUES ('019', '烹饪与酒店管理', '666666', '韩式师范学院');

-- ----------------------------
-- Table structure for t_major
-- ----------------------------
DROP TABLE IF EXISTS `t_major`;
CREATE TABLE `t_major` (
  `majorId` varchar(30) NOT NULL COMMENT '专业编号',
  `majorName` varchar(50) NOT NULL COMMENT '专业名称',
  `collegeId` varchar(30) NOT NULL COMMENT '学院编号',
  `collegeName` varchar(50) NOT NULL COMMENT '学院名称',
  `schoolId` varchar(30) NOT NULL DEFAULT '666666' COMMENT '学校编号',
  PRIMARY KEY (`majorId`,`collegeId`,`schoolId`),
  KEY `major_college` (`collegeId`),
  CONSTRAINT `major_college` FOREIGN KEY (`collegeId`) REFERENCES `t_college` (`collegeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_major
-- ----------------------------
INSERT INTO `t_major` VALUES ('001001', '无机非金属材料工程', '001', '材料科学与工程学院', '666666');
INSERT INTO `t_major` VALUES ('001002', '材料科学与工程材料', '001', '材料科学与工程学院', '666666');
INSERT INTO `t_major` VALUES ('001003', '材料物理', '001', '材料科学与工程学院', '666666');
INSERT INTO `t_major` VALUES ('002001', '化学', '002', '化学与环境工程学院', '666666');
INSERT INTO `t_major` VALUES ('002002', '环境科学', '002', '化学与环境工程学院', '666666');
INSERT INTO `t_major` VALUES ('002003', '环境工程', '002', '化学与环境工程学院', '666666');
INSERT INTO `t_major` VALUES ('002004', '应用化学', '002', '化学与环境工程学院', '666666');
INSERT INTO `t_major` VALUES ('002005', '高分子材料与工程', '002', '化学与环境工程学院', '666666');
INSERT INTO `t_major` VALUES ('003001', '计算机科学与技术', '003', '计算机与信息工程学院', '666666');
INSERT INTO `t_major` VALUES ('003002', '软件工程', '003', '计算机与信息工程学院', '666666');
INSERT INTO `t_major` VALUES ('003003', '信息管理与信息系统', '003', '计算机与信息工程学院', '666666');
INSERT INTO `t_major` VALUES ('003004', '物联网工程', '003', '计算机与信息工程学院', '666666');
INSERT INTO `t_major` VALUES ('004001', '经济学', '004', '经济与管理学院', '666666');
INSERT INTO `t_major` VALUES ('004002', '人力资源管理', '004', '经济与管理学院', '666666');
INSERT INTO `t_major` VALUES ('004003', '财务管理', '004', '经济与管理学院', '666666');
INSERT INTO `t_major` VALUES ('004004', '审计学', '004', '经济与管理学院', '666666');
INSERT INTO `t_major` VALUES ('005001', '学前教育', '005', '教育与科学学院', '666666');
INSERT INTO `t_major` VALUES ('005002', '心理学', '005', '教育与科学学院', '666666');
INSERT INTO `t_major` VALUES ('005003', '小学教育', '005', '教育与科学学院', '666666');
INSERT INTO `t_major` VALUES ('005004', '教育技术', '005', '教育与科学学院', '666666');
INSERT INTO `t_major` VALUES ('006001', '历史学（师范）', '006', '历史文化学院', '666666');
INSERT INTO `t_major` VALUES ('006002', '档案学（非师范）', '006', '历史文化学院', '666666');
INSERT INTO `t_major` VALUES ('008001', '美术学', '008', '美术与设计学院', '666666');
INSERT INTO `t_major` VALUES ('008002', '书法教育', '008', '美术与设计学院', '666666');
INSERT INTO `t_major` VALUES ('008003', '陶瓷艺术设计', '008', '美术与设计学院', '666666');
INSERT INTO `t_major` VALUES ('008004', '环境艺术设计', '008', '美术与设计学院', '666666');
INSERT INTO `t_major` VALUES ('008005', '装潢艺术设计', '008', '美术与设计学院', '666666');
INSERT INTO `t_major` VALUES ('008006', '商业摄影', '008', '美术与设计学院', '666666');
INSERT INTO `t_major` VALUES ('009001', '生物科学', '009', '食品工程与生物科技学院', '666666');
INSERT INTO `t_major` VALUES ('009002', '生物技术', '009', '食品工程与生物科技学院', '666666');
INSERT INTO `t_major` VALUES ('009003', '食品科学与工程', '009', '食品工程与生物科技学院', '666666');
INSERT INTO `t_major` VALUES ('009004', '食品质量与安全专业', '009', '食品工程与生物科技学院', '666666');
INSERT INTO `t_major` VALUES ('010001', '信息与计算科学', '010', '数学与统计学院', '666666');
INSERT INTO `t_major` VALUES ('010002', '统计学', '010', '数学与统计学院', '666666');
INSERT INTO `t_major` VALUES ('010003', '数学与应用数学', '010', '数学与统计学院', '666666');
INSERT INTO `t_major` VALUES ('011001', '体育教育', '011', '体育学院', '666666');
INSERT INTO `t_major` VALUES ('011002', '社会体育指导与管理', '011', '食品工程与生物科技学院', '666666');
INSERT INTO `t_major` VALUES ('011003', '运动健康', '011', '食品工程与生物科技学院', '666666');
INSERT INTO `t_major` VALUES ('012001', '产品设计', '012', '陶瓷与非物质文化遗产传承学院', '666666');
INSERT INTO `t_major` VALUES ('012002', '艺术设计', '012', '陶瓷与非物质文化遗产传承学院', '666666');
INSERT INTO `t_major` VALUES ('012003', '服装与服饰设计', '012', '陶瓷与非物质文化遗产传承学院', '666666');
INSERT INTO `t_major` VALUES ('012004', '动漫设计专业', '012', '陶瓷与非物质文化遗产传承学院', '666666');
INSERT INTO `t_major` VALUES ('014001', '汉语言文学', '014', '文学与新闻传播学院', '666666');
INSERT INTO `t_major` VALUES ('014002', '中英文秘书（非师范）', '014', '文学与新闻传播学院', '666666');
INSERT INTO `t_major` VALUES ('014003', '广播电视新闻学（非师范）', '014', '文学与新闻传播学院', '666666');
INSERT INTO `t_major` VALUES ('014004', '网络与新媒体专业', '014', '文学与新闻传播学院', '666666');
INSERT INTO `t_major` VALUES ('015001', '英语（师范）', '015', '外国语学院', '666666');
INSERT INTO `t_major` VALUES ('015002', '英语（商务英语方向）', '015', '外国语学院', '666666');
INSERT INTO `t_major` VALUES ('015003', '日语（商务方向）', '015', '外国语学院', '666666');
INSERT INTO `t_major` VALUES ('016001', '物理学', '016', '物理与电子工程学院', '666666');
INSERT INTO `t_major` VALUES ('016002', '电子信息科学与技术', '016', '物理与电子工程学院', '666666');
INSERT INTO `t_major` VALUES ('016003', '电子信息工程', '016', '物理与电子工程学院', '666666');
INSERT INTO `t_major` VALUES ('016004', '电气工程及自动化专业', '016', '物理与电子工程学院', '666666');
INSERT INTO `t_major` VALUES ('017001', '音乐学（钢琴调律方向、师范类）', '017', '音乐学院', '666666');
INSERT INTO `t_major` VALUES ('017002', '音乐学（师范类）', '017', '音乐学院', '666666');
INSERT INTO `t_major` VALUES ('018001', '思想政治教育（师范类）', '018', '政法学院', '666666');
INSERT INTO `t_major` VALUES ('018002', '法学', '018', '政法学院', '666666');
INSERT INTO `t_major` VALUES ('018003', '社会工作', '018', '政法学院', '666666');
INSERT INTO `t_major` VALUES ('019001', '烹饪与营养教育', '019', '烹饪与酒店管理学院', '666666');
INSERT INTO `t_major` VALUES ('019002', '酒店管理', '019', '烹饪与酒店管理学院', '666666');
INSERT INTO `t_major` VALUES ('019003', '旅游管理', '019', '烹饪与酒店管理学院', '666666');
INSERT INTO `t_major` VALUES ('019004', '地理科学', '019', '烹饪与酒店管理学院', '666666');

-- ----------------------------
-- Table structure for t_messagehistory
-- ----------------------------
DROP TABLE IF EXISTS `t_messagehistory`;
CREATE TABLE `t_messagehistory` (
  `Sender` varchar(30) NOT NULL COMMENT '发送者',
  `Recever` varchar(30) NOT NULL COMMENT '接收者',
  `sendTime` datetime NOT NULL COMMENT '信息发送时间',
  `message` text NOT NULL COMMENT '信息内容',
  `isRecever` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否被接收到',
  `isRead` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否被读取'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_messagehistory
-- ----------------------------
INSERT INTO `t_messagehistory` VALUES ('2016116155', '101', '2020-05-22 09:59:44', '老师好', '1', '1');
INSERT INTO `t_messagehistory` VALUES ('101', '2016116155', '2020-05-22 10:00:03', '你好', '1', '1');
INSERT INTO `t_messagehistory` VALUES ('2016116155', '101', '2020-05-22 10:00:36', '年后撒多渠道\n', '1', '1');
INSERT INTO `t_messagehistory` VALUES ('2016116155', '101', '2020-05-22 10:00:44', 'hello', '1', '1');
INSERT INTO `t_messagehistory` VALUES ('101', '2016116155', '2020-05-22 10:00:52', '你好啊', '1', '1');
INSERT INTO `t_messagehistory` VALUES ('101', '2016116155', '2020-05-22 10:01:13', '你好', '1', '1');
INSERT INTO `t_messagehistory` VALUES ('2016116151', '101', '2020-05-22 10:10:14', '你好老师', '1', '1');

-- ----------------------------
-- Table structure for t_midreport
-- ----------------------------
DROP TABLE IF EXISTS `t_midreport`;
CREATE TABLE `t_midreport` (
  `studentId` varchar(30) CHARACTER SET utf8 NOT NULL,
  `teacherId` varchar(30) CHARACTER SET utf8 NOT NULL,
  `status` enum('0','1','2') CHARACTER SET utf8 NOT NULL DEFAULT '0' COMMENT '中期检查报告状态',
  `fileName` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '文件名称',
  `suffix` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '.docx' COMMENT '文件后缀名称',
  `subTime` date NOT NULL COMMENT '提交时间',
  PRIMARY KEY (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_midreport
-- ----------------------------
INSERT INTO `t_midreport` VALUES ('2016116105', '101', '0', '2016116105QQQ.docx', '.docx', '2020-05-22');
INSERT INTO `t_midreport` VALUES ('2016116106', '101', '2', '2016116106刘楚峰.docx', '.docx', '2020-05-01');
INSERT INTO `t_midreport` VALUES ('2016116109', '101', '0', '2016116109009', '.docx', '2020-04-20');
INSERT INTO `t_midreport` VALUES ('2016116151', '101', '1', '2016116151小明.docx', '.docx', '2020-05-22');

-- ----------------------------
-- Table structure for t_openreport
-- ----------------------------
DROP TABLE IF EXISTS `t_openreport`;
CREATE TABLE `t_openreport` (
  `studentId` varchar(30) CHARACTER SET utf8 NOT NULL,
  `teacherId` varchar(30) NOT NULL,
  `status` enum('0','1','2') CHARACTER SET utf8 DEFAULT '0',
  `fileName` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '文件名称',
  `suffix` varchar(20) CHARACTER SET utf8 DEFAULT '.docx' COMMENT '文件后缀',
  `subTime` date NOT NULL COMMENT '提交时间',
  PRIMARY KEY (`studentId`),
  CONSTRAINT `fk_open_student` FOREIGN KEY (`studentId`) REFERENCES `t_student` (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_openreport
-- ----------------------------
INSERT INTO `t_openreport` VALUES ('20161105', '101', '0', '20161105XXX.docx', '.docx', '2020-05-22');
INSERT INTO `t_openreport` VALUES ('2016116105', '101', '1', '2016116105QQQ.docx', '.docx', '2020-05-22');
INSERT INTO `t_openreport` VALUES ('2016116106', '101', '1', '2016116106刘楚峰', '.docx', '2020-04-22');
INSERT INTO `t_openreport` VALUES ('2016116109', '101', '1', '2016116109dada xv', '.docx', '2020-04-19');
INSERT INTO `t_openreport` VALUES ('2016116151', '101', '1', '2016116151小明.docx', '.docx', '2020-05-22');
INSERT INTO `t_openreport` VALUES ('2016116155', '101', '1', '2016116155小艾.docx', '.docx', '2020-05-22');

-- ----------------------------
-- Table structure for t_plead
-- ----------------------------
DROP TABLE IF EXISTS `t_plead`;
CREATE TABLE `t_plead` (
  `teacherId` varchar(30) NOT NULL COMMENT '教师编号',
  `pleadTime` date NOT NULL COMMENT '答辩时间',
  `pleadAddress` varchar(100) NOT NULL COMMENT '答辩地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_plead
-- ----------------------------
INSERT INTO `t_plead` VALUES ('101', '0002-11-30', '韩东校区c201');

-- ----------------------------
-- Table structure for t_progress
-- ----------------------------
DROP TABLE IF EXISTS `t_progress`;
CREATE TABLE `t_progress` (
  `subTopic` date NOT NULL COMMENT '选择试题',
  `subOpenReport` date NOT NULL COMMENT '提交开题报告',
  `subMidCheck` date NOT NULL COMMENT '提交中期检查',
  `subThesisFirst` date NOT NULL COMMENT '提交初稿',
  `subThesisSecond` date NOT NULL COMMENT '提交定稿',
  `subThesisLast` date NOT NULL COMMENT '提交终稿',
  `teacherId` varchar(30) NOT NULL,
  PRIMARY KEY (`teacherId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_progress
-- ----------------------------
INSERT INTO `t_progress` VALUES ('2020-02-10', '2020-03-27', '2020-04-11', '2020-04-25', '2020-05-01', '2019-05-16', '101');

-- ----------------------------
-- Table structure for t_school
-- ----------------------------
DROP TABLE IF EXISTS `t_school`;
CREATE TABLE `t_school` (
  `schoolId` varchar(30) NOT NULL DEFAULT '666666' COMMENT '学校编号',
  `schoolName` varchar(50) NOT NULL DEFAULT '韩山师范学院' COMMENT '学院名称',
  PRIMARY KEY (`schoolId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_school
-- ----------------------------
INSERT INTO `t_school` VALUES ('666666', '韩山师范学院');

-- ----------------------------
-- Table structure for t_scoring
-- ----------------------------
DROP TABLE IF EXISTS `t_scoring`;
CREATE TABLE `t_scoring` (
  `studentId` varchar(30) NOT NULL,
  `teacherId` varchar(30) NOT NULL,
  `content` tinyint(4) NOT NULL,
  `think` tinyint(4) NOT NULL,
  `express` tinyint(4) NOT NULL,
  `answer` tinyint(4) NOT NULL,
  `grade` tinyint(4) NOT NULL,
  `subtime` date NOT NULL,
  PRIMARY KEY (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_scoring
-- ----------------------------
INSERT INTO `t_scoring` VALUES ('2016116106', '101', '12', '12', '1', '1', '1', '2020-05-22');
INSERT INTO `t_scoring` VALUES ('2016116109', '101', '10', '10', '10', '10', '40', '2020-04-25');
INSERT INTO `t_scoring` VALUES ('2016116151', '101', '10', '10', '10', '10', '40', '2020-05-22');

-- ----------------------------
-- Table structure for t_student
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student` (
  `studentId` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '学生号',
  `studentName` varchar(10) CHARACTER SET utf8 NOT NULL COMMENT '学生姓名',
  `studentAge` varchar(4) CHARACTER SET utf8 NOT NULL DEFAULT '22' COMMENT '学生年龄',
  `studentSex` enum('男','女') CHARACTER SET utf8 NOT NULL DEFAULT '男' COMMENT '学生性别',
  `studentEducation` enum('本科','硕士','博士','专科') CHARACTER SET utf8 NOT NULL DEFAULT '本科' COMMENT '学历',
  `studentEmail` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT 'xxx@xxx.com',
  `studentTel` varchar(20) CHARACTER SET utf8 NOT NULL,
  `studentAddress` varchar(100) CHARACTER SET utf8 NOT NULL,
  `schoolId` varchar(30) NOT NULL DEFAULT '666666' COMMENT '学校编号',
  `isTopic` enum('0','1') CHARACTER SET utf8 NOT NULL DEFAULT '0' COMMENT '是否选择论文',
  `isOpenReport` enum('0','1') CHARACTER SET utf8 NOT NULL DEFAULT '0' COMMENT '是否提交开题报告',
  `isMidReport` enum('0','1') CHARACTER SET utf8 NOT NULL DEFAULT '0' COMMENT '是否提交中期检查',
  `isThesisFirst` enum('0','1') CHARACTER SET utf8 NOT NULL DEFAULT '0' COMMENT '是否提交论文初稿',
  `isThesisSecond` enum('0','1') CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `isThesisLast` enum('0','1') CHARACTER SET utf8 NOT NULL DEFAULT '0' COMMENT '是否提交论文终稿',
  PRIMARY KEY (`studentId`,`schoolId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_student
-- ----------------------------
INSERT INTO `t_student` VALUES ('20161105', 'XXX', '22', '男', '本科', 'xxx@xxx.com', '001', 'nullnullnull', '666666', '1', '1', '0', '0', '0', '0');
INSERT INTO `t_student` VALUES ('2016116105', 'QQQ', '22', '男', '本科', 'xxx@xxx.com', '15916456921', '韩师', '666666', '1', '1', '1', '0', '0', '0');
INSERT INTO `t_student` VALUES ('2016116106', '刘楚峰', '22', '男', '本科', '1131211503@qq.com', '010', 'nullnullnull', '666666', '1', '1', '1', '1', '1', '1');
INSERT INTO `t_student` VALUES ('2016116109', '王嘉尔', '22', '男', '本科', '15626482523@123.com', '010', 'nullnullnull', '666666', '1', '1', '1', '1', '1', '1');
INSERT INTO `t_student` VALUES ('2016116115', 'xmy', '22', '女', '本科', '1131211503@qq.com', '', '', '666666', '1', '1', '0', '1', '0', '0');
INSERT INTO `t_student` VALUES ('2016116151', '小明', '22', '男', '本科', 'xxx@xxx.com', '15916456921', '韩东校区', '666666', '1', '1', '1', '1', '1', '1');
INSERT INTO `t_student` VALUES ('2016116155', '小艾', '22', '男', '本科', 'xxx@xxx.com', '15916456921', '韩东校区', '666666', '1', '1', '0', '0', '0', '0');
INSERT INTO `t_student` VALUES ('2016116201', 'yyy', '22', '男', '本科', 'xxx@xxx.com', '15916456341', '位置', '666666', '0', '0', '0', '0', '0', '0');
INSERT INTO `t_student` VALUES ('2016491118', '傻逼仔', '22', '女', '博士', 'xxx@xxx.com', '15916456921', '月球', '666666', '1', '1', '1', '1', '0', '1');

-- ----------------------------
-- Table structure for t_studentlogin
-- ----------------------------
DROP TABLE IF EXISTS `t_studentlogin`;
CREATE TABLE `t_studentlogin` (
  `studentId` varchar(30) CHARACTER SET utf8 NOT NULL COMMENT '学生编号',
  `studentpassword` varchar(30) NOT NULL COMMENT '学生密码',
  `schoolId` varchar(30) NOT NULL COMMENT '学校编号',
  `islogin` enum('yes','no') NOT NULL DEFAULT 'no' COMMENT '是否登陆',
  PRIMARY KEY (`studentId`,`schoolId`),
  KEY `studentId` (`studentId`),
  CONSTRAINT `fk_studentlogin` FOREIGN KEY (`studentId`) REFERENCES `t_student` (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_studentlogin
-- ----------------------------
INSERT INTO `t_studentlogin` VALUES ('20161105', '123', '666666', 'no');
INSERT INTO `t_studentlogin` VALUES ('2016116105', '123', '666666', 'no');
INSERT INTO `t_studentlogin` VALUES ('2016116106', '123', '666666', 'no');
INSERT INTO `t_studentlogin` VALUES ('2016116109', '123', '666666', 'no');
INSERT INTO `t_studentlogin` VALUES ('2016116115', '123', '666666', 'no');
INSERT INTO `t_studentlogin` VALUES ('2016116151', '123', '666666', 'no');
INSERT INTO `t_studentlogin` VALUES ('2016116155', '123', '666666', 'no');
INSERT INTO `t_studentlogin` VALUES ('2016116201', '123', '666666', 'no');
INSERT INTO `t_studentlogin` VALUES ('2016491118', '123', '666666', 'no');

-- ----------------------------
-- Table structure for t_student_class
-- ----------------------------
DROP TABLE IF EXISTS `t_student_class`;
CREATE TABLE `t_student_class` (
  `studentId` varchar(30) CHARACTER SET utf8 NOT NULL COMMENT '学号',
  `classId` varchar(30) NOT NULL COMMENT '班级编号',
  `schoolId` varchar(30) NOT NULL DEFAULT '666666' COMMENT '学校编号',
  PRIMARY KEY (`studentId`,`schoolId`),
  KEY `fk_student_class` (`classId`),
  KEY `studentId` (`studentId`),
  CONSTRAINT `fk_student` FOREIGN KEY (`studentId`) REFERENCES `t_student` (`studentId`),
  CONSTRAINT `fk_student_class` FOREIGN KEY (`classId`) REFERENCES `t_class` (`classId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_student_class
-- ----------------------------
INSERT INTO `t_student_class` VALUES ('20161105', '20161161', '666666');
INSERT INTO `t_student_class` VALUES ('2016116105', '20161161', '666666');
INSERT INTO `t_student_class` VALUES ('2016116106', '20161161', '666666');
INSERT INTO `t_student_class` VALUES ('2016116109', '20161161', '666666');
INSERT INTO `t_student_class` VALUES ('2016116115', '20161161', '666666');
INSERT INTO `t_student_class` VALUES ('2016116151', '20161161', '666666');
INSERT INTO `t_student_class` VALUES ('2016116155', '20161161', '666666');
INSERT INTO `t_student_class` VALUES ('2016116201', '20161162', '666666');
INSERT INTO `t_student_class` VALUES ('2016491118', '20164911', '666666');

-- ----------------------------
-- Table structure for t_student_topic
-- ----------------------------
DROP TABLE IF EXISTS `t_student_topic`;
CREATE TABLE `t_student_topic` (
  `studentId` varchar(30) CHARACTER SET utf8 NOT NULL COMMENT '学号',
  `topicId` varchar(30) NOT NULL COMMENT '课题编号',
  `selectTime` date DEFAULT NULL COMMENT '选题时间',
  PRIMARY KEY (`studentId`),
  KEY `studentId` (`studentId`),
  KEY `student_topic2` (`topicId`),
  CONSTRAINT `student_topic2` FOREIGN KEY (`topicId`) REFERENCES `t_teacher_topic` (`topicId`),
  CONSTRAINT `t_student_topics3` FOREIGN KEY (`studentId`) REFERENCES `t_student` (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_student_topic
-- ----------------------------
INSERT INTO `t_student_topic` VALUES ('20161105', '119', null);
INSERT INTO `t_student_topic` VALUES ('2016116105', '105', null);
INSERT INTO `t_student_topic` VALUES ('2016116106', '10', '0000-00-00');
INSERT INTO `t_student_topic` VALUES ('2016116109', '11', '0000-00-00');
INSERT INTO `t_student_topic` VALUES ('2016116115', '12', '0000-00-00');
INSERT INTO `t_student_topic` VALUES ('2016116151', '65', null);
INSERT INTO `t_student_topic` VALUES ('2016116155', '585', null);
INSERT INTO `t_student_topic` VALUES ('2016491118', '18', '0000-00-00');

-- ----------------------------
-- Table structure for t_teacher
-- ----------------------------
DROP TABLE IF EXISTS `t_teacher`;
CREATE TABLE `t_teacher` (
  `teacherId` varchar(30) NOT NULL COMMENT '教师编号',
  `teacherName` varchar(30) NOT NULL COMMENT '教师姓名',
  `teacherAge` varchar(10) NOT NULL COMMENT '教师年龄',
  `teacherSex` enum('男','女') NOT NULL DEFAULT '男' COMMENT '教师性别',
  `teacherTel` varchar(30) NOT NULL COMMENT '教师联系电话',
  `teacherEmail` varchar(20) NOT NULL COMMENT '教师邮箱',
  `isHeadTeacher` enum('yes','no') NOT NULL DEFAULT 'no' COMMENT '是否是班主任',
  `schoolId` varchar(30) NOT NULL DEFAULT '666666' COMMENT '学校编号',
  PRIMARY KEY (`teacherId`,`schoolId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_teacher
-- ----------------------------
INSERT INTO `t_teacher` VALUES ('101', 'xmy', '23', '男', '18028262575', '1231544816@qq.com', 'no', '666666');
INSERT INTO `t_teacher` VALUES ('102', 'xdd', '45', '男', '15648156489', '1231544816@qq.com', 'no', '666666');
INSERT INTO `t_teacher` VALUES ('103', 'zxmmm', '48', '男', '15165146548', '234', 'yes', '666666');

-- ----------------------------
-- Table structure for t_teacherlogin
-- ----------------------------
DROP TABLE IF EXISTS `t_teacherlogin`;
CREATE TABLE `t_teacherlogin` (
  `teacherId` varchar(30) NOT NULL,
  `teacherPassword` varchar(50) NOT NULL,
  `schoolId` varchar(30) NOT NULL DEFAULT '666666',
  `islogin` enum('yes','no') CHARACTER SET utf8 NOT NULL DEFAULT 'no' COMMENT '是否登陆',
  PRIMARY KEY (`teacherId`,`schoolId`),
  KEY `teacherId` (`teacherId`),
  CONSTRAINT `fk_teacherlogin` FOREIGN KEY (`teacherId`) REFERENCES `t_teacher` (`teacherId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_teacherlogin
-- ----------------------------
INSERT INTO `t_teacherlogin` VALUES ('101', '123', '666666', 'no');
INSERT INTO `t_teacherlogin` VALUES ('102', '1234', '666666', 'no');
INSERT INTO `t_teacherlogin` VALUES ('103', '123', '666666', 'no');

-- ----------------------------
-- Table structure for t_teacher_college
-- ----------------------------
DROP TABLE IF EXISTS `t_teacher_college`;
CREATE TABLE `t_teacher_college` (
  `teacherId` varchar(30) NOT NULL COMMENT '教师编号',
  `collegeId` varchar(30) NOT NULL COMMENT '学院名称',
  `schoolId` varchar(30) NOT NULL DEFAULT '666666' COMMENT '学校编号',
  PRIMARY KEY (`teacherId`,`collegeId`,`schoolId`),
  KEY `fk_teacher` (`collegeId`),
  CONSTRAINT `fk_teacher` FOREIGN KEY (`collegeId`) REFERENCES `t_college` (`collegeId`),
  CONSTRAINT `fk_teacher_college` FOREIGN KEY (`teacherId`) REFERENCES `t_teacher` (`teacherId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_teacher_college
-- ----------------------------
INSERT INTO `t_teacher_college` VALUES ('103', '006', '666666');
INSERT INTO `t_teacher_college` VALUES ('101', '010', '666666');
INSERT INTO `t_teacher_college` VALUES ('102', '010', '666666');
INSERT INTO `t_teacher_college` VALUES ('103', '010', '666666');

-- ----------------------------
-- Table structure for t_teacher_topic
-- ----------------------------
DROP TABLE IF EXISTS `t_teacher_topic`;
CREATE TABLE `t_teacher_topic` (
  `topicId` varchar(30) NOT NULL COMMENT '试题编号',
  `teacherId` varchar(30) NOT NULL COMMENT '教师编号',
  `schoolId` varchar(30) NOT NULL DEFAULT '666666' COMMENT '学校编号',
  PRIMARY KEY (`topicId`,`schoolId`),
  KEY `fk_teachers` (`teacherId`),
  KEY `topicId` (`topicId`),
  CONSTRAINT `fk_teacher_topic` FOREIGN KEY (`topicId`) REFERENCES `t_topic` (`topicId`),
  CONSTRAINT `fk_teachers` FOREIGN KEY (`teacherId`) REFERENCES `t_teacher` (`teacherId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_teacher_topic
-- ----------------------------
INSERT INTO `t_teacher_topic` VALUES ('10', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('105', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('11', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('119', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('12', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('13', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('15', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('236', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('252', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('34', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('355', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('383', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('387', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('585', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('586', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('597', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('65', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('671', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('680', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('885', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('886', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('936', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('957', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('97', '101', '666666');
INSERT INTO `t_teacher_topic` VALUES ('17', '103', '666666');
INSERT INTO `t_teacher_topic` VALUES ('18', '103', '666666');
INSERT INTO `t_teacher_topic` VALUES ('182', '103', '666666');
INSERT INTO `t_teacher_topic` VALUES ('528', '103', '666666');

-- ----------------------------
-- Table structure for t_thesisfirst
-- ----------------------------
DROP TABLE IF EXISTS `t_thesisfirst`;
CREATE TABLE `t_thesisfirst` (
  `studentId` varchar(30) CHARACTER SET utf8 NOT NULL,
  `teacherId` varchar(30) NOT NULL,
  `Status` enum('0','1','2') CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `fileName` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '文件名称',
  `suffix` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '.docx' COMMENT '文件后缀',
  `subTime` date NOT NULL COMMENT '提交时间',
  PRIMARY KEY (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_thesisfirst
-- ----------------------------
INSERT INTO `t_thesisfirst` VALUES ('2016116106', '101', '0', '2016116106刘楚峰', '.docx', '2020-04-22');
INSERT INTO `t_thesisfirst` VALUES ('2016116109', '101', '0', '2016116109009', '.docx', '2020-04-21');
INSERT INTO `t_thesisfirst` VALUES ('2016116151', '101', '1', '2016116151小明.docx', '.docx', '2020-05-22');

-- ----------------------------
-- Table structure for t_thesislast
-- ----------------------------
DROP TABLE IF EXISTS `t_thesislast`;
CREATE TABLE `t_thesislast` (
  `studentId` varchar(30) NOT NULL COMMENT '学号',
  `teacherId` varchar(30) NOT NULL COMMENT '教师编号',
  `status` enum('0','1','2') NOT NULL DEFAULT '0' COMMENT '状态',
  `fileName` varchar(100) NOT NULL COMMENT '论文名称',
  `subTime` date NOT NULL COMMENT '提交时间',
  PRIMARY KEY (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_thesislast
-- ----------------------------
INSERT INTO `t_thesislast` VALUES ('2016116106', '101', '0', '2016116106刘楚峰.docx', '2020-05-22');
INSERT INTO `t_thesislast` VALUES ('2016116109', '101', '0', '2016116109王嘉尔', '2020-04-21');
INSERT INTO `t_thesislast` VALUES ('2016116151', '101', '0', '2016116151小明.docx', '2020-05-22');

-- ----------------------------
-- Table structure for t_thesissecond
-- ----------------------------
DROP TABLE IF EXISTS `t_thesissecond`;
CREATE TABLE `t_thesissecond` (
  `studentId` varchar(30) NOT NULL COMMENT '学号',
  `teacherId` varchar(30) NOT NULL COMMENT '教师编号',
  `status` enum('0','1','2') NOT NULL DEFAULT '0' COMMENT '论文状态',
  `fileName` varchar(100) NOT NULL COMMENT '论文名称',
  `subTime` date NOT NULL COMMENT '提交时间',
  PRIMARY KEY (`studentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_thesissecond
-- ----------------------------
INSERT INTO `t_thesissecond` VALUES ('2016116106', '101', '0', '2016116106刘楚峰.docx', '2020-04-22');
INSERT INTO `t_thesissecond` VALUES ('2016116109', '101', '0', '2016116109009', '2020-04-20');
INSERT INTO `t_thesissecond` VALUES ('2016116151', '101', '0', '2016116151小明.docx', '2020-05-22');

-- ----------------------------
-- Table structure for t_topic
-- ----------------------------
DROP TABLE IF EXISTS `t_topic`;
CREATE TABLE `t_topic` (
  `topicId` varchar(30) NOT NULL COMMENT '课题编号',
  `topicName` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '课题名',
  `teacherName` varchar(50) NOT NULL COMMENT '出题老师姓名',
  `topicDesc` varchar(255) NOT NULL COMMENT '描述课题',
  `topicRequier` varchar(100) NOT NULL COMMENT '课题要求',
  `schoolId` varchar(30) NOT NULL DEFAULT '666666' COMMENT '学校编号',
  `publishTime` date DEFAULT '2020-01-01' COMMENT '发布时间',
  `isSelected` enum('yes','no') NOT NULL DEFAULT 'no',
  PRIMARY KEY (`topicId`,`schoolId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_topic
-- ----------------------------
INSERT INTO `t_topic` VALUES ('10', 'Ceasdadsad', 'xmy', '奥利个', '', '666666', '2020-01-01', 'yes');
INSERT INTO `t_topic` VALUES ('105', 'php网站开发', 'xmy', '网站开发', 'php', '666666', null, 'yes');
INSERT INTO `t_topic` VALUES ('11', 'text', 'xmy', '不知', '不知', '666666', '2020-02-24', 'yes');
INSERT INTO `t_topic` VALUES ('119', 'go语言', 'xmy', 'go', '语言', '666666', null, 'yes');
INSERT INTO `t_topic` VALUES ('12', '毕业论文选题系统的开发', 'xmy', '基于java web开发', '基于java web开发', '666666', null, 'yes');
INSERT INTO `t_topic` VALUES ('13', '1221', 'xmy', '????', '123', '666666', null, 'no');
INSERT INTO `t_topic` VALUES ('15', '1221', 'xmy', '123', '123', '666666', null, 'no');
INSERT INTO `t_topic` VALUES ('17', '论幼师教育方法', 'zxm', '相当大的多多', '敖德萨大多', '666666', '2020-01-02', 'no');
INSERT INTO `t_topic` VALUES ('18', '论狗子', 'zxm', '1231321', '123131', '666666', '2020-01-01', 'yes');
INSERT INTO `t_topic` VALUES ('182', '幼师教育理论', 'zxmmm', '幼师', '幼师', '666666', '2020-04-25', 'no');
INSERT INTO `t_topic` VALUES ('236', '安卓安全系统', 'xmy', 'ios', 'ios', '666666', '2020-05-22', 'no');
INSERT INTO `t_topic` VALUES ('252', 'c++游戏开发', 'xmy', '游戏开发', 'c++', '666666', null, '');
INSERT INTO `t_topic` VALUES ('34', '3434', 'xmy', 'asd', 'asda', '666666', '2020-01-01', 'no');
INSERT INTO `t_topic` VALUES ('355', 'go语言', 'xmy', 'go', '语言', '666666', null, '');
INSERT INTO `t_topic` VALUES ('383', '易语言编程？？', 'xmy', '编程', '易语言', '666666', '2020-04-20', 'no');
INSERT INTO `t_topic` VALUES ('387', 'php网站开发', 'xmy', '网站开发', 'php', '666666', null, 'no');
INSERT INTO `t_topic` VALUES ('528', '考古学', 'zxmmm', '考古', 'dddd', '666666', '2020-04-25', 'no');
INSERT INTO `t_topic` VALUES ('585', 'C#开发', 'xmy', 'AQS', '123，com', '666666', '2020-04-21', 'yes');
INSERT INTO `t_topic` VALUES ('586', 'python数据爬虫', 'xmy', 'python', 'python', '666666', null, '');
INSERT INTO `t_topic` VALUES ('597', 'eqwe', 'xmy', 'qweqe', 'qwe', '666666', null, '');
INSERT INTO `t_topic` VALUES ('65', '基于安卓的地图开发', 'xmy', '安卓', '地图开发', '666666', '2020-05-22', 'yes');
INSERT INTO `t_topic` VALUES ('671', 'php网站开发', 'xmy', '网站开发', 'php', '666666', null, 'no');
INSERT INTO `t_topic` VALUES ('680', '12', 'xmy', ' 23', '231', '666666', '2020-04-22', 'no');
INSERT INTO `t_topic` VALUES ('885', '12', 'xmy', ' 23', '231', '666666', '2020-04-22', 'no');
INSERT INTO `t_topic` VALUES ('886', '菠萝头', 'xmy', '谁喜欢她', '帅', '666666', '2020-04-20', 'no');
INSERT INTO `t_topic` VALUES ('936', 'c++游戏开发', 'xmy', '游戏开发', 'c++', '666666', null, '');
INSERT INTO `t_topic` VALUES ('957', 'java web开发', 'xmy', 'java', 'web', '666666', null, '');
INSERT INTO `t_topic` VALUES ('97', 'php网站开发', 'xmy', '网站开发', 'php', '666666', null, 'no');
