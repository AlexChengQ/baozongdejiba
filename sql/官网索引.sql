ALTER TABLE `qcode_article`
ADD INDEX `IX_qcodeArticle_id` (`id`) USING BTREE ;

ALTER TABLE `qcode_news`
ADD INDEX `IX_qcodeNews_newsid` (`news_id`) USING BTREE ,
ADD INDEX `IX_qcodeNews_articleId` (`article_id`) USING BTREE ;

ALTER TABLE `qcode_product`
ADD INDEX `IX_qcodeProduct_id` (`id`) USING BTREE ;


ALTER TABLE `qcode_recruit`
ADD INDEX `IX_qcodeRecruit_id` (`id`) USING BTREE ;

ALTER TABLE `qcode_team`
ADD INDEX `IX_qcodeTeam_id` (`id`) USING BTREE ;

ALTER TABLE `sys_banner`
ADD INDEX `IX_sysBanner_id` (`id`) USING BTREE ,
ADD INDEX `IX_sysBanner_parentId` (`parent_id`) USING BTREE ;