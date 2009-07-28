<?php

define(domain, 'jabber.starshine-online.com');
define(muc, 'conference.'.domain);

session_start();

function replace_accents($string)
{
  return str_replace( array('à','á','â','ã','ä', 'ç', 'è','é','ê','ë', 'ì','í','î','ï', 'ñ', 'ò','ó','ô','õ','ö', 'ù','ú','û','ü', 'ý','ÿ', 'À','Á','Â','Ã','Ä', 'Ç', 'È','É','Ê','Ë', 'Ì','Í','Î','Ï', 'Ñ', 'Ò','Ó','Ô','Õ','Ö', 'Ù','Ú','Û','Ü', 'Ý'), array('a','a','a','a','a', 'c', 'e','e','e','e', 'i','i','i','i', 'n', 'o','o','o','o','o', 'u','u','u','u', 'y','y', 'A','A','A','A','A', 'C', 'E','E','E','E', 'I','I','I','I', 'N', 'O','O','O','O','O', 'U','U','U','U', 'Y'), $string);
}

function replace_all($string)
{
  $string = str_replace(' ', '_', $string);
  return strtolower(replace_accents($string));
}

session_start();
$login = replace_all($_SESSION['nom']);
$password = $_SESSION['password'];
if (isset($_SESSION['race'])) {
  $rooms = array('sso', $_SESSION['race']);  
}
else {
  $rooms = array('sso', 'roi', 'admin', 'barbare', 'elfebois', 'elfehaut', 'humain', 'humainnoir', 'mortvivant', 'nain', 'orc', 'scavenger', 'troll', 'vampire');
}
if (isset($_SESSION['grade']) && $_SESSION['grade'] == 6) $rooms[] = 'roi';

$roomlist = '';
foreach ($rooms as $room) {
	if ($roomlist != '') $roomlist .= ',';
	$roomlist .= $room.'@'.muc;
}

$roomname = 'sso@'.muc;

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="Tigase_messenger.css">
<link rel="stylesheet" type="text/css" href="resources/css/gxt-all.css" />
<title>Tigase Messenger</title>
<script type="text/javascript" language="javascript"
	src="tigase_messenger/tigase_messenger.nocache.js"></script>
<style>
#loading {
  position: absolute;
  left: 45%;
  top: 40%;
  margin-left: -45px;
  padding: 2px;
  z-index: 20001;
  height: auto;
  border: 1px solid #ccc;
}

#loading a {
  color: #225588;
}

#loading .loading-indicator {
  background: white;
  color: #444;
  font: bold 13px tahoma, arial, helvetica;
  padding: 10px;
  margin: 0;
  height: auto;
}

#loading .loading-indicator img {
  margin-right:8px;
  float:left;
  vertical-align:top;
}

#loading-msg {
  font: normal 10px arial, tahoma, sans-serif;
}

</style>
<script type="text/javascript">
		var Config = {
			httpBase: "/bosh",
			debug: "false",
			jid: "<?= $login.'@'.domain ?>/Tigase",
			password: "<?= $password ?>",
			anonymous: "false",
			hostname: "jabber.starshine-online.com",
			roomname: "<?= $roomname ?>",
			directPresences: "",
			rooms: "<?= $roomlist ?>"
		}
</script>
</head>
<body style="overflow: hidden">

<div id="loading">
    <div class="loading-indicator">
    <img src="resources/images/default/shared/large-loading.gif" width="32" height="32"/>Tigase Messenger<a href="http://tigase.org"></a><br />
    <span id="loading-msg">Loading...</span>
</div>
</div>
</body>
</html>
