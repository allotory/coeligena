INSERT INTO `business` (`id`, `job_name`) VALUES
(1, '销售'),
(2, '市场/市场拓展/公关'),
(3, '商务/采购/贸易'),
(4, '计算机软、硬件/互联网/IT'),
(5, '电子/半导体/仪表仪器'),
(6, '通信技术'),
(7, '客户服务/技术支持'),
(8, '行政/后勤'),
(9, '人力资源'),
(10, '高级管理'),
(11, '生产/加工/制造'),
(12, '质控/安检'),
(13, '工程机械'),
(14, '技工'),
(15, '财会/审计/统计'),
(16, '金融/银行/保险/证券/投资'),
(17, '建筑/房地产/装修/物业'),
(18, '交通/仓储/物流'),
(19, '普通劳动力/家政服务'),
(20, '零售业'),
(21, '教育/培训'),
(22, '咨询/顾问'),
(23, '学术/科研'),
(24, '法律'),
(25, '美术/设计/创意'),
(26, '编辑/文案/传媒/影视/新闻'),
(27, '酒店/餐饮/旅游/娱乐'),
(28, '化工'),
(29, '能源/矿产/地质勘查'),
(30, '医疗/护理/保健/美容'),
(31, '生物/制药/医疗器械'),
(32, '翻译（口译与笔译）'),
(33, '公务员'),
(34, '环境科学/环保'),
(35, '农/林/牧/渔业'),
(36, '兼职/临时/培训生/储备干部'),
(37, '在校学生'),
(38, '其他');

INSERT INTO `roles` (`id`, `rolename`, `role_content`, `pid`, `status`, `create_time`, `update_time`, `remark`) VALUES
(0, 'Administrators', '超级管理员', 0, '', null, null, ''),
(0, 'foregroundAdministrators', '前台管理员', 0,  '', null, null, ''),
(0, 'UnauthenticatedUser', '未验证用户', 0, '', null, null, ''),
(0, 'RegularUser', '普通用户', 1, '', null, null, ''),
(0, 'CorporateUser', '企业会员', 1, '', null, null, ''),
(0, 'PremiumUser', '高级会员', 1, '', null, null, ''),
(0, 'CoreUser', '核心会员', 1, '', null, null, ''),
(0, 'UnregisteredUser', '未注册用户', 0, '', null, null, '');