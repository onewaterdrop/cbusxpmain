<?php
require "global.php";
headhtml();
?>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="tablebg">
  <tr>
    <th width="50">&nbsp;</th>
    <th>IP</th>
    <th>����ʱ��</th>
    <th>���õ�ַ</th>
  </tr>
<?php
  $sql="select * from ve123_stat_visitor ";//echo $sql;
  $result=$db->query($sql);
  $total=$db->num_rows($result);//��¼����
  $pagesize=30;//ÿҳ��ʾ��
  $totalpage=ceil($total/$pagesize);
  $page=intval($_GET["page"]);
  if($page<=0){$page=1;}
  $offset=($page-1)*$pagesize;
  $result=$db->query($sql." order by v_id desc limit $offset,$pagesize");
    while($row=$db->fetch_array($result))
  {
?>
  <tr>
    <td>&nbsp;</td>
    <td><?php echo $row["v_ip"];?></td>
    <td><?php echo $row["v_time"];?></td>
    <td><?php echo $row["http_referer"];?></td>
  </tr>
    <?php
  }
  ?>
</table>
<?php
echo pageshow($page,$totalpage,$total,"?");
?>
