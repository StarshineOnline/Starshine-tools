<?php
//header("Content-type: image/png"); 

$mydir = "./texture/";
$Angle_Choisi = "NE";

switch($Angle_Choisi)
{
	case "NE" :	$angle = -45;	break;
	case "NO" :	$angle = 45;	break;
	case "SE" :	$angle = -90;	break;
	case "SO" :	$angle = 90;	break;
	default	:	$angle = -45; 	break;
}

function imageRotate2($src_img, $angle, $bicubic=false) 
{
 
   // convert degrees to radians
   $angle = $angle + 180;
   $angle = deg2rad($angle);
 
   $src_x = imagesx($src_img);
   $src_y = imagesy($src_img);
 
   $center_x = floor($src_x/2);
   $center_y = floor($src_y/2);

   $cosangle = cos($angle);
   $sinangle = sin($angle);

   $corners=array(array(0,0), array($src_x,0), array($src_x,$src_y), array(0,$src_y));

   foreach($corners as $key=>$value) 
   {
     $value[0]-=$center_x;        //Translate coords to center for rotation
     $value[1]-=$center_y;
     $temp=array();
     $temp[0]=$value[0]*$cosangle+$value[1]*$sinangle;
     $temp[1]=$value[1]*$cosangle-$value[0]*$sinangle;
     $corners[$key]=$temp;   
   }
  
   $min_x=1000000000000000;
   $max_x=-1000000000000000;
   $min_y=1000000000000000;
   $max_y=-1000000000000000;
  
   foreach($corners as $key => $value) 
   {
     if($value[0]<$min_x)
       $min_x=$value[0];
     if($value[0]>$max_x)
       $max_x=$value[0];
  
     if($value[1]<$min_y)
       $min_y=$value[1];
     if($value[1]>$max_y)
       $max_y=$value[1];
   }

   $rotate_width=round($max_x-$min_x);
   $rotate_height=round($max_y-$min_y);

   $rotate=imagecreatetruecolor($rotate_width,$rotate_height);
   imagealphablending($rotate, false);
   imagesavealpha($rotate, false);

   //Reset center to center of our image
   $newcenter_x = ($rotate_width)/2;
   $newcenter_y = ($rotate_height)/2;

	for ($y = 0; $y < ($rotate_height); $y++) 
	{
		for ($x = 0; $x < ($rotate_width); $x++) 
		{
			// rotate...
			$old_x = round((($newcenter_x-$x) * $cosangle + ($newcenter_y-$y) * $sinangle)) + $center_x;
			$old_y = round((($newcenter_y-$y) * $cosangle - ($newcenter_x-$x) * $sinangle)) + $center_y;

			if ( $old_x >= 0 && $old_x < $src_x && $old_y >= 0 && $old_y < $src_y ) 
			{
				$color = imagecolorat($src_img, $old_x, $old_y);
			}
			else 
			{
				// this line sets the background colour
				$color = imagecolorallocatealpha($src_img, 255, 255, 255, 127);
			}
			imagesetpixel($rotate, $x, $y, $color);
		}
	}

	return($rotate);
	imagedestroy($rotate);
}

function makeImage($filein, $fileout, $angle)
{
	global $Angle_Choisi;
	
	$size = getimagesize("fond_texture3d.png");
	$im = imagecreatefrompng("fond_texture3d.png");
	imagealphablending($im, true);
	imagesavealpha($im, true);

	$size2 = getimagesize($filein);
	$im2 = imagecreatefrompng($filein);
	imagealphablending($im2, true);
	imagesavealpha($im2, true);

	$marron = imagecolorallocate($im2, hexdec("57"), hexdec("3C"), hexdec("26"));

	$im2 = imageRotate2($im2, $angle);
	$w_rot_src = sqrt(($size2[0]*$size2[0]) + ($size2[1]*$size2[1])); 

	imagecopyresampled($im, $im2, 0, 0, 0, 0, 101, 50, $w_rot_src, $w_rot_src);

	imagepng($im, $fileout, 9, PNG_ALL_FILTERS);
	
	imagedestroy($im);
	imagedestroy($im2);
	
	echo $fileout."<br/>";
}

function recurse_createResize($src,$dst)
{
    $dir = opendir($src);
    @mkdir($dst);
    while(false !== ( $file = readdir($dir)) ) 
	{
        if (( $file != '.' ) && ( $file != '..' ) && ( $file != '.svn' ) && ($file != '.DS_Store') && ($file != '._.DS_Store')) 
		{
            if ( is_dir($src . '/' . $file) ) 
			{
                recurse_createResize($src . '/' . $file, $dst . '/' . $file);
            }
            else 
			{
				$filein = $src . '/' . $file;
				$fileout = $dst . '/' . $file;
				$thumbnail = makeImage($filein, $fileout,'-45');
				echo $filein ." => " ;
				if ($thumbnail != "")
					echo $fileout ."<img src='".$thumbnail."'></br>";
				else
					echo "invalide</br>";
				
			}
        }
    }
    closedir($dir);
} 

/* utilisation : */
recurse_createResize('./texture', './texture_test');

?>



