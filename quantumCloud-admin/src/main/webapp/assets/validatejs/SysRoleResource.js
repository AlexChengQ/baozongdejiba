var saveSysRoleResourceConfig = {
	roleId:[{rule:notBlank,msg:"角色ID 不能为空"},{rule:integer,msg:"角色ID 必须是数字"}],
	resource:[{rule:notBlank,msg:"资源名 不能为空"},{rule:length,params:{min:0,max:255},msg:"资源名 长度不在0-255范围"}]
};
