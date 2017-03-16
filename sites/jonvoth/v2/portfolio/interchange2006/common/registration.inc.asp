<%
httpbase="http://" & Request.ServerVariables("SERVER_NAME") & "/"
httpsBase="https://" & Request.ServerVariables("SERVER_NAME")& "/"
thispage=Request.ServerVariables("SCRIPT_NAME")
If InStr(LCase(thispage),".inc.") > 0 Then
	Response.Redirect(httpBase & "interchange/default.htm?function=timeout")
End If
%>

		<%
		Select Case Request("function")

			Case "popupconfirmation"
				If Session("Customer") Then
					subSite = "Customer"
				ElseIf Session ("PublisherV") Then
					subSite = "PublisherV"
				ElseIf Session ("PublisherS") Then
					subSite = "PublisherS"
				Else
					Response.Redirect("/Interchange")
				End If
				Call ValidateForm(d)
				Response.Write("<table width='100%'><tr><td><table align=center width='85%' ><tr><td align=center><p align='left'>Thank you for submitting your registration. <br/><br/>Please use your browser's <a  href='javascript:window.print()'>Print</a> function to print this page")
				If Session("PublisherS") or Session("PublisherV") Then
					Response.Write(". <b style='color:#FF0000; '>Your registration will not be complete unless you fax a signed copy of this information to Lisa Hammer at (763)504-1107 by May 26, 2006.</b>")
				Else
					Response.Write(".")
				End If
				Response.Write("<br/><br/><a href='/Interchange/" & subSite & "/main.htm'> Return to the Interchange 2006 web site</a></p></td></tr><tr><td>")
				Call DisplayConfirmation(d)	
				If Session("PublisherS") or Session("PublisherV") Then
					Response.Write("<p align='left'>" & d.item("authorizedsigner") & "'s Signature_______________________________<b>Date_________<br></p>")
				End If
				Response.Write("<p align='left'>Remember to email your company logo in high resolution (300dpi) tif or eps format to: <a href='mailto:Laura.Ohman@navarre.com'>Laura.Ohman@navarre.com</a>.</p>")
				Response.Write("</td></tr></table></tr></td></table>")
			Case "submitform"
				Call ValidateForm(d)
				Call SubmitForm(d)
				Call HiddenForm("")
				Response.Write("<table width='100%'><tr><td><table align=center width='85%' ><tr><td align=center><p align='left'>Thank you for submitting your registration. ")
				If Session("PublisherS") or Session("PublisherV") Then
					Response.Write("<br/><br/><b>Your registration will not be complete unless you fax a signed copy of this information to Lisa Hammer at (763)504-1107 by May 26, 2006.</b><br/><br/> ")
				End If
				Response.Write ("Click <a target='Interchange 2006 Registration Confirmation' href='#' onClick='javascript:form1.submit();return false'>here</a> for a printable version.")
				Response.Write("</p></td></tr><tr><td>")
				ConfirmationData = CreateConfirmation(d)
				Response.Write(ConfirmationData)
				Set Mail = CreateObject("CDONTS.Newmail")
				Mail.From = "webmaster@navarre.com"
				Mail.To = "jvoth@navarre.com"
				Mail.Bcc = "webmaster@navarre.com"
				Mail.Subject = "New Interchange 2006 Registrant"
				Mail.BodyFormat = 0
				Mail.MailFormat = 0
				Mail.Body = "<html><body>" & ConfirmationData & "<br /><br /><br /><br /></body></html>"
				Mail.Send
				Set Mail = Nothing
				If Session("PublisherS") or Session("PublisherV") Then
					Response.Write("<p align='left'>" & d.item("authorizedsigner") & "'s Signature_______________________________<b>Date_________<br></p>")
				End If
				Response.Write("<p align='left'>Remember to email your company logo in high resolution (300dpi) tif or eps format to: <a href='mailto:Laura.Ohman@navarre.com'>Laura.Ohman@navarre.com</a>.</p>")
				Response.Write("</td></tr></table></tr></td></table>")
			Case "confirmform"
				If ValidateForm(d) Then
					Response.Write("<table><tr><td><br><br>Please look over the following statements. They should reflect the choices you made on the prior page. If you agree with them, please click the 'I agree' button below. Otherwise use the <a href='javascript:history.back()'>BACK</a> button on your browser to go back and correct your choices.</p></td></tr><tr><td>")
					Call DisplayConfirmation(d)
					Call HiddenForm("I Agree")
					Response.Write("</td></tr></table>")
				Else
					Call DisplayFormError()
				End If
			Case Else
				Call DisplayForm()
		End Select%>



