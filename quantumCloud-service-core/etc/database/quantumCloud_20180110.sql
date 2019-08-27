#用户申请
CREATE TABLE `qcode_user_application` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `email` varchar(50) DEFAULT NULL COMMENT 'emil',
  `org_name` varchar(50) DEFAULT NULL COMMENT '机构',
  `level` int(1) DEFAULT NULL COMMENT '用户等级（1：一级用户,2：二级用户，3：三级用户）',
  `base` varchar(50) DEFAULT NULL COMMENT '具有基础',
  `target` varchar(500) DEFAULT NULL COMMENT '目标',
  `user_id` bigint(20) DEFAULT NULL COMMENT '申请人id',
  `status` int(1) DEFAULT NULL COMMENT '申请状态（0：已拒绝，1：已通过，2：未审核）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `auditor_id` bigint(20) DEFAULT NULL COMMENT '审核人id',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `refuse_reason` varchar(500) DEFAULT NULL COMMENT '拒绝理由',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='用户申请';

#留言表
CREATE TABLE `qcode_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `title` varchar(255) DEFAULT NULL COMMENT '主题',
  `content` varchar(500) DEFAULT NULL COMMENT '内容',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='留言表';

#2018/1/30 houdongdong
ALTER TABLE `qcode_red_packet`
MODIFY COLUMN `moneny`  double(10,2) NULL DEFAULT NULL COMMENT '金额' AFTER `reason`;
#2018/1/30 houdongdong
alter table qcode_red_packet character set = utf8mb4;
ALTER TABLE `qcode_red_packet`
MODIFY COLUMN `weChat_name`  varchar(20) CHARACTER SET utf8mb4 NULL DEFAULT NULL COMMENT '微信名称' AFTER `open_id`;
CREATE TABLE `qcode_red_packet_chance` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `amount` double(10,2) DEFAULT NULL COMMENT '数值',
  `chance_num` int(255) DEFAULT NULL COMMENT '概率区间数值',
  `available` int(1) DEFAULT NULL COMMENT '可获得的(0:不可用，1：可用)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=314095 DEFAULT CHARSET=utf8 COMMENT='红包概率区间表';
#2018/2/1 houdongdong
CREATE TABLE `qcode_we_chat_event_request` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `unique_identification` varchar(50) NOT NULL COMMENT '请求唯一标识',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_identification` (`unique_identification`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COMMENT='微信事件请求表';
ALTER TABLE `qcode_red_packet_chance`
MODIFY COLUMN `amount`  varchar(50) NULL DEFAULT NULL COMMENT '数值' AFTER `id`;
#2018/2/27 houdongdong
CREATE TABLE `qcode_third_login` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '会员id',
  `app_type` int(1) DEFAULT NULL COMMENT '第三方登录类型(如1:qq、2：微信、3：微博)',
  `app_id` varchar(200) DEFAULT NULL COMMENT '第三方唯一id',
  `access_token` varchar(200) DEFAULT NULL,
  `face` varchar(255) DEFAULT NULL COMMENT '第三方头像',
  `nickname` varchar(255) DEFAULT NULL COMMENT '第三方的昵称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='第三方登录';
#2018/2/28 houdongdong
ALTER TABLE `qcode_user`
MODIFY COLUMN `token`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'TOKEN' AFTER `api_key`;
#2018/3/01 houdongdong
ALTER TABLE `qcode_user`
MODIFY COLUMN `name`  varchar(20) CHARACTER SET utf8mb4 NULL DEFAULT NULL COMMENT '姓名' AFTER `id`;
ALTER TABLE `qcode_user`
MODIFY COLUMN `name`  varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名' AFTER `id`;
ALTER TABLE `qcode_red_packet`
MODIFY COLUMN `user_name`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '量子云用户名称' AFTER `user_id`;
#2018/3/5 houdongdong
ALTER TABLE `qcode_third_login`
MODIFY COLUMN `nickname`  varchar(255) CHARACTER SET utf8mb4 NULL DEFAULT NULL COMMENT '第三方的昵称' AFTER `face`;


