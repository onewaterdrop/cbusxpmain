<?php
function headhtml()
{
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ޱ����ĵ�</title>
<link rel="stylesheet" href="images/maincss.css">
<script language="javascript">
function CheckAll(form,name)
  {
  for (var i=0;i<form.elements.length;i++)
    {
    var e = form.elements[i];
    if (e.name == name)
       e.checked = form.chkall.checked;
    }
  }
function checklistform()
{
var do_action;
var obj = document.getElementsByName("do_action"); //������Ա�ǩ��name��ȡ�ؼ� 
                 for(i=0; i<obj.length;i++)    { 
                  if(obj[i].checked){ 
                          do_action=obj[i].value; 
                   }
              } 
  //if(do_action=="undefined"){alert("��ѡ��");return false;};
  if(do_action=="del")
  {
       if(!confirm("ȷ��ɾ����?"))
	   {
	       return false;
	   }
  }
}
</script>
</head>

<body>
<?php
}
?>
<?php
function foothtml()
{
?>
<div style="text-align:center;"><a target="_blank" href="http://www.zeidu.com/"><font color="#666666">Powered by zeidu</font></a></div>
</body>
</html>
<?php
}
?>
<?php
function tips($msg)
{
    $tips_html="��è��ʾ:".$msg;
	return $tips_html;
}
?>