var messages = 
{
	visitor_no_right:'游客无操作权限.',
	option_fail:'操作失败',
	option_success:'操作成功',
	
	//page_main
	tutorial_cannot_modified:'教程案例不可修改',
	
	//page_forget
	enter_email_true:'请输入正确邮箱地址',
	send_message_login_mail:'验证邮件已发送至邮箱，请登录邮箱操作',
	
	//page_modify
	password_six_to_eight:'密码和确认密码为8~16位字母和数字组合',
	password_six:'密码至少6位',
	confirm_password_six:'确认密码至少6位',
	password_not_same:'密码不一致',
	pwd_update_success:'密码修改成功，请重新登录',
	
	//page_register
	name_not_null:'姓名不能为空',
	org_not_null:'机构不能为空',
	register_success_login:'注册成功,请登陆',
	register_fail:'注册失败',
	
	//page_community
	title_not_null:'主题不能为空',
	community_not_null:'留言不能为空',
	volidate_code_not_null:'验证码不能为空',
	community_is_submit:'留言已提交',
	server_is_busy:'服务器繁忙，请稍候重试',

    //page_apply
    phone_not_null:'电话不能为空',
    phone_is_proper:'电话格式不正确',
    email_not_null:'邮箱不能为空',
    email_is_proper:'邮箱格式不正确',
    vmType_not_null:'请选择使⽤何种虚拟机',
    purpose_not_null:'使用目的不能为空',
    apply_is_submit:'申请已提交',
    checkbox_is:'请您阅读并同意用户申请条款',


	//page_qcode_index
	celiangzhi:'测量值',
	gailv:'概率',
	zhixingshijian:'执行时间',
	chongfushiyancishu:'重复试验次数',
	end_time:'结束时间',
	in_queue:'队列中',
	no_task:'没有任务',
	task_fail:'任务失败',
	wanchengjindu:'完成进度',
	code_error:'存在语法错误',
	new_version:'项目已创建新版本',
	project_name_not_null:'项目名称不能为空',
	liangzishu_not_null:'量子比特数不能为空',
	biteshu_not_null:'经典比特数不能为空',
	create_success:'项目创建成功',
	repert_not_null:'重复次数不能为空',
	project_edit_success:'项目编辑成功',
	delete_version:'确定要删除版本吗？',
	delete_task:'确定要删除任务吗？',
	terminate_task:'确定要终止任务吗？',
	save_success:'保存成功',
	first_click_icon:'先点击图标，或者先点击格点都能插入一个量子逻辑门。',
	same_pro_diff_result:'相同的项目，多次测量也可能得到不同的结果。',
	real_liangzi:'真实量子芯片即将上线，敬请期待！',
	number_of_classical_registers:'经典寄存器个数',
	must_be_operated:'您还没有操作',
    Confirm_tab_tip0:'确定要切换到"图形设计"模式吗?代码中的注释会消失',
    Confirm_tab_tip1:'确定要切换到"量子语言"模式吗?设计中的图标排列可能会发生变化',

	//page_project
	delete_engineering:'确定要删除项目吗？',
	
	//js_qcode.js
	expression_32:'表达式长度不能超过32',
	expression_is_not_legal:'表达式不合法',
	settings_successful:'参数设置成功',
	point_already_exists:'操作点位指令已经存在，先双击删除指令后再添加',
	icons_not_allowed:'当前位置不允许放置图标',
	second_points_must_be_set:'第二个点位必须在设置',
	second_points_must_be_on_vertical_line:'第二个点位必须在一条垂直线上',
	already_exists_on_vertical_line:'垂直线上已经存在操作命令',
	third_points_must_be_on_vertical_line:'第三个点位必须在一条垂直线上',
	must_be_included_measurement:'必须包含测量操作',
	select_another_operation_point:'当前操作命令不完整，请选择另一个操作点位',
	select_second_operation_point:'当前操作命令不完整，请选择第2个操作点位',
	commandtip_0:'这个操作选择的量子比特之间会发生交换并附带一个i相位。随着操作时间的不同，可以选择iSWAP（一个操作时间长）或者√iSWAP一般的操作时长）',
	commandtip_1:'将Qubit的测量结果保存到经典寄存器上，请输入经典比特序号',
	commandtip_2:'请输入一个数学表达式，可以包括pi，不包含括号，运算符包括"+-*/^."(弧度制)',
	measure_is_end:'测量门应为结束比特门',
	measure_is_only:'每个量子比特线条上仅允许存在一个测量门',
	measure_not_more_qubit:'测量门后不能存在跨越当前比特线条的多比特门',
	
	//js_app.js
	app_js_desc:'半导体量子芯片，目前只提供演示算法的功能，不可改变量子线路。',
	number_of_qubits:'量子比特数',
	number_of_qubits_1_30:'量子比特数<br/><span>(1-32,20以上需要二级用户或以上权限)</span>',
	number_of_classical_registers_1_255:'经典寄存器个数<br/> <span>(1-255,用于保存测量值)</span>',
	
	//code2Trans.js
	version_information:'版本信息为空或版本信息不正确',
	compile_error:'格式错误，行',
	analog_type:'模拟',
	measure_is_end_in_line:'测量门应为结束比特门，行',
	measure_is_only_in_line:'每个量子比特线条上仅允许存在一个测量门，行',
	measure_not_more_qubit_in_line:'多比特门节点前不能存在测量门，行',
		
	task_status_syntactic_error:'语法错误'	,
	beyond_the_number_of_qubits:'超出量子比特数范围，行'	,
	bit_gate_already_existed:'该坐标已存在比特门，行',
	contain_repeating_coordinates:'含有重复坐标，行'	,
	unauthorized_operation:'无权操作',
	
	//page_user_application
	base_not_null:'基础不能为空',
	target_not_null:'目标不能为空',
	application_is_submit:'申请已提交',
	user_application_is_submit:'个人信息修改成功',
	init_waiting:'初始化中，请稍后'
};
