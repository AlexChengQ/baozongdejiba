var saveDicConfig = {
	dicDesc:[{rule:notBlank,msg:"描述 不能为空"},{rule:length,params:{min:0,max:200},msg:"描述 长度不在0-200范围"}],
	dicName:[{rule:notBlank,msg:"字典值 不能为空"},{rule:length,params:{min:0,max:100},msg:"字典值 长度不在0-100范围"}]
};
