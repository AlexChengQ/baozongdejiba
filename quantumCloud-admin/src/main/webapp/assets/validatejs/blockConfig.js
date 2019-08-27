var saveBlockConfig = {
	name:[{rule:notBlank,msg:"版块名称 不能为空"},{rule:length,params:{min:0,max:200},msg:"版块名称 长度不在0-200范围"}],
	cataLog:[{rule:notBlank,msg:"所属类型 不能为空"},{rule:length,params:{min:0,max:200},msg:"所属类型 长度不在0-200范围"}]
};
