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
<body class="J_scroll_fixed">
<div class="wrap jj">
	<div class="nav">
		<div class="return"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=manage'; ?>">返回上一级</a></div>
		<ul class="cc">
			<li class="current"><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?uid=', rawurlencode($uid),'&m=u&c=manage&a=edit'; ?>">编辑</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?uid=', rawurlencode($uid),'&m=u&c=manage&a=editCredit'; ?>">积分</a></li>
			<li><a href="<?php echo Wekit::app()->baseUrl,'/','admin.php?uid=', rawurlencode($uid),'&m=u&c=manage&a=editGroup'; ?>">用户组</a></li>
		</ul>
	</div>
<!--====================用户编辑开始====================-->
<form class="J_ajaxForm" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=u&c=manage&a=doEdit'; ?>" method="post">
<input type="hidden" value="<?php echo htmlspecialchars($uid, ENT_QUOTES, 'UTF-8');?>" name="uid"/>
<div class="h_a">用户信息</div>
<div class="table_full">
	<table width="100%">
		<col class="th" />
		<col/>
		<thead>
		<tr>
			<th>UID</th>
			<td><?php echo htmlspecialchars($uid, ENT_QUOTES, 'UTF-8');?></td>
		</tr>
		</thead>
		<tr>
			<th>用户名</th>
			<td><input name="username" type="text" class="input input_hd length_5" value="<?php echo htmlspecialchars($info['username'], ENT_QUOTES, 'UTF-8');?>"></td>
		</tr>
		<tr>
			<th>头像</th>
			<td><div><img id="J_face_img" class="J_avatar" data-type="middle" src="<?php echo htmlspecialchars(Pw::getAvatar($info['uid']), ENT_QUOTES, 'UTF-8');?>?t=<?php echo htmlspecialchars(Pw::getTime(), ENT_QUOTES, 'UTF-8');?>" class="face"></div><a id="J_set_def" href="<?php echo Wekit::app()->baseUrl,'/','admin.php?uid=', rawurlencode($info['uid']),'&m=u&c=manage&a=defaultAvatar'; ?>">[恢复为系统头像]</a></td>
		</tr>
		<tr>
			<th>新密码</th>
			<td><input name="password" type="text" class="input length_5"></td>
		</tr>
		<tr>
			<th>确认密码</th>
			<td><input name="repassword" type="text" class="input length_5"></td>
		</tr>
		<tr>
			<th>安全问题</th>
			<td>
				<select name="question" class="select_5">
					<option value="-1">不修改安全问题和答案</option>
					<option value="-2">取消安全问题和答案</option>
				</select>
			</td>
		</tr>
		<tr style="display:none">
			<th>安全问题答案</th>
			<td>
				<input name="answer" type="text" class="input length_5" value="<?php echo htmlspecialchars($info['answer'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>

		<tr>
			<th>注册时间</th>
			<td>
				<input name="regdate" type="text" class="input length_5 J_datetime date" value="<?php echo htmlspecialchars(Pw::time2str($info['regdate'], 'Y-m-d H:i:s'), ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
		<tr>
			<th>注册IP</th>
			<td>
				<input name="regip" type="text" class="input length_5" value="<?php echo htmlspecialchars($info['regip'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
		<tr>
			<th>最后登录时间</th>
			<td>
				<?php echo htmlspecialchars(Pw::time2str($info['lastvisit'], 'Y-m-d H:i:s'), ENT_QUOTES, 'UTF-8');?>
			</td>
		</tr>
		<tr>
			<th>在线时间（小时）</th>
			<td>
				<input name="online" type="text" class="input length_5" value="<?php echo htmlspecialchars($online, ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
	</table>
	</div>
