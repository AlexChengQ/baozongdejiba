var saveQcodeUserApplicationConfig = {
	name:[{rule:length,params:{min:0,max:20},msg:"姓名 长度不在0-20范围"}],
	email:[{rule:notBlank,msg:"emil 不能为空"},{rule:length,params:{min:0,max:50},msg:"emil 长度不在0-50范围"}],
	orgName:[{rule:length,params:{min:0,max:50},msg:"机构 长度不在0-50范围"}],
	level:[{rule:integer,msg:"用户等级(1:一级用户,2:二级用户,3:三级用户) 必须是数字"}],
	base:[{rule:length,params:{min:0,max:50},msg:"具有基础 长度不在0-50范围"}],
	target:[{rule:length,params:{min:0,max:255},msg:"目标 长度不在0-255范围"}],
	userId:[{rule:integer,msg:"申请人id 必须是数字"}],
	status:[{rule:integer,msg:"申请状态(0:已拒绝,1:已通过,2:未审核) 必须是数字"}],
	createtime:[{rule:date,msg:"创建时间 必须是日期"}]
};
