var saveQcodeMessageConfig = {
	userId:[{rule:integer,msg:"创建人id 必须是数字"}],
	title:[{rule:length,params:{min:0,max:255},msg:"主题 长度不在0-255范围"}],
	content:[{rule:length,params:{min:0,max:500},msg:"内容 长度不在0-500范围"}],
	createTime:[{rule:date,msg:"创建时间 必须是日期"}]
};
