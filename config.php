<?php

$PHP_SELF = $_SERVER['PHP_SELF'];

if (preg_match("(config.php)",$PHP_SELF)) { 
    Header("Location: index.php");
    die();
}




$dbhost = "localhost";
$dbuname = "zancanaro5k";
$dbpass = "";
$dbname = "my_zancanaro5k";
$prefix = "scrlu_";
$user_prefix = "";
$dbtype = "MySQLI";


# definiamo anche le variabili relative al cookie.

$cookie_name = 'test_session';
$cookie_time = 3600;
$cookie_path = '/' ;
$cookie_domain = 'localhost';

?>
