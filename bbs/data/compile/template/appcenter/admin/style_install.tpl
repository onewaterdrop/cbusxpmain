<!doctype html>
<html>
<head>
<meta charset="<?php echo htmlspecialchars(Wekit::app()->charset, ENT_QUOTES, 'UTF-8');?>">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title><?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','c','name'), ENT_QUOTES, 'UTF-8');?></title>
<link href="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','css'), ENT_QUOTES, 'UTF-8');?>/admin_style.css?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>" rel="stylesheet" />
<script>
//全局变量，是Global Variables不是Gay Video喔
var GV = {
	JS_ROOT : "<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','res'), ENT_QUOTES, 'UTF-8');?>/js/dev/",																									//js目录
	JS_VERSION : "<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>",																										//js版本号
	TOKEN : '<?php echo htmlspecialchars(Wind::getComponent('windToken')->saveToken('csrf_token'), ENT_QUOTES, 'UTF-8');?>',	//token ajax全局
	REGION_CONFIG : {},
	SCHOOL_CONFIG : {},
	URL : {
		LOGIN : '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','loginUrl'), ENT_QUOTES, 'UTF-8');?>',																													//后台登录地址
		IMAGE_RES: '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>',																										//图片目录
		REGION : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=webData&a=area'; ?>',					//地区
		SCHOOL : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=webData&a=school'; ?>'				//学校
	}
};
</script>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/wind.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/jquery.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>

</head>
<body>
<div class="wrap">
	<div class="nav">
        <ul class="cc">
			<?php  foreach($addons as $key => $value){ ?>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=', rawurlencode($key),'&m=appcenter&c=style'; ?>"><?php echo htmlspecialchars($value[0], ENT_QUOTES, 'UTF-8');?></a></li>
			<?php  } ?>
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=style&a=install'; ?>">本地安装</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=style&a=manage'; ?>">界面管理</a></li>
			<?php  if(Wekit::load('APPS:appcenter.service.srv.PwDebugApplication')->inDevMode1()){ ?>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=style&a=generate'; ?>">开发助手</a></li>
			<?php  } ?>
		</ul>
	</div>
	<div class="h_a">功能说明</div>
	<div class="prompt_text">
		<ul>
			<li>可选择上传风格安装包来安装</li>
			<li>也可选择未安装的模板列表来安装</li>
		</ul>
	</div>
	<div class="h_a">模板安装</div>
	<form id="uploadForm" method="post" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=app&a=doInstall'; ?>">
	<div class="table_full mb10">
			<table width="100%">
				<col class="th" />
				<tr>
					<th>选择文件</th>
					<td>
						<!--选择文件-->
						<div class="cc mb10">
							<div id="J_up_wrap" class="single_file_up">
								<a href="">上传文件</a>
								<input id="J_swfupload_btn" name="application" type="file">
							</div>
							<span id="J_up_tip" class="mr20" style="display:none;"></span>
							<span id="J_up_file" class="mr5" style="display:none;"></span>
							<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=app&a=delFile'; ?>" id="J_up_del" style="display:none;">[删除]</a>
							<!-- <span class="tips_loading">正在上传</span>
							<span class="tips_loading">正在验证</span>
							<span class="tips_error">错误提示</span>
							<span class="tips_success">安装成功</span> -->
						</div>
						<button type="submit" class="btn btn_submit J_ajax_submit_btn" style="visibility:hidden;">立即安装</button>
						<!--上传进度-->
						<div id="J_cc" style="display:none;">
							<div class="cc">
								<div class="install_schedule_bg fl mr10"><div id="J_install_schedule" class="install_schedule" style="width:0%;"><span></span></div></div><div id="J_percent" style="line-height:24px;">0%</div>
							</div>
							<div id="loadStep" class="install_load cc"></div>
						</div>
					</td>
				</tr>
			</table>
		<input type="hidden" name="file" id="J_file_input">
		</div>
