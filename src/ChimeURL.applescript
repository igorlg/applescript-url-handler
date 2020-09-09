on openInChime(handle)
	set chime_handle to "chime://meeting?pin=" & handle
	do shell script "open " & chime_handle -- open location
end openInChime

on openInBrowser(this_URL)
	set choosy_url to "x-choosy://chrome.work/" & this_URL
	do shell script "open " & choosy_url -- open location
end openInBrowser

to checkForceOpen(this_URL, callid)
	set diagText to "Chime Meeting id '" & callid & "' - from URL '" & this_URL & "' might not be valid. Open in Chime anyway?"
	display dialog diagText buttons {"Open in Chime", "Open in Browser", "Cancel"} with icon caution default button 1 cancel button 3
	
	if result = {button returned:"Open in Chime"} then
		openInChime(callid)
	else if result = {button returned:"Open in Browser"} then
		openInBrowser(this_URL)
	else
		display notification "Not opening URL '" & this_URL & "'"
	end if
end checkForceOpen

on open location this_URL
	set AppleScript's text item delimiters to "/"
	set callid to text item 4 of this_URL
	
	# Match URL e.g. https://chime.aws/3705483650 with regex.
	set isMatch to "0" = (do shell script "[[ " & quoted form of callid & " =~ ^[[:digit:]]{10} ]]; printf $?")
	
	if isMatch then
		# If match, it's a Chime meeting, thus open the app.
		openInChime(callid)
	else
		# Otherwise, ask wether to open in Chime anyway, with the browser or do nothing
		checkForceOpen(this_URL, callid)
	end if
end open location

