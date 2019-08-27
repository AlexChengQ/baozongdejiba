var saveQcodeArticleConfig = {
	title:[{rule:notBlank,msg:"文章标题 不能为空"},{rule:length,params:{min:0,max:50},msg:"文章标题 长度不在0-50范围"}],
	titleEnglish:[{rule:notBlank,msg:"文章标题(英文) 不能为空"},{rule:length,params:{min:0,max:200},msg:"文章标题(英文) 长度不在0-200范围"}],
	comment:[{rule:notBlank,msg:"文章内容 不能为空"},{rule:length,params:{min:0,max:100000},msg:"文章内容 长度不在0-100000范围"}],
	commentEnglish:[{rule:notBlank,msg:"文章内容(英文) 不能为空"},{rule:length,params:{min:0,max:100000},msg:"文章内容(英文) 长度不在0-100000范围"}],
	type:[{rule:notBlank,msg:"文章类型 不能为空"},{rule:integer,msg:"文章类型 必须是数字"}]
};