<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	<div class="h_a">未安装模板</div>
	<?php if(empty($themes)) { ?>
	<div class="prompt_text">
	无
	</div>
	<?php  } else { ?>
	<form action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=style&a=doinstall'; ?>" method="post" >
	<div class="table_full mb10">
		<table width="100%">
			<col class="th" />
			<col width="300" />
			<thead>
				<tr>
					<th>安装选择</th>
					<td>风格名称</td>
					<td>操作</td>
				</tr>
			</thead>
<?php foreach ($themes as $k => $v){ 
  foreach($v as $theme){ ?>
			<tr>
				<th><input type="checkbox" name="themes[]" value="THEMES:<?php echo htmlspecialchars(str_replace('/','.',$addons[$k][1]).'.'.$theme, ENT_QUOTES, 'UTF-8');?>"></th>
				<td><span class="mr10 b"><?php echo htmlspecialchars($theme, ENT_QUOTES, 'UTF-8');?></span>(<?php echo htmlspecialchars($addons[$k][0], ENT_QUOTES, 'UTF-8');?>)</td>
				<td><a class="J_ajax_del" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=style&a=delFolder'; ?>&folder=<?php echo htmlspecialchars(str_replace('/','.',$addons[$k][1]).'.'.$theme, ENT_QUOTES, 'UTF-8');?>">[删除文件]</a></td>
			</tr>
	<?php  } 
  } ?>
		</table>
	</div>
	<button type="submit" class="btn btn_submit">安装</button>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	<?php  } ?>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/util_libs/swfupload/swfupload.js?v<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','c','version'), ENT_QUOTES, 'UTF-8');?>"></script>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/util_libs/swfupload/plugins/swfupload.cookies.js?v<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','c','version'), ENT_QUOTES, 'UTF-8');?>"></script>
<script>
/*
 * 1、state = 'success' && step = '' 成功！
 * 2、state = 'success' && step = 'num' 请求stepurl!
 * 3、state = 'fail' 失败！
 */
var conf = {
	stepUrl : '<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=app&a=doInstall'; ?>',
	
};
$(function(){


	var up_wrap = $('#J_up_wrap'),
			swfu,
			up_tip = $('#J_up_tip'),
			up_file = $('#J_up_file'),
			up_del = $('#J_up_del'),
			up_btn = $('button.J_ajax_submit_btn'),
			file_input = $('#J_file_input');
	

	swfu = new SWFUpload({
		//debug : true,
		upload_url : '<?php echo Wekit::app()->baseUrl,'/','admin.php?_json=1&m=appcenter&c=app&a=upload'; ?>', 
		flash_url : GV.JS_ROOT+ 'util_libs/swfupload/Flash/swfupload.swf', 
		post_params: {
			siteId : 1,
			csrf_token : GV.TOKEN
		},
		/*custom_settings : {
			progressTarget : "fsUploadProgress",
			cancelButtonId : "btnCancel"
		},*/
		file_types : "*.zip",
		file_upload_limit : 1,
		button_placeholder_id : "J_swfupload_btn", 
		button_width: "65",
		button_height: "29",
		button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
		button_text: '',
		file_queue_error_handler : function(file, errorCode, message) {
			try {
				switch (errorCode) {
					case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
						alert("文件太大了——文件名: " + file.name + ", 大小: " + file.size + ", Message: " + message);
						break;
					case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
						alert("请不要上传0字节的文件");
						$.error("Error Code: Zero byte file, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
						break;
					case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
						alert("错误的文件类型");
						break;
					case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
						alert('最多只能上传'+ this.settings.file_upload_limit +'个文件');
						break;
					default:
						$.error("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
						break;
				}
			} catch (ex) {
	       	 $.error(ex);
	   	 }
		},
		file_dialog_complete_handler : function (numFilesSelected, numFilesQueued) {
			//开始上传
			this.startUpload();
			//up_tip.html('<span class="tips_loading">正在上传</span>').show();
		},
    //file_size_limit : "20480",
		upload_start_handler : function (file) {
			//开始上传文件前触发的事件处理函数
			try {
				up_tip.html('<span class="tips_loading">正在上传并校验</span>');
			}
			catch (ex) {}
	
			return true;
		},
		upload_success_handler : function (file, serverData, r) {
			//文件上传成功后触发的事件处理函数
			try {
				var data = $.parseJSON(serverData),
						_data = data.data;

				if(data.state=== 'success') {
					file_input.val(_data.file);

					up_wrap.hide();

					up_tip.html('<span class="tips_success">上传成功</span>').show();
					up_file.text(file.name).show();
					up_del.show();	
					up_btn.css('visibility', 'visible');	//按钮可见
				}else if(data.state === 'fail'){
					up_tip.html('<span class="tips_error">'+ data.message +'</span>');
				}
			} catch (ex) {
				this.debug(ex);
			}
		},
		upload_complete_handler : function (file) {
			//完成
		}

	});

	//删除
	up_del.on('click', function(e){
		e.preventDefault();
		$.post(this.href, {
			file : file_input.val()
		}, function(data){
			if(data.state == 'success') {
				window.location.href=window.location.href;
			}else if(data.state == 'fail') {
				Wind.use('dialog', function(){
					Wind.dialog.alert(data.message);
				});
			}
		}, 'json');
		
	});

	//队列数减1
	function restLimit() {
		var stats = swfu.getStats();
		stats.successful_uploads--;
		swfu.setStats(stats);
	}
	
});
Wind.js(GV.JS_ROOT +"/pages/appcenter/admin/setUpApp.js?v="+ GV.JS_VERSION);
</script>
</body>
</html>