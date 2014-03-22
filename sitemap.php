<?
if (ob_get_level() == 0) ob_start();
set_time_limit(0);
$config_path=dirname(__FILE__)."/";
include_once("data/conn.php");
echo date("H:i:s")."<br>";
class sitemap{
	var $db;
	var $dir,$changefreq,$priority,$docfile,$url;	
	function map(){
		$str.="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
		$str.="<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n";		
		foreach($this->url as $key=>$value){
		  $str.="<url>\n";
		  $str.="<loc>$value</loc>\n";
		 // $str.="<lastmod>".utf8_encode(date("Y-m-d\TH:i:s"). substr(date("O"),0,3) . ":" . substr(date("O"),3))."</lastmod>\n";
		  $str.="<changefreq>".$this->changefreq."</changefreq>\n";
		  $str.="<priority>".$this->priority."</priority>\n";
		  $str.="</url>\n";
		}
		$str.="</urlset>\n";

		$handle=fopen($this->dir.$this->docfile,"w+");
		if(!$handle){
			mkdir($this->dir);			
		}
		fwrite($handle,$str);
	}
	
	function __set($name,$value){         
       $this->$name=$value;     
    }
	function __get($name){
		return $this->$name;
	}
}
$result=$db->query("select * from p8_fenlei_city");
$j=1;
$k=0;
$xml=new sitemap();
$b[0]="http://www.or58.com/allcity.xml";
$num=1;
$sum=1;
while($rows=$result->fetchRow()){
	$list=$db->getCol("select dir_name as name from p8_fenlei_sort");
	if($num%50==0){
		$i=0;
	}
	foreach($list as $key=>$val){
		$a[$i++]=$rows["domain"]."/".$val."/";
	}
	/*********** 栏录xml生成****************/
	if($num%50==0){//50个城市一组
		$xml->db=$db;
		$xml->url=$a;
		$xml->changefreq="always";
		$xml->priority=0.6;
		$xml->docfile=$sum.".xml";
		$xml->map();
		echo $sum."xml<br>";
		ob_flush();
		flush();
		$sum++;
	}
	$c[$k++]=$rows["domain"];	
	$num++;
}
   
   
    /***********所有城市xml生成****************/
	$xml->url=$c;
	$xml->changefreq="hourly";
	$xml->priority=0.8;
	$xml->docfile="sitemap.xml";
	$xml->map();
	
  /***********sitemap xml生成****************/
	/*
	$xml->url=$b;
	$xml->changefreq="always";
	$xml->priority=0.8;
	$xml->docfile="sitemap.xml";
	$xml->map();
	echo "<br>共生成了$j xml";
	*/
	
?>


