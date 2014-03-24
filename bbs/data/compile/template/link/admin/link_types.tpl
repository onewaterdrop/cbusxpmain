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
	<li class="<?php echo htmlspecialchars($tabs['run'], ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=link&c=link'; ?>">链接列表</a></li>
	<li class="<?php echo htmlspecialchars($tabs['editTypes'], ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=link&c=link&a=types'; ?>">链接分类</a></li>
	<li class="<?php echo htmlspecialchars($tabs['check'], ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=link&c=link&a=check'; ?>">链接审核</a></li>
	</ul>
</div>
	

<!--==============================链接分类================================-->
	
	<form method="post" class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=link&c=link&a=doTypes'; ?>" data-role="list">
	<div class="table_list">
		<table width="100%" id="J_table_list">
			<colgroup>
				<col width="60">
				<col width="210">
				<col width="60">
				<col width="320">
			</colgroup>
			<thead>
				<tr>
					<td>顺序</td>
					<td>分类名称</td>
					<td>链接数</td>
					<td>调用代码</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody>
			<?php  if ($typesList) { 
  foreach ($typesList as $key => $value) { ?>
			<tr>
				<td><input type="hidden" name="data[<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>][typeid]" value="<?php echo htmlspecialchars($value['typeid'], ENT_QUOTES, 'UTF-8');?>"><input class="input length_0" type="text" name="data[<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>][vieworder]" value="<?php echo htmlspecialchars($value['vieworder'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><input class="input length_3" type="text" name="data[<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>][typename]" value="<?php echo htmlspecialchars($value['typename'], ENT_QUOTES, 'UTF-8');?>"></td>
				<td><?php echo htmlspecialchars($value['linknum'], ENT_QUOTES, 'UTF-8');?></td>
				<td><textarea readonly="true" class="textarea_code" id="J_clipboard_copy<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>"><?php  echo WindSecurity::escapeHTML("<component tpl='TPL:link.link' class='SRV:link.srv.PwLinkService' method='getLinksByType' args='{$value[typename]}'/>") ?></textarea></td>
				<td><a href="#" style="z-index:0;" class="mr10 J_copy_clipboard" data-rel="J_clipboard_copy<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>">[复制调用代码]</a><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?typeid=', rawurlencode($value['typeid']),'&m=link&c=link'; ?>" class="mr10">[查看]</a><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?typeId=', rawurlencode($value['typeid']),'&m=link&c=link&a=doDeleteType'; ?>" class="mr10 J_ajax_del">[删除]</a></td>
			</tr>
			<?php  } 
  } else { ?>
				<tr><td colspan="7" class="tac">啊哦，暂无内容！</td></tr>
			<?php  } ?>
			</tbody>
		</table>
		<div class="p10"><a href="#" class="link_add" id="J_add_root" data-html="tbody">添加分类</a></div>
	</div>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<button class="btn btn_submit mr10 J_ajax_submit_btn" type="submit">提交</button>
		</div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
var root_tr_html = '<tr>\
					<td><input class="input length_0" type="text" name="newdata[NEW_ID_][vieworder]" value=""></td>\
					<td><input class="input length_3" type="text" name="newdata[NEW_ID_][typename]" value=""></td>\
					<td>&nbsp;</td>\
					<td>&nbsp;</td>\
					<td><a href="" class="mr10 J_newRow_del">[删除]</a></td>\
				</tr>';
Wind.js(GV.JS_ROOT+ 'pages/admin/common/forumTree_table.js?v=' +GV.JS_VERSION);
</script>
</body>
</html>
