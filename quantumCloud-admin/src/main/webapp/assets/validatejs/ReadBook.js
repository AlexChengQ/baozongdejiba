var saveReadBook = {
	title:[{rule:notBlank,msg:"标题 不能为空"},{rule:length,params:{min:0,max:200},msg:"标题 长度不在0-200范围"}],
    context:[{rule:notBlank,msg:"内容 不能为空"}],
    author:[{rule:notBlank,msg:"作者不能为空"}],
    videoFile:[{rule:notBlank,msg:"视频不能为空"}],
};
