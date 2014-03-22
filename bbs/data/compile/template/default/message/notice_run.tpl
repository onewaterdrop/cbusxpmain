<!doctype html>
<html>
<head>
<meta charset="<?php echo htmlspecialchars(Wekit::app()->charset, ENT_QUOTES, 'UTF-8');?>" />
<title><?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','seo','title'), ENT_QUOTES, 'UTF-8');?> - Powered by phpwind</title>
<meta http-equiv="X-UA-Compatible" content="chrome=1">
<meta name="generator" content="phpwind v<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','version'), ENT_QUOTES, 'UTF-8');?>" />
<meta name="description" content="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','seo','description'), ENT_QUOTES, 'UTF-8');?>" />
<meta name="keywords" content="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','seo','keywords'), ENT_QUOTES, 'UTF-8');?>" />
<link rel="stylesheet" href="<?php echo Wekit::app()->themes.'/site/'.Wekit::C('site', 'theme.site.default').'/css'.Wekit::getGlobal('theme','debug'); ?>/core.css?v=<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>" />
<link rel="stylesheet" href="<?php echo Wekit::app()->themes.'/site/'.Wekit::C('site', 'theme.site.default').'/css'.Wekit::getGlobal('theme','debug'); ?>/style.css?v=<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>" />
<!-- <base id="headbase" href="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','base'), ENT_QUOTES, 'UTF-8');?>/" /> -->
<?php echo Wekit::C('site', 'css.tag');?>
<script>
//全局变量 Global Variables
var GV = {
	JS_ROOT : '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','res'), ENT_QUOTES, 'UTF-8');?>/js/dev/',										//js目录
	JS_VERSION : '<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>',											//js版本号(不能带空格)
	JS_EXTRES : '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','extres'), ENT_QUOTES, 'UTF-8');?>',
	TOKEN : '<?php echo htmlspecialchars(Wind::getComponent('windToken')->saveToken('csrf_token'), ENT_QUOTES, 'UTF-8');?>',	//token $.ajaxSetup data
	U_CENTER : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=space'; ?>',		//用户空间(参数 : uid)
<?php 
$loginUser = Wekit::getLoginUser();
if ($loginUser->isExists()) {
?>
	//登录后
	U_NAME : '<?php echo htmlspecialchars($loginUser->username, ENT_QUOTES, 'UTF-8');?>',										//登录用户名
	U_AVATAR : '<?php echo htmlspecialchars(Pw::getAvatar($loginUser->uid), ENT_QUOTES, 'UTF-8');?>',							//登录用户头像
<?php 
}
?>
	U_AVATAR_DEF : '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>/face/face_small.jpg',					//默认小头像
	U_ID : parseInt('<?php echo htmlspecialchars($loginUser->uid, ENT_QUOTES, 'UTF-8');?>'),									//uid
	REGION_CONFIG : '',														//地区数据
	CREDIT_REWARD_JUDGE : '<?php echo $loginUser->showCreditNotice();?>',			//是否积分奖励，空值:false, 1:true
	URL : {
		LOGIN : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=u&c=login'; ?>',										//登录地址
		QUICK_LOGIN : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=u&c=login&a=fast'; ?>',								//快速登录
		IMAGE_RES: '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>',										//图片目录
		CHECK_IMG : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=u&c=login&a=showverify'; ?>',							//验证码图片url，global.js引用
		VARIFY : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=verify&a=get'; ?>',									//验证码html
		VARIFY_CHECK : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=verify&a=check'; ?>',							//验证码html
		HEAD_MSG : {
			LIST : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&a=minilist'; ?>'							//头部消息_列表
		},
		USER_CARD : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&c=card'; ?>',								//小名片(参数 : uid)
		LIKE_FORWARDING : '<?php echo Wekit::app()->baseUrl,'/','index.php?c=post&a=doreply'; ?>',							//喜欢转发(参数 : fid)
		REGION : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=webData&a=area'; ?>',									//地区数据
		SCHOOL : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=webData&a=school'; ?>',								//学校数据
		EMOTIONS : "<?php echo Wekit::app()->baseUrl,'/','index.php?m=emotion&type=bbs'; ?>",					//表情数据
		CRON_AJAX : '<?php echo htmlspecialchars($runCron, ENT_QUOTES, 'UTF-8');?>',											//计划任务 后端输出执行
		FORUM_LIST : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=forum&a=list'; ?>',								//版块列表数据
		CREDIT_REWARD_DATA : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=u&a=showcredit'; ?>',					//积分奖励 数据
		AT_URL: '<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=remind'; ?>',									//@好友列表接口
		TOPIC_TYPIC: '<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=forum&a=topictype'; ?>'							//主题分类
	}
};
</script>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/wind.js?v=<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>