<div class="h_a">基本资料</div>
<div class="table_full">
	<table width="100%">
		<col class="th" />
		<col/>
		<tr>
			<th>真实姓名</th>
			<td><input name="realname" type="text" class="input input_hd length_5" value="<?php echo htmlspecialchars($info['realname'], ENT_QUOTES, 'UTF-8');?>"></td>
		</tr>
		<tr>
			<th>性别</th>
			<td>
				<select name="gender" class="select_5">
					<option value="1" <?php echo htmlspecialchars(Pw::isSelected($info['gender'] == 1), ENT_QUOTES, 'UTF-8');?>>女</option>
					<option value="0" <?php echo htmlspecialchars(Pw::isSelected($info['gender'] == 0), ENT_QUOTES, 'UTF-8');?>>男</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>生日</th>
			<td>
				<input name="birthday" type="text" class="input length_5 J_date" value="<?php echo htmlspecialchars($info['byear'], ENT_QUOTES, 'UTF-8');?>-<?php echo htmlspecialchars($info['bmonth'], ENT_QUOTES, 'UTF-8');?>-<?php echo htmlspecialchars($info['bday'], ENT_QUOTES, 'UTF-8');?>" min="<?php echo htmlspecialchars($bmin, ENT_QUOTES, 'UTF-8');?>" max="<?php echo htmlspecialchars($bmax, ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
		<tr>
			<th>现居住地</th>
			<td class="J_region_set">
				<span>
				<span class="J_province"><?php echo htmlspecialchars($location[0]['name'], ENT_QUOTES, 'UTF-8');?></span> <span class="J_city"><?php echo htmlspecialchars($location[1]['name'], ENT_QUOTES, 'UTF-8');?></span> <span class="J_district"><?php echo htmlspecialchars($location[2]['name'], ENT_QUOTES, 'UTF-8');?></span></span>
				<a data-pid="<?php echo htmlspecialchars($location[0]['areaid'], ENT_QUOTES, 'UTF-8');?>" data-cid="<?php echo htmlspecialchars($location[1]['areaid'], ENT_QUOTES, 'UTF-8');?>" data-did="<?php echo htmlspecialchars($location[2]['areaid'], ENT_QUOTES, 'UTF-8');?>" href="" class="J_region_change">更改</a>
				<input class="J_areaid" type="hidden" name="location" value="<?php echo htmlspecialchars($info['location'], ENT_QUOTES, 'UTF-8');?>" />
			</td>
		</tr>
		<tr>
			<th>家乡</th>
			<td class="J_region_set">
				<span>
				<span class="J_province"><?php echo htmlspecialchars($hometown[0]['name'], ENT_QUOTES, 'UTF-8');?></span> <span class="J_city"><?php echo htmlspecialchars($hometown[1]['name'], ENT_QUOTES, 'UTF-8');?></span> <span class="J_district"><?php echo htmlspecialchars($hometown[2]['name'], ENT_QUOTES, 'UTF-8');?></span></span>
				<a data-pid="<?php echo htmlspecialchars($hometown[0]['areaid'], ENT_QUOTES, 'UTF-8');?>" data-cid="<?php echo htmlspecialchars($hometown[1]['areaid'], ENT_QUOTES, 'UTF-8');?>" data-did="<?php echo htmlspecialchars($hometown[2]['areaid'], ENT_QUOTES, 'UTF-8');?>" href="" class="J_region_change">更改</a>
				<input class="J_areaid" type="hidden" name="hometown" value="<?php echo htmlspecialchars($info['hometown'], ENT_QUOTES, 'UTF-8');?>" />
			</td>
		</tr>
		<tr>
			<th>个人主页</th>
			<td>
				<input name="homepage" type="text" class="input length_5" value="<?php echo htmlspecialchars($info['homepage'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
		<tr>
			<th>自我简介</th>
			<td>
				<textarea class="length_5" name="profile"><?php echo htmlspecialchars($info['profile'], ENT_QUOTES, 'UTF-8');?></textarea>
			</td>
		</tr>
	</table>
	</div>
