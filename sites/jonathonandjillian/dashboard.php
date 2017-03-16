<?php
	$hostname = "jonandjill.db.9749977.hostedresource.com";
	$username = "jonandjill";
	$dbname = "jonandjill";
	$password = "sp@m6nuzi7vU";
	$groupsWithNoRSVP = array();
	$groupsRSVPYes = array();
	$groupsRSVPNo = array();
	$totalAttending = 0;
	$totalAttendingCeremony = 0;
	$totalNotAnswered = 0;
	$totalNotAnsweredCeremony = 0;
	$totalAttendingRehearsal = 0;
	$totalNotAnsweredRehearsal = 0;

	//Connect to database
	mysql_connect($hostname, $username, $password) OR DIE ("Unable to connect to database! Please try again later.");
	mysql_select_db($dbname);

	if($_GET['key'] == '012514'){
		$query = sprintf("SELECT * FROM groups");
		$result = mysql_query($query);
		if ($result) {
			while($row = mysql_fetch_array($result)){
	
				//Query database for other users in group
				$guestsInGroup = array();
				$hasPlusOne = 0;
				$query = sprintf("SELECT * FROM guests 
						WHERE GroupID='%s'",
						mysql_real_escape_string($row['ID'])
					);
				$guestResult = mysql_query($query);
				if($guestResult){
					while($guestRow = mysql_fetch_array($guestResult)){
						array_push($guestsInGroup, $guestRow);
						$hasPlusOne = $guestRow['HasPlusOne'];
					}
					$row['guestsInGroup'] = $guestsInGroup;
					$row['hasPlusOne'] = $hasPlusOne;
				}
	
				//Sort into correct arrays
				switch($row['RSVP']){
					case '0':
						array_push($groupsWithNoRSVP, $row);
						break;
					case '1':
						array_push($groupsRSVPYes, $row);
						break;
					case '2':
						array_push($groupsRSVPNo, $row);
						break;
					default:
						break;
				}
			}

			foreach($groupsRSVPYes as $yesResponse) {
				$totalAttending += $yesResponse['NumAttending'];
				if($yesResponse['AttendanceType'] != 2){
					$totalAttendingCeremony += $yesResponse['NumAttending'];
				}
				if($yesResponse['AttendanceType'] == 0 || $yesResponse['RehearsalFlag'] == 1){
					$totalAttendingRehearsal += $yesResponse['NumAttending'];
				}
			}
			foreach($groupsWithNoRSVP as $waitingResponse) {
				$totalNotAnswered += count($waitingResponse['guestsInGroup']);
				$totalNotAnswered += $waitingResponse['hasPlusOne'];
				if($waitingResponse['AttendanceType'] != 2){
					$totalNotAnsweredCeremony += count($waitingResponse['guestsInGroup']);
					$totalNotAnsweredCeremony += $waitingResponse['hasPlusOne'];
					if($waitingResponse['AttendanceType'] == 0 || $waitingResponse['RehearsalFlag'] == 1){
						$totalNotAnsweredRehearsal += count($waitingResponse['guestsInGroup']);
						$totalNotAnsweredRehearsal += $waitingResponse['hasPlusOne'];
					}
				}
			}
		}
	}
?>