<%Sub DisplayFormError()%>
<link href="../interchange2006.css" rel="stylesheet" type="text/css">

		<table width='100%' haeight=640><tr><td><table width="85%" align="center">
			<tr><td><br><br><font class="lgrhead">Error on form</font><br><br>Please go <a href="javascript:history.back()"><font color=black>back</font></a> and double-check the following field(s):<br><br><font class="srdhead"><%=BadFieldList%></font><br></td></tr>
		<tr><td><input type="button" value="Back" onClick="javascript:history.back()"></td></tr></table></tr></td></table><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<%
End Sub

Sub SubmitForm(byref d)
	Const KEY ="69216E6E7461657672616372687261656E35673F65"
	Dim Fs, DatFile, k, i, j
	Const ForReading = 1, ForWriting = 2, ForAppending = 8
	
	Set Fs = CreateObject("Scripting.FileSystemObject")
	Set DatFile = Fs.OpenTextFile("c:\inetpub\webs\interchangedata\interchange2006.txt", ForAppending, True)
	
	DatFile.Write(Now()&"|"&IIf(Session("Customer"),"Customer",IIf(Session("PublisherS"),"PublisherS","PublisherV")))
	
	k = d.Keys
	i = d.Items
	For j = 0 To d.Count -1 ' Iterate the array.
			'Response.Write(CStr(j))
		If k(j) = "cardnumber" Then
			Dim aKey()
			Dim nKeyLen
			dim blf_P(17)
			dim blf_S(3, 255)
			
			'Set the key
			If KEY <> "" Then
				ReDim aKey((Len(KEY) \ 2) - 1)
				nKeyLen = bu_HexStr2Bytes(KEY, aKey)
				Call blf_Key(aKey, nKeyLen, blf_P, blf_S)
			End If
			
			' encrypt the cardnumber
			szTxtCipher = blf_StringEnc(i(j), blf_P, blf_S)
			szTxtCipherHex = bu_Str2Hex(szTxtCipher)

			DatFile.Write("|" & szTxtCipherHex)
		Else
			DatFile.Write("|" & i(j))
		End If
	Next
		
	DatFile.WriteLine("")
	DatFile.Close

End Sub

Sub DisplayConfirmation(d)
	Response.Write(CreateConfirmation(d))
End Sub

