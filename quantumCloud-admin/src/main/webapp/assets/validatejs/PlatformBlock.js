var savePlatformBlock = {
    blockName:[{rule:notBlank,msg:"版块名称 不能为空"},{rule:length,params:{min:0,max:200},msg:"版块名称 长度不在0-200范围"}],
    blockDesc:[{rule:notBlank,msg:"版块描述 不能为空"}]
};