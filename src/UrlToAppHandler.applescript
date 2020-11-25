on checkForceOpen(this_URL, appName, handle)
	set diagText to appName & " handle '" & handle & "' - from URL '" & this_URL & "' might not be valid. Open in " & appName & " anyway?"
	display dialog diagText buttons {"Open in " & appName, "Open in Browser", "Cancel"} with icon caution default button 1 cancel button 3
	
	if result = {button returned:"Open in " & appName} then
		openApp(appName, handle)
	else if result = {button returned:"Open in Browser"} then
		openApp("Browser", this_URL)
	else
		display notification "Not opening URL '" & this_URL & "'"
	end if
end checkForceOpen

on regexTest(str, regex)
	set retVal to (do shell script "[[ " & quoted form of str & " =~ " & regex & " ]]; printf $?")
	return "0" = retVal
end regexTest

on openApp(appName, handle)
	if appName = "Chime" then
		do shell script "open " & "chime://meeting?pin=" & handle
	else if appName = "Quip" then
		do shell script "open " & "quip://" & handle
	else if appName = "Browser" then
		do shell script "open " & "x-choosy://chrome.work/" & handle
	else if appName = "Outlook" then
		do shell script "mdfind 'com_microsoft_outlook_recordID == " & handle & "' -0 | xargs -0 open"
	end if
end openApp

on processChimeURL(this_URL)
	set handle to text item 4 of this_URL
	
	# Match URL e.g. https://chime.aws/3705483650
	if regexTest(handle, "^[[:digit:]]{10}") then
		openApp("Chime", handle)
	else
		checkForceOpen(this_URL, "Chime", handle)
	end if
end processChimeURL

on processQuipURL(this_URL)
	set handle to text item 4 of this_URL
	
	# Match URL e.g. https://quip-amazon.com/O88tAi6VG0lM/Doc-Cognito-Federate with regex.
	if regexTest(handle, "^[A-Za-z0-9]{12}") then
		openApp("Quip", handle)
	else
		checkForceOpen(this_URL, "Quip", handle)
	end if
end processQuipURL

on processOutlookURL(this_URL)
	set handle to text item 3 of this_URL
	if regexTest(handle, "^[[:digit:]]+") then
		openApp("Outlook", handle)
	else
		display dialog "Outlook handle '" & handle & "' from URL '" & this_URL & "' is not valid."
	end if
end processOutlookURL

on open location this_URL
	set AppleScript's text item delimiters to "/"
	
	# Test for Chime URL
	if regexTest(this_URL, "chime.aws") then
		processChimeURL(this_URL)
	else if regexTest(this_URL, "quip-amazon.com") then
		processQuipURL(this_URL)
	else if regexTest(this_URL, "^outlookmsg") then
		processOutlookURL(this_URL)
	else
		display dialog "URL not supported: '" & this_URL & "'"
	end if
end open location

