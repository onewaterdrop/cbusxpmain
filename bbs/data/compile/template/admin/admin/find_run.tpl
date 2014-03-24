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

<!--搜索开始-->
	<div class="h_a">有关“<span class="red"><?php echo htmlspecialchars($keyword, ENT_QUOTES, 'UTF-8');?></span>”的搜索结果</div>
	<div class="search_list">
		<?php  if($result){ 
  foreach($result as $k=>$v) { ?>
			<h2><a class="J_search_items" href="<?php echo $v['url'];?>&searchword=<?php echo htmlspecialchars($keyword, ENT_QUOTES, 'UTF-8');?>" data-id="<?php echo $k;?>" data-parent="<?php echo $v['parent'];?>" data-level="<?php echo htmlspecialchars($v['level'], ENT_QUOTES, 'UTF-8');?>"><?php echo $v['name'];?></a></h2>
			<?php  if($v['items']){
				foreach($v['items'] as $v2){
			?>
			<dl>
				<dd><?php echo $v2;?></dd>
			</dl>
				<?php  } 
  } 
  if ($v['sub']) {
			 ?>
			<dl>
				<?php  foreach($v['sub'] as $v2){ ?>
				<dt><a class="J_search_items" href="<?php echo $v2['url'];?>&searchword=<?php echo htmlspecialchars($keyword, ENT_QUOTES, 'UTF-8');?>" data-id="<?php echo $k;?>" data-parent="<?php echo $v['parent'];?>" data-level="<?php echo htmlspecialchars($v['level'], ENT_QUOTES, 'UTF-8');?>"><?php echo $v2['name'];?></a></dt>
					<?php  foreach($v2['items'] as $v3){ ?>
				<dd><?php echo $v3;?></dd>
					<?php  } 
  } ?>
			</dl>
			<?php  } 
  
			}
		} else { ?>
		<dl>
			<dt><span class="red">没有找到相关内容</span></dt>
		</dl>
		<?php  } ?>
	</div>

<!--搜索结束-->

</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
$(function(){
	var par_win = parent.window,
		par_doc = $(par_win.document),
		par_menu_main = par_doc.find('#J_B_main_block'),	//顶部导航
		par_menu_side = par_doc.find('#B_menubar'),			//左侧导航
		_SUBMENU_CONFIG = parent.window.SUBMENU_CONFIG,		//导航数据
		href = '';

	$('a.J_search_items').on('click', function(e){
		e.preventDefault();
		var $this = $(this),
			id = $this.data('id'),						//id
			par = $this.data('parent'),					//父导航id
			level = parseInt($this.data('level'));		//二级三级导航标识

		href = this.href;
		eachSubmenu(_SUBMENU_CONFIG, id, par, level);
	});



	//查询导航数据
	function eachSubmenu(data, id, par, level){
		for(i in data) {
			if(level == 2) {
				if(i == par) {
					//一级
					setMenuMain(par_menu_main.find('a[data-id='+ par +']'));
					eachSubmenu(data[par]['items'], id, par, level);
					break;
				}else if(i == id){
					//二级
					setMenuSide(data, id, par, level);
				}

			}else if(level == 3) {
				if(i == par) {
					//匹配父导航
					var root = data[i]['parent'];
					setMenuMain(par_menu_main.find('a[data-id='+ data[i]['parent'] +']'));
					setMenuSide(_SUBMENU_CONFIG[root]['items'], id, par, level);
					break;
				}else{
					//父导航不匹配
					var items = data[i]['items'];
					if(items) {
						eachSubmenu(items, id, par, level)
					}

				}
			}
			
			
		}
	}

	//设置顶部导航
	function setMenuMain(elem){
		elem.parent().addClass('current').siblings().removeClass('current');
	}

	//设置左侧导航
	function setMenuSide(data, id, par, level){

		var arr  = [],			//左侧一级导航数据
			child_arr = [];		//左侧二级导航数据

		//循环数据
		$.each(data, function(i, o){
			var cls = (o.id == id ? 'current' : '');
			
			//添加一级数据
			arr.push('<dt class="'+ cls +'"><a href="'+ o.url +'" data-id="'+ o.id +'">'+ o.name +'</a></dt>');

			if(level == 3 && i == par){
				//进入二级导航
				$.each(o['items'], function(i, o){
					child_arr.push('<li><a href="'+ o.url +'" data-id="'+ o.id +'">'+ o.name +'</a></li>');
				});

				var style = (o.id == par ? '' : 'display:none;');

				//并入一级
				arr.push('<dd style="'+ style +'"><ul>'+child_arr.join('')+'</ul></dd>');
			}
			
		});

		//show_left_menu(data_list['items']);
		par_menu_side.html(arr.join('')).attr('data-id', par);

		////检查是否应该出现上一页、下一页
		par_win.checkMenuNext();

		var side_item = par_doc.find('a[data-id='+ id +']');

		//点击导航展开iframe
		par_win.iframeJudge({
			elem : side_item,
			href : href,
			id : id
		});
		
	}

});
</script>
</body>
</html>