Function CreateConfirmation(d)
	r = r & "<br>"
	r = r & "<font class='sgrhead'><u>Contact Info:</u></font><br>"
	r = r & "<b>" & d.item("name") & "<br>" & d.item("company") & "<br>" & d.item("title") & "<br>"
	r = r & IIf(d.item("address1")>"",d.item("address1")&"<br>","")
	r = r & IIf(d.item("address2")>"",d.item("address2")&"<br>","")
	r = r & d.item("city") & ",&nbsp;" & d.item("state") & " " & d.item("zip") & "<br></b>"
	r = r & "E-mail:&nbsp;<b>" & d.item("email") & "</b><br>"
	r = r & "Phone:&nbsp;<b>" & d.item("phone") & "</b>"
	r = r & " Fax:&nbsp;<b>" & d.item("fax") & "</b><br>"
	r = r & "<br>"
	r = r & "<font class='sgrhead'><u>Hotel Info:</u></font><br>"
	r = r & "I will be checking into the Westfield's Marriot on <b>" & d.item("hotelcheckin") & "</b><br>"
	r = r & "I will be checking out on <b>" & d.item("hotelcheckout") & "</b><br>"
	r = r & "I <b>" & IIf(d.item("extensionplan")="YES","do","do not") & "</b> need assistance with extension plans in the area.<br>"
	r = r & "My <b>"
	Select Case d.item("cardtype")
		Case "visa"
			r = r & "VISA"
		Case "amex"
			r = r & "American Express"
		Case "mastercard"
			r = r & "MasterCard"
		Case Else
			r = r & "credit card"
	End Select
	r = r & "</b> "
	r = r & "number is: <b>" & String(Iif(Len(d.item("cardnumber"))>4,Len(d.Item("cardnumber"))-4,0),"X")&Right(d.Item("cardnumber"),4) & "</b>. It expires on <b>" & d.item("cardexpirationmonth")&"/"&d.item("cardexpirationyear") & "</b><br>"
	r = r & "Aside from a <b>" & d.item("smokingpref") & "</b> room,"
	If d.item("hotelrequests") > "" Then
		r = r & "	I have the following special requests:<br>"
		r = r & "	&nbsp;<b>" & d.item("hotelrequests") & "</b><br>"
	Else
		r = r & "	I have <strong>no</strong> additional special requests.<br>"
	End If
	r = r & "<br>"
	r = r & "<font class='sgrhead'><u>" & Iif(Session("PublisherS") or Session("PublisherV"),"Transportation","Airline") & " Info:</u></font><br>"
	r = r & IIf(d.item("driving")="YES","No Air arrangements are necessary as <b>I am driving</b><br>","")
	If d.item("driving") = "NO" Then
		r = r & "	I prefer <b>" & d.item("seatingpref") & "</b> seat(s)<br>"
		r = r & "	I will be departing from <b>" & d.item("departurecity") & "</b><br>"
		r = r & "	" & IIf(d.item("frequentfliernumber") > "","Please apply miles to my Frequent Flyer number <b>" & d.item("frequentfliernumber") & "</b>.","I <b>do not</b> want to use a Frequent Flyer number") & "<br>"
		If d.item("airlinerequests") > "" Then
			r = r & "	I have the following special requests:<br>"
			r = r & "	&nbsp;<b>" & d.item("airlinerequests") & "</b><br>"
		Else
			r = r & "I have <strong>no</strong> additional special requests.<br>"
		End If
	End If
	If Session("PublisherS") or Session("PublisherV") Then
		r = r & "	I <strong>would " & Iif(d.Item("groundtransportation")="YES","","not ") & "</strong> like to utilize Navarre's shuttle transportation service."
	End If
	r = r & "<br>"
	r = r & "<br>"
	r = r & "<font class='sgrhead'><u>Activity Info:</u></font><br>"
	Select Case d.item("activitypref")
	Case "unable"
		r = r & "I am <b>unable to participate</b> in the Saturday activity<br>"
	Case "scavenger"
		r = r & "I would like to participate in <B>The Great Washington DC Scavenger Hunt</B>.<br>"
	Case "welcome"
		r = r & "I would like to take the <B>Welcome to Washington Tour</B>.<br>"
	Case "war"
		r = r & "I would like to take the <B>War and Remembrance Tour</B>.<br>"
	Case "capitol"
		r = r & "I would like to take the <B>Capitol Hill Tour</B>.<br>"
	Case "smith"
		r = r & "I would like to take the <B>Inside the Smithsonian Tour</B>.<br>"
	Case "golf"
		r = r & "I would like to <b>Golf</b><br>"
		If d.item("golfclubrental")="NO" Then
			r = r & "I <b>will not</b> need golf clubs.<br>"
		Else
			r = r & "I <b>will</b> need <b>" & d.Item("golfclublr") & "</b> handed, <b>" & d.item("golfclubmw") & "</b> golf clubs.<br>"
		End If
		'				If d.item("golfshoerental")="YES" Then"
		'					Response.Write("I <b>will</b> need <b>" & d.item("satgolfclubs") & "</b> shoes, size <b>" & d.item("golfshoesize")) & "</b><br>""
		'				End If"
	End Select
	r = r & "<br><font class='sgrhead'><u>Company Info:</u></font><br>"
	r = r & Iif(d.item("companybio") > "","<b>" & d.item("companybio") & "</b>","I <b>do not</b> want to provide a company bio.") & "<br>"
	If Session("PublisherS") or Session("PublisherV") Then
		r = r & "	<br><font class='sgrhead'><u>Guest Badges:</u></font><br>"
		If d.item("guestPass1") <> "" Then
			r = r & IIf(d.item("guestName1") > "","My guest's name is <b>" & d.item("guestName1") & "</b>.", "The guest's name was not entered.")& "<br>"
			r = r & "I have selected the <b>" & IIf(d.item("guestPass1")= "activityPass", "$400 Friday Night and Saturday Activity Pass" , "$700 All Access Pass") & "</b> for my guest.<br>"
		Else
			r = r & "I <b>will not</b> be bringing a guest and <b>do not</b> need an activity pass.<br>"
		End If
	End If
	If Session("PublisherS") or Session("PublisherV") Then
		r = r & "<br><font class='sgrhead'><u>Authorization Info:</u></font><br>"
		r = r & "<strong>The company agrees</strong> to pay " & IIf(Session("PublisherV"),"$6,000","$16,500") & " in the form of a <b>" & d.Item("authpay") & "</b> for registration to the 2006 Interchange Program.<br>"
		r = r & "I <b>" & IIf(d.Item("sendsponsorshipinfo")="YES","want","do not want") & "</b> to be sent information on becoming a Sponsor for this year's Interchange Event.<br>"
		r = r & "<b>" & d.Item("authorizedsigner") & "</b> authorizes this payment.<br>"
	End If

	CreateConfirmation = r
