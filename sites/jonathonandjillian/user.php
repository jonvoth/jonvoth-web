<?php
	$displayStateID = 0;
	$todayDate = date('Y-m-d');
	$invitationDate = '2013-11-24';//'2012-11-30'; - FOR TESTING
	$returnData = null;

	//Check if returning from form post
	if($_SERVER['REQUEST_METHOD'] == 'GET') {
		$hostname = "jonandjill.db.9749977.hostedresource.com";
		$username = "jonandjill";
		$dbname = "jonandjill";
		$password = "sp@m6nuzi7vU";
		$postedFirstName = htmlspecialchars($_GET["FirstName"]);
		$postedLastName = htmlspecialchars($_GET["LastName"]);

		//Connect to database
		mysql_connect($hostname, $username, $password) OR DIE ("Unable to connect to database! Please try again later.");
		mysql_select_db($dbname);

		//Query database for user
		if($postedUserID){
			$query = sprintf("SELECT * FROM guests 
					WHERE ID='%s'",
					mysql_real_escape_string($postedUserID)
				);
		}else{
			$query = sprintf("SELECT * FROM guests 
					WHERE FirstName='%s' AND LastName='%s'",
					mysql_real_escape_string($postedFirstName),
					mysql_real_escape_string($postedLastName)
				);
		}
		$result = mysql_query($query);
		if ($result) {
			$row = mysql_fetch_array($result);
			if($row){
				$UserID = $row['ID'];
				$GroupID = $row['GroupID'];
				$FirstName = $row['FirstName'];
				$LastName = $row['LastName'];
				$EmailAddress = $row['EmailAddress'];
				$HasPlusOne = $row['HasPlusOne'];
				$guestsInGroup = array();

				//Manage plus ones
				if($HasPlusOne == 1){
					$guestObj = array(
							'FirstName' => 'Guest',
							'LastName' => ''
						);
					array_push($guestsInGroup, $row);
					array_push($guestsInGroup, $guestObj);
				}else{
					//Query database for other users in group
					$query = sprintf("SELECT * FROM guests 
							WHERE GroupID='%s'",
							mysql_real_escape_string($GroupID)
						);
					$result = mysql_query($query);
					if($result){	
						while($row = mysql_fetch_array($result)){
							$guestObj = array(
									'ID' => $row['ID'],
									'FirstName' => $row['FirstName'],
									'LastName' => $row['LastName'],
									'EmailAddress' => $row['EmailAddress'],
									'GroupID' => $row['GroupID'],
									'HasPlusOne' => $row['HasPlusOne']
								);
							array_push($guestsInGroup, $guestObj);
						}
					}else{
						$displayStateID = 16;
					}
				}

				//Query database for user's group
				$query = sprintf("SELECT * FROM groups 
						WHERE ID='%s'",
						mysql_real_escape_string($GroupID)
					);
				$result = mysql_query($query);
				if($result){
					$row = mysql_fetch_array($result);
					if($row){
						$AttendanceType = $row['AttendanceType'];
						$RSVP = $row['RSVP'];
						$NumAttending = $row['NumAttending'];
						$FoodChoice = $row['FoodChoice'];
						$PhysicalAddress = $row['PhysicalAddress'];

						//Check date range
						if(strtotime($todayDate) < strtotime($invitationDate)){
							$displayStateID = 1;
						}else{
							switch($AttendanceType){
								case 0:
									if($RSVP == 0){
										$displayStateID = 2;
									}else{
										$displayStateID = 3;
									}
									break;
								case 1:
									if($RSVP == 0){
										$displayStateID = 4;
									}else{
										$displayStateID = 5;
									}
									break;
								case 2:
									if($RSVP == 0){
										$displayStateID = 6;
									}else{
										$displayStateID = 7;
									}
									break;
								default:
									$displayStateID = 11;
									break;
							}
						}
					}else{
						$displayStateID = 12;
					}
				}else{
					$displayStateID = 13;
				}
			}else{
				$displayStateID = -1;
			}
		}else{
			$displayStateID = 14;
		}
	}else{
		$displayStateID = 0;
	}

	switch($displayStateID){
		case 0:
			//Login State
			$message = array(
					'headline' => '',
					'body' => ''
				);
			break;
		case 1:
			//Save the Date State
			$message = array(
					'headline' => '',
					'body' => array(
							'line1' => 'Jon and Jill',
							'line2' => 'are getting married',
							'line3' => 'January 25, 2014',
							'line4' => 'Minneapolis, Minnesota',
							'line5' => 'Formal invitation to follow'
						)
				);
			break;
		case 2:
			//Ceremony & Rehearsal Invitation State
			$message = array(
					'headline' => 'Ceremony & Rehearsal Invitation State',
					'body' => ''
				);
			break;
		case 4:
			//Ceremony Invitation State
			$message = array(
					'headline' => 'Ceremony Invitation State',
					'body' => ''
				);
			break;
		case 6:
			//Reception Invitation State
			$message = array(
					'headline' => 'Reception Invitation State',
					'body' => ''
				);
			break;
		case 3:
			//Ceremony & Rehearsal Info State
			$message = array(
					'headline' => 'Ceremony & Rehearsal Info State',
					'body' => ''
				);
			break;
		case 5:
			//Ceremony Info State
			$message = array(
					'headline' => 'Ceremony Info State',
					'body' => ''
				);
			break;
		case 7:
			//Reception Info State
			$message = array(
					'headline' => 'Reception Info State',
					'body' => ''
				);
			break;
		case -1:
			//Login Error State
			$message = array(
					'headline' => 'That name could not be found on the guest list. Please try again.',
					'body' => ''
				);
			break;
		case 11:
		case 12:
		case 13:
		case 14:
		case 15:
		case 16:
		default:
			//Error State
			$message = array(
					'headline' => 'There was an error. Please log in again.',
					'body' => ''
				);
			break;
	}

$returnData = (object)array(
		'stateId' => $displayStateID,
		'userFirstName' => $postedFirstName,
		'userLastName' => $postedLastName,
		'guests' => $guestsInGroup,
		'message' => $message
	);

header('Content-type: application/json');
echo json_encode($returnData);
?>