<?php

function replace_accents($string)
{
  return str_replace( array('à','á','â','ã','ä', 'ç', 'è','é','ê','ë', 'ì','í','î','ï', 'ñ', 'ò','ó','ô','õ','ö', 'ù','ú','û','ü', 'ý','ÿ', 'À','Á','Â','Ã','Ä', 'Ç', 'È','É','Ê','Ë', 'Ì','Í','Î','Ï', 'Ñ', 'Ò','Ó','Ô','Õ','Ö', 'Ù','Ú','Û','Ü', 'Ý'), array('a','a','a','a','a', 'c', 'e','e','e','e', 'i','i','i','i', 'n', 'o','o','o','o','o', 'u','u','u','u', 'y','y', 'A','A','A','A','A', 'C', 'E','E','E','E', 'I','I','I','I', 'N', 'O','O','O','O','O', 'U','U','U','U', 'Y'), $string);
} 

$link = mysql_connect('mysql', 'jabberd2', '4VZLvzjnXtUxXLxe');
if (!$link) {
  die('Could not connect: ' . mysql_error());
}
mysql_select_db('jabberd2') or die('Could not select database.');
mysql_set_charset('utf-8', $link);

$roi = 6;
$races = "'barbare', 'elfebois', 'elfehaut', 'humain', 'humainnoir', 'mortvivant', 'nain', 'orc', 'scavenger', 'troll', 'vampire'";
$result= mysql_query( "select jid, name from rooms where name in ($races)" );

if ($result == null) exit (1);

$chans = array();
while ($row = mysql_fetch_assoc($result)) {
  $chans[] = $row;
}

$rois = array();

$dm = '@ubuntu-sso-test.geekwu.org';
$owner = 'irulan';

function set_xml_value(&$doc, $name, $value) {
  $params = $doc->getElementsByTagName($name);
  foreach ($params as $param) {
    while ($param->hasChildNodes())
      $param->removeChild($param->firstChild);
    $param->appendChild($doc->createTextNode($value));
  }
}

system('/etc/init.d/jabberd2-mysql stop jabberd2-muc');

foreach ($chans as $row) {
  $jid = $row['jid'];
  $race = $row['name'];
  $name = '/var/spool/jabberd2/rooms/'.sha1($jid).'.xml';
  if (file_exists($name)) {
    echo "$race: $name\n";

    $doc = new DOMDocument();
    $doc->load($name);
    $doc->save($name.'.bak');

    $xpath = new DOMXPath($doc);
    $query = '//list[@xdbns="muc:list:member"]';
    $entries = $xpath->query($query);

    $roi_royaume = null;

    foreach ($entries as $entry) {
      while ($entry->hasChildNodes())
	$entry->removeChild($entry->firstChild);
      $persos = mysql_query("select nom, rang_royaume from perso where race = '$race' and statut = 'actif'");
      while ($perso = mysql_fetch_assoc($persos)) {
	$tmp = replace_accents(utf8_encode($perso['nom']));
	$perso['nom'] = $tmp;

	if ($perso['rang_royaume'] == $roi) {
	  $rois[] = $perso['nom'];
	  $roi_royaume = $perso['nom'];
	}
	$node = $doc->createElement('item');
	$jid = $doc->createAttribute('jid');
	$jid->appendChild($doc->createTextNode($perso['nom'].$dm));
	$node->appendChild($jid);
	//$entry->appendChild($node);
      }
    }

    if ($roi_royaume != null) {
      $query = '//list[@xdbns="muc:list:admin"]';
      $entries = $xpath->query($query);
      
      foreach ($entries as $entry) {
	while ($entry->hasChildNodes())
	  $entry->removeChild($entry->firstChild);
	$node = $doc->createElement('item');
        $jid = $doc->createAttribute('jid');
        $jid->appendChild($doc->createTextNode($roi_royaume.$dm));
	$node->appendChild($jid);
        $entry->appendChild($node);
      }
    }

    $query = '//list[@xdbns="muc:list:owner"]';
    $entries = $xpath->query($query);
      
    foreach ($entries as $entry) {
      while ($entry->hasChildNodes())
	$entry->removeChild($entry->firstChild);
      $node = $doc->createElement('item');
      $jid = $doc->createAttribute('jid');
      $jid->appendChild($doc->createTextNode($owner.$dm));
      $node->appendChild($jid);
      $entry->appendChild($node);
    }
    
    set_xml_value($doc, 'invitation', 1);
    set_xml_value($doc, 'public', 0);
    set_xml_value($doc, 'maxusers', 0);

    $doc->save($name);

  } else echo "No file for $race: $jid \n[$name expected]\n";
}