End Function%>

<%Sub HiddenForm(buttontext)
	If buttontext <> "" then%>
		<form method="post" id=form1 name=form1>
		<%
	Else%>
		<form method="post" id=form1 name=form1 action="../common/confirm.htm" target="_top">
	<%		
	End If
	k = d.Keys
	i = d.Items
	cardnumberefield=-1
	sTemp="<html><body style='background-color:#FAF8D3;'><table border><tr><th>type</th>"
	For j = 0 To d.Count -1 ' Iterate the array.
		If k(j) = "cardnumber" Then
			cardnumberfield = j
		End If
		sTemp = sTemp & "<th>" & k(j) & "</th>"
	Next
	sTemp = sTemp & "</tr><tr><th>" & Iif(Session("PublisherS"),"publishers",IIf(Session("customer"),"customer","publisherv")) & "</th>"
	For j = 0 To d.Count -1 ' Iterate the array.
		If j = cardnumberfield Then
			sTemp = sTemp & "<td>&nbsp;</td>"
			cardnumberfield=-1	
		Else
			sTemp = sTemp & "<td>" & Iif(i(j)="","&nbsp;",i(j)) & "</td>"
		End If
		Response.Write("<input type='hidden' name='" & k(j) & "' value='" & i(j) & "'>" & CHR(13))
	Next
	sTemp = sTemp & "</tr></table></body></html>"
	If buttontext <> "" Then
		%>
		<input type="hidden" name="function" value="submitform">
		<input type="button" onclick="javascript:history.back()" value="Back" id=button1 name=button1>&nbsp;&nbsp;<input type="submit" value="<%=buttontext%>" id=submit1 name=submit1></form>
		<%
	Else
	
	%>
	<input type="hidden" name="function" value="popupconfirmation">
	</form>
	<%
	End If		
End Sub

Function ValidateForm(byref d)
	Dim Req, Opt
	Req=True
	Opt=False
	pReq=Session("PublisherS") or Session("PublisherV")
	d.Add "name", Clean("name",Req,"Your Name")
	d.Add "company", Clean("company",Req,"Company Name")
	d.Add "title", Clean("title",Req,"Title")
	d.Add "address1", Clean("address1",Req,"Address Line 1")
	d.Add "address2", Clean("address2",Opt,"")
	d.Add "city", Clean("city",Req,"City")
	d.Add "state", Clean("state",Req,"State")
	d.Add "zip", Clean("zip",Req,"Zip Code")
	d.Add "email", Clean("email",Req,"Email Address")
	d.Add "phone", Clean("phone",Req,"Phone Number")
	d.Add "fax", Clean("fax",Req,"Fax Number")
	d.Add "agreetopay", IIf(UCase(Clean("agreetopay",pReq,"Payment Agreement"))="YES","YES","NO")
	d.Add "paymethod", Clean("paymethod",pReq,"Payment Method")
	d.Add "sendsponsorshipinfo", IIf(UCase(Clean("sendsponsorshipinfo",Opt,""))="YES","YES","NO")
	d.Add "authorizedsigner", Clean("authorizedsigner",pReq,"Authorized Signer Name")
	d.Add "authdate", ""
	d.Add "hotelcheckin", Clean("hotelcheckin",Req,"Hotel Check-In Date")
	d.Add "hotelcheckout", Clean("hotelcheckout",Req,"Hotel Check-Out Date")
	d.Add "extensionplan", IIf(UCase(Clean("extensionplan",Opt,""))="YES","YES","NO")
	d.Add "cardtype", Clean("cardtype",Req,"Credit Card Type")
	d.Add "cardnumber", Clean("cardnumber",Req,"Credit Card Number")
	d.Add "smokingpref", Clean("smokingpref",Opt,"")
	d.Add "hotelrequests", Clean("hotelrequests",Opt,"")
	d.Add "cardexpirationmonth", Clean("cardexpirationmonth",Req,"Credit Card Expiration Month")
	d.Add "cardexpirationyear", Clean("cardexpirationyear",Req,"Credit Card Expiration Year")
	d.Add "driving", IIf(UCase(Clean("driving",Opt,""))="YES","YES","NO")
	d.Add "seatingpref", Clean("seatingpref",Opt,"")
	d.Add "departurecity", Clean("departurecity",Opt,"")
	d.Add "airlinerequests", Clean("airlinerequests",Opt,"")
	d.Add "frequentfliernumber", Clean("frequentfliernumber",Opt,"")
	d.Add "groundtransportation", IIf(UCase(Clean("groundtransportation",Opt,""))="YES","YES","NO")
	d.Add "activitypref", Clean("activitypref",Req,"Activity Preference")
	d.Add "golfhandicap", Clean("golfhandicap",d.item("activitypref")="golf","Golf Handicap")
	d.Add "golfclubrental", IIf(UCase(Clean("golfclubrental",Opt,""))="YES","YES","NO")
	d.Add "golfclubmw", Clean("golfclubmw",Opt,"")
	d.Add "golfclublr", Clean("golfclublr",Opt,"")
