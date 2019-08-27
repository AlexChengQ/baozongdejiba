var saveQcodeNewsConfig = {
	title:[{rule:notBlank,msg:"标题 不能为空"},{rule:length,params:{min:0,max:255},msg:"标题 长度不在0-255范围"}],
	titleEnglish:[{rule:notBlank,msg:"英文标题 不能为空"},{rule:length,params:{min:0,max:1000},msg:"英文标题 长度不在0-1000范围"}],
	category:[{rule:notBlank,msg:"新闻类别 不能为空"}],
	picture:[{rule:notBlank,msg:"首页展示图 不能为空"},{rule:length,params:{min:0,max:255},msg:"首页展示图 长度不在0-255范围"}],
	isShow:[{rule:notBlank,msg:"是否展示 不能为空"},{rule:integer,msg:"是否展示(0:不展示,1:展示) 必须是数字"}],
	comment:[{rule:notBlank,msg:"文章内容 不能为空"},{rule:length,params:{min:0,max:25500},msg:"文章内容 长度不在0-25500范围"}],
	commentEnglish:[{rule:notBlank,msg:"英文内容 不能为空"},{rule:length,params:{min:0,max:25500},msg:"英文内容 长度不在0-25500范围"}],
	publishTime:[{rule:notBlank,msg:"发布时间 不能为空"},{rule:date,msg:"发布时间 必须是日期"}]
};



