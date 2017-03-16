<?php
	$displayStateID = 0;
	$returnData = null;

	//Check if returning from form post
/* 	if($_SERVER['REQUEST_METHOD'] == 'POST') { */
		$hostname = "jonandjill.db.9749977.hostedresource.com";
		$username = "jonandjill";
		$dbname = "jonandjill";
		$password = "sp@m6nuzi7vU";
		$postedUserID = htmlspecialchars($_GET["UserID"]);
		$postedGroupID = htmlspecialchars($_GET["GroupID"]);
		$postedAccept = htmlspecialchars($_GET["Accept"]);
		$postedDecline = htmlspecialchars($_GET["Decline"]);
		$postedNumAttending = htmlspecialchars($_GET["NumAttending"]);

		//Connect to database
		mysql_connect($hostname, $username, $password) OR DIE ("Unable to connect to database! Please try again later.");
		mysql_select_db($dbname);

		//Check for RSVP data and update database
		if($postedAccept || $postedDecline){
			if($postedAccept == 'on'){
				$RSVPValue = 1;
			}else{
				$RSVPValue = 2;
			}
			mail('jonvoth@gmail.com', 'JonathonAndJillian.com: RSVP', 'User: '.$postedUserID.' - Accept: '.$postedAccept.' - Decline: '.$postedDecline.' - Number Attending: '.$postedNumAttending);
			$query = sprintf("UPDATE groups
					SET RSVP = '%s', NumAttending = '%s'
					WHERE ID = $postedGroupID",
					mysql_real_escape_string($RSVPValue),
					mysql_real_escape_string($postedNumAttending)
				);
			$result = mysql_query($query);
			if (!$result) {
				$displayStateID = 15;
			}
		}
/*
	}else{
		$displayStateID = 0;
	}
*/

/*
	0 //Login State
	1 //Save the Date State
	
	2 //Ceremony & Rehearsal Invitation State
	4 //Ceremony Invitation State
	6 //Reception Invitation State
	
	3 //Ceremony & Rehearsal Info State
	5 //Ceremony Info State
	7 //Reception Info State
	
	-1 //Login Error State
	11-16 //Error State
*/

$returnData = (object)array(
		'stateId' => $displayStateID
	);

header('Content-type: application/json');
echo json_encode($returnData);
?>