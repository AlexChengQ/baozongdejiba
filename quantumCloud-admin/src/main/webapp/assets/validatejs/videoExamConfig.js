var saveVideoExamConfig = {
    subject:[{rule:notBlank,msg:"试题内容 不能为空"},{rule:length,params:{min:0,max:500},msg:"试题内容 长度不在0-500范围"}],
    answer:[{rule:notBlank,msg:"答案 不能为空"}],
    answerdetail:[{rule:notBlank,msg:"试题解析不能为空"}],
};
