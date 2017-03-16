<?php
	$displayStateID = 0;
	$todayDate = date('Y-m-d');
	$invitationDate = '2013-11-23';
	$invitationDate = $_GET['date'];

	//Check if returning from form post
	if($_SERVER['REQUEST_METHOD'] == 'POST') {
		$hostname = "jonandjill.db.9749977.hostedresource.com";
		$username = "jonandjill";
		$dbname = "jonandjill";
		$password = "sp@m6nuzi7vU";
		$postedFirstName = htmlspecialchars($_POST["FirstName"]);
		$postedLastName = htmlspecialchars($_POST["LastName"]);
		$postedUserID = htmlspecialchars($_POST["UserID"]);
		$postedGroupID = htmlspecialchars($_POST["GroupID"]);
		$postedAccept = htmlspecialchars($_POST["Accept"]);
		$postedDecline = htmlspecialchars($_POST["Decline"]);
		$postedNumAttending = htmlspecialchars($_POST["NumAttending"]);

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
			mail('jonvoth@gmail.com', 'JonathonAndJillian.com: RSVP', 'User: '.$postedFirstName.' '.$postedLastName.' (ID: '.$postedUserID.') - Accept: '.$postedAccept.' - Number Attending: '.$postedNumAttending);
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
							array_push($guestsInGroup, $row);
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
?>


<!DOCTYPE html>
<html class="no-js">
	<head>
		<meta charset="utf-8">
		<title>Jonathon &amp; Jillian</title>
		<meta name="description" content="Jon and Jill's Wedding">
		<meta name="viewport" content="width=device-width">
		<link rel="stylesheet" href="css/main.css">
		<script src="js/libs/modernizr-2.6.2.min.js"></script>
		<script src="//www.google-analytics.com/ga.js"></script>
	</head>
	<body>
		<div class="wrapper">
		<?php
			if($displayStateID !== 0){
		?>
			 <div class="reveal-panel-container">
				 <div class="reveal-panel one" data-0="
													 -moz-transform: rotate(-45deg);
													 -webkit-transform: rotate(-45deg);
													 transform: rotate(-45deg);
													 "
											 data-300="
													 -moz-transform: rotate(-90deg);
													 -webkit-transform: rotate(-90deg);
													 transform: rotate(-90deg);
													 "></div>
				 <div class="reveal-panel two" data-0="
													 -moz-transform: rotate(-45deg);
													 -webkit-transform: rotate(-45deg);
													 transform: rotate(-45deg);
													 "
											 data-300="
													 -moz-transform: rotate(-90deg);
													 -webkit-transform: rotate(-90deg);
													 transform: rotate(-90deg);
													 "></div>
				 <div class="reveal-panel three" data-0="
													 -moz-transform: rotate(-45deg);
													 -webkit-transform: rotate(-45deg);
													 transform: rotate(-45deg);
													 "
											 data-300="
													 -moz-transform: rotate(-90deg);
													 -webkit-transform: rotate(-90deg);
													 transform: rotate(-90deg);
													 "></div>
				 <div class="reveal-panel four" data-0="
													 -moz-transform: rotate(-45deg);
													 -webkit-transform: rotate(-45deg);
													 transform: rotate(-45deg);
													 "
											 data-300="
													 -moz-transform: rotate(-90deg);
													 -webkit-transform: rotate(-90deg);
													 transform: rotate(-90deg);
													 "></div>
				 <div class="reveal-panel five" data-0="
													 -moz-transform: rotate(-25deg);
													 -webkit-transform: rotate(-25deg);
													 transform: rotate(-25deg);
													 "
											 data-400="
													 -moz-transform: rotate(-180deg);
													 -webkit-transform: rotate(-180deg);
													 transform: rotate(-180deg);
													 "></div>
				 <div class="reveal-panel six" data-0="
													 -moz-transform: rotate(-25deg);
													 -webkit-transform: rotate(-25deg);
													 transform: rotate(-25deg);
													 "
											 data-400="
													 -moz-transform: rotate(-180deg);
													 -webkit-transform: rotate(-180deg);
													 transform: rotate(-180deg);
													 "></div>
				 <div class="reveal-panel seven" data-0="
													 -moz-transform: rotate(25deg);
													 -webkit-transform: rotate(25deg);
													 transform: rotate(25deg);
													 "
											 data-400="
													 -moz-transform: rotate(180deg);
													 -webkit-transform: rotate(180deg);
													 transform: rotate(180deg);
													 "></div>
				 <div class="reveal-panel eight" data-0="
													 -moz-transform: rotate(25deg);
													 -webkit-transform: rotate(25deg);
													 transform: rotate(25deg);
													 "
											 data-400="
													 -moz-transform: rotate(180deg);
													 -webkit-transform: rotate(180deg);
													 transform: rotate(180deg);
													 "></div>
				 <h2 class="hide" data-100="opacity: 1;" data-200="opacity: 0;">Welcome, <?php echo($postedFirstName); ?>.<br/>Please scroll down.</h2>
				 <div class="btn hide" id="auto-scroll" data-100="opacity: 1;" data-200="opacity: 0;">Scroll for me</div>
			 </div>
		<?php
			}
			switch($displayStateID){
				case 0:
					//Login State
					?>
						<h1 class="site-title"><span class="orange">Jonathon</span> + <span class="green">Jillian</span></h1>
						<div class="content-container state-login">
							<h2>Please Enter Your Name.</h2>
							<form name="LoginForm" action="" method="post">
								<label for="FirstName">First Name</label><br/>
								<input type="text" name="FirstName"><br/>
								<label for="LastName">Last Name</label><br/>
								<input type="text" name="LastName"><br/>
								<input type="submit" name="Submit" value="Go" class="orange">
							</form>
						</div>
					<?php
					break;
				case 1:
					//Save the Date State
					?>
						<div class="content-container state-save-the-date">
							<div class="bkg-container">
								<img src="img/std_ink1.png" class="one" alt="std_ink1" data-50="
																								-moz-transform: scale(0.95) rotate(4deg) translate(-5%,70%); opacity: 0;
																								-webkit-transform: scale(0.95) rotate(4deg) translate(-5%,70%); opacity: 0;
																								transform: scale(0.95) rotate(4deg) translate(-5%,70%); opacity: 0;
																								"
																						data-100="
																								-moz-transform: scale(1) rotate(0deg) translate(-5%,70%); opacity: 1;
																								-webkit-transform: scale(1) rotate(0deg) translate(-5%,70%); opacity: 1;
																								transform: scale(1) rotate(0deg) translate(-5%,70%); opacity: 1;
																								">
								<img src="img/std_ink2.png" class="two" alt="std_ink2" data-200="
																								-moz-transform: scale(0.95) rotate(-2deg) translate(140%,10%); opacity: 0;
																								-webkit-transform: scale(0.95) rotate(-2deg) translate(140%,10%); opacity: 0;
																								transform: scale(0.95) rotate(-2deg) translate(140%,10%); opacity: 0;
																								"
																						data-400="
																								-moz-transform: scale(1) rotate(0deg) translate(140%,10%); opacity: 1;
																								-webkit-transform: scale(1) rotate(0deg) translate(140%,10%); opacity: 1;
																								transform: scale(1) rotate(0deg) translate(140%,10%); opacity: 1;
																								">
								<img src="img/std_ink3.png" class="three" alt="std_ink3" data-100="
																								-moz-transform: scale(0.95) rotate(3deg) translate(75%,25%); opacity: 0;
																								-webkit-transform: scale(0.95) rotate(3deg) translate(75%,25%); opacity: 0;
																								transform: scale(0.95) rotate(3deg) translate(75%,25%); opacity: 0;
																								"
																						data-350="
																								-moz-transform: scale(1) rotate(0deg) translate(75%,25%); opacity: 1;
																								-webkit-transform: scale(1) rotate(0deg) translate(75%,25%); opacity: 1;
																								transform: scale(1) rotate(0deg) translate(75%,25%); opacity: 1;
																								">
								<img src="img/std_ink4.png" class="four" alt="std_ink4" data-50="
																								-moz-transform: scale(0.95) rotate(-5deg) translate(20%,30%); opacity: 0;
																								-webkit-transform: scale(0.95) rotate(-5deg) translate(20%,30%); opacity: 0;
																								transform: scale(0.95) rotate(-5deg) translate(20%,30%); opacity: 0;
																								"
																						data-300="
																								-moz-transform: scale(1) rotate(0deg) translate(20%,30%); opacity: 1;
																								-webkit-transform: scale(1) rotate(0deg) translate(20%,30%); opacity: 1;
																								transform: scale(1) rotate(0deg) translate(20%,30%); opacity: 1;
																								">
								<img src="img/std_ink5.png" class="five" alt="std_ink5" data-250="
																								-moz-transform: scale(0.95) rotate(2deg) translate(75%,10%); opacity: 0;
																								-webkit-transform: scale(0.95) rotate(2deg) translate(75%,10%); opacity: 0;
																								transform: scale(0.95) rotate(2deg) translate(75%,10%); opacity: 0;
																								"
																						data-500="
																								-moz-transform: scale(1) rotate(0deg) translate(75%,10%); opacity: 1;
																								-webkit-transform: scale(1) rotate(0deg) translate(75%,10%); opacity: 1;
																								transform: scale(1) rotate(0deg) translate(75%,10%); opacity: 1;
																								">
								<img src="img/std_ink6.png" class="six" alt="std_ink6" data-350="
																								-moz-transform: scale(0.95) rotate(-3deg) translate(40%,120%); opacity: 0;
																								-webkit-transform: scale(0.95) rotate(-3deg) translate(40%,120%); opacity: 0;
																								transform: scale(0.95) rotate(-3deg) translate(40%,120%); opacity: 0;
																								"
																						data-400="
																								-moz-transform: scale(1) rotate(0deg) translate(40%,120%); opacity: 1;
																								-webkit-transform: scale(1) rotate(0deg) translate(40%,120%); opacity: 1;
																								transform: scale(1) rotate(0deg) translate(40%,120%); opacity: 1;
																								">
								<img src="img/std_ink7.png" class="seven" alt="std_ink7" data-200="
																								-moz-transform: scale(0.95) rotate(1deg) translate(0%,0%); opacity: 0;
																								-webkit-transform: scale(0.95) rotate(1deg) translate(0%,0%); opacity: 0;
																								transform: scale(0.95) rotate(1deg) translate(0%,0%); opacity: 0;
																								"
																						data-300="
																								-moz-transform: scale(1) rotate(0deg) translate(0%,0%); opacity: 1;
																								-webkit-transform: scale(1) rotate(0deg) translate(0%,0%); opacity: 1;
																								transform: scale(1) rotate(0deg) translate(0%,0%); opacity: 1;
																								">
							</div>
							<p>
								<span class="one" data-300="opacity: 0;" data-500="opacity: 1;">Jon and Jill</span><br/>
								<span class="two" data-350="opacity: 0;" data-550="opacity: 1;">are getting married</span><br/>
								<span class="three" data-400="opacity: 0;" data-600="opacity: 1;">January 25, 2014</span><br/>
								<span class="four" data-450="opacity: 0;" data-650="opacity: 1;">Minneapolis, Minnesota</span><br/>
								<span class="five" data-500="opacity: 0;" data-700="opacity: 1;">Formal invitation to follow</span>
							</p>
						</div>
					<?php
					break;
				case 2:
				case 4:
				case 6:
					//Invitation State
						//Ceremony & Rehearsal Invitation State - $displayStateID = 2
						//Ceremony Invitation State - $displayStateID = 4
						//Reception Invitation State - $displayStateID = 6
					?>
					<div class="content-container state-invitation">
						<div class="bkg-container">
							<img src="img/invite_main.jpg" class="bkg-invite">
							<img src="img/invite_details.jpg" class="bkg-details">
							<img src="img/invite_rsvp.jpg" class="bkg-rsvp">
						</div>
						<div class="head-title">
							<h1><span class="orange">Jonathon</span> + <span class="green">Jillian</span></h1>
						</div>
						<div class="container-content">
							<div id="ContainerInvite" class="container-invite">
								<span class="one">Jillian Slater and</span>
								<span class="two">Jonathon Voth</span>
								<span class="three">with their parents</span>
								<span class="four">Jane and Tony Slater</span>
								<span class="five">&amp; Karen and Marc Voth</span>
								<span class="six">invite you to celebrate their</span>
								<?php
									 if($displayStateID === 6){
								?>
								<span class="reception-only">
									<span class="seven">wedding</span>
									<span class="eight">reception</span>
									<span class="nine">January 25th, 2014 at 8:30pm</span>
									<span class="ten">American Swedish Institute</span>
									<span class="eleven">Minneapolis, Minnesota</span>
								</span>
								<?php
									}else{
								?>
								<span class="full-invite">
									<span class="seven">wedding</span>
									<span class="eight">January 25th, 2014 at 6pm</span>
									<span class="nine">American Swedish Institute</span>
									<span class="ten">Minneapolis, Minnesota</span>
									<span class="eleven">Dinner and dancing to follow</span>
								</span>
								<?php
									 }
								 ?>
							</div>
							<div id="ContainerDetails" class="container-details">
								<p>
									<strong>American Swedish Institute</strong><br>
									<a href="https://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=American+Swedish+Institute,+Park+Avenue+South,+Minneapolis,+MN&aq=0&oq=american&sll=44.970697,-93.261478&sspn=0.373079,0.750504&vpsrc=0&ie=UTF8&hq=&hnear=&t=m&z=16&iwloc=A&cid=5335361704089780480" target="_blank">2600 Park Ave<br>
									Minneapolis, MN 55407</a>
								</p>
								<p>
									<strong>Hotels</strong><br>
									A block of rooms is reserved at<br>
									<a href="https://www.starwoodmeeting.com/StarGroupsWeb/booking/reservation?id=1307236448&key=A4EE0" target="_blank">The Minneapolis Sheraton Midtown</a><br>
									Another convenient hotel is<br>
									<a href="http://hiltongardeninn3.hilton.com/en/hotels/minnesota/hilton-garden-inn-minneapolis-downtown-MSPCNGI/index.html" target="_blank">The Minneapolis Hilton Garden Inn</a>
								</p>
								<?php
									if($displayStateID != 6){
								?>
								<p class="full-invite">
									<strong>Gifts</strong><br>
									If you would like to purchase a gift, we have registries at <a href="http://www.amazon.com/registry/wedding/39UTRGDSX1ZQK" target="_blank">Amazon.com</a>, <a href="http://www1.macys.com/registry/wedding/guest/?registryId=6026836" target="_blank">Macy's</a> and <a href="http://www.target.com/wedd/registry/zFX-elN8PRfw7a2m1js7TA" target="_blank">Target</a>.<br>
									Feel free to bring gifts to the event or ship them directly to our home at:<br>
									2549 Bryant Ave S #1<br>
									Minneapolis, MN 55405
								</p>
								<?php
									}
								?>
								<p>
									<strong>Kids</strong><br>
									While we love the little ones, this is an adult-only affair.
								</p>
							</div>
							<div id="ContainerRSVP" class="container-rsvp clearfix">
								<h3>Please reply by January 4th, 2014</h3>
								<p>Your party includes:
									<?php
										$totalGuests = count($guestsInGroup);
										for ($i = 0; $i < $totalGuests; $i++) {
											if($guestsInGroup[$i]['LastName'] != ''){
												echo $guestsInGroup[$i]['FirstName'].' '.$guestsInGroup[$i]['LastName'];
											}else{
												echo $guestsInGroup[$i]['FirstName'];
											}
											if($i == $totalGuests - 2){
												echo ' &amp; ';
											}else if($i == $totalGuests - 1){
												echo '.';
											}else{
												echo ', ';
											}
										}
									?>
								</p>
								<form name="RSVPForm" action="" method="post">
									<input type="text" name="FirstName" value="<?php echo $FirstName ?>" hidden="true">
									<input type="text" name="LastName" value="<?php echo $LastName ?>" hidden="true">
									<input type="text" name="UserID" value="<?php echo $UserID ?>" hidden="true">
									<input type="text" name="GroupID" value="<?php echo $GroupID ?>" hidden="true">
									<label for="Accept">Accept with exuberance:</label><input type="radio" id="Accept" name="Accept" value="on"><br>
									<label for="Decline">Decline with apologies:</label><input type="radio" id="Decline" name="Accept" value="off"><br>
									<div class="form-bottom">
										<label for="NumAttending">Number attending:</label>
										<select id="NumAttending" name="NumAttending">
											<option value="0">0</option>
											<?php
											for ($i = 0; $i < count($guestsInGroup); $i++) {
												echo '<option value="'.intval($i+1).'">'.intval($i+1).'</option>';
											}
											?>
										</select>
										<input id="BtnSubmitRSVP" type="submit" name="Submit" value="RVSP" class="orange">
									</div>
								</form>
							</div>
						</div>
						<nav class="footer-nav">
							<ul>
								<li id="NavItemInvite" class="active"><a href="#ContainerInvite" class="orange">Invitation</a></li>
								<li id="NavItemDetails"><a href="#ContainerDetails" class="green">Details</a></li>
								<li id="NavItemRSVP"><a href="#ContainerRSVP" class="orange">RSVP</a></li>
							</ul>
						</nav>
					</div>
					<?php
					break;
				case 3:
				case 5:
				case 7:
					//Info State
					?>
						<div class="content-container state-info">
							<div class="bkg-container"></div>
								<div class="head-title">
									<h1><span class="orange">Jonathon</span> + <span class="green">Jillian</span></h1>
								</div>
								<div class="head-rsvp">
									<p>
										<?php
											if($RSVP == 1){
												if($NumAttending == 1){
													echo('1 person in your party is attending.');
												}else{
													echo($NumAttending.' people in your party are attending.');
												}
											}else{
												echo('You are not attending.');
											}
										?>
									</p>
								</div>
								<div class="container-content">
									<div id="ContainerEvents" class="container-events">
										<?php
										switch($displayStateID){
											case 3:
												//Ceremony & Rehearsal Info State
												?>
												<div class="rehearsal-invite">
													<h2>Friday, January 24th</h2>
													<p>
														1:00 pm - Rehearsal<br>
														<span>Swedish Institute</span><br>
														3:00 pm - Rehearsal Dinner<br>
														<span>Black Forest Inn</span><br>
														<span><a href="http://www.google.com/calendar/event?action=TEMPLATE&text=Jon%20and%20Jill's%20Wedding%20Rehearsal&dates=20140124T190000Z/20140124T210000Z&details=&location=American%20Swedish%20Institute%2C%202600%20Park%20Ave%20S%2C%20Minneapolis%2C%20MN&trp=true&sprop=Jonathon%20%26%20Jillian&sprop=name:jonathonandjillian.com" target="_blank"><img src="//www.google.com/calendar/images/ext/gc_button3.gif" border=0></a></span>
													</p>
												</div>
												<div class="full-invite">
													<h2>Saturday, January 25th</h2>
													<p>
														6:00 pm - Ceremony<br>
<!--
														<span>Processional</span><br>
														<span>Welcome</span><br>
														<span>Community Blessing</span><br>
														<span>Readings</span><br>
														<span>Vows</span><br>
														<span>Exchange of Rings</span><br>
														<span>Announcement</span><br>
														<span>Recessional</span><br>
														6:30 pm - Cocktails<br>
-->
														7:15 pm - Dinner<br>
<!--
														8:00 pm - Toasts<br>
-->
														8:30 pm - Dancing<br>
														<span><a href="http://www.google.com/calendar/event?action=TEMPLATE&text=Jon%20and%20Jill's%20Wedding&dates=20140126T000000Z/20140126T053000Z&details=&location=American%20Swedish%20Institute%2C%202600%20Park%20Ave%2C%20Minneapolis%2C%20MN%2055407&trp=true&sprop=Jon%20and%20Jill's%20Wedding&sprop=name:jonathonandjillian.com" target="_blank"><img src="//www.google.com/calendar/images/ext/gc_button3.gif" border=0></a></span>
													</p>
												</div>
												<?php
												break;
											case 5:
												//Ceremony Info State
												?>
												<div class="full-invite">
													<h2>Saturday, January 25th</h2>
													<p>
														6:00 pm - Ceremony<br>
<!--
														<span>Processional</span><br>
														<span>Welcome</span><br>
														<span>Community Blessing</span><br>
														<span>Readings</span><br>
														<span>Vows</span><br>
														<span>Exchange of Rings</span><br>
														<span>Announcement</span><br>
														<span>Recessional</span><br>
														6:30 pm - Cocktails<br>
-->
														7:15 pm - Dinner<br>
<!--
														8:00 pm - Toasts<br>
-->
														8:30 pm - Dancing<br>
														<span><a href="http://www.google.com/calendar/event?action=TEMPLATE&text=Jon%20and%20Jill's%20Wedding&dates=20140126T000000Z/20140126T053000Z&details=&location=American%20Swedish%20Institute%2C%202600%20Park%20Ave%2C%20Minneapolis%2C%20MN%2055407&trp=true&sprop=Jon%20and%20Jill's%20Wedding&sprop=name:jonathonandjillian.com" target="_blank"><img src="//www.google.com/calendar/images/ext/gc_button3.gif" border=0></a></span>
													</p>
												</div>
												<?php
												break;
											case 7:
												//Reception Info State
												?>
												<div class="partial-invite">
													<h2>Saturday, January 25th</h2>
													<p>
														8:30 pm - Wedding Reception<br>
														<span><a href="http://www.google.com/calendar/event?action=TEMPLATE&text=Jon%20and%20Jill's%20Wedding%20Reception&dates=20140126T023000Z/20140126T053000Z&details=&location=American%20Swedish%20Institute%2C%202600%20Park%20Ave%2C%20Minneapolis%2C%20MN%2055407&trp=true&sprop=Jon%20and%20Jill's%20Wedding%20Reception&sprop=name:jonathonandjillian.com" target="_blank"><img src="//www.google.com/calendar/images/ext/gc_button3.gif" border=0></a></span>
													</p>
												</div>
												<?php
												break;
											default:
												break;
										}
										?>
									</div>
									<div id="ContainerParty" class="container-party">
										<p>
										<strong>Officiant</strong><br>
										Justin Ley - Jon’s Friend
										</p>
										<p>
										<strong>Jill’s Attendants</strong><br>
										Laura Friant - Sister<br>
										Kristy Reid - Friend<br>
										Adam Carmichael - Friend<br>
										Max Slater - Brother
										</p>
										<p>
										<strong>Jon’s Attendants</strong><br>
										Anton Friant - Friend<br>
										Peter Voth - Brother<br>
										Matt Kroll - Brother-in-law
										</p>
										<p>
										<strong>Ushers</strong><br>
										Draeke Weseman - Couple’s friend<br>
										Ricky Coles - Couple’s friend
										</p>
									</div>
									<div id="ContainerDetails" class="container-details">
										<p>
											<strong>Community Blessing</strong><br>
											Officiant: Jill and Jon come to us today to create a family. Our presence consecrates their new family and will support them as they move forward in their new life together.<br><br>
											Guests: We have come together to celebrate the love that you have found with each other. By being here with you, we declare our support for your decision to join together in marriage.<br><br>
											Officiant: As family and friends, we form the community of support that surrounds Jill and Jon. We are called upon to uphold them in honoring and loving each other.<br><br>
											Guests: We promise to always stand beside you, never between you, offering our love and support on your journey together.<br><br>
											All: May we continue to share the love that has brought us here together.
										</p>
										<?php
											if($displayStateID === 3){
										?>
										<p class="rehearsal-invite">
											<strong>Rehearsal Dinner Venue</strong><br>
											Black Forest Inn<br>
											<a href="https://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=Black+Forest+Inn,+East+26th+Street,+Minneapolis,+MN&aq=0&oq=Black+For&sll=44.970697,-93.261478&sspn=0.373079,0.750504&vpsrc=0&ie=UTF8&hq=&hnear=&t=m&z=16&iwloc=A&cid=1702101610920509138" target="_blank">1 E 26th St<br>
											Minneapolis, MN 55404</a>
										</p>
										<?php
											}
											if($displayStateID !== 7){
										?>
										<p>
											<strong>Wedding Venue</strong><br>
											American Swedish Institute<br>
											<a href="https://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=American+Swedish+Institute,+Park+Avenue+South,+Minneapolis,+MN&aq=0&oq=american&sll=44.970697,-93.261478&sspn=0.373079,0.750504&vpsrc=0&ie=UTF8&hq=&hnear=&t=m&z=16&iwloc=A&cid=5335361704089780480" target="_blank">2600 Park Ave<br>
											Minneapolis, MN 55407</a>
										</p>
										<?php
											}
										?>
										<p>
											<strong>Hotels</strong><br>
											A block of rooms is reserved at<br>
											<a href="https://www.starwoodmeeting.com/StarGroupsWeb/booking/reservation?id=1307236448&key=A4EE0" target="_blank">The Minneapolis Sheraton Midtown</a><br>
											Another convenient hotel is<br>
											<a href="http://hiltongardeninn3.hilton.com/en/hotels/minnesota/hilton-garden-inn-minneapolis-downtown-MSPCNGI/index.html" target="_blank">The Minneapolis Hilton Garden Inn</a>
										</p>
										<?php
											if($displayStateID !== 7){
										?>
										<p class="full-invite">
											<strong>Gifts</strong><br>
											If you would like to purchase a gift, we have registries at <a href="http://www.amazon.com/registry/wedding/39UTRGDSX1ZQK" target="_blank">Amazon.com</a>, <a href="http://www1.macys.com/registry/wedding/guest/?registryId=6026836" target="_blank">Macy's</a> and <a href="http://www.target.com/wedd/registry/zFX-elN8PRfw7a2m1js7TA" target="_blank">Target</a>.<br>
											Feel free to bring gifts to the event or ship them directly to our home at:<br>
											2549 Bryant Ave S #1<br>
											Minneapolis, MN 55405
										</p>
										<?php
											}
										?>
										<p>
											<strong>Kids</strong><br>
											While we love the little ones, this is an adult-only affair.
										</p>
									</div>
								</div>
								<nav class="footer-nav">
									<ul>
										<li id="NavItemEvents" class="active"><a href="#ContainerEvents" class="orange">Order Of Events</a></li>
										<li id="NavItemParty"><a href="#ContainerParty" class="green">Wedding Party</a></li>
										<li id="NavItemDetails"><a href="#ContainerDetails" class="orange">Details</a></li>
									</ul>
								</nav>
						</div>
					<?php
					break;
				case -1:
					//Login Error State
					?>
						<h1 class="site-title"><span class="orange">Jonathon</span> &amp; <span class="green">Jillian</span></h1>
						<div class="content-container state-error">
							<h2>That name could not be found on the guest list. Please try again.</h2>
							<form name="ErrorForm" action="" method="get">
								<input type="submit" name="Submit" value="Back To Login" class="orange">
							</form>
						</div>
					<?php
					break;
				case 11:
				case 12:
				case 13:
				case 14:
				case 15:
				case 16:
					//Error State
					?>
						<h1 class="site-title"><span class="orange">Jonathon</span> &amp; <span class="green">Jillian</span></h1>
						<div class="content-container state-error">
							<h2>There was an error. Please log in again. (<?php echo $displayStateID ?>)</h2>
							<form name="ErrorForm" action="" method="get">
								<input type="submit" name="Submit" value="Back To Login" class="orange">
							</form>
							<?php
							mail('jonvoth@gmail.com', 'JonathonAndJillian.com: ERROR', 'User: '.$UserID.' - Error Code: '.$displayStateID);
							?>
						</div>
					<?php
					break;
				default:
					break;
			}
		?>
		</div>

		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
		<script src="js/libs/skrollr.min.js"></script>
		<script src="js/main.min.js"></script>
		<script>
			// Google Analytics
			var _gaq=[['_setAccount','UA-33307208-1'],['_trackPageview']];
			(function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
			g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
			s.parentNode.insertBefore(g,s)}(document,'script'));
		</script>
	</body>
</html>