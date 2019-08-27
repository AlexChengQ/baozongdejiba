/**
     * 初始化裁剪工具。
     * @param divId 定义生成填充页面代码的div（函数产生的代码会填充到此div内）
     * @param imagePath 图片地址
     * @param ratio 宽长比例
     * @param callback  裁剪之后的回调
     */
var jcrop_api;
//加载标识
var imgloading = false;

var productComparisonEditor;
var productComparisonEnglishEditor;
var commentEditor;
var commentEnglishEditor;
var saveloading = false;
KindEditor.ready(function(K) {
    productComparisonEditor = K.create('textarea[name="context"]', {
        height : "600px",
        cssPath : base+'/assets/kindeditor/plugins/code/prettify.css',
        uploadJson: base+'/assets/kindeditor/jsp/upload_json.jsp',
        fileManagerJson : base+'/assets/kindeditor/jsp/file_manager_json.jsp',
        allowFileManager : true,
        afterFocus : function() {
            $("#errormsg-comment").remove();
        },
        afterCreate : function() {
            var self = this;
            K.ctrl(document, 13, function() {
                self.sync();
                document.forms['myFormId'].submit();
            });
            K.ctrl(self.edit.doc, 13, function() {
                self.sync();
                document.forms['myFormId'].submit();
            });
        },
        afterBlur:function(){
            this.sync();
        }
    });
    prettyPrint();
});



function cutPicMethod(){
if (!+[ 1, ]) {  
 	//是IE浏览器  
     createJCrop(1);  
 } else {  
         //单独判断IE10  
     if (document.documentMode == 10) {  
         createJCrop(1);  
     } else  
     //非IE浏览器  
     createJCrop(0);  
 }
};

function createJCrop(flag) {
    if (flag == 0) {
        //非IE下创建
        $('#target').Jcrop({
            allowSelect: false,
            onChange: showCoords,
            onSelect: showCoords,
            onRelease: clearCoords,
            allowResize: false, //不允许改变选中区域的大小
            setSelect: [0, 0, 300, 240] //初始化选中区域
        }, function () {
            jcrop_api = this;
        });
    } else {
        //IE下创建
        jcrop_api = $.Jcrop('#target', {
            allowSelect: false,
            onChange: showCoords,
            onSelect: showCoords,
            onRelease: clearCoords,
            allowResize: false, //不允许改变选中区域的大小
            setSelect: [0, 0, 300, 240] //初始化选中区域
        });

    }
}




