var saveSysBannerConfig = {
	bannerName:[{rule:notBlank,msg:"导航名称 不能为空"},{rule:length,params:{min:0,max:20},msg:"导航名称 长度不在0-20范围"}],
	bannerNameEnglish:[{rule:notBlank,msg:"英文导航名称 不能为空"},{rule:length,params:{min:0,max:200},msg:"英文导航名称 长度不在0-200范围"}],
	bannerUrl:[{rule:notBlank,msg:"链接地址 不能为空或以'#'代替"},{rule:length,params:{min:0,max:200},msg:"链接地址 长度不在0-200范围"}],
	bannerIndex:[{rule:integer,msg:"排序 必须是数字"}]
};
