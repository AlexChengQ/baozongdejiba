var saveSysRoleConfig = {
	roleName:[{rule:notBlank,msg:"角色名称 不能为空"},{rule:length,params:{min:1,max:20},msg:"角色名称 长度不在1-20范围"}],
	descn:[{rule:length,params:{min:0,max:255},msg:"描述 长度不在0-255范围"},{rule:"roleRule"}],
};
