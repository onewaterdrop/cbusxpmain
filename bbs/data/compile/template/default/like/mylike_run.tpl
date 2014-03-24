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

<link href="<?php echo Wekit::app()->themes.'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/like.css?v=<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>" rel="stylesheet" />
</head>
<body>
<style type="text/css">
</style><?php  
    			$__design_pageid = 10;
    			Wind::import("SRV:design.bo.PwDesignPageBo");
    			$__design = new PwDesignPageBo();
    			$__design_data = $__design->getDataByModules(array());
    			
  
			$loginUser = Wekit::getLoginUser();
	   	 	$designPermission = $loginUser->getPermission('design_allow_manage.push');
	    	if ($designPermission > 0){?><form method="post" action=""><button class="design_mode_edit" type="submit">模块管理</button><input type="hidden" name="design" value="1"><input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form><?php  } ?>
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
			<a href="<?php echo Wekit::app()->baseUrl; ?>" class="home" title="<?php echo Wekit::C("site", "info.name"); ?>">首页</a><em>&gt;</em><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=like'; ?>">喜欢</a><em>&gt;</em><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike'; ?>">我的喜欢</a>
		</div>
		<div class="main cc">
			<div class="main_body">
				<div class="main_content">
					
					<div class="like_nav">
						<ul class="cc">
							<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=like'; ?>">热门喜欢</a></li>
							<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=ta'; ?>" data-referer="true" class="J_qlogin_trigger">Ta的喜欢</a></li>
							<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike'; ?>" data-referer="true" class="J_qlogin_trigger">我的喜欢</a></li>
						</ul>
					</div>
					<div class="box_wrap like_page">
					<?php  if ($logLists):?>
						<div class="like_content">
							<div id="J_like_ul" class="feed_lists">
							<?php  foreach ($logLists as $logList):
								$uid = $likeInfos[$logList['likeid']]['uid'];
								if (!isset($likeInfos[$logList['likeid']])) {
							?>
								<dl class="cc">
								 <dt class="feed_face"><img class="J_avatar" src="<?php echo htmlspecialchars(Pw::getAvatar(0, 'small'), ENT_QUOTES, 'UTF-8');?>" data-type="small" width="50" height="50" alt="游客" /></dt>
									<dd class="feed_content">
										<div class="content">原文不存在</div>
										<div class="info">
											<span class="time">喜欢于<?php echo htmlspecialchars(Pw::time2str($logList['created_time']), ENT_QUOTES, 'UTF-8');?></span><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=doDelLike&logid=', rawurlencode($logList['logid']); ?>" class="a_unlike J_unlike">取消喜欢</a>
										</div>
									</dd>
								</dl>
							 <?php  continue;}?>
								<dl class="cc">
								 <dt class="feed_face"><a class="J_user_card_show" data-uid="<?php echo htmlspecialchars($uid, ENT_QUOTES, 'UTF-8');?>" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($uid); ?>"><img  class="J_avatar" src="<?php echo htmlspecialchars(Pw::getAvatar($likeInfos[$logList['likeid']]['uid'], 'small'), ENT_QUOTES, 'UTF-8');?>" data-type="small" width="50" height="50" alt="<?php echo htmlspecialchars($likeInfos[$logList['likeid']]['username'], ENT_QUOTES, 'UTF-8');?>" /></a></dt>
									<dd class="feed_content">
									<?php  if (empty($likeInfos[$logList['likeid']]['subject'])):?>
										<div class="content"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($uid); ?>" class="name J_user_card_show" data-uid="<?php echo htmlspecialchars($likeInfos[$logList['likeid']]['uid'], ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($likeInfos[$logList['likeid']]['username'], ENT_QUOTES, 'UTF-8');?></a>：<em class="f14"><?php echo $likeInfos[$logList['likeid']]['content'];?></em></div>
										<div class="info">
											<div class="sort">
												<a class="J_group_trigger" id="J_group_trigger_<?php echo htmlspecialchars($logList['logid'], ENT_QUOTES, 'UTF-8');?>" data-id="<?php echo htmlspecialchars($logList['logid'], ENT_QUOTES, 'UTF-8');?>" href="">
													<?php  if (empty($logList['tags'])):?>
													<span class="J_group_names">未分组</span>
													<?php  else: 
 
															$_sbtagname = '';
															foreach((array)$logList['tags'] as $tag):
																if (!$tagLists[$tag]['tagname']) continue;
																$_sbtagname .= $_sbtagname ? ','. $tagLists[$tag]['tagname'] : $tagLists[$tag]['tagname'] ;
															endforeach;
														?>
														<span class="J_group_names" title="<?php echo htmlspecialchars(Pw::substrs($_sbtagname,100), ENT_QUOTES, 'UTF-8');?>">
														<?php echo htmlspecialchars(Pw::substrs($_sbtagname, 5), ENT_QUOTES, 'UTF-8');?>
														</span>
													<?php  endif; ?>
													<em class="core_arrow"></em>
												</a>
											</div>
											<span class="time">喜欢于<?php echo htmlspecialchars(Pw::time2str($logList['created_time']), ENT_QUOTES, 'UTF-8');?></span><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=doDelLike&logid=', rawurlencode($logList['logid']); ?>" class="a_unlike J_unlike">取消喜欢</a>
										</div>
									<?php  else: ?>
										<div class="content"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=space&uid=', rawurlencode($uid); ?>" class="name J_user_card_show" data-uid="<?php echo htmlspecialchars($likeInfos[$logList['likeid']]['uid'], ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($likeInfos[$logList['likeid']]['username'], ENT_QUOTES, 'UTF-8');?></a>：<em><a href="<?php echo htmlspecialchars($likeInfos[$logList['likeid']]['url'], ENT_QUOTES, 'UTF-8');?>" class="title"><?php echo htmlspecialchars($likeInfos[$logList['likeid']]['subject'], ENT_QUOTES, 'UTF-8');?></a></em></div>
										<div class="descrip"><?php echo $likeInfos[$logList['likeid']]['content'];?></div>
										<div class="info">
											<div class="sort">
												<a class="J_group_trigger" id="J_group_trigger_<?php echo htmlspecialchars($logList['logid'], ENT_QUOTES, 'UTF-8');?>" data-id="<?php echo htmlspecialchars($logList['logid'], ENT_QUOTES, 'UTF-8');?>" href="">
													<?php  if (empty($logList['tags'])):?>
													<span class="J_group_names">未分组</span>
													<?php  else: 
 
															$_sbtagname = '';
															foreach((array)$logList['tags'] as $tag):
																if (!$tagLists[$tag]['tagname']) continue;
																$_sbtagname .= $_sbtagname ? ','. $tagLists[$tag]['tagname'] : $tagLists[$tag]['tagname'] ;
															endforeach;
														?>
														
														<span class="J_group_names" title="<?php echo htmlspecialchars(Pw::substrs($_sbtagname,100), ENT_QUOTES, 'UTF-8');?>">
														<?php echo htmlspecialchars(Pw::substrs($_sbtagname, 5), ENT_QUOTES, 'UTF-8');?>
														</span>
													<?php  endif; ?>
													<em class="core_arrow"></em>
												</a>
											</div>
											<span class="time">喜欢于 <?php echo htmlspecialchars(Pw::time2str($logList['created_time']), ENT_QUOTES, 'UTF-8');?></span>&nbsp;&nbsp;<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=doDelLike&logid=', rawurlencode($logList['logid']); ?>" class="a_unlike J_unlike">取消喜欢</a>
										</div>
									<?php  endif; ?>
										<div class="fr">
											<div id="J_group_check_list_<?php echo htmlspecialchars($logList['logid'], ENT_QUOTES, 'UTF-8');?>" data-id="<?php echo htmlspecialchars($logList['logid'], ENT_QUOTES, 'UTF-8');?>" class="sort_down J_group_check_list" style="display:none;">
												<ul></ul>
												<a href="" class="add J_group_creat_show" data-id="<?php echo htmlspecialchars($logList['logid'], ENT_QUOTES, 'UTF-8');?>">创建新分类</a>
											</div>
										</div>
									</dd>
								</dl>
							<?php  endforeach; 
 $__tplPageCount=(int)$count;
$__tplPagePer=(int)$perpage;
$__tplPageTotal=(int)0;
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
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&page=', rawurlencode($_page_i); 
 echo htmlspecialchars($args ? '&' . http_build_query($args) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?>
							</div>
						</div>
					<?php  else: ?>
						<div class="like_not_tips">没有喜欢的帖子</div>
					<?php  endif; ?>
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
  if ($loginUser->isExists()) { ?>
	<div class="box_wrap">
		<h2 class="box_title J_sidebar_box_toggle">我的应用</h2>
		<div class="my_app_list">
			<ul>
				<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=vote&c=my'; ?>"><span class="icon_vote"></span>投票</a></li>
				<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike'; ?>"><span class="icon_like"></span>喜欢</a></li>
				<?php  if (Wekit::C('site','medal.isopen')){ ?>
				<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=medal'; ?>"><span class="icon_medal"></span>勋章</a></li>
				<?php }
 if (1 == Wekit::C('site', 'task.isOpen')) {?>
				<li><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=task'; ?>"><span class="icon_task"></span>任务</a></li>
				<?php }?>
			</ul>
		</div>
	</div>
<?php  } ?>
<!--advertisement id='Site.Sider.User' sys='1'/-->
<?php  
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
<?php  }} 
  if ($tagLists):?>
				<div class="box_wrap">
					<h2 class="box_title">我的喜欢分类</h2>
					<div class="side_cate_list">
						<ul id="J_side_group_list" class="cc">
						<?php  foreach ($tagLists as $tag):?>
							<li id="J_side_group_<?php echo htmlspecialchars($tag['tagid'], ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=doDelTag&tag=', rawurlencode($tag['tagid']); ?>" class="icon_del J_group_del" data-id="<?php echo htmlspecialchars($tag['tagid'], ENT_QUOTES, 'UTF-8');?>">删除</a><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=doEditTag&tag=', rawurlencode($tag['tagid']); ?>" data-name="<?php echo htmlspecialchars($tag['tagname'], ENT_QUOTES, 'UTF-8');?>" data-id="<?php echo htmlspecialchars($tag['tagid'], ENT_QUOTES, 'UTF-8');?>" class="icon_edit J_group_edit">编辑</a><a href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&tag=', rawurlencode($tag['tagid']); ?>" class="title"><span class="J_name"><?php echo htmlspecialchars($tag['tagname'], ENT_QUOTES, 'UTF-8');?></span><em>(<?php echo htmlspecialchars($tag['number'], ENT_QUOTES, 'UTF-8');?>)</em></a></li>
						<?php  endforeach; ?>
						</ul>
						<a href="" class="add" id="J_creat_group_side">创建新分类</a>
					</div>
				</div>
			<?php  endif; ?>
				<div class="box_wrap">
					<h2 class="box_title">热门喜欢</h2>
					<div class="like_hot_list">
						<ul>
						<?php  foreach ($hotBrand as $list):?>
							<li><a href="<?php echo Wekit::app()->baseUrl,'/','read.php?tid=', rawurlencode($list['fromid']); ?>"><?php echo htmlspecialchars($list['subject'], ENT_QUOTES, 'UTF-8');?></a><span class="num"><?php echo htmlspecialchars($list['counts'], ENT_QUOTES, 'UTF-8');?></span></li>         
						<?php  endforeach; ?>
						</ul>
					</div>
				</div>
			</div>
