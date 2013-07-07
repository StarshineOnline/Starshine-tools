<?php

$suggested = array('sso');

// Here get race & co to set suggested groupchats
if ($pun_user['is_admmod']) $suggested[] = 'admin';
$title = $pun_user["g_user_title"];

if (preg_match('/Mafieux/', $title)) $suggested[] = 'groupe';
if (preg_match('/Apo/', $title)) $suggested[] = 'groupe';
if (preg_match('/^Roi /', $title)) $suggested[] = 'roi';
if (preg_match('/Barbare/', $title)) $suggested[] = 'barbare';
if (preg_match('/Corrompu/', $title)) $suggested[] = 'humainnois';
if (preg_match('/Elfe des bois/', $title)) $suggested[] = 'elfebois';
if (preg_match('/Haut Elfe/', $title)) $suggested[] = 'elfehaut';
if (preg_match('/Humain/', $title)) $suggested[] = 'humain';
if (preg_match('/Mort-vivant/', $title)) $suggested[] = 'mortvivant';
if (preg_match('/Nain/', $title)) $suggested[] = 'nain';
if (preg_match('/Orc/', $title)) $suggested[] = 'orc';
if (preg_match('/Scavenger/', $title)) $suggested[] = 'scavenger';
if (preg_match('/Troll/', $title)) $suggested[] = 'troll';
if (preg_match('/Vampire/', $title)) $suggested[] = 'vampire';

$_sug = array();
foreach (array_unique($suggested) as $s) {
	$_sug[] = '"' . $s . '@conference.jabber.starshine-online.com"';
}
$out_sug = implode(',', $_sug);

?>
<!-- Mini Jappix -->
<script type="text/javascript" src="http://www.starshine-online.com/javascript/diacritics.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
   jQuery(document).ready(function() {
     jQuery.ajaxSetup({cache: true});
     $('body').append('<div id="minichat_authbox" class="pun punwrap"><div id="minichat_login" class="pun punwrap">Connexion au chat : <br/><label>Login: <input id="minichat_ilogin" type="text" /></label><br/>  <label>Password: <input id="minichat_ipwd" type="password"></label><br/>  <input type="button" onclick="doLogin()" value="Connexion" /></div><div id="minichat_clearauth" class="pun punwrap">  <input type="button" onclick="doCls()" value="Effacer les informations de connexion au chat" /></div></div>');
     $('#minichat_login').hide();
     tryLogin();
   });

function doLogin() {
  var log = $('#minichat_ilogin').val();
  var pwd = $('#minichat_ipwd').val();
  if (log == '' || pwd == '' || !log || !pwd) return false;
  $('#minichat_login').hide();
  localStorage.ssologin = clearLogin(log);
  localStorage.ssopwd = pwd;
  tryLogin();
}

function tryLogin() {
  var log = clearLogin(localStorage.ssologin);
  var pwd = localStorage.ssopwd;
  if (log == null || pwd == null) {
    $('#minichat_login').show();
    $('#minichat_clearauth').hide();
  } else {
    MINI_NICKNAME = log;

		jQuery.ajaxSetup({cache: true});
		//var js = "/jappix_mini/js/mini.js";
		var js = "/jappix/php/get.php?l=fr&t=js&g=mini.xml";

		jQuery.getScript(js, function() {
				MINI_GROUPCHATS = ["sso@conference.jabber.starshine-online.com"];
				MINI_SUGGEST_GROUPCHATS = [<?php echo $out_sug; ?>];
				MINI_ANIMATE = false;
				HOST_MUC = "conference.jabber.starshine-online.com";
				launchMini(false, true, "jabber.starshine-online.com", log, pwd);
			});

    $('#minichat_clearauth').show();
  }
}

function doCls() {
  localStorage.removeItem('ssologin');
  localStorage.removeItem('ssopwd');
  $('#minichat_login').show();
  $('#minichat_clearauth').hide();
}
</script>
<!-- END Mini Jappix -->