<link href="<?php echo Wekit::app()->themes.'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/message.css?v=<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>" rel="stylesheet" />
</head>
<body>
<div class="wrap">
<?php if ($site_info_notice = Wekit::C('site','info.notice')) {?>
<style>.header_wrap{top:29px;}body{padding-top:75px;}</style><div id="notice"><?php echo htmlspecialchars($site_info_notice, ENT_QUOTES, 'UTF-8');?></div>
<?php }?>
<header class="header_wrap">
	<div id="J_header" class="header cc">
		<div class="logo">
			<a href="<?php echo Wekit::app()->baseUrl,'/',''; ?>">
				<?php  if($__css = Wekit::C('site', 'css.logo')) { ?>
				<!--后台logo上传-->
				<img src="<?php echo htmlspecialchars(Pw::getPath($__css), ENT_QUOTES, 'UTF-8');?>" alt="<?php echo htmlspecialchars(Wekit::C('site','info.name'), ENT_QUOTES, 'UTF-8');?>">
				<?php  } else { ?>
				<img src="<?php echo Wekit::app()->themes.'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/logo.png" alt="<?php echo htmlspecialchars(Wekit::C('site','info.name'), ENT_QUOTES, 'UTF-8');?>">
				<?php  } ?>
			</a>
		</div>
		<nav class="nav_wrap">
			<div class="nav">
				<ul>
	<?php  $nav = Wekit::load('SRV:nav.bo.PwNavBo');
		  $nav->setRouter();
		  $currentId =  '';
		   $main = $child = array();
		  if ($nav->isForum()) $nav->setForum($pwforum->foruminfo['parentid'], $fid, $tid);
		  $main = $nav->getNavFromConfig('main', true);
		  foreach($main as $key=>$value):
			if ($value['current']) {
				$current = 'current';
				$currentId = $key;
			} else {
				$current = '';
			}
			$value['child'] && $child[$key] = $value['child'];
		  ?>
					<li class="<?php echo htmlspecialchars($current, ENT_QUOTES, 'UTF-8');?>"><?php echo $value['name'];?></li>
	<?php  endforeach; ?>
				</ul>
			</div>
		</nav>
		<div class="header_search" role="search">
			<form action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=search&c=s'; ?>" method="post">
				<input type="text" id="s" aria-label="搜索关键词" accesskey="s" placeholder="搜索其实很简单" x-webkit-speech speech name="keyword"/>
				<button type="submit" aria-label="搜索"><img src="<?php echo Wekit::app()->themes.'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/common/search.png" alt="search" /></button>
			<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
		</div>
		<?php
