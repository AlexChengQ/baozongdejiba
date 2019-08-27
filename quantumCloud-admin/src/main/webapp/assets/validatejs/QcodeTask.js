var saveQcodeTaskConfig = {
	versionId:[{rule:integer,msg:"项目版本id 必须是数字"}],
	taskId:[{rule:length,params:{min:0,max:20},msg:"任务编号 长度不在0-20范围"}],
	classicRegisterName:[{rule:length,params:{min:0,max:20},msg:"经典寄存器名 长度不在0-20范围"}],
	startTime:[{rule:date,msg:"执行时间 必须是日期"}],
	endTime:[{rule:date,msg:"结束时间 必须是日期"}],
	repeat:[{rule:integer,msg:"重复次数 必须是数字"}],
	meaarr:[{rule:length,params:{min:0,max:100},msg:"测量比特数组 长度不在0-100范围"}],
	status:[{rule:integer,msg:"状态(1:等待,2:处理中,3:完成,4:语法错误,5:已终止) 必须是数字"}],
	ans:[{rule:length,params:{min:0,max:2147483647},msg:"应答 长度不在0-2147483647范围"}],
	isDel:[{rule:integer,msg:"是否删除(0:否,1:是) 必须是数字"}]
};
