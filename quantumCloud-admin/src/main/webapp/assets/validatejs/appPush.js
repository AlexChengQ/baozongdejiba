var saveAppPushConfig = {
	title:[{rule:notBlank,msg:"标题 不能为空"},{rule:length,params:{min:0,max:200},msg:"标题 长度不在0-200范围"}],
	content:[{rule:notBlank,msg:"内容 不能为空"},{rule:length,params:{min:0,max:200},msg:"内容 长度不在0-200范围"}]
};