PwHook::display(array(PwSimpleHook::getInstance("header_nav"), "runDo"), array(), "", $__viewer);

  if (!$loginUser->isExists()) { ?>
<div class="header_login">
	<a rel="nofollow" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=u&c=login'; ?>">登录</a><a rel="nofollow" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=u&c=register'; ?>">注册</a>
</div>
<?php  } else {
	if ($pwforum && $pwforum->isForum()) {
		$ifJsFastPost = '';
		$_tmpfid = $pwforum->fid;
	} else {
		$ifJsFastPost = "J_head_forum_post";
		$_tmpfid = 0;
	}
?>
	<a class="header_login_btn" id="<?php echo htmlspecialchars($ifJsFastPost, ENT_QUOTES, 'UTF-8');?>" role="button" aria-label="快速发帖" aria-haspopup="J_head_forum_pop" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=post&fid=', rawurlencode($_tmpfid); ?>" title="快速发帖" style="width:68px;" tabindex="-1"><span class="inside"><span class="header_post" >发帖</span></span></a>
	<div id="J_head_forum_pop" tabindex="0" class="pop_select_forum" style="top:45px;left:50%;margin-left:100px;z-index:11;display:none;" aria-label="快速发帖菜单,按ESC键关闭菜单">
		<a id="J_head_forum_close" href="#" class="pop_close" role="button">关闭窗口</a>
		<div class="core_arrow_top" style="left:310px;"><em></em><span></span></div>
		<div class="hd">发帖到其他版块</div>
		<div id="J_head_forum_ct" class="ct cc">
			<div class="pop_loading"></div>
		</div>
		<div class="ft">
			<div class="associate">
				<label class="fr"><input type="checkbox" id="J_head_forum_join" data-url="<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=forum&a=join'; ?>">添加到我的版块</label>
				发帖到：<span id="J_post_to_forum"></span>
			</div>
			<div class="tac">
				<button type="button" class="btn btn_submit disabled" disabled="disabled" id="J_head_forum_sub" data-url="<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=post'; ?>">确定</button>
			</div>
		</div>
	</div>
	<?php 
		$messageCount = $loginUser->info['notices'] + $loginUser->info['messages'];
		$messageClass = $messageCount ? 'header_message' : 'header_message header_message_none';
	?>
	<a class="header_login_btn" id="J_head_msg_btn" tabindex="0" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=message'; ?>" aria-haspopup="J_head_msg_pop" style="width:37px;" aria-label="消息菜单,按pagedown打开菜单,tab键导航,esc键关闭"><span class="inside"><span class="<?php echo htmlspecialchars($messageClass, ENT_QUOTES, 'UTF-8');?>">消息<em class="core_num J_hm_num"><?php echo htmlspecialchars($messageCount, ENT_QUOTES, 'UTF-8');?></em></span></span></a>
	<!--消息下拉菜单-->
	<div id="J_head_msg_pop" tabindex="0" aria-label="消息下拉菜单,按ESC键关闭菜单" class="header_menu_wrap my_message_menu" style="width:380px;display:none;">
		<div class="header_menu cc">
			<div class="header_menu_hd" id="J_head_pl_hm"><span class="<?php echo htmlspecialchars($messageClass, ENT_QUOTES, 'UTF-8');?> header_message_down">消息<em class="core_num J_hm_num"><?php echo htmlspecialchars($messageCount, ENT_QUOTES, 'UTF-8');?></em></span></div>
			<div id="J_head_msg" class="my_message_content"><div class="pop_loading"></div></div>
		</div>
	</div>
	<div class="header_login_later">
		<?php
PwHook::display(array(PwSimpleHook::getInstance("header_info_1"), "runDo"), array(), "", $__viewer);
?>
		<a aria-haspopup="J_head_user_menu" aria-label="个人功能菜单,按pagedown打开菜单,tab键导航,esc键关闭" tabindex="0" rel="nofollow" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($loginUser->uid); ?>" id="J_head_user_a" class="username" title="<?php echo htmlspecialchars($loginUser->username, ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars(Pw::substrs($loginUser->username,6), ENT_QUOTES, 'UTF-8');?><em class="core_arrow"></em></a>
		<?php
PwHook::display(array(PwSimpleHook::getInstance("header_info_2"), "runDo"), array(), "", $__viewer);
?>
		<div class="fl">
		<div id="J_head_user_menu" role="menu" class="header_menu_wrap my_menu_wrap" style="display:none;">
			<div class="header_menu my_menu cc">
				<div class="header_menu_hd" id="J_head_pl_user"><span title="<?php echo htmlspecialchars($loginUser->username, ENT_QUOTES, 'UTF-8');?>" class="username"><?php echo htmlspecialchars(Pw::substrs($loginUser->username,6), ENT_QUOTES, 'UTF-8');?></span><em class="core_arrow_up"></em></div>
				<ul class="ct cc">
				<?php  $nav = Wekit::load('SRV:nav.bo.PwNavBo');
					$myNav = $nav->getNavFromConfig('my');
					foreach($myNav as $key=>$value):
				?>
					<li><?php echo $value['name'];?></li>
				<?php  endforeach; 
 
				$_url = '';
				$_panelManage = false;
				if ($loginUser->getPermission('panel_bbs_manage')) {
					$_url = 'manage/content/run';
					$_panelManage = true;
				}
				if (!$_panelManage && $loginUser->getPermission('panel_user_manage')) {
					$_url = 'manage/user/run';
					$_panelManage = true;
				}
				if (!$_panelManage && $loginUser->getPermission('panel_report_manage')) {
					$_url = 'manage/report/run';
					$_panelManage = true;
				}
				if (!$_panelManage && $loginUser->getPermission('panel_recycle_manage')) {
					$_url = 'manage/recycle/run';
					$_panelManage = true;
				}
				if ($_panelManage) {
				?>
					<li><a href="<?php echo WindUrlHelper::createUrl($_url);?>" rel="nofollow"><em class="icon_system"></em>前台管理</a></li>
				<?php } if (Pw::getstatus($loginUser->info['status'], PwUser::STATUS_ALLOW_LOGIN_ADMIN) || in_array(3, $loginUser->groups)) {?>
					<li><a href="<?php echo htmlspecialchars(Wind::getComponent('router')->getRoute('pw')->checkUrl('admin.php'), ENT_QUOTES, 'UTF-8');?>" target="_blank" rel="nofollow"><em class="icon_admin"></em>系统后台</a></li>
				<?php }?>
				</ul>
				<ul class="ft cc">
					<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile'; ?>"><em class="icon_profile"></em>个人设置</a></li>
					<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=u&c=login&a=logout'; ?>" rel="nofollow"><em class="icon_quit"></em>退出</a></li>
				</ul>
			</div>
		</div>
		</div>
	</div>
	<?php  if ($loginUser->info['message_tone'] > 0 && $messageCount > 0) { ?>
	<audio autoplay="autoplay">
		<source src="<?php echo Wekit::app()->themes.'/site/default/images'; ?>/message/msg.wav" type="audio/wav" />
		<source src="<?php echo Wekit::app()->themes.'/site/default/images'; ?>/message/msg.mp3" type="audio/mp3" />
		<div style='overflow:hidden;width:0;float:left'><embed src='<?php echo Wekit::app()->themes.'/site/default/images'; ?>/message/msg.wav' width='0' height='0' AutoStart='true' type='application/x-mplayer2'></embed></div>
	</audio>
	<?php  } 
  } ?>
	</div>
</header>
<?php 
if ($child) {
foreach ($child as $ck => $cv) {
	 if ($currentId == $ck):
?>
	<div class="nav_weak" id="<?php echo htmlspecialchars($ck, ENT_QUOTES, 'UTF-8');?>">
<?php  else: ?>
	<div class="nav_weak" id="<?php echo htmlspecialchars($ck, ENT_QUOTES, 'UTF-8');?>" style="display:none">
<?php  endif; ?>
		<ul class="cc">
			<?php  foreach($cv as $_v):
				$current = $_v['current'] ? 'current' : '';
			?>
			<li class="<?php echo htmlspecialchars($current, ENT_QUOTES, 'UTF-8');?>"><?php echo $_v['name'];?></li>
			<?php  endforeach; ?>
		</ul>
	</div>
<?php }} ?>
<div class="tac"> </div>
	<div class="main_wrap">
		<div class="bread_crumb">
			<a href="<?php echo Wekit::app()->baseUrl; ?>" class="home" title="<?php echo Wekit::C("site", "info.name"); ?>">首页</a><em>&gt;</em>
			<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=message'; ?>">消息</a><em>&gt;</em>
			<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice'; ?>">通知</a>
		</div>
		<div class="main cc">
			<div class="main_body">
				<div class="main_content">
					<div class="box_wrap notice_page">
						<nav>
<div class="content_nav">
	<span class="fr"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=message&a=pop'; ?>" class="btn btn_submit J_send_msg_pop">写私信</a></span>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=message&a=set'; ?>" class="edit">设置</a>
	<ul>
		<li<?php if($_controller == 'message' && !in_array($_action,array('set','add'))){?> class="current"<?php }?>>
			<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=message'; ?>">私信<?php  if ($loginUser->info['messages']) { ?><em class="core_num id="J_unread_count"><?php echo htmlspecialchars($loginUser->info['messages'], ENT_QUOTES, 'UTF-8');?></em><?php  } ?></a></li>
		<li<?php if($_controller == 'notice' && !in_array($_action,array('set','add'))){?> class="current"<?php }?>><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice'; ?>">通知<?php  if ($loginUser->info['notices']) { ?><em class="core_num"><?php echo htmlspecialchars($loginUser->info['notices'], ENT_QUOTES, 'UTF-8');?></em><?php  } ?></a></li>
	</ul>
	<?php if($_controller == 'message' && !in_array($_action,array('set','add'))){?>
	<div class="message_search">
	<form id="J_msg_search_form" action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=message&a=search'; ?>" method="post" >
	<input type="text" placeholder="输入用户名" name="keyword" id="J_msg_search_input"><button id="J_msg_search_btn"><img src="<?php echo Wekit::app()->themes.'/site/default/images'; ?>/common/search_mini.png" alt="搜索" /></button>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	</div>
	<?php  } ?>
</div>
</nav>

						<div id="J_notice_list" class="notice_list J_check_wrap">
					<?php 
					if ($noticeList){
					?>
							<div class="hd cc J_op_bar" style="display:none;">
								<div class="check"><label><input name="" type="checkbox" class="J_check_all" value="">全选</label></div>
								<div class="operate J_notice_op">
									<span class="filter"><span class="current"><?php echo htmlspecialchars($typeCounts[$typeid]['typename'], ENT_QUOTES, 'UTF-8');?></span> - <a href="javascript:;" data-id="J_notice_drop_1" class="drop_down J_hover_more">更多<em class="core_arrow"></em></a></span>
									<a href="" class="btn J_msg_manage_hide">取消</a>
									<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&a=delete'; ?>" style="visibility:hidden;" class="btn J_check_op J_check_op_sub">删除</a>
								</div>
							</div>
							<div class="hd cc J_op_manage">
								<span class="filter"><span class="current"><?php echo htmlspecialchars($typeCounts[$typeid]['typename'], ENT_QUOTES, 'UTF-8');?></span> - <a href="javascript:;" data-id="J_notice_drop_1" class="drop_down J_hover_more">更多<em class="core_arrow"></em></a></span>
								<a href="javascript:;" class="btn J_msg_manage_show">批量管理</a>
							</div>
							<div id="J_notice_drop_1" class="core_menu" style="display:none;position:absolute;">
								<ul class="core_menu_list cc">
								<?php  
									foreach($typeCounts as $k=>$v){
										$url = @WindUrlHelper::createUrl('message/notice/run'. ($k ? "?type=$k" : ''));
								 ?>
									<li><a href="<?php echo $url;?>"><em class="data"><?php echo htmlspecialchars($v['count'], ENT_QUOTES, 'UTF-8');?></em><?php echo htmlspecialchars($v['typename'], ENT_QUOTES, 'UTF-8');?></a></li>
								<?php  } ?>
								</ul>
							</div>
					<?php 
						}	
					//主题分类
					if ($noticeList){
						
						foreach($noticeList as $v){
							list($typeCounts[$v['typeid']]['type']) = explode('_',$typeCounts[$v['typeid']]['type']);
							$typeTpl = 'notice_segment_' . $typeCounts[$v['typeid']]['type'];
				
 PwHook::segment("$typeTpl", array($v), "list", "notice_list", $__viewer); 
 
					}
				} else {
					?>
							<div class="not_content">
								暂无通知
							</div>
					<?php  	
					}
					 
 
					if ($noticeList){
					?>
							<div class="ft J_op_bar" style="display:none;">
								<div class="check"><label><input name="" type="checkbox" class="J_check_all" value="">全选</label></div>
								<div class="operate">
									<a href="" class="btn J_msg_manage_hide">取消</a>
									<div id="J_notice_drop_2" class="core_menu" style="display:none;position:absolute;">
										<ul class="core_menu_list cc">
										<?php  
											foreach($typeCounts as $k=>$v){
												$url = @WindUrlHelper::createUrl('message/notice/run'. ($k ? "?type=$k" : ''));
											?>
											<li><a href="<?php echo $url;?>"><em class="data"><?php echo htmlspecialchars($v['count'], ENT_QUOTES, 'UTF-8');?></em><?php echo htmlspecialchars($v['typename'], ENT_QUOTES, 'UTF-8');?></a></li>
										<?php  } ?>
										</ul>
									</div>
									<span class="filter"><span class="current"><?php echo htmlspecialchars($typeCounts[$typeid]['typename'], ENT_QUOTES, 'UTF-8');?></span> - <a href="javascript:;" data-id="J_notice_drop_2" class="drop_down J_hover_more">更多<em class="core_arrow"></em></a></span>
									<a class="btn J_check_op J_check_op_sub" style="visibility:hidden;" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&a=delete'; ?>">删除</a>
								</div>
							</div>
						<?php  } 
  if($totalpage > 1){ ?>
							<div style="padding-top:10px;"><?php $__tplPageCount=(int)$count;
$__tplPagePer=(int)$perpage;
$__tplPageTotal=(int)$totalpage;
$__tplPageCurrent=(int)$page;
if($__tplPageCount > 0 && $__tplPagePer > 0){
$__tmp = ceil($__tplPageCount / $__tplPagePer);
($__tplPageTotal !== 0 &&  $__tplPageTotal < $__tmp) || $__tplPageTotal = $__tmp;}
$__tplPageCurrent > $__tplPageTotal && $__tplPageCurrent = $__tplPageTotal;
if ($__tplPageTotal > 1) {
 
$_page_min = max(1, $__tplPageCurrent-3);
$_page_max = min($__tplPageTotal, $__tplPageCurrent+3);
?>
<div class="pages">
<?php  if ($__tplPageCurrent > $_page_min) { 
	$_page_i = $__tplPageCurrent-1;
?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?></div>
						<?php  } ?>
						</div>
					</div>
				</div>
			</div>
			<div class="main_sidebar">
				<?php  if (!$loginUser->isExists()) { 
  Wind::import('APPS:u.service.helper.PwUserHelper'); 
  $_loginWay = PwUserHelper::getLoginMessage(); ?>
	<div class="box_wrap sidebar_login">
		<form id="J_login_form" action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=u&c=login&a=dologin'; ?>" method="post">
		<dl>
			<dt id="J_sidebar_login_dt">
				<label for="J_username">用户名</label><input required type="text" class="input" id="J_username" name="username" placeholder="<?php echo htmlspecialchars($_loginWay, ENT_QUOTES, 'UTF-8');?>">
				<label for="J_password">密　码</label><input required type="password" class="input" id="J_password" name="password" placeholder="密码">
			</dt>
			<dd class="associate"><a class="sendpwd" rel="nofollow" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=u&c=findPwd'; ?>">找回密码</a><label for="head_checkbox" title="下次自动登录"><input type="checkbox" id="head_checkbox" name="cktime" value="31536000">自动登录</label></dd>
			<dd class="operate"><button type="submit" id="J_sidebar_login" class="btn btn_big btn_submit">登录</button><a class="btn btn_big btn_error" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=u&c=register'; ?>" rel="nofollow">立即注册</a></dd>
		</dl>
		<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	</div>
<?php  } else { 
  $_group = $loginUser->getGroupInfo(); ?>
	<div class="box_wrap user_info">
		<dl class="cc">
			<dt id="J_ava_ie6">
				<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($loginUser->uid); ?>"><img class="J_avatar" src="<?php echo htmlspecialchars(Pw::getAvatar($loginUser->uid), ENT_QUOTES, 'UTF-8');?>" data-type="middle" width="72" height="72" alt="<?php echo htmlspecialchars($loginUser->username, ENT_QUOTES, 'UTF-8');?>" /></a>
				<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=avatar&_left=avatar'; ?>"><b></b><span>修改头像</span></a>
			</dt>
			<dd>
				<div class="name"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($loginUser->uid); ?>" class="username"><?php echo htmlspecialchars($loginUser->username, ENT_QUOTES, 'UTF-8');?><i></i></a></div>
				<div class="level"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=profile&c=right&_left=right'; ?>"><?php echo htmlspecialchars($_group['name'], ENT_QUOTES, 'UTF-8');?></a></div>
				<div class="level_img">
					<img src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>/level/<?php echo htmlspecialchars($_group['image'], ENT_QUOTES, 'UTF-8');?>" alt="<?php echo htmlspecialchars($_group['name'], ENT_QUOTES, 'UTF-8');?>" />
				</div>
			</dd>
		</dl>
		<div class="num">
			<ul class="cc">
				<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=my&c=follow'; ?>"><span><?php echo htmlspecialchars($loginUser->info['follows'], ENT_QUOTES, 'UTF-8');?></span><em>关注</em></a></li>
				<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=my&c=fans'; ?>"><span><?php echo htmlspecialchars($loginUser->info['fans'], ENT_QUOTES, 'UTF-8');?></span><em>粉丝</em></a></li>
				<li class="tail"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=my&c=article'; ?>"><span><?php echo htmlspecialchars($loginUser->info['postnum'], ENT_QUOTES, 'UTF-8');?></span><em>帖子</em></a></li>
			</ul>
		</div>
	<?php  if (Wekit::C('site','medal.isopen')): ?>
		<div class="medal_widget" id="J_medal_widget">
			<a href="javascript:;" class="next next_disabled J_lazyslide_next" title="下一组"><em></em></a>
			<a href="javascript:;" class="pre pre_disabled J_lazyslide_prev" title="上一组"><em></em></a>
			<div class="medal_list_wrap">
			<ul id="J_medal_widget_ul" class="cc J_lazyslide_list" style="width:900px;">
			<?php  
				$J_medals = Wekit::load('medal.srv.PwMedalCache')->getMyAndAutoMedal($loginUser->uid);
				$_medals = array_slice($J_medals, 0, 6, true);
				foreach ($_medals as $medal):
			
  if($medal['award_status'] !=4): ?>
					<li class="doing"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=medal'; ?>"><img src="<?php echo htmlspecialchars($medal['icon'], ENT_QUOTES, 'UTF-8');?>" width="30" height="30" title="<?php echo htmlspecialchars($medal['name'], ENT_QUOTES, 'UTF-8');?>" alt="<?php echo htmlspecialchars($medal['name'], ENT_QUOTES, 'UTF-8');?>" /></a></li>
				<?php  else: ?>
					<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=medal'; ?>"><img src="<?php echo htmlspecialchars($medal['icon'], ENT_QUOTES, 'UTF-8');?>" width="30" height="30" title="<?php echo htmlspecialchars($medal['name'], ENT_QUOTES, 'UTF-8');?>" alt="<?php echo htmlspecialchars($medal['name'], ENT_QUOTES, 'UTF-8');?>" /></a></li>
				<?php  endif; 
  endforeach; ?>
			</ul>
			<textarea id="J_sidebar_medal_ta" style="display:none">
				<?php  	foreach ($J_medals as $medal): 
  if($medal['award_status'] !=4): ?><li class="doing"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=medal'; ?>"><img src="<?php echo htmlspecialchars($medal['icon'], ENT_QUOTES, 'UTF-8');?>" width="30" height="30" title="<?php echo htmlspecialchars($medal['name'], ENT_QUOTES, 'UTF-8');?>" alt="<?php echo htmlspecialchars($medal['name'], ENT_QUOTES, 'UTF-8');?>" /></a></li><?php  else: ?><li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=medal'; ?>"><img src="<?php echo htmlspecialchars($medal['icon'], ENT_QUOTES, 'UTF-8');?>" width="30" height="30" title="<?php echo htmlspecialchars($medal['name'], ENT_QUOTES, 'UTF-8');?>" alt="<?php echo htmlspecialchars($medal['name'], ENT_QUOTES, 'UTF-8');?>" /></a></li><?php  endif; 
  endforeach; ?></textarea>
			</div>
		</div>
	<?php  endif; 
  
	$punchService = Wekit::load('space.srv.PwPunchService');
	list($punchOpen,$punchFriendOpen) = $punchService->getPunchConfig();
	if ($punchOpen) {
		list($punchStatus,$punchButton,$punchData) = $punchService->getPunch();
		$punchStatus = $punchStatus ? '' : 'punch_widget_disabled';
		list($monthDay,$weekDay) = $punchService->formatWeekDay(Pw::getTime());
	 ?>
	<div class="cc punch_widget_wrap">
		<div id="J_punch_main_tip" class="fl dn">
		<?php  if ($punchData) { ?>
			<div class="tips">
				<div class="core_arrow_top"><em></em><span></span></div>
				<?php echo htmlspecialchars($punchData['username'], ENT_QUOTES, 'UTF-8');?>已帮你领取<span class="red"><?php echo htmlspecialchars($punchData['cNum'], ENT_QUOTES, 'UTF-8');?></span><?php echo htmlspecialchars($punchData['cUnit'], ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($punchData['cType'], ENT_QUOTES, 'UTF-8');?>
			</div>
		<?php  } ?>
		</div>
		<div class="punch_widget <?php echo htmlspecialchars($punchStatus, ENT_QUOTES, 'UTF-8');?>" id="J_punch_widget">
			<div class="date"><?php echo htmlspecialchars($monthDay, ENT_QUOTES, 'UTF-8');?><span><?php echo htmlspecialchars($weekDay, ENT_QUOTES, 'UTF-8');?></span></div>
			<div class="cont"><a data-punchurl="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&c=punch&a=punchtip'; ?>" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&c=punch&a=punch'; ?>" id="J_punch_mine" tabindex="-1" target="_blank"><?php echo htmlspecialchars($punchButton, ENT_QUOTES, 'UTF-8');?></a></div>
			<?php  if ($punchFriendOpen) { ?>
			<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&c=punch&a=friend'; ?>" id="J_punch_friend" class="help_ta" tabindex="-1" target="_blank">帮Ta打卡</a>
			<?php  } ?>
		</div>
	</div>
<?php  } ?>
	</div>
<?php  } 
  if ($loginUser->info['join_forum']) { 
	Wind::import('APPS:bbs.controller.ForumController');
	$myJoinForum = ForumController::splitStringToArray($loginUser->info['join_forum']);
	$myJoinForumCount = count($myJoinForum);
	
?>
<div class="box_wrap my_forum_list"><!--切换样式 my_forum_list_cur -->
	<h2 class="box_title J_sidebar_box_toggle">我的版块<span class="num"><?php echo htmlspecialchars($myJoinForumCount, ENT_QUOTES, 'UTF-8');?></span></h2>
	<ul>
	<?php  foreach ($myJoinForum as $v => $k) { ?>
		<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=thread&fid=', rawurlencode($v); ?>"><?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?></a></li>
	<?php  } ?>
	</ul>
</div>
<?php  } ?>
<!--advertisement id='Site.Sider.User' sys='1'/-->
 
		<?php 
			$forumdb = Wekit::load('forum.srv.PwForumService')->getCommonForumList();
			if ($pwforum instanceof PwForumBo) {
				$__currentCateId = $pwforum->getCateId();
				$__currentFid = $pwforum->fid;
				!isset($forumdb[0][$__currentCateId]) && $__currentCateId = key($forumdb[0]);
			} else {
				$__currentCateId = key($forumdb[0]);
				$__currentFid = 0;
			}
		?>
		<div class="box_wrap" aria-label="版块列表" role="tablist">
			<h2 class="box_title J_sidebar_box_toggle">版块列表</h2>
			<div class="forum_menu" >
			<?php  foreach ($forumdb[0] as $k => $cate) { 
  if ($forumdb[$cate['fid']]) { ?>
				<dl class="<?php echo htmlspecialchars(Pw::isCurrent($k == $__currentCateId), ENT_QUOTES, 'UTF-8');?>">
					<dt class="J_sidebar_forum_toggle"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=cate&fid=', rawurlencode($cate['fid']); ?>"><?php echo htmlspecialchars(strip_tags($cate['name']), ENT_QUOTES, 'UTF-8');?></a></dt>
					<dd role="tabpanel">
						<?php  foreach ($forumdb[$cate['fid']] as $forums) { ?>
						<p><a class="<?php echo htmlspecialchars(Pw::isCurrent($forums['fid'] == $__currentFid), ENT_QUOTES, 'UTF-8');?>" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=bbs&c=thread&fid=', rawurlencode($forums['fid']); ?>"><?php echo htmlspecialchars(strip_tags($forums['name']), ENT_QUOTES, 'UTF-8');?></a></p>
						<?php  } ?>
					</dd>
				</dl>
				<?php  } 
  } ?>
			</div>
		</div>
<?php $__tpl_data = call_user_func_array(
								array(Wekit::load("SRV:tag.srv.PwTagService"), 
								"getHotTags"), 
								array('0','10')); 
  if($__tpl_data) {?>
<div class="box_wrap">
	<h2 class="box_title">热门话题</h2>
	<div class="tags_hot">
	<ul class="cc">
		<?php  foreach($__tpl_data as $k=>$v){ ?>
		<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=tag&a=view&name=', rawurlencode($v['tag_name']); ?>" class="title"><?php echo htmlspecialchars($v['tag_name'], ENT_QUOTES, 'UTF-8');?></a></li>
		<?php  } ?>
	</ul>
	</div>
</div>
 
<?php  } 
  
  
	if ($loginUser->info['recommend_friend']) {
		$pFriends = Wekit::load('attention.srv.PwAttentionRecommendFriendsService')->getRecommentUser($loginUser);
		if ($pFriends) {
		$otherFriends = array_slice($pFriends,3);
		$pFriends = array_slice($pFriends,0,3);
 ?>
<div class="box_wrap" id="J_friend_maybe">
	<h2 class="box_title J_sidebar_box_toggle">可能认识的人</h2>
	<div class="side_may_list" id="J_friend_maybe_list" data-url="<?php echo Wekit::app()->baseUrl,'/','index.php?m=my&c=follow&a=recommendfriend'; ?>">
	<?php 
		$i = 0;
		foreach($pFriends as $v){
			$pUid = $v['uid'];
			//if ($v['cnt'] < 1) continue;
			$class = ($i > 1) ? 'display:none;' : '';
			$class2 = ($i > 0) ? 'display:none;' : '';
			$load = ($i > 0) ? 'false' : 'true';
			$arrow = ($i == 0) ? '&uarr;' : '&darr;';
	 ?>
		<div class="J_friend_maybe_items">
			<dl>
				<dt><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($pUid); ?>" class="J_user_card_show" data-uid="<?php echo htmlspecialchars($pUid, ENT_QUOTES, 'UTF-8');?>"><img class="J_avatar" src="<?php echo htmlspecialchars(Pw::getAvatar($pUid,'small'), ENT_QUOTES, 'UTF-8');?>" width="50" height="50" data-uid="<?php echo htmlspecialchars($pUid, ENT_QUOTES, 'UTF-8');?>" data-type="small" /></a></dt>
				<dd>
					<p class="title"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($pUid); ?>" class="J_user_card_show" data-uid="<?php echo htmlspecialchars($pUid, ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($v['username'], ENT_QUOTES, 'UTF-8');?></a></p>
					<p><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=my&c=follow&a=add&uid=', rawurlencode($pUid); ?>" class="core_follow J_friend_maybe_follow mr10" role="button" rel="nofollow">关注</a>
					<?php  if ($v['cnt']) { ?>
					<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=my&c=follow&a=samefriend&uid=', rawurlencode($pUid); ?>" class="unmore J_friend_view" data-uid="<?php echo htmlspecialchars($pUid, ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($v['cnt'], ENT_QUOTES, 'UTF-8');?>个共同好友<?php echo $arrow;?></a>
					<?php  } ?>
					</p>
				</dd>
			</dl>
			<?php  if ($v['sameUser']) { ?>
			<div id="J_friend_related_<?php echo htmlspecialchars($pUid, ENT_QUOTES, 'UTF-8');?>" class="related J_friend_related" style="<?php echo htmlspecialchars($class2, ENT_QUOTES, 'UTF-8');?>" data-load="<?php echo htmlspecialchars($load, ENT_QUOTES, 'UTF-8');?>">
				
				<div class="menu_arrow"><em></em><span></span></div>
				<?php  
					$tmp = array();
					foreach($v['sameUser'] as $sk => $su){
						if (!trim($su)) continue;
						$tmp[] = sprintf('<a href="%s" class="J_user_card_show" data-uid="%d" target="_blank">%s</a>',WindUrlHelper::createUrl('space/index/run',array('uid'=>$sk)),$sk,$su);
					}
					$tmp = implode('、', $tmp);
				 ?>
				 您关注的人中： <?php echo $tmp;
  if($v['cnt'] > 3) {?>等<?php echo htmlspecialchars($v['cnt'], ENT_QUOTES, 'UTF-8');?>人<?php  } ?> 也关注了Ta
			</div>
			<?php  } ?>
		</div>
	<?php 
		$i++;
		}
	 ?>
		
	</div>
</div>
<?php  }} ?>
 
 
<!--design role="segment" id="linkdemo"/-->
			</div>
		</div>
	</div>
<!--.main-wrap,#main End-->
<div class="tac">
 <br />
 
</div>
<div class="footer_wrap">
	<div class="footer">
		 
		<div class="bottom">
		<?php 
			$nav = Wekit::load('SRV:nav.bo.PwNavBo');
			$bottom = $nav->getNavFromConfig('bottom');
			foreach($bottom as $key=>$value):
		
 echo $value['name'];
  endforeach; ?>
		</div>
		<p>Powered by <a href="http://www.phpwind.net/" target="_blank" rel="nofollow">phpwind v<?php echo htmlspecialchars(NEXT_VERSION, ENT_QUOTES, 'UTF-8');?></a> &copy;2003-2103 <a href="http://www.phpwind.com" target="_blank" rel="nofollow">phpwind.com</a> <a href="http://www.miibeian.gov.cn" target="_blank" rel="nofollow"><?php echo htmlspecialchars(Wekit::C('site','info.icp'), ENT_QUOTES, 'UTF-8');?></a></p>
		<p><?php echo Wekit::C('site','statisticscode');?></p>
	</div>
	 
	 
	 
	<div id="cloudwind_common_bottom"></div>
	<?php
PwHook::display(array(PwSimpleHook::getInstance("footer"), "runDo"), array(), "", $__viewer);
?>
</div>

<!--返回顶部-->
<a href="#" rel="nofollow" role="button" id="back_top" tabindex="-1">返回顶部</a>

</div>
<script>
Wind.use('jquery', 'global', 'dialog', function() {
	var notice_list = $('#J_notice_list');

	//点击整行跳转
	$('#J_notice_list .J_notice_content').on('click', function(e){
		if(e.target.tagName.toLowerCase() !== 'a') {
			var trigger = $(this).find('a.J_notice_show');
			if(trigger.data('role') == 'down') {
				trigger.click()
			}
		};
	});
	
/*
 * 忽略
*/
	var URL_IGNORE = "<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&a=ignore&ignore=1'; ?>",		//忽略
			URL_UNIGNORE = '<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=notice&a=ignore&ignore=0'; ?>';	//取消忽略 开启回复提醒

	$('a.J_notice_ignore').on('click', function(e){
		e.preventDefault();
		var $this = $(this),
				info = $this.parents('.J_notice_item').find('.info'),
				id = $this.data('id'),
				role = $(this).data('role'),
				type = $this.data('type'),
				url = type ? URL_IGNORE : URL_UNIGNORE;

		//global.js
		Wind.Util.ajaxMaskShow();

		$.post(url, {
			id : id
		}, function(data){
			//global.js
			Wind.Util.ajaxMaskRemove();

			if(data.state == 'success') {
				if(!id) {
					//没有取消忽略
					Wind.Util.resultTip({
						elem : $this,
						msg : data.message
					});

					return false;
				}

				if(role == 'reply') {
					//忽略回复
					if(type) {
						//global.js
						Wind.Util.resultTip({
							follow : $this.parent(),
							msg : '您将不会再收到 此帖的回复 通知'
						});
						$this.text('开启回复提醒').data('type', false);
					}else{
						$this.text('关闭回复提醒').data('type', true);
					}
					
				}else{
					//忽略其他
					if(type) {
						Wind.Util.resultTip({
							elem : $this,
							msg : '已忽略此类通知'
						});
						//$this.text('取消忽略').data('type', false);
						$this.replaceWith('<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=message&c=message&a=set'; ?>">查看通知设置</a>')
					}else{
						$this.text('忽略').data('type', true);
					}
				}
				
			}else if(data.state == 'fail') {
				//global.js
				Wind.Util.resultTip({
					error : true,
					elem : $this,
					msg : '已忽略此类通知'
				});
			}
		}, 'json');
	});
	
	//选择后提交
	$('a.J_check_op_sub').on('click', function(e){
		e.preventDefault();
		var $this = $(this),
			href = $this.prop('href'),
			checked = $('input.J_check:checked'),
			ids_arr = [];
			
		//ids数组
		$.each(checked, function(i, o){
			ids_arr.push($(this).val());
		});


		//删除
		Wind.dialog({
			message	: '确定删除选中的通知吗？',
			type	: 'confirm',
			follow : $this,
			isMask	: false,
			onOk	: function() {
				$.ajax({
					url : href,
					type : 'post',
					dataType : 'json',
					data : {
					'ids[]' : ids_arr
					},
					success : function(data){
						if(data.state === 'success') {
							checked.parents('.J_notice_item').fadeOut(function(){
								$(this).remove();
								
								if(!$('.J_notice_item').length) {
									//清空了
									location.reload();
								}
							});

						}else if( data.state === 'fail' ) {
							Wind.dialog.alert(data.message);
						}
					}
				});
			}
		});
		
	});
	
	//显示隐藏
	$('a.J_hover_more').each(function(){
		var $this = $(this);

		//global.js
		Wind.Util.hoverToggle({
			elem : $this,		//hover元素
			list : $('#'+ $this.data('id')),
			callback : function(elem, list){
				//计算定位
				var a_width = elem.width(),
					a_height = elem.height(),
					b_width = list.width(),
					b_height = list.height(),
					a_offset_left = elem.offset().left, //到文档左侧距离
					a_offset_top = elem.offset().top, //到文档顶部距离
					a_window_top = a_offset_top - $(document).scrollTop(), //到窗口顶部距离
					a_window_bottom = $(window).height() - a_window_top - a_height, //到窗口底部距离
					b_left,
					b_top;
							
				if (a_offset_left > $(document).width() / 2) {
					//靠右
					b_left = a_offset_left + a_width - b_width;
				} else {
					//靠左
					b_left = a_offset_left;
				}
							
				//默认垂直定位
				b_top = a_offset_top + a_height;
							
				if (a_window_bottom < b_height && a_window_top >= b_height) {
					//底部空间不足 顶部空间足够时，显示在上面
					b_top = a_offset_top - b_height;
				}
							
				list.css({
					left : b_left,
					top : b_top
				});
			}
		});
	});
	
	
	//展开&收起
	$('a.J_notice_show').on('click', function(e){
		e.preventDefault();
		var $this = $(this),
			notice_part	= $this.siblings('.J_notice_part'),
			notice_all	= $this.siblings('.J_notice_all'),
			role = $this.data('role');
		
		if(role === 'down') {
			//展开
			
			if(notice_all.children().length){
				//内容已隐藏
				notice_part.hide();
				notice_all.show();
				$this.data('role', 'up').text('收起↑').addClass('open_down');
			}else{
				//请求内容
				notice_all.load(this.href, function(data){
					if(Wind.Util.ajaxTempError(data)) {
						return false;
					}

					//模板与头部消息公用，清理
					$(this).find('div.my_message_top, div.my_message_bottom').remove();
					
					notice_all.show();
					notice_part.hide();
					$this.data('role', 'up').text('收起↑');

					//绑定发私信
					if(notice_all.find('a.J_send_msg_pop').length) {
						Wind.js(GV.JS_ROOT+ 'pages/common/sendMsgPop.js?v='+ GV.JS_VERSION);
					}

					//表情js
					if($.isFunction(window.insertEmotions) && $('a.J_insert_emotions').length) {
						Wind.use('rangeInsert', GV.JS_ROOT+ 'pages/common/insertEmotions.js?v='+ GV.JS_VERSION);
					}

					//加关注
					$('a.J_msg_follow').on('click', function(e){
						e.preventDefault();
						var $this = $(this);
						$.post(this.href, function(data){
							if(data.state == 'success') {
								$this.replaceWith('<span class="core_unfollow">已关注</span>');
							}else if(data.state == 'fail'){
								//global.js
								Wind.Util.resultTip({
									error : true,
									msg : data.message,
									follow : $this
								});
							}
						}, 'json');
					});

					//未读icon
					var icon_new = notice_part.find('.J_icon_new');
					if(icon_new.length) {
						icon_new.attr('class', icon_new.attr('class').replace('_new', '')).removeClass('J_icon_new');
					}

				});
			}
		}else{
			//收起
			notice_part.show();
			notice_all.hide();
			$this.data('role', 'down').text('展开↓').removeClass('open_down');
		}
	});

	//绑定表情
	notice_list.on('click', 'a.J_insert_emotions', function(e){
		e.preventDefault();
		//insertEmotions($(this), $($(this).data('emotiontarget')));
	});

	Wind.js(GV.JS_ROOT +'pages/message/message_index.js?v=' + GV.JS_VERSION);
	
});
</script>
</body>
</html>