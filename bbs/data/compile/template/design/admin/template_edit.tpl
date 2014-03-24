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
	
	
<!--添加模板-->

	<div class="nav">
		<div class="return"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=', rawurlencode($isapi),'&m=design&c=module'; ?>">返回上一级</a></div>
		<ul class="cc">
			<?php  if (!$isscript):?>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($moduleid),'&m=design&c=data'; ?>">显示数据</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($moduleid),'&m=design&c=data&a=push'; ?>">推送审核</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($moduleid),'&m=design&c=property&a=edit'; ?>">属性</a></li>
			<?php  endif; ?>
			<li  class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?moduleid=', rawurlencode($moduleid),'&m=design&c=template&a=edit'; ?>">模板</a></li>
		</ul>
	</div>
	<div class="h_a">功能说明</div>
	<div class="prompt_text">
		<ul>
			<li>模板设置：修改完成后需要<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=bbs&c=cache'; ?>">更新模版缓存</a></li>
		</ul>
	</div>
	<div class="h_a">样式设置</div>
	<form class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=template&a=doedit'; ?>" method="post">
	<div class="design_ct">
		<div class="cc">
<div class="pop_design_code">
	<?php  if($components):?>
	<div class="mb5">
		模块模版：
			<select id="J_comp_select" class="select_5" name="compid" data-url="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=template&a=getcomp'; ?>">
				<option value="">自定义</option>
				<?php  foreach ($components as $v):	?>
				<option value="<?php echo htmlspecialchars($v['comp_id'], ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($compid == $v['comp_id']), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($v['comp_name'], ENT_QUOTES, 'UTF-8');?></option>
				<?php  endforeach; ?>
			</select>
	</div>
	<?php  endif; ?>
	<textarea id="J_design_temp_tpl" name="tpl"><?php echo htmlspecialchars($tpl, ENT_QUOTES, 'UTF-8');?></textarea>
	<div>
		<span class="mr5"><input id="J_design_temp_name" type="text" name="tplname" class="input mr5" style="width:90px;" placeholder="模块模板名称"><button type="button" id="J_design_temp_sub" class="btn mr5 btn_submit" data-action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=design&c=template&a=dosave'; ?>">模板另存为</button></span>
		<span class="gray">此样式保存到模块模板中，可用于其他模块</span>
	</div>
</div>
<div class="pop_design_case">
	<table class="pop_design_tablelist">
		<?php  $i=0; foreach ($signkeys as $sign):
					$cls =  is_int($i/2) ? 'thbg' : '';
		?>
		<tr>
			<th class="<?php echo htmlspecialchars($cls, ENT_QUOTES, 'UTF-8');?>">
				<?php echo htmlspecialchars($sign[1], ENT_QUOTES, 'UTF-8');?>
				<div class="J_sign_items cp" style="color:#006699;"><?php echo htmlspecialchars($sign[0], ENT_QUOTES, 'UTF-8');?></div>
			</th>
		</tr>
		<?php  $i++; endforeach; ?>
	</table>
</div>
</div>
<script type="text/javascript">
$(function() {
	//ie不支持高亮功能
	if($.browser.msie) {
		//模块模版
        $('#J_comp_select').change(function(){
			var $this = $(this);

			Wind.Util.ajaxMaskShow(100000);
			$.post($this.data('url'), {
				compid : this.value,
				moduleid : $('#J_moduleid').val()
			}, function(data){
				Wind.Util.ajaxMaskRemove();
				if(data.state == 'success') {
					$('#J_design_temp_tpl').val(data.data);
				}else if(data.state == 'fail'){
					if(Wind.Util.resultTip) {
						Wind.Util.resultTip({
							error : true,
							follow : $this,
							msg : data.message,
							zindex : 100000
						});
					}else{
						//后台
						alert(data.message);
					}

				}
			}, 'json');
		});
	 return;
	}
	
	var textarea = $('#J_design_temp_tpl');
	if(!textarea.length) { return; }
	//改掉ID，因为这个模板所在的页面还会引用common.js，会造成两个代码高亮框
	textarea.attr('id','');
	var	codemirror_path = GV.JS_ROOT + 'windeditor/plugins/codemirror/codemirror/';
	Wind.css(codemirror_path + 'codemirror.css?v='+ GV.JS_VERSION, function(){
		//css要先加载，需要定位计算
		Wind.js(codemirror_path +'codemirror.js?v=' + GV.JS_VERSION,function() {
			if(!window.CodeMirror) {
				return;
			}

			var codeEditor = window.CodeMirror.fromTextArea(textarea[0], {
					mode: "text/html",
	                tabMode: "indent",
	                lineNumbers: true,
	                lineWrapping:true,
	                onChange:function(editor) {
	                	//同步textarea的值，CodeMirror绑定过submit同步，但这里没有用submit
	                	textarea.val(editor.getValue());
	                }
				}
			);
			var dom = codeEditor.getWrapperElement();
			var height = textarea.outerHeight();
	        dom.style.cssText = 'height:'+ height +'px;font-family:consolas,"Courier new",monospace;font-size:13px;';
	        codeEditor.getScrollerElement().style.cssText = 'height:'+ height +'px';
	        codeEditor.refresh();

	        //模块模版
	        $('#J_comp_select').change(function(){
				var $this = $(this);

				Wind.Util.ajaxMaskShow(100000);
				$.post($this.data('url'), {
					compid : this.value,
					moduleid : $('#J_moduleid').val()
				}, function(data){
					Wind.Util.ajaxMaskRemove();
					if(data.state == 'success') {
						$('textarea[name=tpl]').val(data.data);
						codeEditor.setValue(data.data);
					}else if(data.state == 'fail'){
						if(Wind.Util.resultTip) {
							Wind.Util.resultTip({
								error : true,
								follow : $this,
								msg : data.message,
								zindex : 100000
							});
						}else{
							//后台
							alert(data.message);
						}

					}
				}, 'json');
			});
		});
	});
	

});
</script>
	</div>
	<input type="hidden" id="J_moduleid" value="<?php echo htmlspecialchars($moduleid, ENT_QUOTES, 'UTF-8');?>">
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<button class="btn btn_submit J_ajax_submit_btn" type="submit" >提交</button>
			<input type="hidden"  name="moduleid" value="<?php echo htmlspecialchars($moduleid, ENT_QUOTES, 'UTF-8');?>">
		</div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>

	
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
Wind.Util.ajaxMaskShow = function(){};
Wind.Util.ajaxMaskRemove = function(){};
</script>
</body>
</html>