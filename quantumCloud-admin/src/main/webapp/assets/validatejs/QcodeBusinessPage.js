var saveQcodeBusinessPageConfig = {
	title:[{rule:length,params:{min:0,max:50},msg:"标题 长度不在0-50范围"}],
	titleEnglish:[{rule:length,params:{min:0,max:200},msg:"英文标题 长度不在0-200范围"}],
	businessId:[{rule:length,params:{min:0,max:200},msg:"导航页面id 长度不在0-200范围"}],
	showType:[{rule:length,params:{min:0,max:50},msg:"展示类型 长度不在0-50范围"}],
	isShow:[{rule:integer,msg:"是否展示(0:不展示,1:展示) 必须是数字"}],
	order:[{rule:integer,msg:"排序 必须是数字"}],
	operationTime:[{rule:date,msg:"操作时间 必须是日期"}]
};
