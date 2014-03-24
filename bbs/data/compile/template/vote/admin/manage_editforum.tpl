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
<body style="width:450px" class="body_none">
	<form class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=vote&c=manage&a=doeditforum'; ?>" method="post">
			<div class="pop_cont">
				<div class="cc shift">
					<div class="fl">
						<h4>选择版块</h4>
						<div class="select_div" id="J_forum_list">
							<?php  foreach($cateList as $cate){ 
  if ($forumList[$cate['fid']]) { 
								$cate['name'] = strip_tags($cate['name']);
							?>
							<dl>
								<dt><?php echo htmlspecialchars($cate['name'], ENT_QUOTES, 'UTF-8');?></dt>
								<dd>
									<?php  foreach ($forumList[$cate['fid']] as $forum) {
									$forum['name'] = strip_tags($forum['name']);
									 ?>
									<p><a href="#" class="J_forums" data-fid="<?php echo htmlspecialchars($forum['fid'], ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($forum['name'], ENT_QUOTES, 'UTF-8');?></a></p>
									<?php  } ?>
								</dd>
							</dl>
							<?php  }} ?>
						</div>
					</div>
					<div class="fl shift_operate">
						<p class="mb10"><a id="J_forum_add" href="" class="btn ">添加 &gt;&gt;</a></p><!-- btn_success与dialog.js冲突 -->
						<p><a id="J_forum_del" href="#" class="btn">&lt;&lt; 移除</a></p>
					</div>
					<div class="fl">
						<h4>已选择</h4>
						<div class="select_div">
							<dl class="current">
								<dd id="J_forum_selected">
						<?php  foreach($cateList as $cate) { 
  if ($forumList[$cate['fid']]) { 
  foreach ($forumList[$cate['fid']] as $forum) { 
  if (in_array($forum['fid'], array_keys($pollOpenForum))) {
									$forum['name'] = strip_tags($forum['name']);
									 ?>
									<p><a href="#" data-fid="<?php echo htmlspecialchars($forum['fid'], ENT_QUOTES, 'UTF-8');?>" id="J_forum_<?php echo htmlspecialchars($forum['fid'], ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($forum['name'], ENT_QUOTES, 'UTF-8');?></a></p>
									<?php  } 
  } 
  } 
  } ?>
								</dd>
							</dl>
						</div>
					</div>
				</div>
			</div>
	<?php  $forumids = $pollOpenForum ? implode(',', $pollOpenForum) : ''; ?>
			<div class="pop_bottom"><input type="hidden" id="J_fids" name="fid" value="<?php echo htmlspecialchars($forumids, ENT_QUOTES, 'UTF-8');?>"/><button class="btn btn_submit J_ajax_submit_btn fr" type="submit">提交</button></div>
		<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
$(function(){
	var forum_selected = $('#J_forum_selected');
	$('#J_forum_list dt').on('click', function(){
		$(this).parent().toggleClass('current').siblings().removeClass('current');
	});
	
	//点击状态
	$('#J_forum_list, #J_forum_selected').on('click', 'a', function(e){
		e.preventDefault();
		$(this).toggleClass('current');
		if(!$('#J_forum_'+ $(this).data('fid')).length) {
			//未添加
			//forum_selected.append('<p><a href="" id="J_forum_'+ $(this).data('fid') +'">'+ $(this).text() +'</a></p>');
		}
	});
	
	//添加
	$('#J_forum_add').on('click', function(e){
		e.preventDefault();
		var arr = [];
		$('#J_forum_list a.J_forums.current').each(function(i, o){
			if(!$('#J_forum_'+ $(this).data('fid')).length) {
				//未添加
				forum_selected.append('<p><a href="" data-fid="'+ $(this).data('fid') +'" id="J_forum_'+ $(this).data('fid') +'">'+ $(this).text() +'</a></p>');
			}
		});
		getArr();
	});
	
	//移除
	$('#J_forum_del').on('click', function(e){
		e.preventDefault();
		$('#J_forum_selected a.current').parent().remove();
		
		getArr();
	});
	
	function getArr(){
		var arr = [];
		$('#J_forum_selected a').each(function(i, o){
			arr.push($(this).data('fid'));
		});
		
		$('#J_fids').val(arr.join(','));
	}
	
});
</script>
</body>
</html>