<!DOCTYPE html>
<html class="no-js">
	<head>
		<meta charset="utf-8">
		<title>Jonathon &amp; Jillian</title>
		<meta name="description" content="Jon and Jill's Wedding">
		<meta name="viewport" content="width=device-width">
		<link rel="stylesheet" href="css/main.css">
		<style>
			body {
				height: 100%;
				font-size: 12px;
				font-weight: 300;
			}
			h1,
			h2 {
				color: #24b26e;
				text-align: center;
			}
			h1 {
				font-size: 8em;
				margin: 0.2em 0 0;
			}
			h2 {
				font-size: 4em;
				margin: 0;
			}
			h2 small {
				font-size: 0.5em;
				line-height: 0.5em;
			}
			.column {
				float: left;
				width: 30%;
				margin-top: 2em;
				padding-left: 1.666665%;
				padding-right: 1.666665%;
			}
			.column p {
				position: relative;
				background-color: #fff;
				padding: 6px;
				font-weight: normal;
				min-height: 28px;
			}
			.yes {
				color: #24b26e;
			}
			.no {
				color: #ff9742;
			}
			.waiting {
				color: red;
			}
			.reception {
				position: absolute;
				top: 0;
				right: 0;
				padding: 2px;
				background-color: #666;
				color: #fff;
			}
			.rehearsal {
				position: absolute;
				top: 0;
				right: 0;
				padding: 2px;
				background-color: #ccc;
				color: #000;
			}
			.numAttending {
				position: absolute;
				bottom: 0;
				right: 0;
				padding: 2px;
				color: #333;
			}
			@media (max-width: 570px) {
				.column {
					float: none;
					width: 96%;
				}
			}
		</style>
	</head>
	<body>
		<h1><?php echo($totalAttending); ?><span class="waiting">/<?php echo($totalAttending + $totalNotAnswered); ?></span></h1>
		<h2><small>Full:</small><br><?php echo($totalAttendingCeremony); ?><span class="waiting">/<?php echo($totalAttendingCeremony + $totalNotAnsweredCeremony); ?></span></h2>
		<h2><small>Rehearsal:</small><br><?php echo($totalAttendingRehearsal); ?><span class="waiting">/<?php echo($totalAttendingRehearsal + $totalNotAnsweredRehearsal); ?></span></h2>
		<div class="column yes">
			<h3>Attending (<?php echo(count($groupsRSVPYes)); ?> groups)</h3>
			<?php
				foreach($groupsRSVPYes as $yesResponse) {
					echo('<p>');
					foreach($yesResponse['guestsInGroup'] as $thisGuest){
						echo($thisGuest['FirstName'].' '.$thisGuest['LastName'].'<br/>');
					}
					if($yesResponse['AttendanceType'] == 2){
						echo('<span class="reception">Reception</span>');
					}else if($yesResponse['AttendanceType'] == 0 || $yesResponse['RehearsalFlag'] == 1){
						echo('<span class="rehearsal">Rehearsal</span>');
					}
					echo('<span class="numAttending">'.$yesResponse['NumAttending'].'</span>');
					echo('</p>');
				}
			?>
		</div>
		<div class="column no">
			<h3>Declined (<?php echo(count($groupsRSVPNo)); ?> groups)</h3>
			<?php
				foreach($groupsRSVPNo as $noResponse) {
					echo('<p>');
					foreach($noResponse['guestsInGroup'] as $thisGuest){
						echo($thisGuest['FirstName'].' '.$thisGuest['LastName'].'<br/>');
					}
					if($noResponse['AttendanceType'] == 2){
						echo('<span class="reception">Reception</span>');
					}else if($noResponse['AttendanceType'] == 0 || $noResponse['RehearsalFlag'] == 1){
						echo('<span class="rehearsal">Rehearsal</span>');
					}
					echo('</p>');
				}
			?>
		</div>
		<div class="column waiting">
			<h3>Waiting (<?php echo(count($groupsWithNoRSVP)); ?> groups)</h3>
			<?php
				foreach($groupsWithNoRSVP as $unResponded) {
					echo('<p>');
					foreach($unResponded['guestsInGroup'] as $thisGuest){
						echo($thisGuest['FirstName'].' '.$thisGuest['LastName'].'<br/>');
					}
					if($unResponded['AttendanceType'] == 2){
						echo('<span class="reception">Reception</span>');
					}else if($unResponded['AttendanceType'] == 0 || $unResponded['RehearsalFlag'] == 1){
						echo('<span class="rehearsal">Rehearsal</span>');
					}
					echo('</p>');
				}
			?>
		</div>
	</body>
</html>