<!--===========添加分类弹窗=============--> 
	<div id="J_tag_pop" class="core_pop_wrap" style="display:none;">
		<div class="core_pop">
			<div class="pop_like_sort">
				<form id="J_tag_form" method="post" action="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=doAddTag'; ?>">
				<div class="pop_top J_drag_handle">
					<a  href="#" class="pop_close J_tag_pop_close">关闭</a>
					<strong id="J_pop_title">添加分类</strong>
				</div>
				<div class="pop_cont">
					<dl id="J_my_tag_dl" class="cc">
						<dt>我的分类：</dt>
						<dd style="max-height:150px;overflow:auto;">
							<div class="pick_list" id="J_tag_pick_list"></div>
						</dd>
					</dl>
					<dl class="cc">
						<dt>分类：</dt>
						<dd>
							<input id="J_tag_input" type="text" name="tagname" class="input length_4 mb5">
							<p class="gray" id="J_tag_tips"></p>
						</dd>
					</dl>
				</div>
				<div class="pop_bottom">
					<button id="J_tag_sub" type="submit" class="btn btn_submit">提交</button><button class="btn J_tag_pop_close">取消</button>
					<input id="J_tag_logid" type="hidden" name="logid" />
					<input id="J_tag_tagid" type="hidden" name="tagid" />
				</div>
				<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
			</div>
		</div>
	</div>
		</div>
	</div>
