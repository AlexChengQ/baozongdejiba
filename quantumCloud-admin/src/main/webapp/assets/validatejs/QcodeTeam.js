var saveQcodeTeamConfig = {
	nameZh:[{rule:length,params:{min:0,max:45},msg:"中文名 长度不在0-45范围"}],
	nameEn:[{rule:length,params:{min:0,max:45},msg:"英文名 长度不在0-45范围"}],
	positionName:[{rule:notBlank,msg:"职位 不能为空"},{rule:length,params:{min:0,max:45},msg:"职位 长度不在0-45范围"}],
	positionNameEnglish:[{rule:notBlank,msg:"职位(英文) 不能为空"},{rule:length,params:{min:0,max:200},msg:"职位(英文) 长度不在0-200范围"}],
	expertBackground:[{rule:notBlank,msg:"专家背景 不能为空"},{rule:length,params:{min:0,max:5000},msg:"专家背景 长度不在0-5000范围"}],
	expertBackgroundEnglish:[{rule:notBlank,msg:"专家背景(英文) 不能为空"},{rule:length,params:{min:0,max:5000},msg:"专家背景(英文) 长度不在0-5000范围"}],
	isShow:[{rule:notBlank,msg:"是否展示(0:不展示,1:展示) 不能为空"},{rule:integer,msg:"是否展示(0:不展示,1:展示) 必须是数字"}],
	sort:[{rule:notBlank,msg:"排序 不能为空"},{rule:length,params:{min:0,max:20},msg:"排序 长度不在0-20范围"}],
    picture:[{rule:length,params:{min:0,max:255},msg:"首页展示图 长度不在0-255范围"}]
};
