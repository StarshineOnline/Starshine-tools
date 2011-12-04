<!-- Mini Jappix -->
<script type="text/javascript" src="http://www.starshine-online.com/javascript/diacritics.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
<script type="text/javascript" src="https://static.jappix.com/php/get.php?l=fr&amp;t=js&amp;g=mini.xml"></script>
<script type="text/javascript">
   jQuery(document).ready(function() {
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
  MINI_GROUPCHATS = ["sso@conference.jabber.starshine-online.com"];
  MINI_ANIMATE = false;
  HOST_MUC = "conference.jabber.starshine-online.com";
  var log = clearLogin(localStorage.ssologin);
  var pwd = localStorage.ssopwd;
  if (log == null || pwd == null) {
    $('#minichat_login').show();
    $('#minichat_clearauth').hide();
  } else {
    MINI_NICKNAME = log;
    launchMini(false, true, "jabber.starshine-online.com", log, pwd);
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

