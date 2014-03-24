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


	<div class="h_a">消息群发</div>
	<form id="J_message_form" action="<?php echo Wekit::app()->baseUrl,'/','admin.php?m=message&c=manage&a=doSend'; ?>" method="post">
	<div class="table_full">
		<table width="100%">
			<col class="th" />
			<col width="400" />
			<col />
			<tr>
				<th>接收用户</th>
				<td>
					<ul class="single_list cc J_radio_change">
						<li><label><input data-arr="J_usergroup" type="radio" name="type" checked="checked" value="1">按用户组</label></li>
						<li><label><input data-arr="J_username" type="radio" name="type" value="2">按用户名</label></li>
						<li><label><input data-arr="" type="radio" name="type" value="3">所有在线用户</label></li>
					</ul>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
		</table>
<!--=============用户组===============-->
		<table width="100%" id="J_usergroup" class="J_radio_change_items" style="margin:0;">
			<col class="th" />
			<col width="400" />
			<col />
			<tbody>
				<tr>
					<th>用户组</th>
					<td>
						<ul class="three_list cc mb10 J_radio_change" data-rel=".J_usergroup_items">
							<li><label><input type="radio" data-arr="J_memberid" name="grouptype" checked="checked" value="memberid"><span>普通会员组</span></label></li>
							<li><label><input type="radio" data-arr="J_groupid"  name="grouptype" value="groupid"><span>其他会员组</span></label></li>
						</ul>
						<div class="user_group J_check_wrap">
							<div id="J_memberid" style="margin:0;" class="J_usergroup_items" >
						<?php foreach($memberGroupTypes as $type => $typeName){ ?>
								<dl>
									<dt><label><input class="J_check_all" data-direction="y" data-checklist="J_check_<?php echo htmlspecialchars($type, ENT_QUOTES, 'UTF-8');?>" type="checkbox" /><?php echo htmlspecialchars($typeName, ENT_QUOTES, 'UTF-8');?></label></dt>
									<dd>
						<?php foreach($members as $group){ 
							if($group['type'] == $type){
							?>
										<label><input class="J_check" data-yid="J_check_<?php echo htmlspecialchars($type, ENT_QUOTES, 'UTF-8');?>" type="checkbox" name="user_groups[]" value="<?php echo htmlspecialchars($group['gid'], ENT_QUOTES, 'UTF-8');?>" /><span><?php echo htmlspecialchars($group['name'], ENT_QUOTES, 'UTF-8');?></span></label>
						<?php } }?>
									</dd>
								</dl>
						<?php }?>
							</div>
							<div id="J_groupid" style="margin:0;display:none;" class="J_usergroup_items" >
						<?php foreach($groupGroupTypes as $type => $typeName){ ?>
								<dl>
									<dt><label><input class="J_check_all" data-direction="y" data-checklist="J_check_<?php echo htmlspecialchars($type, ENT_QUOTES, 'UTF-8');?>" type="checkbox" /><?php echo htmlspecialchars($typeName, ENT_QUOTES, 'UTF-8');?></label></dt>
									<dd>
						<?php foreach($othergroup as $group){ 
							if($group['type'] == $type){
							?>
										<label><input class="J_check" data-yid="J_check_<?php echo htmlspecialchars($type, ENT_QUOTES, 'UTF-8');?>" type="checkbox" name="user_groups[]" value="<?php echo htmlspecialchars($group['gid'], ENT_QUOTES, 'UTF-8');?>" /><span><?php echo htmlspecialchars($group['name'], ENT_QUOTES, 'UTF-8');?></span></label>
						<?php } }?>
									</dd>
								</dl>
						<?php }?>
							</div>
						</div>
					</td>
					<td><div class="fun_tips"></div></td>
				</tr>
			</tbody>
		</table>
<!--=============用户名===============-->
		<table width="100%" id="J_username" class="J_radio_change_items" style="margin:0;display:none;">
			<col class="th" />
			<col width="400" />
			<col />
			<tbody>
				<tr>
					<th>用户名</th>
					<td>
						<input type="text" class="input length_5" name="touser">
					</td>
					<td><div class="fun_tips">多个用户名用空格分开</div></td>
				</tr>
			</tbody>
		</table>
		<table width="100%">
			<col class="th" />
			<col width="400" />
			<col />
			<tr>
				<th>标题</th>
				<td>
					<input type="text" class="input length_6" name="title">
				</td>
				<td></td>
			</tr>
<!--=============切换结束===============-->
			<tr>
				<th>内容</th>
				<td>
					<textarea class="length_6" style="height:150px;" name="content"></textarea>
				</td>
				<td><div class="fun_tips">支持html代码</div></td>
			</tr>
		</table>
	</div>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<input id="J_step_input" type="hidden" name="step" value="<?php echo htmlspecialchars($step, ENT_QUOTES, 'UTF-8');?>">
			<input id="J_countStep_input" type="hidden" name="countStep" value="<?php echo htmlspecialchars($countStep, ENT_QUOTES, 'UTF-8');?>">
			<button id="J_message_submit_btn" class="btn btn_submit" type="submit">提交</button>
			<div id="J_message_send_tip"></div>
		</div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>

</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
Wind.use('dialog', 'ajaxForm', function() { 
	
	var btn = $('#J_message_submit_btn'),	//提交按钮
		message_send_tip = $('#J_message_send_tip');
	
	$('#J_message_form').ajaxForm( {
		dataType : 'json',
		beforeSubmit : function(arr, $form, options) {
			//btn.prop('disabled',true).addClass('disabled');
			
		},
		success : function(data, statusText, xhr, $form) {
			btn.parent().find('span').remove();
			if( data.state === 'fail' ) {
				$( '<span class="tips_error">' + data.message + '</span>' ).insertAfter(btn).fadeIn( 'fast' );
				//btn.removeProp('disabled').removeClass('disabled');
			}else{
				if( data.state === 'success' ) {
					//完成
					$( '<span class="tips_success">' + data.message + '</span>' ).insertAfter(btn).fadeIn('slow').delay( 1000 ).fadeOut(function() {

						if(window.parent.Wind.dialog) {
							reloadPage(window.parent);
						}else {
							reloadPage(window);
						}
							
					});
				}else{
					//队列
					var _data = data.data;
					if(_data.haveBuild <= Number(_data.count)) {
						$('#J_step_input').val(_data.step);
						$('#J_countStep_input').val(_data.countStep);
						message_send_tip.html('共'+ _data.count +'条，已发送'+_data.haveBuild)
						btn.click();
						//console.log(_data.step);
					}
				}
			}
		}
	});
});
</script>
</body>
</html>