'	d.Add "golfshoerental", IIf(UCase(Clean("golfshoerental",Opt))="YES","YES","NO")
'	d.Add "golfshoesize", Clean("golfshoesize",Opt)
	d.Add "companybio", Clean("companybio",Req,"Company Bio")
	d.Add "guestName1", Clean("guestName1",Opt,"")
	d.Add "guestPass1", Clean("guestPass1",Opt,"")
	ValidateForm = BadFieldList = ""
End Function

Function GetValue(key)
	if d.exists(key) Then
		GetValue=d.item(key)
	Else
		GetValue=""
	End If
End Function

Function IIf(i,j,k)
	If i Then IIf = j Else IIf = k
End Function

Function Clean(inputfield,ByRef Req,displayedname)
	Dim sTemp
	sTemp = Trim(Request(inputfield))
	sTemp = Replace(sTemp, "'", "")
	sTemp = Replace(sTemp, Chr(10), " ")
	sTemp = Replace(sTemp, Chr(13), " ")
	sTemp = Replace(sTemp, "|", ":")
	If sTemp="" and Req=True Then
		BadFieldList = BadFieldList & displayedname & "<br>"
		'Req=False
	End If
	Clean = sTemp
End Function

Sub DisplayForm()%><img src="../images/headRegister.gif" title="Register" alt="Register" width="450" height="50" class="imgTop">
	<a href="javascript:popUp('https://digitalid.verisign.com/as2/bb89a0c95dc20bc5308fc921f106388e')"><img src="../common/sm_verisign.gif" width="100"height="42" border="0" class="imgRight"></a>
		<p>&nbsp;</p>
		<p class="text">Please complete the following form to secure your spot at this year's event. You will have many one-on-one meetings with your <%=Iif(Session("Customer"),"software and video game publishing", "retail")%> partners to plan your fourth quarter. A meeting prioritization form will be sent to you with the list of attending <%=Iif(Session("Customer"),"publishers","retailers")%>. We will arrange your meeting schedule. You will receive a preliminary schedule to review two weeks prior to your arrival.<br>
		<br>
		<%If Session("PublisherS") or Session("PublisherV") Then%>
		The publisher registration fee for Interchange 2006 is <%=IIf(Session("PublisherV"),"$6,000","$16,500")%> <strong>(one-time fee per publisher)</strong>. This fee includes attendance at event, group meals at the Westfield's Marriot, three exciting evening events, scheduled one-on-one meetings with retailers and the Golf Tournament/Saturday Activities. Airline transportation, hotel accommodations and activities not listed are at your own expense.<br>
		<br>
		<%End If%>
		<strong>Please complete and submit your Interchange registration form by May 26, 2006. <%=Iif(Session("PublisherS") or Session("PublisherV"),"You must complete a separate registration form for each person attending from your company.","")%><br>
		</strong>
		</p>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<h1>Personal Information</h1>
		<form method="post" id="Form3" name=form2>
		<input type="hidden" name="function" value="confirmform" ID="Hidden1">
		<table cellpadding="0" cellspacing="0" class="tableRegister" ID="Table1">
			<tr>
				<td class="tdRegisterLeft">Name</td>
				<td class="tdRegisterRight"><input type="text" name="name" style="width:250px" ID="Text1"></td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">Company</td>
				<td class="tdRegisterRight"><input type="text" name="company" style="width:250px" ID="Text2"></td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">Title:</td>
				<td class="tdRegisterRight"><input type="text" name="title" style="width:250px" ID="Text3"></td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">Address</td>
				<td class="tdRegisterRight"><input type="text" name="address1" style="width:250px" ID="Text4"></td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">&nbsp;</td>
				<td class="tdRegisterRight"><input type="text" name="address2" style="width:250px" ID="Text5"></td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">City</td>
				<td class="tdRegisterRight"><input type="text" name="city" size="24" ID="Text6"></td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">State</td>
				<td class="tdRegisterRight">
					<input type="text" name="state" size="2" ID="Text7">
					&nbsp;&nbsp;<strong>Zip</strong>&nbsp;&nbsp;
					<input type="text" name="zip" size="10" ID="Text8">
				</td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">Phone</td>
				<td class="tdRegisterRight">
					<input type="text" name="phone" size="10" ID="Text9">
					&nbsp;&nbsp;<strong>Fax</strong>&nbsp;&nbsp;
					<input type="text" name="fax" size="10" ID="Text10">
				</td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">E-Mail</td>
				<td class="tdRegisterRight"><input type="text" name="email" size="16" ID="Text11"></td>
			</tr>
		</table>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
	<%If Session("PublisherS") or Session("PublisherV") Then%>
		<h1>Payment Information</h1>
		<table cellpadding="0" cellspacing="0" class="tableRegister" ID="Table2">
			<tr>
				<td class="tdRegisterRight" colspan="2"><input type="checkbox" value="yes" name="agreetopay" ID="Checkbox1"><strong>The company agrees to pay <%=IIf(Session("PublisherV"),"$6,000","$16,500")%> for registration to the 2006 Interchange program.</strong></td>
			</tr>
			<tr>
				<td class="tdRegisterRight" colspan="2">
					This one-time per publisher fee will be paid by<br />
					<input type="radio" value="check" name="paymethod" ID="Radio1">
					&nbsp;Check&nbsp;&nbsp;
					<input type="radio" value="chargeback" name="paymethod" ID="Radio2">
					&nbsp;Chargeback
				</td>
			</tr>
			<tr>
				<td class="tdRegisterRight" colspan="2"><strong>Authorized Signer</strong>&nbsp;&nbsp;
				<input type="text" name="authorizedsigner" size="32" ID="Text12"></td>
			</tr>
			<tr>
				<td class="tdRegisterRight" colspan="2">
					<input type="checkbox" value="yes" name="sendsponsorshipinfo" ID="Checkbox2">
					Please send me information on becoming a sponsor for this year&#146;s Interchange Event.
				</td>
			</tr>
			<tr>
				<td class="tdRegisterRight" colspan="2">
					<strong>Once registration is complete, please print, sign, and FAX in an authorizing signature to Lisa Hammer at (763)504-1107.</strong>
				</td>
			</tr>
		</table>
	<%End If%>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<h1>Hotel Information</h1>
		<table cellpadding="0" cellspacing="0" class="tableRegister" ID="Table3">
	<%If Session("PublisherS") or Session("PublisherV") Then%>
			<tr>
				<td class="tdRegisterRight" colspan="2">
					<strong>Navarre will reserve all hotel rooms. Please complete a separate form for each person attending from your company.</strong>
				</td>
			</tr>
	<%End If%>
			<tr>
				<td class="tdRegisterRight" colspan="2">
					I will be <strong>checking in</strong> to the Westfield's Marriot on&nbsp;&nbsp;<input type="text" name="hotelcheckin" size="12" ID="Text13"><em>&nbsp;(mm/dd/yy)</em>
				</td>
			</tr>
			<tr>
				<td class="tdRegisterRight" colspan="2">
					and <strong>checking out</strong> on&nbsp;&nbsp;<input type="text" name="hotelcheckout" size="12" ID="Text14"><em>&nbsp;(mm/dd/yy)</em>
				</td>
			</tr>
			<tr>
				<td class="tdRegisterRight" colspan="2">
					<em>(Rooms will be reserved based on the arrival and departure dates you indicate)</em>
				</td>
			</tr>
			<tr>
				<td class="tdRegisterRight" colspan="2">
					<input type="checkbox" value="yes" name="extensionplan" ID="Checkbox3">
						&nbsp;I need assistance with extension plans in the area
				</td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">Credit Card</td>
				<td class="tdRegisterRight"><select name="cardtype" size="1" ID="Select1">
						<option value="visa">Visa</option>
						<option value="amex">American Express</option>
						<option value="mastercard">MasterCard</option>
						</select></td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">Card Number</td>
				<td class="tdRegisterRight"><input type="text" name="cardnumber" size="18" ID="Text15"></td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">Expiration Date</td>
				<td class="tdRegisterRight">
					<select name="cardexpirationmonth" size="1" ID="Select2">
						<option value="January">January</option>
						<option value="February">February</option>
						<option value="March">March</option>
						<option value="April">April</option>
						<option value="May">May</option>
						<option value="June">June</option>
						<option value="July">July</option>
						<option value="August">August</option>
						<option value="September">September</option>
						<option value="October">October</option>
						<option value="November">November</option>
						<option value="December">December</option>
					</select>
						&nbsp;&nbsp;
						<select name="cardexpirationyear" size="1" ID="Select3">
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						</select>
				</td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">Smoking preference</td>
				<td class="tdRegisterRight">
					&nbsp;&nbsp;
					<input type="radio" value="nonsmoking" name="smokingpref" ID="Radio3">
					&nbsp;Non-Smoking&nbsp;&nbsp;
					<input type="radio" value="smoking" name="smokingpref" ID="Radio4">
					&nbsp;Smoking
				</td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">Special Requests</td>
				<td class="tdRegisterRight"><textarea name="hotelrequests" cols="30" rows="4" ID="Textarea1"></textarea></td>
			</tr>
	<%If Session("PublisherS") or Session("PublisherV") Then%>
			<tr>
				<td class="tdRegisterRight" colspan="2"><strong>Publishers will be responsible for a base room charge of $325 per night for any attendee cancellations occurring after July 9, 2006.</strong></td>
			</tr>
	<%End If%>
		</table>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<h1>Transportation Information</h1>
		<table cellpadding="0" cellspacing="0" class="tableRegister" ID="Table4">
	<%If Session("Customer") Then%> 
			<tr>
				<td class="tdRegisterRight" colspan="2">
					<input type="checkbox" value="yes" name="driving" ID="Checkbox4">&nbsp;I am driving, no airline tickets required
				</td>
			</tr>
			<tr>
				<td class="tdRegisterRight" colspan="2">
					<p class="text"><em>(All airline tickets will be issued using the best available fares and schedules)</em></p>
				</td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">
					Seating preference
				</td>
				<td class="tdRegisterRight">
					<input type="radio" value="window" name="seatingpref" ID="Radio5">
					&nbsp;Window&nbsp;&nbsp;
					<input type="radio" value="aisle" name="seatingpref" ID="Radio6">
					&nbsp;Aisle
				</td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">Departure City </td>
				<td class="tdRegisterRight"><input type="text" name="departurecity" size="24" ID="Text16"></td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">Frequent Flyer Number</td>
				<td class="tdRegisterRight"><input type="text" name="frequentfliernumber" size="24" ID="Text17"></td>
			</tr>
			<tr>
				<td class="tdRegisterLeft">Special Requests</td>
				<td class="tdRegisterRight"><textarea name="airlinerequests" cols="30" rows="4" ID="Textarea2"></textarea></td>
			</tr>
			<tr>
				<td class="tdRegisterRight" colspan="2">
					<p class="text">While we cannot make guarantees, we will make every effort to fulfill these requests. Airline tickets cannot be issued until this form has been completed.</p>
					<p class="text">We will arrange your transportation to and from the hotel based on your arrival and departure times.</p>
				</td>
			</tr>
	<%End If%>
	<%If Session("PublisherS") or Session("PublisherV") Then%>
			<tr>
				<td class="tdRegisterRight" colspan="2">
					<p class="text">
						* Transportation to and from the airport is included in the hotel room rate. Please send Rachel Schmieg (<a href="mailto:rachel.schmieg@navarre.com">Rachel.Schmieg@navarre.com</a>) your arrival and departure times.
					</p>
				</td>
			</tr>
	<%End If%>
		</table>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<h1>Saturday Activity </h1>
		<table cellpadding="0" cellspacing="0" class="tableRegister" ID="Table5">
			<tr>
				<td class="tdRegisterRight" colspan="2">
					<p class="text">
						Please <strong>select one</strong> of the options below.
					</p>
					<p class="text">
						<em>(A minimum number of people is required for these activities. If the minimum is not met, the activity will be cancelled and we will contact you.)</em>
					</p>
				<!--
				<input type="radio" value="able" name="activitypref" ID="Radio7">
					&nbsp;Yes, I <strong>would</strong> like to participate in a Saturday activity.<br>
					-->
					<p class="text">
					<input type="radio" value="scavenger" name="activitypref">&nbsp;The Great Washington DC Scavenger Hunt</strong><br/>
					<input type="radio" value="welcome" name="activitypref">&nbsp;Welcome to Washington Tour<br/>
					<input type="radio" value="war" name="activitypref">&nbsp;War and Remembrance Tour<br/>
					<input type="radio" value="capitol" name="activitypref">&nbsp;Capitol Hill Tour<br/>
					<input type="radio" value="smith" name="activitypref">&nbsp;Inside the Smithsonian Tour</p>
					
					<p class="text">
					If you are interested in a sporting activity, please contact Rachael Schmieg at <a href="mailto:Rachel.Schmieg@navarre.com">Rachel.Schmieg@navarre.com</a>.
					</p>
					<br />
					<p class="text">
					<input type="radio" value="unable" name="activitypref" ID="Radio8">
					&nbsp;I am <strong>unable to participate</strong> in the Saturday Activities.
					</p>
					<br />
					<p class="text">
					<input type="radio" value="golf" name="activitypref" ID="Radio9">
					&nbsp;I would like to <strong>Golf</strong>.<br /><br/>
					<!--
					&nbsp;&nbsp;My handicap is&nbsp;
					<input type="text" name="golfhandicap" size="4" ID="Text18">
					-->
					<input type="checkbox" value="yes" name="golfclubrental" ID="Checkbox5">
							&nbsp;I will need to rent golf clubs<br/>
				
					<input type="radio" value="mens" name="golfclubmw" ID="Radio10">
					&nbsp;Mens&nbsp;&nbsp;
					<input type="radio" value="womens" name="golfclubmw" ID="Radio11">
					&nbsp;Womens<br/>
				
					<input type="radio" value="left" name="golfclublr" ID="Radio12">
					&nbsp;Left&nbsp;&nbsp;
					<input type="radio" value="right" name="golfclublr" ID="Radio13">
					&nbsp;Right
					</p>
				</td>
			</tr>
		</table>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<h1>Company Bio</h1>
		<table cellpadding="0" cellspacing="0" class="tableRegister" ID="Table6">
			<tr>
				<td class="tdRegisterRight">
					<p class="text">
						Please include a short one paragraph narrative which includes a summary of your company, your position and the categories you buy or sell. <b>* This information will appear in the Official Interchange book given at the event *</b>
					</p>
					<p class="text"><textarea name="companybio" cols="30" rows="6" ID="Textarea3"></textarea></p>
					<p class="text">
						Please email your company logo in high resolution (300dpi) TIFF or EPS format to <a href="mailto: Laura.Ohman@navarre.com">Laura.Ohman@navarre.com</a>.
					</p>
				</td>
			</tr>
		</table>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
	<%If Session("PublisherS") or Session("PublisherV") Then%>
		<h1>Guest Badges</h1>
		<table cellpadding="0" cellspacing="0" class="tableRegister" ID="Table7">
			<tr>
				<td class="tdRegisterRight">
					<p class="text">Interchange has a strong heritage of being one of the best working events in our industry.  Because we host this event at wonderful locations, it is understandable that there is an interest in bringing friends and family.  Guest attendance has increased substantially over the past few years.  Because of this and because we want to maintain our event’s value to our participating publishers, we have initiated a guest badge program.</p>
					<p class="text">Should you wish to bring a family member or friend to our event, please note the following badge registration cost breakdown:</p>
					<p class="text">$400 - Friday night and Saturday Activity Pass <br />
					$700 - All Access Pass – provides access to Interchange breakfast, lunch and evening events as well as a Saturday Activity</p>
					<p class="text">Please register your guest below and indicate which level of pass you wish to purchase</p>
					<p class="text">Name:&nbsp;&nbsp;<input name="guestName1" type="text" maxlength="100" style="width:250px;" ID="Text19"></p>
					<p class="text"><input name="guestPass1" type="radio" value="activityPass" ID="Radio14">&nbsp;&nbsp;$400 Friday Night and Saturday Activity Pass<br />
					<input name="guestPass1" type="radio" value="allAccessPass" ID="Radio15">&nbsp;&nbsp;$700 All Access Pass</p>
				</td>
			</tr>
		</table>
	<%End If%>
		<p>&nbsp;</p>
		<p class="text"><input type="submit" name="registerbutton" value="Register Now" ID="Submit2"></p>
		<p>&nbsp;</p>
		</form>
<%
End Sub
%>