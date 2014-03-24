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
		<div class="return"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=announce&c=announce'; ?>">返回上一级</a></div>
	</div>
<!--==============================添加公告================================-->
	<form id="J_announce_form" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=announce&c=announce&a=doAdd'; ?>" method="post">
	<div class="h_a">添加公告</div>
	<div class="table_full">
		<table width="100%">
			<colgroup>
				<col class="th">
				<col width="400">
			</colgroup>
			<tr>
				<th>显示顺序</th>
				<td><input name="vieworder" type="text" class="input length_6"></td>
				<td></td>
			</tr>
			<tr>
				<th>有效时间</th>
				<td><span class="must_red">*</span><input name="start_date" type="text" class="input length_2 J_date mr20"><span class="mr20">至</span><input name="end_date" type="text" class="input length_2 J_date"></td>
				<td></td>
			</tr>
			<tr class="J_radio_change">
				<th>公告类别</th>
				<td>
					<ul class="single_list cc">
						<li><label><input name="typeid" type="radio" value="0" checked="checked" data-arr="J_announce_content">文字公告</label></li>
						<li><label><input name="typeid" type="radio" value="1" data-arr="J_announce_link">链接公告</label></li>
					</ul>
				</td>
				<td></td>
			</tr>
			<tr>
				<th>公告标题</th>
				<td><span class="must_red">*</span><input name="subject" type="text" class="input length_6" placeholder="公告标题"></td>
				<td></td>
			</tr>
			<tbody id="J_announce_content" class="J_radio_tbody">
				<tr>
					<th>公告内容</th>
					<td colspan="2"><span class="must_red">*</span><textarea id="J_textarea" name="content" style="width:600px;height:400px;"></textarea></td>
				</tr>
			</tbody>
			<tbody id="J_announce_link" class="J_radio_tbody">
				<tr>
					<th>公告链接</th>
					<td><span class="must_red">*</span><input name="url" type="text" class="input length_6" placeholder="公告指向的链接地址"></td>
					<td></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<button class="btn btn_submit" id="J_announce_sub" type="submit">提交</button>
		</div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	</div>
	<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
Wind.js(GV.JS_ROOT + '/pages/announce/admin/announceSub.js?v=' + GV.JS_VERSION);
</script>
</body>
</html>
