<!doctype html>
<html>
<head>
<?php  if(!$action){ ?>
<meta http-equiv="refresh" content="2; url=<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=upgrade&a=check'; ?>" />
<?php  } ?>
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
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=upgrade'; ?>">版本升级</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=fixup'; ?>">安全中心</a></li>
		</ul>
	</div>
	<div class="tips">
	<?php  if(isset($disable)){ ?>
	通信失败，无法在线升级，请手动升级
	<?php  }else{ 
  if($action){ ?>
	检测到您上次的升级操作未完成，是否继续上次操作？
	<p><a href="<?php echo WindUrlHelper::createUrl('appcenter/upgrade/'.$action);?>" class="btn">继续升级</a>
	<?php  if($recheck){ ?>
	<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=upgrade&a=check'; ?>" class="btn">重新检测</a></p>
	<?php  } } else { ?>
    正在检测可升级版本，请稍候…
    <p>如果您的浏览器没有自动跳转，<a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=appcenter&c=upgrade&a=check'; ?>">请点击这里</a></p>
	<?php  }} ?>
	</div>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
<script>

</script>
</html>