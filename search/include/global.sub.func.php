<?php
function foothtml()
{
   global $zeigou;
?>
<div id="ft"><?php echo $zeigou["copyright"];?> <span>������ϵ<?php echo $config["name"];?>��������ָ���Զ������Ľ����������<?php echo $zeigou["name"];?>�޳ɱ�������վ�����ݻ�����&nbsp;
������� <a target="_blank" href="http://www.somao123.com">��è</a>
</span></div>
</body>
</html>
</html>
<div id="statcode"><?php echo $zeigou["statcode"];?></div>
<?php
}//end foothtml
?>
<?php
function RightAd()
{
    global $db,$wd,$wd_en,$tg,$zeigou;
?>
<table width="30%" border="0" cellpadding="0" cellspacing="0" align="right"><tr>
<td align="left" style="padding-right:10px">
<div style="border-left:1px solid #e1e1e1;padding-left:10px;word-break:break-all;word-wrap:break-word;">
<div id="ec_im_container">
<div>

</div>
<?php
$query_ad=$db->query("select * from ve123_ad where type='2' and is_show limit 5");
while($row_ad=$db->fetch_array($query_ad))
{
?>
<div class="r" id="bdfs0">

<a id=dfs0 href='<?php echo $row_ad["siteurl"];?>' target='_blank' onMouseOver="return ss('������ <?php echo $zeigou["url"];?>')" onMouseOut="cs()">

<font size="3"><?php echo $row_ad["title"];?></font>

</a><br>

<span id="bdfs0"><font size="-1" color="#000000"><?php echo $row_ad["content"];?></font><br>
<a href='<?php echo $row_ad["siteurl"];?>' target="_blank"><font size="-1" color="#008000"><?php echo  str_cut($row_ad["siteurl"],38);?></font></a>
</span>

</div><br>
<?php
}
?>
</div>

<table border=0 cellpadding=0 cellspacing=0  style="width:240px;border-left: #EFF2FA 1px solid; border-right: #EFF2FA 1px solid;border-bottom: #EFF2FA 1px solid; font-size: 12px; color: #333333;background-color: #EFF2FA;"><tr><td style="table-layout:fixed;word-break:break-all;border-top: #7593E5 1px solid;background-color: #EFF2FA;padding-left:10px;line-height:24px;">
�ٷ���ʾ��ַ:<a href="http://www.somao123.com/" target="_blank">http://www.somao123.com/</a><br>
�ٷ����۵�ַ:<a href="http://www.somao123.com/" target="_blank">http://www.somao123.com</a>
</td>
</tr></table>
<DIV id=ScriptDiv></DIV>
</div>
</td></tr></table>

<?php
}//end RightAd
?>