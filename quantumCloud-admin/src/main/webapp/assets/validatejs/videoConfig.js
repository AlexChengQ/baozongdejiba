var saveVideoConfig = {
	title:[{rule:notBlank,msg:"视频标题 不能为空"},{rule:length,params:{min:0,max:200},msg:"视频标题 长度不在0-200范围"}],
    file:[{rule:notBlank,msg:"视频图片 不能为空"}],
    video360pFile:[{rule:notBlank,msg:"视频不能为空"}],
    videoFile:[{rule:notBlank,msg:"视频不能为空"}],
};
