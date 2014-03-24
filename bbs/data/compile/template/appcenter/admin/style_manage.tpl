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
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=style&a=install'; ?>">本地安装</a></li>
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=style&a=manage'; ?>">界面管理</a></li>
			<?php  if(Wekit::load('APPS:appcenter.service.srv.PwDebugApplication')->inDevMode1()){ ?>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=style&a=generate'; ?>">开发助手</a></li>
			<?php  } ?>
		</ul>
	</div>
	<form class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?_json=1&m=appcenter&c=style&a=doManage'; ?>" method="post" enctype="multipart/form-data">
	<div class="h_a">全局</div>
	<div class="table_full">
		<table width="100%">
			<colgroup>
				<col class="th">
				<col width="400">
			</colgroup>
			<tr>
				<th>站点logo</th>
				<td>
					<div class="mb5"><input name="logo" class="J_upload_preview" type="file" data-preview="#J_logo_preview"></div>
					<?php  if($logo){ ?>
					<img id="J_logo_preview" src="<?php echo htmlspecialchars(Pw::getPath($logo), ENT_QUOTES, 'UTF-8');?>" align="top" class="mr10">
					<a class="J_ajax_del" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=logo&path=', rawurlencode($logo),'&m=appcenter&c=style&a=delete'; ?>">[删除]</a>
					<input type="hidden" name="oldlogo" value="<?php echo htmlspecialchars($logo, ENT_QUOTES, 'UTF-8');?>">
					<?php  }else{ ?>
					<img id="J_logo_preview" style="display:none">
					<?php  } ?>
				</td>
				<td><div class="fun_tips">请自行备份之前的logo，以免被替换无法找回<br>默认模板下建议图片高度为50以内</div></td>
			</tr>
			<tr>
				<th>全站背景图片</th>
				<td>
				<div class="mb5"><input name="bg" class="J_upload_preview" type="file" data-preview="#J_bg_preview"></div>
					<?php  if($bg){ ?>
					<img id="J_bg_preview" src="<?php echo htmlspecialchars(Pw::getPath($bg), ENT_QUOTES, 'UTF-8');?>" align="top" class="mr10">
					<a class="J_ajax_del" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=bg&path=', rawurlencode($bg),'&m=appcenter&c=style&a=delete'; ?>">[删除]</a>
					<input type="hidden" name="oldbg" value="<?php echo htmlspecialchars($bg, ENT_QUOTES, 'UTF-8');?>">
					<?php  }else{ ?>
					<img id="J_bg_preview" style="display:none">
					<?php  } ?>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>全站背景颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em style="<?php  if ($bgcolor) { ?>background:<?php echo htmlspecialchars($bgcolor, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="bgcolor" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($bgcolor, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>全站背景展示方式</th>
				<td>
					<ul class="single_list cc">
						<li><label><input name="bgtile" type="radio" value="no-repeat" <?php echo htmlspecialchars(Pw::ifcheck($bgtile == "no-repeat"), ENT_QUOTES, 'UTF-8');?>><span>正常</span></label></li>
						<li><label><input name="bgtile" type="radio" value="fixed" <?php echo htmlspecialchars(Pw::ifcheck($bgtile == "fixed"), ENT_QUOTES, 'UTF-8');?>><span>锁定</span></label></li>
						<li><label><input name="bgtile" type="radio" value="repeat-x" <?php echo htmlspecialchars(Pw::ifcheck($bgtile == "repeat-x"), ENT_QUOTES, 'UTF-8');?>><span>横向平铺</span></label></li>
						<li><label><input name="bgtile" type="radio" value="repeat-y" <?php echo htmlspecialchars(Pw::ifcheck($bgtile == "repeat-y"), ENT_QUOTES, 'UTF-8');?>><span>竖向平铺</span></label></li>
						<li><label><input name="bgtile" type="radio" value="repeat" <?php echo htmlspecialchars(Pw::ifcheck($bgtile == "repeat"), ENT_QUOTES, 'UTF-8');?>><span>完全平铺</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>全局背景展示位置</th>
				<td>
					<ul class="single_list cc">
						<li><label><input name="bgalign" type="radio" value="center" <?php echo htmlspecialchars(Pw::ifcheck($bgalign == "center"), ENT_QUOTES, 'UTF-8');?>><span>居中</span></label></li>
						<li><label><input name="bgalign" type="radio" value="left" <?php echo htmlspecialchars(Pw::ifcheck($bgalign == "left"), ENT_QUOTES, 'UTF-8');?>><span>居左</span></label></li>
						<li><label><input name="bgalign" type="radio" value="right" <?php echo htmlspecialchars(Pw::ifcheck($bgalign == "right"), ENT_QUOTES, 'UTF-8');?>><span>居右</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>全站文本大小</th>
				<td>
					<ul class="single_list cc">
						<li><label><input name="size" type="radio" value="" <?php echo htmlspecialchars(Pw::ifcheck($size == ""), ENT_QUOTES, 'UTF-8');?>><span>默认</span></label></li>
						<li><label><input name="size" type="radio" value="12px" <?php echo htmlspecialchars(Pw::ifcheck($size == "12px"), ENT_QUOTES, 'UTF-8');?>><span>12像素</span></label></li>
						<li><label><input name="size" type="radio" value="14px" <?php echo htmlspecialchars(Pw::ifcheck($size == "14px"), ENT_QUOTES, 'UTF-8');?>><span>14像素</span></label></li>
						<li><label><input name="size" type="radio" value="16px" <?php echo htmlspecialchars(Pw::ifcheck($size == "16px"), ENT_QUOTES, 'UTF-8');?>><span>16像素</span></label></li>
						<li><label><input name="size" type="radio" value="18px" <?php echo htmlspecialchars(Pw::ifcheck($size == "18px"), ENT_QUOTES, 'UTF-8');?>><span>18像素</span></label></li>
					</ul>
				</td>
				<td>
					<div class="fun_tips">
						<p>默认为不为指定，根据模板自身的样式来展示</p>
						<p style="font-size:12px;">12像素的字体效果</p>
						<p style="font-size:14px;">14像素的字体效果</p>
						<p style="font-size:16px;">16像素的字体效果</p>
						<p style="font-size:18px">18像素的字体效果</p>
					</div>
				</td>
			</tr>
			<tr>
				<th>全站字体选择</th>
				<td>
					<ul class="single_list cc">
						<li><label><input name="font" type="radio" value="" <?php echo htmlspecialchars(Pw::ifcheck($font == ""), ENT_QUOTES, 'UTF-8');?>><span>默认</span></label></li>
						<li><label><input name="font" type="radio" value="Simsun" <?php echo htmlspecialchars(Pw::ifcheck($font == "Simsun"), ENT_QUOTES, 'UTF-8');?>><span>宋体</span></label></li>
						<li><label><input name="font" type="radio" value="'Microsoft Yahei'" <?php echo htmlspecialchars(Pw::ifcheck($font == "'Microsoft Yahei'"), ENT_QUOTES, 'UTF-8');?>><span>微软雅黑</span></label></li>
					</ul>
				</td>
				<td>
					<div class="fun_tips">
						<p>默认为不为指定，根据模板自身的样式来展示</p>
						<p style="font-family:Simsun;">宋体的展示效果</p>
						<p style="font-family:'Microsoft Yahei';">微软雅黑的展示效果</p>
					</div>
				</td>
			</tr>
			<tr>
				<th>全站链接颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em style="<?php  if ($corelink) { ?>background:<?php echo htmlspecialchars($corelink, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="corelink" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($corelink, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td>
					<div class="fun_tips">
					</div>
				</td>
			</tr>
			<tr>
				<th>全站文本颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em style="<?php  if ($coretext) { ?>background:<?php echo htmlspecialchars($coretext, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="coretext" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($coretext, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td>
					<div class="fun_tips">
					</div>
				</td>
			</tr>
			<tr>
				<th>帖子列表标题字体大小</th>
				<td>
					<ul class="single_list cc">
						<li><label><input name="subjectsize" type="radio" value="" <?php echo htmlspecialchars(Pw::ifcheck($subjectsize == ""), ENT_QUOTES, 'UTF-8');?>><span>默认</span></label></li>
						<li><label><input name="subjectsize" type="radio" value="12px" <?php echo htmlspecialchars(Pw::ifcheck($subjectsize == "12px"), ENT_QUOTES, 'UTF-8');?>><span>12像素</span></label></li>
						<li><label><input name="subjectsize" type="radio" value="14px" <?php echo htmlspecialchars(Pw::ifcheck($subjectsize == "14px"), ENT_QUOTES, 'UTF-8');?>><span>14像素</span></label></li>
						<li><label><input name="subjectsize" type="radio" value="16px" <?php echo htmlspecialchars(Pw::ifcheck($subjectsize == "16px"), ENT_QUOTES, 'UTF-8');?>><span>16像素</span></label></li>
						<li><label><input name="subjectsize" type="radio" value="18px" <?php echo htmlspecialchars(Pw::ifcheck($subjectsize == "18px"), ENT_QUOTES, 'UTF-8');?>><span>18像素</span></label></li>
					</ul>
				</td>
				<td>
					<div class="fun_tips">
						<p>默认为不为指定，根据模板自身的样式来展示</p>
						<p style="font-size:12px;">12像素的字体效果</p>
						<p style="font-size:14px;">14像素的字体效果</p>
						<p style="font-size:16px;">16像素的字体效果</p>
						<p style="font-size:18px">18像素的字体效果</p>
					</div>
				</td>
			</tr>
			<tr>
				<th>帖子内容页正文大小</th>
				<td>
					<ul class="single_list cc">
						<li><label><input name="contentsize" type="radio" value="" <?php echo htmlspecialchars(Pw::ifcheck($contentsize == ""), ENT_QUOTES, 'UTF-8');?>><span>默认</span></label></li>
						<li><label><input name="contentsize" type="radio" value="12px" <?php echo htmlspecialchars(Pw::ifcheck($contentsize == "12px"), ENT_QUOTES, 'UTF-8');?>><span>12像素</span></label></li>
						<li><label><input name="contentsize" type="radio" value="14px" <?php echo htmlspecialchars(Pw::ifcheck($contentsize == "14px"), ENT_QUOTES, 'UTF-8');?>><span>14像素</span></label></li>
						<li><label><input name="contentsize" type="radio" value="16px" <?php echo htmlspecialchars(Pw::ifcheck($contentsize == "16px"), ENT_QUOTES, 'UTF-8');?>><span>16像素</span></label></li>
						<li><label><input name="contentsize" type="radio" value="18px" <?php echo htmlspecialchars(Pw::ifcheck($contentsize == "18px"), ENT_QUOTES, 'UTF-8');?>><span>18像素</span></label></li>
					</ul>
				</td>
				<td>
					<div class="fun_tips">
						<p>默认为不为指定，根据模板自身的样式来展示</p>
						<p style="font-size:12px;">12像素的字体效果</p>
						<p style="font-size:14px;">14像素的字体效果</p>
						<p style="font-size:16px;">16像素的字体效果</p>
						<p style="font-size:18px">18像素的字体效果</p>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div class="h_a">头部导航</div>
	<div class="table_full">
		<table width="100%">
			<colgroup>
				<col class="th">
				<col width="400">
			</colgroup>
			<tr>
				<th>背景图片</th>
				<td>
				<div class="mb5"><input name="headbg" class="J_upload_preview" type="file" data-preview="#J_headbg_preview"></div>
					<?php  if($headbg){ ?>
					<img id="J_headbg_preview" src="<?php echo htmlspecialchars(Pw::getPath($headbg), ENT_QUOTES, 'UTF-8');?>" align="top" class="mr10">
					<a class="J_ajax_del" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=headbg&path=', rawurlencode($headbg),'&m=appcenter&c=style&a=delete'; ?>">[删除]</a>
					<input type="hidden" name="oldheadbg" value="<?php echo htmlspecialchars($headbg, ENT_QUOTES, 'UTF-8');?>">
					<?php  }else{ ?>
					<img id="J_headbg_preview" style="display:none">
					<?php  } ?>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>背景颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em style="<?php  if ($headbgcolor) { ?>background:<?php echo htmlspecialchars($headbgcolor, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="headbgcolor" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($headbgcolor, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>背景展示方式</th>
				<td>
					<ul class="single_list cc">
						<li><label><input name="headbgtile" type="radio" value="no-repeat" <?php echo htmlspecialchars(Pw::ifcheck($headbgtile == "no-repeat"), ENT_QUOTES, 'UTF-8');?>><span>正常</span></label></li>
						<li><label><input name="headbgtile" type="radio" value="fixed" <?php echo htmlspecialchars(Pw::ifcheck($headbgtile == "fixed"), ENT_QUOTES, 'UTF-8');?>><span>锁定</span></label></li>
						<li><label><input name="headbgtile" type="radio" value="repeat-x" <?php echo htmlspecialchars(Pw::ifcheck($headbgtile == "repeat-x"), ENT_QUOTES, 'UTF-8');?>><span>横向平铺</span></label></li>
						<li><label><input name="headbgtile" type="radio" value="repeat-y" <?php echo htmlspecialchars(Pw::ifcheck($headbgtile == "repeat-y"), ENT_QUOTES, 'UTF-8');?>><span>竖向平铺</span></label></li>
						<li><label><input name="headbgtile" type="radio" value="repeat" <?php echo htmlspecialchars(Pw::ifcheck($headbgtile == "repeat"), ENT_QUOTES, 'UTF-8');?>><span>完全平铺</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>背景展示位置</th>
				<td>
					<ul class="single_list cc">
						<li><label><input name="headbgalign" type="radio" value="center" <?php echo htmlspecialchars(Pw::ifcheck($headbgalign == "center"), ENT_QUOTES, 'UTF-8');?>><span>居中</span></label></li>
						<li><label><input name="headbgalign" type="radio" value="left" <?php echo htmlspecialchars(Pw::ifcheck($headbgalign == "left"), ENT_QUOTES, 'UTF-8');?>><span>居左</span></label></li>
						<li><label><input name="headbgalign" type="radio" value="right" <?php echo htmlspecialchars(Pw::ifcheck($headbgalign == "right"), ENT_QUOTES, 'UTF-8');?>><span>居右</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>导航链接颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em style="<?php  if ($headlink) { ?>background:<?php echo htmlspecialchars($headlink, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="headlink" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($headlink, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td>
					<div class="fun_tips">
					</div>
				</td>
			</tr>
			<tr>
				<th>激活状态背景颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em style="<?php  if ($headactivelink) { ?>background:<?php echo htmlspecialchars($headactivelink, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="headactivelink" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($headactivelink, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td>
					<div class="fun_tips">
					</div>
				</td>
			</tr>
			<tr>
				<th>激活状态链接颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em style="<?php  if ($headactivecolor) { ?>background:<?php echo htmlspecialchars($headactivecolor, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="headactivecolor" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($headactivecolor, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td>
					<div class="fun_tips">
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div class="h_a">全局通用模块</div>
	<div class="table_full">
		<table width="100%">
			<colgroup>
				<col class="th">
				<col width="400">
			</colgroup>
			<tr>
				<th>模块背景图片</th>
				<td>
				<div class="mb5"><input name="boxbg" class="J_upload_preview" type="file" data-preview="#J_boxbg_preview"></div>
					<?php  if($boxbg){ ?>
					<img id="J_boxbg_preview" src="<?php echo htmlspecialchars(Pw::getPath($boxbg), ENT_QUOTES, 'UTF-8');?>" align="top" class="mr10">
					<a class="J_ajax_del" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=boxbg&path=', rawurlencode($boxbg),'&m=appcenter&c=style&a=delete'; ?>">[删除]</a>
					<input type="hidden" name="oldboxbg" value="<?php echo htmlspecialchars($boxbg, ENT_QUOTES, 'UTF-8');?>">
					<?php  }else{ ?>
					<img id="J_boxbg_preview" style="display:none">
					<?php  } ?>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>模块背景颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em style="<?php  if ($boxbgcolor) { ?>background:<?php echo htmlspecialchars($boxbgcolor, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="boxbgcolor" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($boxbgcolor, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>模块背景展示方式</th>
				<td>
					<ul class="single_list cc">
						<li><label><input name="boxbgtile" type="radio" value="no-repeat" <?php echo htmlspecialchars(Pw::ifcheck($boxbgtile == "no-repeat"), ENT_QUOTES, 'UTF-8');?>><span>正常</span></label></li>
						<li><label><input name="boxbgtile" type="radio" value="fixed" <?php echo htmlspecialchars(Pw::ifcheck($boxbgtile == "fixed"), ENT_QUOTES, 'UTF-8');?>><span>锁定</span></label></li>
						<li><label><input name="boxbgtile" type="radio" value="repeat-x" <?php echo htmlspecialchars(Pw::ifcheck($boxbgtile == "repeat-x"), ENT_QUOTES, 'UTF-8');?>><span>横向平铺</span></label></li>
						<li><label><input name="boxbgtile" type="radio" value="repeat-y" <?php echo htmlspecialchars(Pw::ifcheck($boxbgtile == "repeat-y"), ENT_QUOTES, 'UTF-8');?>><span>竖向平铺</span></label></li>
						<li><label><input name="boxbgtile" type="radio" value="repeat" <?php echo htmlspecialchars(Pw::ifcheck($boxbgtile == "repeat"), ENT_QUOTES, 'UTF-8');?>><span>完全平铺</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>模块背景展示位置</th>
				<td>
					<ul class="single_list cc">
						<li><label><input name="boxbgalign" type="radio" value="center" <?php echo htmlspecialchars(Pw::ifcheck($boxbgalign == "center"), ENT_QUOTES, 'UTF-8');?>><span>居中</span></label></li>
						<li><label><input name="boxbgalign" type="radio" value="left" <?php echo htmlspecialchars(Pw::ifcheck($boxbgalign == "left"), ENT_QUOTES, 'UTF-8');?>><span>居左</span></label></li>
						<li><label><input name="boxbgalign" type="radio" value="right" <?php echo htmlspecialchars(Pw::ifcheck($boxbgalign == "right"), ENT_QUOTES, 'UTF-8');?>><span>居右</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>模块边框颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em style="<?php  if ($boxborder) { ?>background:<?php echo htmlspecialchars($boxborder, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="boxborder" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($boxborder, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td>
					<div class="fun_tips">
					</div>
				</td>
			</tr>
			<tr>
				<th>模块链接颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em style="<?php  if ($boxlink) { ?>background:<?php echo htmlspecialchars($boxlink, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="boxlink" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($boxlink, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td>
					<div class="fun_tips">
					</div>
				</td>
			</tr>
			<tr>
				<th>模块文本颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em style="<?php  if ($boxtext) { ?>background:<?php echo htmlspecialchars($boxtext, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="boxtext" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($boxtext, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td>
					<div class="fun_tips">
					</div>
				</td>
			</tr>
			<tr>
				<th>标题栏背景图片</th>
				<td>
				<div class="mb5"><input name="boxhdbg" class="J_upload_preview" type="file" data-preview="#J_boxhdbg_preview"></div>
					<?php  if($boxhdbg){ ?>
					<img id="J_boxhdbg_preview" src="<?php echo htmlspecialchars(Pw::getPath($boxhdbg), ENT_QUOTES, 'UTF-8');?>" align="top" class="mr10">
					<a class="J_ajax_del" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?type=boxhdbg&path=', rawurlencode($boxhdbg),'&m=appcenter&c=style&a=delete'; ?>">[删除]</a>
					<input type="hidden" name="oldboxhdbg" value="<?php echo htmlspecialchars($boxhdbg, ENT_QUOTES, 'UTF-8');?>">
					<?php  }else{ ?>
					<img id="J_boxhdbg_preview" style="display:none">
					<?php  } ?>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>标题栏背景颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em style="<?php  if ($boxhdbgcolor) { ?>background:<?php echo htmlspecialchars($boxhdbgcolor, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="boxhdbgcolor" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($boxhdbgcolor, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>标题栏背景展示方式</th>
				<td>
					<ul class="single_list cc">
						<li><label><input name="boxhdbgtile" type="radio" value="no-repeat" <?php echo htmlspecialchars(Pw::ifcheck($boxhdbgtile == "no-repeat"), ENT_QUOTES, 'UTF-8');?>><span>正常</span></label></li>
						<li><label><input name="boxhdbgtile" type="radio" value="fixed" <?php echo htmlspecialchars(Pw::ifcheck($boxhdbgtile == "fixed"), ENT_QUOTES, 'UTF-8');?>><span>锁定</span></label></li>
						<li><label><input name="boxhdbgtile" type="radio" value="repeat-x" <?php echo htmlspecialchars(Pw::ifcheck($boxhdbgtile == "repeat-x"), ENT_QUOTES, 'UTF-8');?>><span>横向平铺</span></label></li>
						<li><label><input name="boxhdbgtile" type="radio" value="repeat-y" <?php echo htmlspecialchars(Pw::ifcheck($boxhdbgtile == "repeat-y"), ENT_QUOTES, 'UTF-8');?>><span>竖向平铺</span></label></li>
						<li><label><input name="boxhdbgtile" type="radio" value="repeat" <?php echo htmlspecialchars(Pw::ifcheck($boxhdbgtile == "repeat"), ENT_QUOTES, 'UTF-8');?>><span>完全平铺</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>标题栏背景展示位置</th>
				<td>
					<ul class="single_list cc">
						<li><label><input name="boxhdbgalign" type="radio" value="center" <?php echo htmlspecialchars(Pw::ifcheck($boxhdbgalign == "center"), ENT_QUOTES, 'UTF-8');?>><span>居中</span></label></li>
						<li><label><input name="boxhdbgalign" type="radio" value="left" <?php echo htmlspecialchars(Pw::ifcheck($boxhdbgalign == "left"), ENT_QUOTES, 'UTF-8');?>><span>居左</span></label></li>
						<li><label><input name="boxhdbgalign" type="radio" value="right" <?php echo htmlspecialchars(Pw::ifcheck($boxhdbgalign == "right"), ENT_QUOTES, 'UTF-8');?>><span>居右</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>标题栏边框颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em style="<?php  if ($boxhdborder) { ?>background:<?php echo htmlspecialchars($boxhdborder, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="boxhdborder" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($boxhdborder, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td>
					<div class="fun_tips">
					</div>
				</td>
			</tr>
			<tr>
				<th>标题栏链接颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em style="<?php  if ($boxhdlink) { ?>background:<?php echo htmlspecialchars($boxhdlink, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="boxhdlink" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($boxhdlink, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td>
					<div class="fun_tips">
					</div>
				</td>
			</tr>
			<tr>
				<th>标题栏文本颜色</th>
				<td>
					<span class="J_color_pick color_pick"><em class="J_bg" style="<?php  if ($boxhdtext) { ?>background:<?php echo htmlspecialchars($boxhdtext, ENT_QUOTES, 'UTF-8');?>;<?php  } ?>"></em></span>
					<input name="boxhdtext" type="hidden" class="J_hidden_color bgcolor" value="<?php echo htmlspecialchars($boxhdtext, ENT_QUOTES, 'UTF-8');?>">
				</td>
				<td>
					<div class="fun_tips">
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<button class="J_ajax_submit_btn btn btn_submit" type="submit">提交</button>
		</div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</div>
</body>
</html>