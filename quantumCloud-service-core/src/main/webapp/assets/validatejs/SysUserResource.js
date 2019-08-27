var saveSysUserResourceConfig = {
	userId:[{rule:notBlank,msg:"用户ID 不能为空"},{rule:integer,msg:"用户ID 必须是数字"}],
	resource:[{rule:notBlank,msg:"资源名 不能为空"},{rule:length,params:{min:0,max:150},msg:"资源名 长度不在0-150范围"}]
};
