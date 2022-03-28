<?php
/*
 * VisualizzaQuery.php
 * 
 * Copyright 2022 Admin <Admin@DESKTOP-U8CV1L7>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */

include("config.php");


$mysqli = @new mysqli($dbhost, $dbuname, $dbpass,$dbname);
	mysqli_select_db($mysqli,$dbname);

/*
$query = "SELECT  *
 FROM AC_History t ORDER BY id DESC LIMIT 20";
*/
//$query = "SELECT * FROM Giocatori;";
/*
$query = "SELECT @minimo := MIN(Stipendio)
  FROM Dip_Impiegati;
SELECT Cognome, Nome, Residenza, Stipendio
	FROM Dip_Impiegati
	WHERE Stipendio >=@minimo +10000;";
 */  

/*//-- Se vogliamo usarla in un applicativo web php va riscritta meglio

$query = "SELECT Cognome, Nome, Residenza, Stipendio
	FROM Dip_Impiegati
	WHERE Stipendio >=(SELECT @minimo := MIN(Stipendio)
  FROM Dip_Impiegati) +10000;";
*/
//-- va bene anche se eliminiamo la variabile @minimo

$query = "SELECT Cognome, Nome, Residenza, Stipendio
	FROM Dip_Impiegati
	WHERE Stipendio >=(SELECT MIN(Stipendio)
  FROM Dip_Impiegati) +10000;";


#printf("\$query: %s \n",$query);

if ($result=@mysqli_query($mysqli, $query))
  {
  // Return the number of rows in result set
  $numOfRows=mysqli_num_rows($result);
  
//  printf("Result set has %d rows.<br>",$numOfRows);
  
  $numfields = mysqli_num_fields($result);

  if ($numOfRows>0){
	echo "<table class = dati>";
	echo " <tr>";
	$row=mysqli_fetch_array($result,MYSQLI_ASSOC);
	foreach($row as $x => $x_value) {
		echo "<th>" . $x . "</th>";   
	} 
	echo "</tr>";
	echo " <tr>";
 		foreach($row as $x => $x_value) {
			echo "<td>" . $x_value . "</td>";   
		} 
	echo "</tr>";

 
  for ($i = 1; $i < $numOfRows; $i++){
		echo " <tr>";
		$row=mysqli_fetch_array($result,MYSQLI_ASSOC);
		foreach($row as $x => $x_value) {
		echo "<td>" . $x_value . "</td>";   
		} 
		 echo "</tr>";
	}
	echo "</table><br>";
	}

  // Free result set
  mysqli_free_result($result);
  }
mysqli_close($mysqli);

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>Visualizza query</title>
    <meta http-equiv="refresh" content="10">

    <link rel="stylesheet" type="text/css" href="stile_pagina.css"> 

  </head>

<body>
	
</body>

</html>
