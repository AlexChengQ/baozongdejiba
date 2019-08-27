var saveProgramAdd = {
		name:[{rule:notBlank,msg:"项目名称 不能为空"},{rule:length,params:{min:0,max:1000},msg:"项目名称 长度不在0-50范围"}],
		desc:[{rule:length,params:{min:0,max:1000},msg:"项目描述 长度不在0-500范围"}],
		qubitNum:[{rule:notBlank,msg:"量子比特数 不能为空"}],
		classicalbitNum:[{rule:notBlank,msg:"经典寄存器个数 不能为空"}]
};

var updateProgram = {
		desc:[{rule:length,params:{min:0,max:1000},msg:"项目描述 长度不在0-500范围"}]
};
