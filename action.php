<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<?php
include("data/conn.php");
if($_REQUEST["act"]=="add"){
	$content=str_replace("'","&#39",trim($_REQUEST["content"]));
	$time=time();
	$sql="insert into contactus(content,sdate) values('$content','$time')";
	$db->query($sql);
	echo"<script  language=\"javascript\">";
	echo"alert(\"�����������ύ�����Ǿ���Ϊ�㴦��\");";
	echo"document.location.href=\"http://www.or58.com\"";;
	echo"</script>";
}
?>