<ul style="display:none;" id="J_group_check_ul">
	<?php  foreach ($tagLists as $tag):?>
	<li><label><input class="J_group_name" type="checkbox" data-id="<?php echo htmlspecialchars($tag['tagid'], ENT_QUOTES, 'UTF-8');?>" data-value="<?php echo htmlspecialchars($tag['tagname'], ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($tag['tagname'], ENT_QUOTES, 'UTF-8');?></label></li>
	<?php  endforeach; ?>
</ul>
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
		<p>Powered by <a href="http://www.columbusxp.com/" target="_blank" rel="nofollow">columbusXP v<?php echo htmlspecialchars(NEXT_VERSION, ENT_QUOTES, 'UTF-8');?></a> &copy;2003-2103 <a href="http://www.columbusxp.com" target="_blank" rel="nofollow">columbusxp.com</a> <a href="http://www.columbusxp.com" target="_blank" rel="nofollow"><?php echo htmlspecialchars(Wekit::C('site','info.icp'), ENT_QUOTES, 'UTF-8');?></a></p>
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
var  GRROUP_DATA = '<?php echo WindJson::encode($likeJson, 'UTF-8');?>';
//var GRROUP_DATA = '[{"id":652,"items":[{"id":9,"value":"我喜欢的分类"},{"id":19,"value":"好东西"}]},{"id":640,"items":[{"id":19,"value":"好东西"}]}]';
Wind.use('jquery', 'global', 'dialog', 'draggable', 'ajaxForm', function(){
	
	var my_like = $('#J_my_like_list');
	$('#J_group_check_ul').data({
		'saveList' : function(elem, type, id){
			//保存分组
			Wind.Util.ajaxMaskShow();
			$.post("<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=doLogTag'; ?>", {
				logid : elem.data('id'),
				tagid : id,
				type : (type ? 1 : 0)
			}, function(data){
				Wind.Util.ajaxMaskRemove();
				if(data.state === 'success') {
					/*Wind.Util.resultTip({
						msg : '操作成功',
						follow : elem,
						callback : function(){
						}
					});*/
				}else if(data.state === 'fail') {
					Wind.Util.resultTip({
						error : true,
						follow : elem,
						msg : data.message
					});
				}
			}, 'json');
		},
		'saveCreat' : function(btn){
			//保存创建
			var creat_wrap = $('#J_group_creat_wrap'),
				check_list = btn.parents('.J_group_check_list');
			$.post("<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=doAddLogTag'; ?>", {
				tagname : $('#J_group_creat_input').val(),
				logid : check_list.data('id')
			}, function(data){
				if(data.state === 'success') {
					var _data = data.data;
					creat_wrap.remove();
					btn.show();
					
					//所有列表写入新创建分组
					$('div.J_group_check_list > ul').append('<li><label><input type="checkbox" data-id="'+ _data.id +'" data-value="'+ _data.name +'" class="J_group_name">'+ _data.name +'</label></li>');

					//选中新创建的
					var newest = check_list.find('ul > li:last input:checkbox');
					newest.prop('checked', true);
					//checkListGroup.js
					setGroupNames(newest);

					//右侧栏写入新分组
					my_like.append('<li id="J_side_group_'+ _data.id +'"><a class="icon_del J_group_del" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=doDelTag'; ?>&tag='+ _data.id +'" data-id="'+ _data.id +'">删除</a><a class="icon_edit J_group_edit" data-id="'+ _data.id +'" data-name="'+ _data.name +'" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=doEditTag'; ?>&tag='+ _data.id +'">编辑</a><a class="title" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike'; ?>&tag='+ _data.id +'"><span class="J_name">'+ _data.name +'</span><em>(1)</em></a></li>');

				}else if(data.state === 'fail'){
					Wind.Util.resultTip({
						error : true,
						follow : creat_wrap,
						msg : data.message
					});
				}
			}, 'json');
		}
	});

	$('#J_side_group_list').data({
		save : function(elem, url){
			var group_edit_input = $('#J_group_edit_input'),
				id = elem.data('id');
			$.post(url, {
				tag : id,
				tagname : elem.val()
			}, function(data){
				if(data.state === 'success') {
					var _data = data.data,
						li = $('#J_side_group_'+ id);

					if(li.length) {
						//编辑
						li.find('.J_name').text(_data.name);
						li.find('.J_group_edit').data('name', _data.name);
					}else{
						//所有列表写入新创建分组
						$('div.J_group_check_list > ul').append('<li><label><input type="checkbox" data-id="'+ _data.id +'" data-value="'+ _data.name +'" class="J_group_name">'+ _data.name +'</label></li>');

						//右侧栏写入新分组
						$('#J_side_group_list').append('<li id="J_side_group_'+ _data.id +'"><a class="icon_del J_group_del" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=doDelTag'; ?>&tag='+ _data.id +'" data-id="'+ _data.id +'">删除</a><a class="icon_edit J_group_edit" data-id="'+ _data.id +'" data-name="'+ _data.name +'" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=doEditTag'; ?>&tag='+ _data.id +'">编辑</a><a class="title" href="<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike'; ?>&tag='+ _data.id +'"><span class="J_name">'+ _data.name +'</span><em>(0)</em></a></li>');
					}
					var group_edit_wrap = $('#J_group_edit_wrap');
					group_edit_wrap.siblings('li:hidden').show();
					$('#J_creat_group_side').show();
					group_edit_wrap.remove();
				}else if(data.state === 'fail'){
					Wind.Util.resultTip({
						error : true,
						elem : elem,
						follow : true,
						msg : data.message
					});
				}
			}, 'json');
		},
		creatsave :  '<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=doAddTag'; ?>',
		editsave : '<?php echo Wekit::app()->baseUrl,'/','index.php?m=like&c=mylike&a=doEditTag'; ?>',
		deltip : '确定删除该分类？<br><span class="gray">不会将该分类的喜欢一起删除</span>'
	});

	Wind.js(GV.JS_ROOT +'pages/common/checkListGroup.js?v='+ GV.JS_VERSION);

	
	//取消喜欢
	$('a.J_unlike').on('click', function(e){
		e.preventDefault();
		var $this = $(this);
		
		$.getJSON($this.attr('href'), function(data){
			if(data.state === 'success') {
				$this.parents('dl').slideUp('slow', function(){
					$(this).remove();

					//一页取消完
					if($('#J_like_ul').children('dl').length === 0) {
						location.reload();
					}
				});
			}else{
				//global.js
				Wind.Util.resultTip({
					error : true,
					msg : data.message,
					follow : $this
				});
			}
		});
		
	});
	
});
</script>

</body>
</html>