<div class="h_a">交易信息</div>
<div class="table_full">
	<table width="100%">
		<col class="th" />
		<col/>
		<tr>
			<th>支付宝</th>
			<td>
				<input name="alipay" type="text" class="input length_5" value="<?php echo htmlspecialchars($info['alipay'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
		<tr>
			<th>手机号码</th>
			<td>
				<input name="mobile" type="text" class="input length_5" value="<?php echo htmlspecialchars($info['mobile'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
		<tr>
			<th>固定电话</th>
			<td>
				<input name="telphone" type="text" class="input length_5" value="<?php echo htmlspecialchars($info['telphone'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
		<tr>
			<th>邮寄地址</th>
			<td>
				<input name="address" type="text" class="input length_5" value="<?php echo htmlspecialchars($info['address'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
		<tr>
			<th>邮编</th>
			<td>
				<input name="zipcode" type="text" class="input length_5" value="<?php echo htmlspecialchars($info['zipcode'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
	</table>
	</div>
<div class="h_a">联系信息</div>
<div class="table_full">
	<table width="100%">
		<col class="th" />
		<col/>
		<tr>
			<th>电子邮箱</th>
			<td>
				<input name="email" type="email" class="input length_5" value="<?php echo htmlspecialchars($info['email'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
		<tr>
			<th>阿里旺旺</th>
			<td>
				<input name="aliww" type="text" class="input length_5" value="<?php echo htmlspecialchars($info['aliww'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
		<tr>
			<th>QQ</th>
			<td>
				<input name="qq" type="text" class="input length_5" value="<?php echo htmlspecialchars($info['qq'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
		<tr>
			<th>MSN</th>
			<td>
				<input name="msn" type="email" class="input length_5" value="<?php echo htmlspecialchars($info['msn'], ENT_QUOTES, 'UTF-8');?>">
			</td>
		</tr>
	</table>
	</div>
<div class="h_a">其他</div>
<div class="table_full">
	<table width="100%">
		<col class="th" />
		<col/>
		<tr>
			<th>工作经历</th>
			<td>
				<?php foreach ($workList as $_item) {?>
					<p style="line-height:26px;">于<?php echo htmlspecialchars($_item['starty'], ENT_QUOTES, 'UTF-8');?>年<?php echo htmlspecialchars($_item['startm'], ENT_QUOTES, 'UTF-8');?>月在《<?php echo htmlspecialchars($_item['company'], ENT_QUOTES, 'UTF-8');?>》工作至<?php if(!$_item['endy']){?>今<?php }else{
 echo htmlspecialchars($_item['endy'], ENT_QUOTES, 'UTF-8');?>年<?php echo htmlspecialchars($_item['endm'], ENT_QUOTES, 'UTF-8');?>月<?php }?></p>
				<?php }?>
			</td>
		</tr>
		<tr>
			<th>教育经历</th>
			<td>
				<?php foreach ($educationList as $_item) {?>
					<p style="line-height:26px;">于<?php echo htmlspecialchars($_item['start_time'], ENT_QUOTES, 'UTF-8');?>年就读于《<?php echo htmlspecialchars($_item['school'], ENT_QUOTES, 'UTF-8');?>》，学历<?php echo htmlspecialchars($_item['degree'], ENT_QUOTES, 'UTF-8');?></p>
				<?php }?>
			</td>
		</tr>
	</table>
	</div>
	
	<div class="btn_wrap">
		 <div class="btn_wrap_pd">
				<button type="submit" class="btn btn_submit J_ajax_submit_btn">提交</button>
		 </div>
	</div>
<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>

</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
Wind.use('region', function(){
	$('a.J_region_change').region();

	//恢复默认头像
	$('#J_set_def').on('click', function(e){
		e.preventDefault();
		var $this = $(this);
		$.post(this.href, function(data){
			if(data.state == 'success') {
				$('#J_face_img').attr('src', '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>/face/face_middle.jpg');
				$this.hide();
			}else{
				//common.js
				resultTip({
					error : true,
					msg : data.message[0]
				});
			}
		}, 'json');
	});
});
</script>
</body>
</html>