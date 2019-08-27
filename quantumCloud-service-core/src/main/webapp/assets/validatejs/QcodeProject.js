var saveQcodeProjectConfig = {
	name:[{rule:length,params:{min:0,max:50},msg:"项目名称 长度不在0-50范围"}],
	userId:[{rule:notBlank,msg:"创建人id 不能为空"},{rule:integer,msg:"创建人id 必须是数字"}],
	createTime:[{rule:date,msg:"创建时间 必须是日期"}],
	qubitNum:[{rule:integer,msg:"量子比特数 必须是数字"}],
	classicalbitNum:[{rule:integer,msg:"经典比特数 必须是数字"}],
	repeat:[{rule:integer,msg:"重复次数 必须是数字"}],
	pic:[{rule:length,params:{min:0,max:100},msg:"图片 长度不在0-100范围"}],
	desc:[{rule:length,params:{min:0,max:65535},msg:"项目描述 长度不在0-65535范围"}],
	taskTypeId:[{rule:integer,msg:"任务类型id(1:量子仿真,2:超导量子芯片,3:半导体量子芯片) 必须是数字"}],
	isDel:[{rule:integer,msg:"是否删除(0:否,1:是) 必须是数字"}],
	nameEnglish:[{rule:length,params:{min:0,max:500},msg:"英文名称 长度不在0-500范围"}],
	descEnglish:[{rule:length,params:{min:0,max:500},msg:"英文描述 长度不在0-500范围"}],
	analogType:[{rule:integer,msg:"模拟类型(0:Monte-Carlo,1:概率方法) 必须是数字"}]
};
