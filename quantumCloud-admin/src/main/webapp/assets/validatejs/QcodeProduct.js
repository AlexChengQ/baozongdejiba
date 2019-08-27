var saveQcodeProductConfig = {
	title:[{rule:notBlank,msg:"标题 不能为空"},{rule:length,params:{min:0,max:50},msg:"标题 长度不在0-50范围"}],
	titleEnglish:[{rule:notBlank,msg:"英文标题 不能为空"},{rule:length,params:{min:0,max:200},msg:"英文标题 长度不在0-200范围"}],
	brief:[{rule:notBlank,msg:"简介 不能为空"},{rule:length,params:{min:0,max:50},msg:"简介 长度不在0-50范围"}],
	briefEnglish:[{rule:notBlank,msg:"英文简介 不能为空"},{rule:length,params:{min:0,max:200},msg:"英文简介 长度不在0-200范围"}],
	comment:[{rule:notBlank,msg:"产品详情 不能为空"},{rule:length,params:{min:0,max:5000},msg:"产品详情 长度不在0-5000范围"}],
	commentEnglish:[{rule:notBlank,msg:"英文产品详情 不能为空"},{rule:length,params:{min:0,max:5000},msg:"英文产品详情 长度不在0-5000范围"}],	
	isShow:[{rule:integer,msg:"是否展示(0:不展示,1:展示) 必须是数字"}],
};