/* le chan des rois */
$jid = 'roi@conference.ubuntu-sso-test.geekwu.org';
$name = '/var/spool/jabberd2/rooms/'.sha1($jid).'.xml';
if (file_exists($name)) {
  echo "roi: $name\n";

  $doc = new DOMDocument();
  $doc->load($name);

  $xpath = new DOMXPath($doc);
  $query = '//list[@xdbns="muc:list:member"]';
  $entries = $xpath->query($query);
  
  $adm = array();

  foreach ($entries as $entry) {
    while ($entry->hasChildNodes())
      $entry->removeChild($entry->firstChild);
    
    foreach ($rois as $roi) {
      $node = $doc->createElement('item');
      $jid = $doc->createAttribute('jid');
      $jid->appendChild($doc->createTextNode($roi.$dm));
      $node->appendChild($jid);
      //$entry->appendChild($node);
    }
  }
  
  set_xml_value($doc, 'invitation', 1);
  set_xml_value($doc, 'public', 0);
  set_xml_value($doc, 'maxusers', 0);
  
  $doc->save($name);
} else echo "No file for roi $jid \n[$name expected]\n";

/* le chan des admins */
$jid = 'admin@conference.ubuntu-sso-test.geekwu.org';
$name = '/var/spool/jabberd2/rooms/'.sha1($jid).'.xml';
if (file_exists($name)) {
  echo "admin: $name\n";

  $doc = new DOMDocument();
  $doc->load($name);

  $xpath = new DOMXPath($doc);
  $query = '//list[@xdbns="muc:list:member"]';
  $entries = $xpath->query($query);
  
  $adm = array();

  foreach ($entries as $entry) {
    while ($entry->hasChildNodes())
      $entry->removeChild($entry->firstChild);
    
    $admins = mysql_query("select * from jabber_admin");
    while ($admin = mysql_fetch_assoc($admins)) {
      $nom = utf8_encode($admin['nom']);
      
      if ($admin['statut'] == 'admin') $adm[] = $nom;
      
      $node = $doc->createElement('item');
      $jid = $doc->createAttribute('jid');
      $jid->appendChild($doc->createTextNode($nom.$dm));
      $node->appendChild($jid);
      //$entry->appendChild($node);
    }
  }
  
  $query = '//list[@xdbns="muc:list:admin"]';
  $entries = $xpath->query($query);
  
  foreach ($entries as $entry) {
    while ($entry->hasChildNodes())
      $entry->removeChild($entry->firstChild);
    
    foreach ($adm as $roxxor) {
      $node = $doc->createElement('item');
      $jid = $doc->createAttribute('jid');
      $jid->appendChild($doc->createTextNode($roxxor.$dm));
      $node->appendChild($jid);
      $entry->appendChild($node);
    }
  }

  set_xml_value($doc, 'invitation', 1);
  set_xml_value($doc, 'public', 0);
  set_xml_value($doc, 'maxusers', 0);
  
  $doc->save($name);
} else echo "No file for admin $jid \n[$name expected]\n";

system('/etc/init.d/jabberd2-mysql start jabberd2-muc');

?>