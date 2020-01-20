/*
Navicat MySQL Data Transfer

Source Server         : 10.9.1.42
Source Server Version : 50537
Source Host           : 10.9.1.42:3306
Source Database       : qos

Target Server Type    : MYSQL
Target Server Version : 50537
File Encoding         : 65001

Date: 2019-12-11 09:59:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for data_event
-- ----------------------------
DROP TABLE IF EXISTS `data_event`;
CREATE TABLE `data_event` (
  `id` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '事件名称',
  `content` varchar(500) DEFAULT NULL,
  `event_type` tinyint(4) NOT NULL COMMENT '事件类型，1统计概率，2统计总数,3统计最大,4,统计最小',
  `target_type` tinyint(4) NOT NULL COMMENT '目标类型 1:全部 ，2所有医院， 3所有社区服务中心',
  `data_source` varchar(30) NOT NULL,
  `real_time_enabled` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否需要实时',
  `real_time_interval` smallint(6) NOT NULL DEFAULT '5' COMMENT '实时间隔，分钟',
  `filing_strategy` tinyint(4) NOT NULL,
  `filing_strategy_param1` int(11) DEFAULT NULL,
  `filing_strategy_param2` varchar(500) DEFAULT NULL,
  `schedule_strategy` tinyint(4) NOT NULL,
  `schedule_strategy_param1` int(11) DEFAULT NULL,
  `schedule_strategy_param2` varchar(500) DEFAULT NULL,
  `schedule_hour` int(11) NOT NULL DEFAULT '19',
  `execute_hours` int(11) NOT NULL DEFAULT '10' COMMENT '执行多久',
  `separate_process_thread` tinyint(4) NOT NULL COMMENT '单独处理线程',
  `process_start_date` date NOT NULL COMMENT '初始化开始处理日期',
  `force_process_date` date DEFAULT NULL,
  `maximum_process` int(11) NOT NULL DEFAULT '365',
  `enabled` tinyint(4) NOT NULL COMMENT '是否启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_event
-- ----------------------------
INSERT INTO `data_event` VALUES ('10100', '住院死亡率', '(住院患者死亡人数/同期出院患者总人次)*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('10110', '新生儿住院住院总死亡率', '（新生儿患者住院死亡人数/同期新生儿手术患者出院人次）*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('10111', '新生儿手术患者住院死亡率统计', '（新生儿死亡且有手术记录/新生儿手术且正常出院）*100% ', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('10112', '新生儿非手术患者住院死亡率', '新生儿死亡无手术记录/新生儿无手术且正常出院人数）*100% ', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('10113', '新生儿患者出生体重≤750克死亡率', '（出生体重≤750克的新生儿患者住院死亡人数/同期出生体重≤750克的新生儿患者出院人次）*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('10114', '新生儿患者出生体重751-1000克死亡率', '（出生体重751-1000克的新生儿患者住院死亡人数/同期出生体重751-1000克的新生儿患者出院人次）*100% ', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('10115', '新生儿患者出生体重1001-1800克死亡率', '（出生体重1001-1800克的新生儿患者住院死亡人数/同期出生体重1001-1800克的新生儿患者出院人次）*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('10116', '新生儿患者出生体重>=1801克死亡率', '（出生体重>=1801克的新生儿患者住院死亡人数/同期出生体重>=1801克的新生儿患者出院人次）*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11100', '住院患者出院31天内再住院率统计', '（出院31天再住院患者人次/同期出院患者总人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11101', '急性心肌梗死再住院率统计', '（急性心肌梗死患者出院31天内再住院人次/同期急性心肌梗死出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11102', '充血性心力衰竭再住院率统计', '（充血性心力衰竭患者出院31天内再住院人次/同期充血性心力衰竭出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11103', '脑出血和脑梗死再住院率统计', '脑出血和脑梗死患者出院31天内再住院人次/同期脑出血和脑梗死出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11104', '创伤性颅脑损伤再住院率统计', '（创伤性颅脑损伤患者出院31天内再住院人次/创伤性颅脑损伤出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11105', '消化道出血（无并发症）再住院率统计', '消化道出血（无并发症）患者出院31天内再住院人次/同期消化道出血（无并发症）出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11106', '累及身体多个部位的损伤再住院率统计', '（累及身体多个部位的损伤患者出院31天内再住院人次/同期累及身体多个部位的损伤出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11107', '细菌性肺炎（成人、无并发症）再住院率统计', '细菌性肺炎（成人、无并发症）患者出院31天内再住院人次/同期细菌性肺炎（成人、无并发症）出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11108', '慢性阻塞性肺疾病再住院率统计', '（慢性阻塞性肺疾病患者出院31天内再住院人次/同期慢性阻塞性肺疾病出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11109', '糖尿病伴短期与长期并发症再住院率统计', '（糖尿病伴短期与长期并发症患者出院31天内再住院人次/同期糖尿病伴短期与长期并发症出院人次（除死亡患者外））*100% ', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11110', '结节性甲状腺肿再住院率统计', '（结节性甲状腺肿患者出院31天内再住院人次/同期结节性甲状腺肿出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11111', '急性阑尾炎伴弥漫性腹膜炎及脓肿再住院率统计', '（急性阑尾炎伴弥漫性腹膜炎及脓肿出院31天内再住院人次/同期急性阑尾炎伴弥漫性腹膜炎及脓肿出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11112', '前列腺增生再住院率统计', '（前列腺增生出院31天内再住院人次/同期前列腺增生出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11113', '肾衰竭再住院率统计', '（肾衰竭出院31天内再住院人次/同期肾衰竭出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11114', '败血症（成人）再住院率统计', '（败血症（成人）出院31天内再住院人次/同期败血症（成人）出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11115', '高血压病（成人）再住院率统计', '（高血压病（成人）出院31天内再住院人次/同期高血压病（成人）出院人次（除死亡患者外））*100% ', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11116', '急性胰腺炎再住院率统计', '（急性胰腺炎出院31天内再住院人次/同期急性胰腺炎出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11117', '恶性肿瘤术后化疗再住院率统计', '（恶性肿瘤术后化疗出院31天内再住院人次/同期恶性肿瘤术后化疗出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('11118', '恶性肿瘤维持性化学治疗再住院率统计', '（恶性肿瘤维持性化学治疗出院31天内再住院人次/同期恶性肿瘤维持性化学治疗出院人次（除死亡患者外））*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('12100', '冠状动脉旁路移植术死亡率', '（年龄≥18岁的冠状动脉旁路移植术死亡人数/年龄≥18岁的冠状动脉旁路移植术例数）*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('12101', '经皮冠状动脉介入治疗死亡人率', '年龄≥18岁的经皮冠状动脉介入治疗死亡人数/年龄≥18岁的经皮冠状动脉介入治疗例数）*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('12102', '髋、膝关节置换术死亡率', '（年龄≥18岁的髋、膝关节置换术死亡人数/年龄≥18岁的髋、膝关节置换术例数）*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('12103', '颅、脑手术死亡率', '（年龄≥18岁的颅、脑手术死亡人数/年龄≥18岁的颅、脑手术例数）*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('12104', '剖宫产手术死亡率', '（年龄≥18岁的剖宫产手术死亡人数/年龄≥18岁的剖宫产手术例数）*100%', '1', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13001', '门诊人次数', '门诊人次数', '2', '3', 'jcyl', '1', '30', '2', '30', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13002', '急诊人次数', '急诊人次数', '2', '3', 'jcyl', '1', '30', '2', '30', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13003', '门急诊总人数', '门急诊总人数', '2', '3', 'jcyl', '1', '30', '2', '30', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1300301', '门急诊总人数(医保)', '门急诊总人数(医保)', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1300302', '门急诊总人数（自费）', '门急诊总人数（自费）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1300303', '门急诊总人数（初诊）', '门急诊总人数（初诊）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1300304', '门急诊总人数（复诊)', '门急诊总人数（复诊)', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1300305', '门急诊总人数（窗口预约）', '门急诊总人数（窗口预约）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1300306', '门急诊总人数（电话预约）', '门急诊总人数（电话预约）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1300307', '门急诊总人数（窗口挂号）', '门急诊总人数（窗口挂号）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1300308', '门急诊总人数（门诊收费）', '门急诊总人数（门诊收费）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1300309', '门急诊总人数（医生站）', '门急诊总人数（医生站）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1300310', '门急诊总人数（自助机挂号）', '门急诊总人数（自助机挂号）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13004', '出诊医生数', '出诊医生数', '2', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13101', '药物流产人数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13102', '负压吸宫人数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13103', '避孕套发放数量', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13104', '避孕药发放数量', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13105', '宫内节育器放置', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13106', '宫内节育器取出', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13201', '男性新生儿分娩数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13202', '女性新生儿分娩数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13203', '儿童建卡人数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13204', '新生儿疾病筛查人数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13205', '新生儿出生缺陷人数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13206', '婴幼儿死亡人数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13207', '儿童入园健康检查数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13208', '婴幼儿先天性心脏病', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13209', '儿童健康体检', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13210', '婴幼儿视力', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13211', '新生儿听力人数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13301', '男性婚前检查', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13302', '女性婚前检查', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13303', '孕前检查人次数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13304', '产妇筛查数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13305', '高危孕产妇人数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13306', '孕产妇死亡人数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13307', '两癌筛查-宫颈癌筛查', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13308', '两癌筛查-乳腺癌筛查', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13309', '母婴阻断-梅毒检测人数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13310', '母婴阻断-梅毒感染人数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13311', '母婴阻断-乙肝检测人数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13312', '母婴阻断-乙肝确定感染人次数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13313', '妇女病筛查', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13314', '产妇访视', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13315', '孕产妇体检初检', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13316', '孕产妇体检复检', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13317', '叶酸发放人次数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13318', '叶酸发放瓶数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13319', '孕妇建卡数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13320', '早孕建卡数', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('13321', '新生儿访视', null, '2', '1', 'fuyou', '0', '20', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('14001', '住院人次数', '住院人次数', '2', '3', 'jcyl', '1', '30', '2', '30', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1400101', '住院人次数(医保)', '住院人次数（医保）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1400102', '住院人次数(自费)', '住院人次数（自费）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('14002', '出院人次数', '出院人次数', '2', '3', 'jcyl', '1', '30', '2', '30', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1400201', '出院人次数（医保）', '出院人次数（医保）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1400202', '出院人次数（自费）', '出院人次数（自费）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('14003', '在院人次数', '在院人次数', '2', '3', 'jcyl', '1', '30', '2', '30', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('14004', '额定床位', '额定床位', '2', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('14005', '使用床位', '使用床位', '2', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('14006', '病床使用率', '病床使用率', '1', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('14007', '检查人次数', '检查人次数', '2', '3', 'jcyl', '1', '30', '2', '2', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1400701', '检查人次数(医保)', '检查人次数（医保）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1400702', '检查人次数(自费)', '检查人次数（自费）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('14008', '检验人次数', '检验人次数', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1400801', '检验人次数（医保）', '检验人次数（医保）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1400802', '检验人次数（自费）', '检验人次数（自费）', '2', '3', 'jcyl', '1', '30', '2', '30', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('15001', '合计总收入', '合计总收入', '2', '3', 'jcyl', '0', '30', '2', '50', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1500101', '合计总收入(医保)', '合计总收入', '2', '3', 'jcyl', '0', '30', '2', '50', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1500102', '合计总收入（自费）', '合计总收入', '2', '3', 'jcyl', '0', '30', '2', '50', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1500103', '合计总收入（初诊）', '合计总收入', '2', '3', 'jcyl', '0', '30', '2', '50', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1500104', '合计总收入（复诊）', '合计总收入', '2', '3', 'jcyl', '0', '30', '2', '50', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1500105', '合计总收入（窗口预约）', '合计总收入', '2', '3', 'jcyl', '0', '30', '2', '50', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1500106', '合计总收入（电话预约）', '合计总收入', '2', '3', 'jcyl', '0', '30', '2', '50', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1500107', '合计总收入（窗口挂号）', '合计总收入', '2', '3', 'jcyl', '0', '30', '2', '50', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1500108', '合计总收入（门诊收费）', '合计总收入', '2', '3', 'jcyl', '0', '30', '2', '50', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1500109', '合计总收入（医生站）', '合计总收入', '2', '3', 'jcyl', '0', '30', '2', '50', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('1500110', '合计总收入（自助机挂号）', '合计总收入', '2', '3', 'jcyl', '0', '30', '2', '50', '', '1', null, '', '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('15002', '医疗收入', '医疗收入', '2', '3', 'jcyl', '0', '30', '2', '50', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('15003', '药品收入', '药品收入', '2', '3', 'jcyl', '0', '30', '2', '50', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('15004', '其他收入', '其他收入', '2', '3', 'jcyl', '0', '30', '2', '50', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('15005', '医保', null, '2', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('15006', '自费', null, '2', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('16001', '处方数量', '处方数量', '2', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('16002', '处方总额', null, '2', '3', 'jcyl', '0', '30', '2', '30', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('16003', '最大处方金额', null, '3', '3', 'jcyl', '0', '30', '2', '30', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('16004', '最小处方金额', null, '4', '3', 'jcyl', '0', '30', '2', '30', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('16005', '平均处方金额', null, '1', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('16006', '门诊中医处方数占比', null, '1', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('16007', '门诊中药饮片占比', null, '1', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('16008', '门诊中医非药物治疗处方占比', null, '1', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('16009', '静脉输液率', null, '1', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('16010', '激素使用率', null, '1', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('16011', '抗菌药物使用率', null, '1', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('16012', '一联抗生素使用率', null, '1', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('16013', '二联抗生素使用率', null, '1', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('16014', '三联抗生素使用率', null, '1', '3', 'jcyl', '0', '30', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21000', '综合健康管理服务包签约率（免费）', '健康管理服务包签约数（免费）/应签约居民数', '1', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21001', '综合健康管理服务包签约率（收费）', '健康管理服务包签约数（收费）/应签约居民数', '1', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21002', '个性化服务签约率（收费）', '签约个性化服务数/签约总数', '1', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21003', '签约机构门诊就诊率', '签约居民中心就诊人次数/签约居民就诊总次数', '1', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21004', '签约医生门诊就诊率', '签约居民家庭医生就诊总数/签约居民中心就诊总次数', '1', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21005', '慢病签约人员管理数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21006', '慢病签约人员随访数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21007', '上门服务人次数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21008', '营养指导人次数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21009', '康复指导人次数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21010', '用药指导人次数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21011', '慢病长处方服务数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21012', '签约居民体检人数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21013', '心脑血管高危人群筛查人数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21014', '肿瘤高危人群筛查数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21015', '骨质疏松高危人群筛查数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21016', 'COPD高危人群筛查数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21017', '儿童哮喘筛查数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21018', '健康自理检测评估数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21019', 'CDSS心脑血管风险评估数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('21020', '个性化健康信息精准推送数', null, '2', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('22010', '预防接种疑似预防接种异常反应规范处置率', null, '1', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('22011', '预防接种接种建证率', null, '1', '3', 'gongwei', '0', '25', '2', '2', null, '1', null, null, '1', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('22013', '床位占用率（医院）', null, '1', '2', 'yiyuan', '0', '5', '5', '30', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('31001', '门急诊总人次（医院）', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '10', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('31002', '门急诊药品总费用(元)（医院）', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('31003', '门急诊使用药品数（医院）', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '3', '10', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('31004', '住院人次（医院）', null, '2', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '1', '10', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('31005', '住院药品总费用(元)（医院）', null, '2', '2', 'yiyuan', '0', '5', '2', '8', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('31006', '住院患者使用药品数（医院）', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '3', '10', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('31007', '急诊人次数（医院）', '', '2', '2', 'yiyuan', '1', '30', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('31008', '门诊人次数（医院）', '', '2', '2', 'yiyuan', '1', '30', '2', '8', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('31009', '支付方式-医保（医院）', '', '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('31010', '支付方式-自费（医院）', '', '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '3', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('31011', '药品收入（医院）', '', '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '5', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('31012', '其他收入（医院）', '', '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '5', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('31013', '医疗收入（医院）', '', '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '5', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('41001', '预约挂号数量（医院）', null, '2', '2', 'yiyuan', '1', '10', '2', '2', null, '1', null, null, '19', '10', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('41002', '总诊疗人次数（医院）', '', '2', '2', 'yiyuan', '1', '10', '2', '2', '', '1', null, '', '19', '10', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('41003', '检查人次数（医院）', '', '2', '2', 'yiyuan', '1', '10', '2', '2', '', '1', null, '', '19', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('41004', '检验人次数（医院）', '', '2', '2', 'yiyuan', '1', '10', '2', '2', '', '1', null, '', '19', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('41005', '医院平均住院日（医院）', '', '1', '2', 'yiyuan', '1', '10', '2', '2', '', '1', null, '', '19', '10', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('42001', '医院耗材费用（医院）', '', '1', '2', 'yiyuan', '0', '5', '2', '2', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('42002', '医院手术费用（医院）', '', '1', '2', 'yiyuan', '0', '5', '2', '2', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('42003', '门诊医保费用（医院）', '', '1', '2', 'yiyuan', '0', '5', '2', '2', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('42004', '基本药物分析（医院）', '', '1', '2', 'yiyuan', '0', '5', '2', '2', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('42005', '城镇职工付费', '', '2', '2', 'yiyuan', '0', '5', '2', '2', '', '1', null, '', '5', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('42006', '城镇居民付费', '', '2', '2', 'yiyuan', '0', '5', '2', '2', '', '1', null, '', '5', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('42007', '新农合付费', '', '2', '2', 'yiyuan', '0', '5', '2', '2', '', '1', null, '', '5', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('42008', '商业保险付费', '', '2', '2', 'yiyuan', '0', '5', '2', '2', '', '1', null, '', '5', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('42009', '全自费付费', '', '2', '2', 'yiyuan', '0', '5', '2', '2', '', '1', null, '', '5', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('42010', '其他付费', '', '2', '2', 'yiyuan', '0', '5', '2', '2', '', '1', null, '', '5', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('51003', '出院人次数（医院）', '', '2', '2', 'yiyuan', '0', '5', '2', '2', '', '1', null, '', '5', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('60001', '门诊医保费用', '统计时间段内，门诊/急诊/住院费用表中，门诊/急诊/住院/体检标识为 “门诊、急诊、体检”的费用记录中，（总费用-自付金额）所得到的医保金额的总和', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('60002', '门诊总费用', '统计时间段内，门诊/急诊/住院费用表中，门诊/急诊/住院/体检标识为 “门诊、急诊、体检”的费用记录中总费用的总和', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('60003', '住院医保费用', '统计时间段内，门诊/急诊/住院费用表中，门诊/急诊/住院/体检标识为 “住院”的费用记录中，（总费用-自付金额）所得到的医保金额的总和', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('60004', '住院总费用', '统计时间段内，门诊/急诊/住院费用表中，门诊/急诊/住院/体检标识为 “住院”的费用记录中总费用的总和', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('60005', '总收入', '总收入', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('60006', '医疗服务收入', '门诊/急诊/住院费用表中江苏医疗收费财务分类除去“药品，耗材，检查检验”的记录中总费用的总和', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('60007', '药品收入', '门诊/急诊/住院费用表中江苏医疗收费财务分类为“药品”的记录中总费用的总和', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('60009', '辅药收入', '门诊/急诊/住院费用表中江苏医疗收费财务分类为“药品”，并且药品编码在辅药编码目录中的记录中总费用的总和', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('60011', '门诊人次数', '', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('60014', '出院患者关联的药品总费用', '', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('60015', '出院患者关联的住院总费用', '', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('60016', '总床日数', '', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '5', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('70001', '门诊出院-门诊人次', '挂号表，退号标记为0', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('70002', '转诊人次', '', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '1', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('70003', '出院者手术数', '', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '1', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('70004', '三四级手术', '', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '1', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('70005', 'Ⅰ类切口手术-手术台数', '', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('70006', 'Ⅰ类切口手术-感染数', '', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '1', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('70007', '临床路径管理-入组数', '', '2', '2', 'yiyuan', '0', '5', '2', '30', '', '1', null, '', '1', '23', '0', '2017-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('90001', '诊察(门诊医保)', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('90002', '检查(门诊医保)', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('90003', '化验(门诊医保)', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('90004', '治疗(门诊医保)', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('90005', '手术(门诊医保)', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('90006', '材料(门诊医保)', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('90007', '西药(门诊医保)', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('90008', '中成药(门诊医保)', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('90009', '中草药(门诊医保)', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('90010', '服务(门诊医保)', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('90011', '其他(门诊医保)', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('90012', '药品(门诊医保)', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
INSERT INTO `data_event` VALUES ('90013', '个人负担(门诊医保)', null, '2', '2', 'yiyuan', '0', '5', '2', '2', null, '1', null, null, '1', '23', '0', '2018-01-01', null, '365', '1');
