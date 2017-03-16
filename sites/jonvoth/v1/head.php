<head>
<title>JonVoth.com</title>
<link rel="stylesheet" type="text/css" href="/JonVoth/v1/JonVoth.css" />
</head>
<!-- DB Connect Script -->
<? 
$dbh=mysql_connect ("localhost", "irvinga_irvingus", "jv1ck2jb3") or die ('I cannot connect to the database because: ' . mysql_error());
mysql_select_db ("irvinga_jonvoth");
?>