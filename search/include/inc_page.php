<?php
/**
*
* �˷�ҳ����,�Ǵ���һ����Ŀ����������д��,ԭ��ֻ��һ������,��д��һ����,���׸����
* Ч���ǰٶȷ�ҳ������,���漰���ݿ����,
* ʵ����,��ҳ��ȷ�Ǻ����ݿ�����ֿ���
* ʹ�÷���
* $total = 50;
* $page = new Page($total);
* echo $page->show();
*
*/
class Page {
    public $total;  //��ҳ��,������,����Ҫ����ҳ�������
    public $p;         //��ǰҳ��
    public $start;     //������ʼҳ
    public $end;       //������ֹҳ
    public $url;      //��ǰ��url,���� index.php?p=
    public $display;  //�����ʾ��ҳ��,������5,����˵�����5ҳ,�ܹ���10ҳ
    public function __construct($total, $url = '?p=', $display = '5') {
        $this->total = $total;
        $this->url = $url;
        $this->display = $display;
        $this->init();
        $this->order();
    }

/**
  *��ʼ��,�����򵥵İ�ȫ����,��Ȼ,�������չ��������Դﵽ���Ҫ��
  */
    public function init() {
        //��ȡ��ǰ��ҳ��
        $this->p = (@$_GET['p'] + 0 <= 0)? 1: (@$_GET['p'] + 0);
        if (!is_int($this->p)) {
            $this->p = 1;
        }
        //���������ҳ��������һ���ϴ����,�������������,��ʾ���һҳ
        //������Լ���չΪ"��ǰû�����ҵ���ҳ",�������ȥ��,��show������Ӹ��жϾ�����
        if ($this->p >= $this->total) {
            $this->p = $this->total;
        }
    } 
    /**
     *���ｫ����ô��ʾΪ�ٶȷ�ҳ������Ч��,��Ȼ,�Ѿ�������
     *���оֲ�û�д����,���������鷳������
     */
     public function order() {
        if ($this->total <= 2 * $this->display) {
            $this->start = 1;
            $this->end = $this->total;
        } else {
            if ($this->p <= $this->display) {
                $this->start = 1;
                $this->end = 2 * $this->display;
            } else {
                if ($this->p > $this->display && ($this->total - $this->p >= $this->display - 1)) {
                    $this->start = $this->p - $this->display;
                    $this->end = $this->p + $this->display - 1;
                } else {
                    $this->start = $this->total - 2 * $this->display + 1;
                    $this->end = $this->total;
                }
            }
        }
    }
    public function show() {
        //���û������,��ȻҲ��û�з�ҳ��
        if ($this->total <= 1) {
            return false;
			//exit;
        }
        else
		     {
               $re = '';  
               // $preǰһҳ $next ��һҳ
               // $re .= "<a href=\"{$this->url}1\">��ҳ</a>";
               $pre = ($this->p - 1 <= 0) ? 1 : ($this->p - 1);
               $re .= "<a href=\"{$this->url}$pre\">ǰһҳ</a>&nbsp;";
               //�����ǰҳ�ǵ�һҳ,��Ҫ��ҳ��ǰһҳ
               if ($this->p == 1) {
                   $re = '';
               }
               for ($i = $this->start; $i <= $this->end; $i++) {
                   $re .= ($i == $this->p)? "$i ": "<a href=\"{$this->url}$i\">[$i]</a>&nbsp;";
               }
  
               $next = ($this->p + 1 >= $this->total) ? $this->total : ($this->p + 1);
               //��ǰҳ�����һҳ��ҳ��,��Ҫ��һҳ�����һҳ
               if ($this->p != $this->total) {
                   $re .= "<a href=\"{$this->url}$next\">��һҳ</a>";
                  // $re .= "<a href=\"{$this->url}$this->total\">���һҳ</a>";
               }   
                return $re;
		   }
    }
}
?>